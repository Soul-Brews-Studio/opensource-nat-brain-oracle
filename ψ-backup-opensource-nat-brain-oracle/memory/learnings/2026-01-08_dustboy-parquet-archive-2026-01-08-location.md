---
title: ## DustBoy Parquet Archive 2026-01-08
tags: [dustboy, parquet, white-server, phd-thesis, data-pipeline, influxdb, ccdc, archive, odin-nas]
created: 2026-01-08
source: Oracle Learn
---

# ## DustBoy Parquet Archive 2026-01-08

## DustBoy Parquet Archive 2026-01-08

**Location**: 
- WHITE: `/mnt/nvme1/dustboy-parquet-2026/`
- odin NAS: `/volume1/volume1/DustBoy/2026-01-08-parquet-archive/`

**Structure**:
- exports_2024/ (15GB, 12 files) - VPN era 2024-11 → 2026-01
- exports_by_model/ (7.1GB, 10 files) - Historical 2019 → 2024-10

**Total**: 22 parquet files, 3.24B rows, 22GB active + 36GB archived

**Key Gaps**:
- Standard 44-day gap: 2024-10-02 → 2024-11-15 (all major models)
- n-nbiotdb ends 2025-07-29 (model discontinued)
- sonydb2 ends 2025-08-04 (model discontinued)
- n-nh, n-nc-wifi missing VPN exports

**Reports Created**:
- PARQUET_BY_MODEL_REPORT.md - Combined timeline with gaps
- DATA_VERIFICATION_2026-01-08.md - Full verification
- DUSTBOY_DATA_MASTER_REPORT.md - 385-line complete inventory

**CCDC Migration**:
- influxdb2026-current (port 8087) - new 2026 data
- influxdb2026-legacy (port 8086) - reserved
- Old data preserved, commented in docker-compose

**Query Pattern**:
```sql
-- VPN era
SELECT * FROM read_parquet('/mnt/nvme1/dustboy-parquet-2026/exports_2024/*.parquet', union_by_name=true);

-- Historical
SELECT * FROM read_parquet('/mnt/nvme1/dustboy-parquet-2026/exports_by_model/*.parquet', union_by_name=true);
```

---
*Added via Oracle Learn*
