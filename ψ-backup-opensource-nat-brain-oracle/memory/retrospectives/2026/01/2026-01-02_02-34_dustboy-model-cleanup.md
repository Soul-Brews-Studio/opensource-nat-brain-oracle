---
title: "DustBoy Model Name Cleanup - Ground Truth Session"
date: 2026-01-02 02:34
duration: ~30 minutes
context_at_end: 81%
mood: productive
---

# Session Retrospective

## What We Did

### 1. Precalculation with DuckDB CLI
- Ran precalc queries directly with `duckdb -c` instead of Python
- Created: `model_summary.parquet`, `sensor_summary.parquet`, `sensor_daily.parquet`, `model_monthly.parquet`, `model_hourly.parquet`

### 2. Model Name Cleanup (Main Task)
**Problem**: Raw model names had dirty suffixes/prefixes
- `model_n-nc-2025_1s` → `model_n-nc-2025`
- `tags_model_n-nbiotdb_1s` → `model_n-nbiotdb`

**Solution**: Clean at source on WHITE, sync everywhere
```sql
REPLACE(REPLACE(model, 'tags_', ''), '_1s', '') as model
```

### 3. Ground Truth Sync
- WHITE: `/mnt/nvme1/duckdb-dustboy/exports_by_model/` (7.1GB, 10 files)
- Local: `parquet-exports-by-model/` (synced from WHITE)
- Both now have identical clean model names

### 4. Streamlit Dashboard Update
- Updated paths from `parquet-exports-by-model-clean/` back to `parquet-exports-by-model/`
- All 4 pages now use precalc files for instant loading

## Key Files

| Location | Purpose |
|----------|---------|
| WHITE:`exports_by_model/` | Ground truth (clean) |
| Local:`parquet-exports-by-model/` | Working copy (synced) |
| Local:`precalc/` | Pre-aggregated for dashboard |

## Model Name Mapping

| Raw (OLD) | Clean (NEW) |
|-----------|-------------|
| `model_n-nc-2025_1s` | `model_n-nc-2025` |
| `model_n-nh_1s` | `model_n-nh` |
| `tags_model_n-nbiotdb_1s` | `model_n-nbiotdb` |
| `model_t3db_1s` | `model_t3db` |
| `model_n-nh-wifi_1s` | `model_n-nh-wifi` |
| `tags_model_n-wifidb_1s` | `model_n-wifidb` |
| `model_n-wplus-dustboy22db_1s` | `model_n-wplus-dustboy22db` |
| `model_n-wifiblackdb_1s` | `model_n-wifiblackdb` |
| `model_n-wifidb2_1s` | `model_n-wifidb2` |
| `model_n-nc-wifi_1s` | `model_n-nc-wifi` |

## Key Learnings

1. **Fix source first** - Don't patch view layer, fix ground truth
2. **WHITE + tmux** - Use for heavy DuckDB CLI queries
3. **Rsync pattern** - WHITE → local, not the other way
4. **Model name pattern** - `REPLACE(REPLACE(model, 'tags_', ''), '_1s', '')`

## Commands for Next Session

```bash
# Dashboard
cd ψ/lab/dustboy-confidence-system
uv run streamlit run app.py --server.port 8503

# Sync from WHITE (if needed)
rsync -avP nat@white.local:/mnt/nvme1/duckdb-dustboy/exports_by_model/ parquet-exports-by-model/

# Query clean data
duckdb -c "SELECT DISTINCT model FROM read_parquet('parquet-exports-by-model/*.parquet')"
```

## What's Next

1. More visualizations for PhD thesis
2. Seasonal analysis (Feb-Apr burning season)
3. Sensor quality scoring
4. Export thesis-ready tables

## AI Diary

Good cleanup session. The `_1s` suffix was a small but annoying artifact from the original DustBoy database schema. Fixing it at the source (WHITE) rather than just in the view layer was the right call - now both WHITE and local have identical clean data.

The user's instinct to maintain ground truth consistency is solid PhD practice. Data provenance matters.

---
Generated with Claude Code
