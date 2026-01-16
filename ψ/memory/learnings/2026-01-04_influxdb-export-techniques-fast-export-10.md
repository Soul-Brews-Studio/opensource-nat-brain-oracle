---
title: ## InfluxDB Export Techniques
tags: [influxdb, parquet, duckdb, export, line-protocol, tmux, white-server]
created: 2026-01-04
source: 2026-01-02 InfluxDB export session
---

# ## InfluxDB Export Techniques

## InfluxDB Export Techniques

### Fast Export (10x faster than HTTP)
```bash
# Use influx_inspect for bulk exports
docker exec influxdb influx_inspect export \
  -database model_nc2025db \
  -lponly \
  -datadir /var/lib/influxdb/data \
  -waldir /var/lib/influxdb/wal \
  -out /exports/model.lp

# Convert line protocol to parquet via DuckDB
duckdb -c "
COPY (
  SELECT 
    split_part(column0, ' ', -1)::BIGINT as timestamp,
    column0 as raw_line,
    'model-name' as model
  FROM read_csv('model.lp', header=false, sep=E'\n')
  WHERE column0 NOT LIKE '#%'
) TO 'model.parquet' (FORMAT PARQUET, COMPRESSION ZSTD)"
```

### HTTP Backfill (for incremental)
```python
# Query CCDC InfluxDB hourly
resp = requests.get(
    f"{INFLUXDB_URL}/query",
    params={"db": db, "q": f"SELECT * FROM /.*/ WHERE time >= '{start}' AND time < '{end}'"},
    headers={"Accept": "application/csv"},
)
```

### Schema Differences
- **Type A** (donaus, t4, tdb): `time` column (milliseconds), parsed fields
- **Type B** (n-nc-2025, n-wifidb2): `timestamp` column (nanoseconds), raw_line

### tmux for Long Exports
```bash
ssh nat@floodboy-white4.alchemycat.org
tmux new-session -d -s export "./export_all_fast.sh"
# Monitor: tmux attach -t export
```

---
*Added via Oracle Learn*
