# DustBoy Monthly Backup Pipeline

Dagster pipeline for monthly InfluxDB → Parquet backups.

## Setup on WHITE Server

```bash
cd /mnt/nvme1/dustboy-monthly-backup
git clone [this-repo] dagster-backup
cd dagster-backup

# Install with uv
uv sync

# Run Dagster
uv run dagster dev -h 0.0.0.0 -p 3001
```

## Output Structure

```
/mnt/nvme1/dustboy-monthly-backup/
├── 2024-11/
│   ├── t4.parquet
│   ├── donaus.parquet
│   ├── n-nc-2025.parquet
│   └── manifest.json
├── 2024-12/
│   └── ...
└── 2025-01/
    └── ...
```

## Schedule

- Runs **1st of every month at 3 AM**
- Exports previous month's data
- Skips existing files (idempotent)

## Manual Run

```bash
# Via Dagster UI
uv run dagster dev

# Or CLI
uv run dagster job execute -j monthly_backup_job \
  --config '{"ops": {"monthly_backup": {"config": {"year": 2024, "month": 12}}}}'
```

## Query Monthly Data

```python
import duckdb

# Single month
df = duckdb.query("""
    SELECT * FROM read_parquet('/mnt/nvme1/dustboy-monthly-backup/2024-12/*.parquet')
""").df()

# All months
df = duckdb.query("""
    SELECT * FROM read_parquet('/mnt/nvme1/dustboy-monthly-backup/*/*.parquet')
""").df()
```

## Single Source of Truth

Each month = one folder with all models as parquet files.
- Immutable after creation
- Easy to query with DuckDB
- ZSTD compressed (~95% reduction)
