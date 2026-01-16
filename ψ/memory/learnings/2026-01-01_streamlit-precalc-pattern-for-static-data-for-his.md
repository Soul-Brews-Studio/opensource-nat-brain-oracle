---
title: Streamlit Precalc Pattern for Static Data
tags: [streamlit, precalc, performance, dashboard, parquet]
created: 2026-01-01
source: Session 2026-01-02 DustBoy
---

# Streamlit Precalc Pattern for Static Data

Streamlit Precalc Pattern for Static Data

For historical/static data that doesn't change:
1. Pre-calculate aggregations once
2. Save to small parquet files
3. Load instantly in Streamlit

```python
PRECALC_DIR = Path("precalc")
if precalc_file.exists():
    return duckdb.query(f"SELECT * FROM read_parquet('{precalc_file}')").df()
# Fallback to raw query if precalc missing
```

Precalc files:
- model_summary.parquet (~2KB)
- sensor_summary.parquet (~80KB)
- sensor_daily.parquet (~3MB)
- model_monthly.parquet (~7KB)
- model_hourly.parquet (~6KB)

Result: Dashboard loads instantly instead of querying 7GB raw data

---
*Added via Oracle Learn*
