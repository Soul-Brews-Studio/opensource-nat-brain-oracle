# Lesson Learned: DuckDB Large-Scale Export with Divide & Conquer

**Date**: 2026-01-02
**Context**: Exporting 2.6B records from 88GB DuckDB to Parquet by model

---

## The Problem

`SELECT DISTINCT` on large datasets (100M+ records) causes:
1. **OOM kills** - DuckDB uses 40GB+ RAM for hash tables
2. **Memory thrashing** - 85%+ memory usage = slow progress
3. **Segfaults** - Memory pressure causes crashes

### Failed Approaches

| Approach | Result |
|----------|--------|
| 4 parallel exports | 45GB/46GB RAM, OOM kills |
| 2 parallel exports | Still OOM on large models |
| 1 sequential export | Works but very slow for 1.2B records |

---

## The Solution: Divide & Conquer

**Split by time (year, then half-year) for large models.**

### Memory Guidelines

| Dataset Size | Strategy | Max Memory |
|--------------|----------|------------|
| <50M records | Full export | ~20% RAM |
| 50M-150M | Split by year | ~40% RAM |
| 150M-300M | Split by half-year | ~50% RAM |
| 300M+ | Split by quarter | ~60% RAM |

### Successful Script Pattern

```bash
#!/bin/bash
DB="/path/to/database.duckdb"
OUT="/path/to/exports"

# Small models - direct export
duckdb -readonly $DB -c "COPY (SELECT DISTINCT * FROM table WHERE model = 'small_model' ...) TO '$OUT/small.parquet'"

# Medium models - split by year
for YEAR in 2019 2020 2021 2022 2023 2024; do
  duckdb -readonly $DB -c "COPY (SELECT DISTINCT * FROM table WHERE model = 'medium_model' AND EXTRACT(YEAR FROM time) = $YEAR ...) TO '$OUT/medium-$YEAR.parquet'"
done

# Large models - split by half-year
duckdb -readonly $DB -c "COPY (SELECT DISTINCT * FROM table WHERE model = 'large_model' AND time >= '2024-01-01' AND time < '2024-07-01' ...) TO '$OUT/large-2024-H1.parquet'"
duckdb -readonly $DB -c "COPY (SELECT DISTINCT * FROM table WHERE model = 'large_model' AND time >= '2024-07-01' AND time < '2025-01-01' ...) TO '$OUT/large-2024-H2.parquet'"
```

### Key Principles

1. **Sequential, not parallel** - ONE export at a time for large datasets
2. **Time-based splitting** - Year, half-year, or quarter
3. **Monitor memory** - Keep below 80% to avoid thrashing
4. **Clean filenames** - Include time period in filename

---

## Results Comparison

| Approach | Time | Success Rate |
|----------|------|--------------|
| Parallel (4 at once) | Failed | 40% (OOM kills) |
| Sequential by model | Hours | 60% (large OOM) |
| **Divide by half-year** | ~30 min | **100%** |

### Final Export Stats

- **Total**: 7.6GB in 33 Parquet files
- **Models**: 10 sensor models
- **Time range**: 2019-2024
- **Deduplication**: `SELECT DISTINCT` on all exports

---

## DuckDB Memory Hints

When memory is tight, these settings help:

```sql
SET threads=4;  -- Reduce from default
SET preserve_insertion_order=false;  -- Reduces memory
SET memory_limit='30GB';  -- Leave headroom
PRAGMA max_temp_directory_size='50GB';  -- Allow disk spill
```

---

## Pattern: Time-Based Sharding for DISTINCT

For any `SELECT DISTINCT` on massive data:

```sql
-- Instead of this (OOM):
SELECT DISTINCT * FROM huge_table

-- Do this (safe):
SELECT DISTINCT * FROM huge_table WHERE time >= '2024-01-01' AND time < '2024-07-01'
SELECT DISTINCT * FROM huge_table WHERE time >= '2024-07-01' AND time < '2025-01-01'
-- ... etc
```

The key insight: **DISTINCT requires in-memory hash tables proportional to unique rows**. Splitting by time reduces the working set.

---

## Summary

> When DISTINCT + large data = OOM, split by time until each chunk fits in memory.

**Rule of thumb**: Start with year splits. If still OOM, go to half-year. If still OOM, go to quarter or month.

---

*This pattern applies to any hash-based operation (GROUP BY, JOIN, DISTINCT) on large datasets.*
