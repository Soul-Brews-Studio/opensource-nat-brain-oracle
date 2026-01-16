---
title: ## Oracle Remote Access via Supergateway - TESTED WORKING
tags: [oracle, supergateway, sse, mcp, tunnel, white.local, remote-access, tested-working]
created: 2026-01-12
source: End-to-end test 2026-01-12
---

# ## Oracle Remote Access via Supergateway - TESTED WORKING

## Oracle Remote Access via Supergateway - TESTED WORKING

### Setup (2026-01-12)

**Mac (Oracle host):**
```bash
# Start supergateway (converts stdio MCP to SSE)
cd /Users/nat/Code/github.com/laris-co/oracle-v2
npx supergateway --stdio "bun src/index.ts" --port 9000

# Create reverse tunnel to white.local
ssh -R 9000:localhost:9000 nat@white.local -f -N
```

**white.local (client):**
```bash
# Add Oracle MCP via SSE
/home/nat/.claude/local/claude mcp add --transport sse --scope user oracle-v2 'http://localhost:9000/sse'

# Verify
/home/nat/.claude/local/claude mcp list
# → oracle-v2: http://localhost:9000/sse (SSE) - ✓ Connected
```

### Key Details
| Component | Port | Protocol |
|-----------|------|----------|
| Supergateway | 9000 | SSE/HTTP |
| Oracle HTTP | 47778 | HTTP |
| SSH Tunnel | 9000 | Reverse (-R) |

### Why Port 9000?
Port 8000 was in use. Always check `lsof -i :PORT` first.

### Persistent (Optional)
```bash
# Use autossh for auto-reconnect
autossh -M 0 -R 9000:localhost:9000 nat@white.local -f -N
```

### Files Created
- Blog: `ψ/writing/2026-01-12_oracle-mcp-architecture-complete-guide.md`

---
*Added via Oracle Learn*
