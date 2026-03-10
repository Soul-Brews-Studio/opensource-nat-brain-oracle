---
title: ## DustBoy InfluxDB Dual-Container Architecture
tags: [influxdb, dustboy, dual-container, data-gap, phd-thesis, parquet, time-series]
created: 2026-01-02
source: PhD Research Session 2026-01-02
---

# ## DustBoy InfluxDB Dual-Container Architecture

## DustBoy InfluxDB Dual-Container Architecture

The DustBoy network runs **TWO InfluxDB 1.8 containers** on the same server (202.28.244.195):

1. **Historical Container** (port 8086): 427 GB of archived data from 2019-2024
2. **Active 2024 Container** (port 8087): ~15 GB of current/new data

### Key Discovery
When checking for data gaps between Parquet exports and InfluxDB:
- The 2024 container has **3 NEW models** not in our export: T4, Donaus, Sonydb2
- T4: Indoor air quality (CO2, TVOC, VOC)
- Donaus: Mobile outdoor (GPS lat/lon, rainfall)
- Both include wind speed/direction, atmospheric pressure

### Sync Pattern
InfluxDB 1.8 TSM files can be copied directly between systems:
```bash
# Selective backup (by database)
tar -czf db-backup.tar.gz /backup/parts/influxdb2024/data/model_t4db/

# Run local InfluxDB with copied data
docker run -d -p 8086:8086 -v ./influxdb-data:/var/lib/influxdb influxdb:1.8
```

### PhD Thesis Implication
Our Parquet export (7.6 GB, 2.6B records) is a snapshot. For complete analysis:
1. Use Parquet for 2019-2024 historical data
2. Query 2024 container directly for latest data
3. Consider incremental export pipeline for new models

---
*Added via Oracle Learn*
