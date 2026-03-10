---
title: DustBoy Ground Truth Sync Pattern
tags: [dustboy, phd, white-server, ground-truth, rsync, data-sync]
created: 2026-01-01
source: Session 2026-01-02 model cleanup
---

# DustBoy Ground Truth Sync Pattern

DustBoy Ground Truth Sync Pattern

WHITE server is the source of truth for DustBoy PhD data.
Local is a working copy synced via rsync.

Sync command:
```bash
rsync -avP nat@white.local:/mnt/nvme1/duckdb-dustboy/exports_by_model/ parquet-exports-by-model/
```

Key principle: Fix source data first (WHITE), then sync everywhere. Never patch only the view layer.

---
*Added via Oracle Learn*
