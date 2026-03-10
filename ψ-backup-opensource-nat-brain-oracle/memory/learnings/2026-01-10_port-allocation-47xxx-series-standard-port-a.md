---
title: ## Port Allocation - 47xxx Series
tags: [ports, configuration, infrastructure]
created: 2026-01-10
source: Session 2026-01-10
---

# ## Port Allocation - 47xxx Series

## Port Allocation - 47xxx Series

Standard port allocation for Nat's Agents apps:

| Port | App |
|------|-----|
| 47778 | oracle-v2 (MCP + HTTP) |
| 47779 | oracle-jarvis |
| 47780 | handoff-mcp-v4 |
| 47781 | fb-embedder |
| 47782+ | (reserved for future) |

Why 47xxx:
- Far from common ports (3000, 8080)
- Sequential for easy memory
- Room to grow (47782-47999)

---
*Added via Oracle Learn*
