---
title: ## DustBoy PhD Project - Complete Migration Record
tags: [dustboy, phd-thesis, influxdb, parquet, air-quality, sensor-data, white-server, dagster, ccdc]
created: 2026-01-04
source: 2026-01-04 dustboy migration complete record
---

# ## DustBoy PhD Project - Complete Migration Record

## DustBoy PhD Project - Complete Migration Record

### Project Overview
- **Name**: dustboy-confidence-system
- **Purpose**: PhD thesis - DustBoy air quality sensor confidence analysis
- **Data**: 1.6B+ rows, 12 InfluxDB models, Nov 2024 - Jan 2026
- **Old location**: ψ/lab/dustboy-confidence-system/ in Nat's Agents
- **New location**: ~/Code/github.com/laris-co/dustboy-confidence-system/
- **GitHub**: https://github.com/laris-co/dustboy-confidence-system (private)

### Data Contents (24GB total)
| Folder | Size | Contents |
|--------|------|----------|
| parquet-exports | 8.8G | OLD data 2019-Oct 2024 |
| exports_2024_new | 7.8G | NEW data Nov 2024-Jan 2026 |
| parquet-exports-by-model | 7.0G | Organized by model |
| dagster-backup | 423M | Backup pipeline + test exports |
| charts | 4.2M | Generated visualizations |
| white-sync | 3.6M | Analysis from WHITE server |
| data | 288K | CSV summaries |

### Code Contents (98 files)
- CHAPTER_1-6.md - Thesis chapters
- THESIS_*.md - Abstract, summary, defense FAQ
- *.py - Visualization and analysis scripts
- pages/ - Streamlit dashboard pages
- export_*.sh - InfluxDB export scripts
- dagster-backup/ - Dagster pipeline for automated backups

### Related Tools Created
1. **dustboy-sync skill** at ~/.claude/skills/dustboy-sync/
   - Check WHITE server export status
   - Run backfills from CCDC InfluxDB
   - Create truth tables
   - Sync parquets

2. **Dagster backup pipeline** at dagster-backup/
   - backfill_hourly.py - Query CCDC hourly
   - dustboy_backup/__init__.py - Dagster assets

### Data Sources
| Source | URL | Purpose |
|--------|-----|---------|
| WHITE server | ssh nat@floodboy-white4.alchemycat.org | Heavy exports (15GB parquet) |
| CCDC InfluxDB | http://influxdb2024.cmuccdc.org:8086 | Live queries, backfills |
| Local | exports_2024_new/ | Analysis, dashboard |

### Key Files
- INFLUXDB_2024_TRUTH.md - 12 models, monthly row counts
- DATA_COMPARISON_REPORT.md - OLD vs NEW dataset analysis
- README.md - Project overview

---
*Added via Oracle Learn*
