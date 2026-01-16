---
title: ## Network Switch Kills Local Services
tags: [network, localhost, services, troubleshooting, arthur, oracle]
created: 2025-12-31
source: Oracle Learn
---

# ## Network Switch Kills Local Services

## Network Switch Kills Local Services

When switching networks (e.g., WiFi → iPad hotspot), localhost services lose connections and need restart.

**Symptoms:**
- Browser shows "connection refused"
- RAG shows "Offline"
- Pages load but API calls fail

**Fix - Restart all services:**
```bash
cd ψ/lab/oracle-v2/react-ui && npm run dev &     # Vite UI
cd ψ/lab/oracle-v2 && npm run server &           # Oracle API
cd ψ/lab/oracle-jarvis && bun run server.ts &    # Arthur API
```

**Pro tip:** Hard refresh (Cmd+Shift+R) to clear cached connections.

---
*Added via Oracle Learn*
