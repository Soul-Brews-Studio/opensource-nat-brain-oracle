---
title: ## Oracle Status Tray - Index Health Display
tags: [oracle-status-tray, ui, index-health]
created: 2026-01-09
source: Oracle Status Tray Development
---

# ## Oracle Status Tray - Index Health Display

## Oracle Status Tray - Index Health Display

The tray shows INDEX HEALTH with human-readable time:

**Server returns:**
- `last_indexed`: ISO timestamp (e.g., "2026-01-09T00:58:19.118Z")
- `index_age_hours`: hours since last index
- `is_stale`: boolean (true if > 24h old)
- `is_indexing`: boolean

**Tray converts to:**
- `< 1h` → "Just now"
- `1-24h` → "Xh ago"
- `> 24h` → "Xd ago"

**Status indicator:**
- Green dot = Ready
- Yellow dot = Stale (> 24h)
- Blue pulsing = Indexing in progress

---
*Added via Oracle Learn*
