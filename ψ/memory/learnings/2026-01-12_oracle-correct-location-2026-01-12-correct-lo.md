---
title: Oracle Correct Location (2026-01-12)
tags: [oracle, location, correct, home, ~/oracle-v2]
created: 2026-01-12
source: Session 2026-01-12 - User correction
---

# Oracle Correct Location (2026-01-12)

Oracle Correct Location (2026-01-12)

**Correct Location**: `~/oracle-v2/oracle.db`

NOT:
- ~/Code/github.com/laris-co/oracle-v2/ (wrong - too deep)
- Nat-s-Agents/ψ/lab/oracle-v2/ (wrong - old location)

**Why ~/oracle-v2/**:
- Simple, central, accessible
- Not buried in Code/ hierarchy
- Easy for all machines to find
- Global MCP config in ~/.claude.json points here

**Config in ~/.claude.json**:
```json
"mcpServers": {
  "oracle-v2": {
    "command": "bun",
    "args": ["~/oracle-v2/src/index.ts"]
  }
}
```

**Remote Access via SuperMCP**:
- Supergateway converts stdio → SSE
- Remote machines tunnel to SSE endpoint

---
*Added via Oracle Learn*
