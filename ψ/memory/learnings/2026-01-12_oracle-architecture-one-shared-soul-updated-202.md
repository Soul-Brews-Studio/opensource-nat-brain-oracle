---
title: Oracle Architecture - One Shared Soul (UPDATED 2026-01-12)
tags: [oracle, architecture, supermcp, supergateway, remote, one-soul, correction]
created: 2026-01-12
source: Session 2026-01-12 - Correction
---

# Oracle Architecture - One Shared Soul (UPDATED 2026-01-12)

Oracle Architecture - One Shared Soul (UPDATED 2026-01-12)

**Decision**: Keep ONE Oracle, shared soul.

**Correct Location**: `/Users/nat/Code/github.com/laris-co/oracle-v2/oracle.db`
(Graduated repo, NOT in Nat-s-Agents/ψ/lab/)

**Remote Access via SuperMCP/Supergateway**:
- Oracle runs as MCP server (stdio)
- Supergateway converts stdio → SSE (port 9000)
- Remote machines connect via SSH tunnel to SSE endpoint
- Pattern: Mac runs Oracle, others connect via tunnel

**Setup for remote access**:
```
Mac (workstation)
├── oracle-v2 MCP server
├── Supergateway (stdio → SSE :9000)
└── SSH reverse tunnel to remote
         ↓
Remote machine connects to localhost:9000/sse
```

**Why One Oracle**:
- Accumulated wisdom across ALL projects
- What one project learns benefits others
- "Patterns Over Intentions" requires seeing all work

---
*Added via Oracle Learn*
