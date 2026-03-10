---
title: Oracle v2 Dashboard URLs and Ports:
tags: [oracle-v2, dashboard, urls, ports, frontend, backend, api]
created: 2026-01-03
source: Oracle Dashboard v0.5.0 Session
---

# Oracle v2 Dashboard URLs and Ports:

Oracle v2 Dashboard URLs and Ports:

**Frontend (React):** http://localhost:3000
- Overview: /
- Feed: /feed
- Search: /search
- Consult: /consult
- Graph: /graph
- Handoff: /handoff

**Backend API:** http://localhost:37778
- Health: /health
- Stats: /stats
- Search: /search?q=query
- List: /list
- Consult: /consult?q=decision
- Reflect: /reflect
- Graph: /graph

**Start Commands:**
- Frontend: `cd frontend && pnpm dev`
- Backend: `pnpm server`

**GitHub:**
- Repo: https://github.com/laris-co/oracle-v2
- PR #7: https://github.com/laris-co/oracle-v2/pull/7

---
*Added via Oracle Learn*
