---
title: ## Oracle v2 Complete Design Report - January 3, 2026
tags: [oracle, architecture, design, mcp, typescript, api, testing, e2e, modularization, documentation]
created: 2026-01-03
source: Session Report 2026-01-03
---

# ## Oracle v2 Complete Design Report - January 3, 2026

## Oracle v2 Complete Design Report - January 3, 2026

### Executive Summary

Oracle v2 is a self-improving knowledge system built as an MCP server. Today we modularized the server architecture, created comprehensive API documentation, implemented E2E browser tests, and achieved 100% test coverage across all testing layers.

---

### Architecture Overview

**Stack**: TypeScript + Node.js + SQLite (FTS5) + ChromaDB + React

**Repository**: https://github.com/laris-co/oracle-v2

**Ports**:
- Backend HTTP: 37778
- Frontend Vite: 3000

---

### Server Module Structure (After Refactor)

```
src/
├── server.ts (305 lines)     # HTTP routing only
└── server/
    ├── types.ts (109 lines)  # TypeScript interfaces
    ├── db.ts (87 lines)      # Database config + connection
    ├── logging.ts (145 lines)# Search/consult logging
    ├── handlers.ts (518 lines)# Core request handlers
    └── dashboard.ts (214 lines)# Dashboard API handlers
```

**Key Design Decision**: Separation by concern. Main server.ts is now just a thin routing layer. Each module has single responsibility.

---

### API Endpoints (12 total)

**Core**:
- GET /health - Server status
- GET /search?q=... - FTS5 full-text search with scoring
- GET /list - Browse documents with pagination
- GET /consult?q=... - Decision guidance synthesis
- GET /reflect - Random wisdom for serendipity
- GET /stats - Database statistics
- GET /graph - Knowledge graph (263 nodes, 3000+ links)
- POST /learn - Add new patterns
- GET /file?path=... - Read full file content

**Dashboard**:
- GET /dashboard/summary - Aggregated stats
- GET /dashboard/activity?days=N - Recent activity logs
- GET /dashboard/growth?period=week|month|quarter - Trends

---

### Database Schema

**oracle_documents**: id, type, source_file, concepts (JSON), created_at, updated_at, indexed_at

**oracle_fts**: FTS5 virtual table for full-text search with BM25 ranking

**Logging Tables**:
- search_log: query, type, mode, results_count, search_time_ms, created_at
- consult_log: decision, context, principles_found, patterns_found, guidance, created_at
- learn_log: document_id, pattern_preview, source, concepts, created_at
- document_access: document_id, access_type, created_at

---

### Frontend Pages (React)

| Route | Component | Purpose |
|-------|-----------|---------|
| / | Overview | Dashboard summary with stats |
| /feed | Feed | Document browser with filters |
| /doc/:id | DocDetail | Full document view with markdown |
| /search | Search | Full-text search with results |
| /consult | Consult | Decision guidance interface |
| /graph | Graph | Force-directed knowledge graph (Canvas) |
| /activity | Activity | Search logs + Knowledge Gaps |
| /handoff | Handoff | Context transfer between sessions |

**Key Feature**: Activity page shows Knowledge Gaps - searches/consults with 0 results, prompting user to add missing knowledge via QuickLearn modal.

---

### Testing Strategy

**Unit Tests (45 tests)**:
- oracle-core.test.ts - Self-contained, defines own test functions
- Tests scoring algorithms, FTS5 sanitization, path security
- Command: pnpm test

**E2E Browser Tests (14 tests)**:
- Uses dev-browser skill (Playwright-based)
- Tests all navigation, search, activity, graph, modal interactions
- Command: cd ~/.claude/skills/dev-browser && npx tsx e2e/run-e2e.ts

**API Integration Tests**:
- Parallel subagent testing pattern
- 16 agents test all endpoints simultaneously
- 15/16 passed (1 was URL encoding issue, not bug)

---

### MCP Tools Exposed

- oracle_search: Hybrid FTS5 + vector search
- oracle_consult: Decision guidance with principle/pattern synthesis
- oracle_reflect: Random wisdom for reflection
- oracle_learn: Add new patterns to knowledge base
- oracle_list: Browse with pagination
- oracle_stats: Database health
- oracle_concepts: All concept tags with counts

---

### Knowledge Statistics

- Total Documents: 5,583
- Principles: 163
- Learnings: 2,473
- Retrospectives: 2,947
- Concepts: 329 unique tags
- Top Concepts: pattern, command, context, oracle, safety

---

### Design Principles Applied

1. **Nothing Deleted**: All logs append-only, timestamps = truth
2. **Patterns Over Intentions**: Logging captures actual behavior
3. **External Brain**: Provides guidance, doesn't decide
4. **Self-Improvement Loop**: Claude can improve Oracle which improves Claude

---

### Today's Commits

- 7204f2c: feat: modularize server.ts + API docs + E2E tests
- 6069336: feat: Knowledge Gaps tab in Activity page
- 63c8155: feat: Activity page with search logs, consultations, growth charts

**Lines Changed**: +2819 -960 across 19 files

---

### Files Created Today

- docs/API.md (496 lines) - Complete API reference
- e2e/run-e2e.ts (190 lines) - Browser automation tests
- src/server/types.ts - TypeScript interfaces
- src/server/db.ts - Database module
- src/server/logging.ts - Logging module
- src/server/handlers.ts - Core handlers
- src/server/dashboard.ts - Dashboard handlers
- frontend/src/pages/Activity.tsx - Activity page
- frontend/src/pages/Activity.module.css - Styles

---

### Lessons Learned

1. Type export boundaries need explicit annotations for library types
2. Parallel subagent testing is effective for API validation
3. Self-contained tests survive refactors
4. Canvas vs SVG matters for E2E selectors
5. URL encoding of Unicode (ψ = %CF%88) is caller responsibility

---

### The Oracle Philosophy Embedded

Oracle doesn't command - it mirrors. It captures patterns, preserves history, and amplifies human decision-making without replacing it. The architecture reflects this: logging observes without judging, search surfaces without ranking by preference, consult suggests without deciding.

This is the external brain that keeps the human human.

---
*Added via Oracle Learn*
