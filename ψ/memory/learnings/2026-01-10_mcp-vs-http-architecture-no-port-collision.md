---
title: ## MCP vs HTTP Architecture - No Port Collision
tags: [mcp, architecture, stdio, multi-agent, read-only, oracle]
created: 2026-01-10
source: Session 2026-01-10: Hono migration + multi-agent setup
---

# ## MCP vs HTTP Architecture - No Port Collision

## MCP vs HTTP Architecture - No Port Collision

**Key Insight**: MCP servers use stdio, not HTTP ports. Multiple agents can run simultaneously without collision.

### Architecture
```
Claude Session A ←──stdio──→ bun src/index.ts (MCP process A)
Claude Session B ←──stdio──→ bun src/index.ts (MCP process B)
                                    ↓
                              SQLite DB (shared)
                                    ↓
Browser/API ←──────HTTP──────→ bun src/server.ts (port 47778, single daemon)
```

### Why No Collision
- **MCP = stdio**: Each Claude session spawns its own process, communicates via stdin/stdout
- **HTTP = single daemon**: Protected by lock file, shared by all
- **DB = shared**: All processes read/write same `~/.oracle-v2/oracle.db`

### Multi-Agent Setup
```json
// Mother (full access)
{ "command": "bun", "args": ["run", "src/index.ts"] }

// Arthur (read-only)
{ "command": "bun", "args": ["run", "src/index.ts"], "env": { "ORACLE_READ_ONLY": "true" } }
```

Both can run simultaneously - separate stdio processes, shared DB, no port conflict.

### Read-Only Mode
- `ORACLE_READ_ONLY=true` hides write tools from agent
- Agent can search/consult but not learn/modify
- Enforced at MCP level, not just hidden

---
*Added via Oracle Learn*
