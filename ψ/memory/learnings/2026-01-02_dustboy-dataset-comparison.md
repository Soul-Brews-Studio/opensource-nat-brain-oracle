# Learning: DustBoy Dataset Comparison Analysis

**Date**: 2026-01-02
**Source**: InfluxDB 2024 export session
**Tags**: `dustboy` `phd-thesis` `data-analysis` `influxdb` `parquet`

---

## Pattern Discovered

When comparing historical and recent sensor data:

1. **Don't assume same naming = same sensors**
   - Wplus ≠ TPlus (different hardware generations)
   - Zero overlap despite similar naming patterns

2. **Check export schema before analysis**
   - Some exports: parsed fields (pm2_5, temp, humid)
   - Other exports: raw line protocol (needs parsing)

3. **Validate parquet files after transfer**
   - n-nc-2025.parquet corrupted ("no magic bytes")
   - Always verify with `duckdb -c "SELECT COUNT(*) FROM read_parquet('file')"`

---

## Key Findings

### Air Quality Improved (or Sensors Changed)
| Period | Avg PM2.5 | Sensors |
|--------|-----------|---------|
| 2019-2024 (OLD) | 30.7 μg/m³ | Wplus models |
| Nov 2024+ (NEW) | 13.8 μg/m³ | TPlus models |

**Not necessarily cleaner air** - could be:
- Different calibration
- Different locations
- Different sensor technology

### New Sensor Types Valuable
- **T4 (Indoor)**: Median 4 μg/m³ - proves indoor much cleaner
- **Donaus (GPS)**: Mobile with lat/lon - enables spatial analysis

---

## Technical Learnings

### InfluxDB Line Protocol to Parquet
```
# Raw format after influx_inspect export
v1,dbname=model_tdb,nickname=X,webid=123 pm2_5=15.4,temp=28.5 1731688200000

# Parse with DuckDB
SELECT
    regexp_extract(raw_line, 'nickname=([^,]+)', 1) as nickname,
    regexp_extract(raw_line, 'pm2_5=([0-9.]+)', 1)::DOUBLE as pm2_5,
    to_timestamp(timestamp/1000000000) as time
FROM raw_table;
```

### DuckDB Multi-Schema Union
```sql
-- When files have different columns
SELECT * FROM read_parquet(['file1.parquet', 'file2.parquet'], union_by_name=true);
```

### Validate Parquet Integrity
```bash
# Quick check
duckdb -c "SELECT COUNT(*) FROM read_parquet('file.parquet')"

# If fails: "No magic bytes" = corrupted/truncated file
```

---

## Mistakes Made

1. **Assumed sensor continuity** - Thought old/new were same sensors renamed
2. **Didn't check schemas first** - Lost time on union errors
3. **Didn't validate after rsync** - Didn't catch corrupted file immediately

---

## Recommendations

### For This Dataset
1. Re-export n-nc-2025 (corrupted)
2. Parse raw files to standard schema
3. Add model comparison to dashboard

### For Future Exports
1. Validate each file after rsync
2. Document schema per database before export
3. Use consistent export method (parsed preferred)

---

## Files Created

| File | Purpose |
|------|---------|
| `DATA_COMPARISON_REPORT.md` | Full analysis report |
| `exports_2024_new/*.parquet` | 12 new data files |

---

*Use when: comparing sensor datasets across time periods*
