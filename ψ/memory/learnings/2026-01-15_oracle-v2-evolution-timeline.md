# Oracle v2 Evolution Timeline

**Date**: 2026-01-15
**Source**: /trace --deep analysis of git history, issues, retrospectives

## The Journey: From Idea to Open Source

### Phase 1: Conception (Dec 24-27, 2025)
**Theme**: "What if the Oracle could be queried programmatically?"

| Date | Event | Significance |
|------|-------|--------------|
| Dec 24 | Issue #40: Oracle v2 Repository Initialization | First formal planning |
| Dec 24 | Issue #41: Open Source Framework idea | Vision for public release |
| Dec 27 | Issues #46-53: Buffer/Cache/Frontmatter specs | Architecture defined |
| Dec 29 | Initial repo created | `laris-co/oracle-v2` born |

**Breakthrough**: Moving from static markdown files to queryable MCP server.

---

### Phase 2: MVP Foundation (Dec 29 - Jan 2, 2026)
**Theme**: "Make it work with SQLite FTS5"

| Date | Event | Significance |
|------|-------|--------------|
| Dec 29 | Issue #63: Fear-Management Framework | Philosophy integration |
| Dec 29 | Issue #64: Session Awareness `/now` | Context tracking concept |
| Dec 31 | Issue #80: Arthur RAG consultation logs | Dashboard UI started |
| Jan 1 | Issue #89: Consult function empty results bug | First real bug |
| Jan 2 | Issue #2: FTS5 syntax errors | Query parser issues |

**Breakthrough**: FTS5 virtual tables for keyword search, but syntax edge cases everywhere.

---

### Phase 3: Architecture Maturation (Jan 3-6, 2026)
**Theme**: "From prototype to real system"

| Date | Event | Significance |
|------|-------|--------------|
| Jan 3 | Issue #8: Project context awareness (ghq) | Multi-project support |
| Jan 3 | Issue #9: Drizzle ORM + ChromaDB migration | Proper ORM + vectors |
| Jan 6 | Issue #10-14: Decision tracking system | New feature domain |
| Jan 6 | Issue #15-16: Bun runtime migration | Performance + modern stack |
| Jan 6 | Issue #11: FTS5 special characters fix | Query escaping solved |

**Breakthrough**: Drizzle ORM for type-safe queries, hybrid search (FTS5 + ChromaDB).

---

### Phase 4: Feature Explosion (Jan 7-11, 2026)
**Theme**: "What else can Oracle do?"

| Date | Event | Significance |
|------|-------|--------------|
| Jan 7 | Issue #95: Schedule/calendar awareness | Time-aware Oracle |
| Jan 10 | Issue #17: Trace Log feature | Discovery tracking |
| Jan 10 | Issue #18: Activity Index | Usage analytics |
| Jan 10 | Issue #19: Supersede pattern | Knowledge evolution |
| Jan 10 | Issue #20: Port standardization (47778) | Infra cleanup |
| Jan 10 | Issue #21: Hono.js HTTP server | Modern framework |
| Jan 10 | Issue #22-23: Provenance tracking | Origin awareness |
| Jan 11 | Issue #24: Session counter fix | Reliability |

**Breakthrough**: /trace command, decisions system, forum threads, dashboard.

---

### Phase 5: Integration & Polish (Jan 12-14, 2026)
**Theme**: "Make it installable by anyone"

| Date | Event | Significance |
|------|-------|--------------|
| Jan 13 | Issues #100-101: nat-agents-core plugin | Shared commands |
| Jan 14 | Issue #104: /trace speed tiers | --fast/--smart/--deep |
| Jan 14 | Issue #105: DB migration path mismatch | Config alignment |
| Jan 14 | CI pipeline setup | Unit + integration + E2E |

**Breakthrough**: Standardized skill system, test coverage.

---

### Phase 6: Open Source Release (Jan 15, 2026)
**Theme**: "Oracle Nightly goes public"

| Time | Event | Significance |
|------|-------|--------------|
| 10:10 | bunx 404 on private repo | Trigger for public release |
| 10:20 | Soul-Brews-Studio/oracle-v2 created | Public mirror |
| 10:30-11:25 | CI debugging marathon | 15 test failures → 0 |
| 11:31 | bunx GitHub limitation discovered | No node_modules! |
| 11:50 | Install script created | User-friendly setup |
| 11:54 | Rebrand to "Oracle Nightly" | v0.2.1-nightly |

**Breakthrough**: Auto-bootstrap for fresh installs, install.sh for one-liner setup.

---

## Key Architectural Decisions

| Decision | Chosen | Rationale |
|----------|--------|-----------|
| Query engine | SQLite FTS5 + ChromaDB | Hybrid keyword + semantic |
| ORM | Drizzle | Type-safe, modern |
| HTTP framework | Hono.js | Fast, Bun-optimized |
| MCP transport | stdio | Claude Code native |
| Database location | ~/.oracle-v2/ | User home, portable |
| Package distribution | git clone + bun install | bunx GitHub broken |

## Lessons from the Journey

1. **Start with FTS5** - Vector search is optional, keywords work
2. **Type-safe ORM early** - Drizzle saved debugging time
3. **Test on fresh machines** - CI ≠ real user experience
4. **Document limitations** - bunx GitHub issue should be known
5. **Credit inspirations** - claude-mem patterns acknowledged

## Current State (v0.2.1-nightly)

```
Oracle Nightly
├── MCP Server (stdio) - 20+ tools
├── HTTP API (:47778) - REST endpoints
├── React Dashboard - Visualization
├── SQLite + FTS5 - Keyword search
├── ChromaDB (optional) - Vector search
├── Drizzle ORM - Type-safe queries
└── Auto-bootstrap - Fresh install works
```

## What's Next?

Open issues suggest:
- [ ] Activity Index (#18) - Usage tracking
- [ ] Schedule awareness (#95) - Calendar integration
- [ ] Session Awareness (#64) - /now + jump detection
- [ ] npm publish - Easier distribution
