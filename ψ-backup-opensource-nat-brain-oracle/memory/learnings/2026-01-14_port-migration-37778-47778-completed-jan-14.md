---
title: ## Port Migration: 37778 → 47778 (Completed Jan 14, 2026)
tags: [ports, migration, oracle-v2, oracle-status-tray, infrastructure, 47778]
created: 2026-01-14
source: Session 2026-01-14 port migration
---

# ## Port Migration: 37778 → 47778 (Completed Jan 14, 2026)

## Port Migration: 37778 → 47778 (Completed Jan 14, 2026)

### What Changed

All Oracle-related services migrated from port 37778 to 47778:

| Component | Before | After | Status |
|-----------|--------|-------|--------|
| oracle-v2 MCP plugin | 37778 | 47778 | ✅ Updated |
| oracle-v2 vite.config | 37778 | 47778 | ✅ Updated |
| oracle-status-tray | 37778 | 47778 | ✅ Pushed to GitHub |
| Active docs (tracks, drafts, learn) | 37778 | 47778 | ✅ Updated |

### Why Migration

- 47xxx series is the new standard (far from common ports)
- GitHub repo oracle-v2 already used 47778
- Local MCP plugin was outdated (37778)
- oracle-status-tray was connecting to wrong port

### Files NOT Changed (Historical Records)

- Retrospectives - document what WAS true at the time
- Old learnings - historical accuracy
- Archived specs - reference for past decisions
- Old handoffs - session history

### Rebuild Required

oracle-status-tray needs rebuild for port change to take effect:
```bash
cd ~/Code/github.com/laris-co/oracle-status-tray
cargo tauri build
```

### Port Allocation Standard

| Port | Service |
|------|---------|
| 47778 | oracle-v2 (MCP + HTTP) |
| 47779 | oracle-jarvis |
| 47780 | handoff-mcp-v4 |
| 47781 | fb-embedder |

---
*Added via Oracle Learn*
