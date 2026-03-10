# DustBoy Confidence System - PhD Thesis Data

> Nat's PhD thesis on air quality analysis using DustBoy sensor network

## Data Locations

| Location | Size | Use Case |
|----------|------|----------|
| **Local** (`parquet-exports-by-model/`) | 7.6GB | Dashboard, quick queries |
| **WHITE** (`/mnt/nvme1/duckdb-dustboy/`) | 88GB | Heavy queries, full data |

## WHITE Server (Preferred for Long Queries)

**Specs**: More RAM, faster storage - use for heavy DuckDB operations

### Access
```bash
# LAN (faster)
ssh nat@white.local

# Remote (anywhere)
ssh nat@floodboy-white4.alchemycat.org
```

### Long Query Pattern
```bash
# 1. SSH to WHITE
ssh nat@white.local

# 2. Start tmux session
tmux new -s duckdb

# 3. Run DuckDB CLI
cd /mnt/nvme1/duckdb-dustboy
duckdb dustboydb.duckdb

# 4. Run query (can take hours)
SELECT ... FROM read_parquet('parquet-exports/*.parquet') ...

# 5. Detach: Ctrl+B, D
# 6. Reattach later: tmux attach -t duckdb
```

### Export to Local
```bash
# On WHITE - export to parquet
COPY (SELECT ...) TO '/tmp/result.parquet' (FORMAT PARQUET);

# On MacBook - rsync back
rsync -avP nat@white.local:/tmp/result.parquet ./
```

## Data Summary

- **Records**: 1.29B deduplicated (2.6B raw)
- **Sensors**: 1,355 across 10 models
- **Period**: 2019-2024
- **Best model**: NBIoT (cleanest, median 9 μg/m³)
- **Worst sensors**: NH-029, NH-083, NH-016 (>120 μg/m³)

## Dashboard

```bash
cd ψ/lab/dustboy-confidence-system
uv run streamlit run app.py --server.port 8503
```

Pages:
1. Overview - Model summary
2. Sensor Explorer - Time series
3. Data Validity - Uptime analysis
4. Model Comparison - Cross-model patterns

## Key Learnings

1. **Divide & conquer** for large DISTINCT exports (split by year/half-year)
2. **>1000 PM2.5** mostly sensor errors, not real burning
3. **Pre-calculate** aggregations for static historical data
4. **tmux + DuckDB CLI** on WHITE for multi-hour queries

## Files

```
dustboy-confidence-system/
├── CLAUDE.md              # This file
├── app.py                 # Streamlit main
├── pages/                 # Multi-page dashboard
├── precalculate.py        # Pre-aggregate script
├── explore_models.py      # Data exploration
├── parquet-exports-by-model/  # 7.6GB cleaned data
├── charts/                # Generated visualizations
└── precalc/               # Pre-calculated aggregations
```
