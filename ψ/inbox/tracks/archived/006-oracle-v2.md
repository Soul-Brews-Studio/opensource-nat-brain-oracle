---
track: oracle-v2
created: 2025-12-29 10:30
last_touch: 2025-12-30 08:00
status: hot
---

# Oracle v2 Track

## Current State

**COMPLETE**: Both speckits finished (65/65 tasks)

| Speckit | Status |
|---------|--------|
| 001-oracle-mcp | 37/37 ✅ |
| 002-hybrid-vector-search | 28/28 ✅ |

**PR #67**: Ready for merge

## What Was Built

- Hybrid search: FTS5 (keywords) + ChromaDB (vectors)
- MCP tools: oracle_search, oracle_consult, oracle_reflect, oracle_learn
- HTTP server: localhost:47778
- Web UI: Search, Consult, Reflect, Graph, Learn
- Pagination, staleness indicator, mode parameter

## Key Files

- `ψ/lab/oracle-v2/` - MCP server + HTTP server
- `specs/001-oracle-mcp/` - Main speckit (37 tasks)
- `specs/002-hybrid-vector-search/` - Vector search speckit (28 tasks)
- `ψ/learn/speckit/002-hybrid-vector-search/` - /learn speckit docs

## Next Actions

- [ ] Merge PR #67 to main
- [ ] Start oracle-list-endpoint speckit (browse latest docs)
- [ ] Optional: oracle-write-refactor (separate write from index)

## Learnings

- Speckit-first: Define criteria BEFORE implementing
- Python 3.12 for ChromaDB (not 3.14)
- /learn works on our own speckits

---

*Updated: 2025-12-30 08:00 - Speckit complete, ready for merge*
