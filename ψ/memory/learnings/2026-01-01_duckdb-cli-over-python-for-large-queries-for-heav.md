---
title: DuckDB CLI over Python for Large Queries
tags: [duckdb, cli, performance, python, large-data]
created: 2026-01-01
source: Session 2026-01-02 DustBoy
---

# DuckDB CLI over Python for Large Queries

DuckDB CLI over Python for Large Queries

For heavy DuckDB operations on large datasets (7GB+), prefer DuckDB CLI over Python:

```bash
duckdb -c "COPY (SELECT ...) TO 'output.parquet' (FORMAT PARQUET)"
```

Benefits:
- Faster startup (no Python overhead)
- Better memory management
- Can run in tmux on remote server
- Direct COPY TO for exports

Use Python only for: Streamlit dashboards, complex logic, visualization

---
*Added via Oracle Learn*
