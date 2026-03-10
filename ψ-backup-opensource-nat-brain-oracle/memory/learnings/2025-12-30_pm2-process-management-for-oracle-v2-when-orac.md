---
title: ## PM2 Process Management for Oracle v2
tags: [pm2, oracle-v2, server-restart, port-in-use, lesson-learned]
created: 2025-12-30
source: Oracle Learn
---

# ## PM2 Process Management for Oracle v2

## PM2 Process Management for Oracle v2

When Oracle v2 server is managed by pm2, direct restarts (npm run server, tsx, bun) will fail with EADDRINUSE because pm2 keeps the process alive and respawns it.

### The Error Pattern
```
Error: listen EADDRINUSE: address already in use :::37778
```
Killing the process manually doesn't help - pm2 respawns immediately.

### The Solution
```bash
# Check if pm2 is managing the server
pm2 list

# If you see oracle-v2-server, use pm2 to restart
npm run build        # Rebuild TypeScript first
pm2 restart oracle-v2-server
```

### Key Points
1. Always check `pm2 list` before trying to restart servers
2. Build before restart if source changed: `npm run build`
3. Never use `kill -9` on pm2-managed processes - they respawn
4. pm2 ecosystem.config.cjs defines the watch/restart behavior

---
*Added via Oracle Learn*
