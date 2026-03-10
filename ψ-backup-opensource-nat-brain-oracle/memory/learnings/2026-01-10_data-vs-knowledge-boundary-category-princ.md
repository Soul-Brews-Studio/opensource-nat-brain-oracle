---
title: ## Data vs Knowledge Boundary
tags: [principle, data-boundary, oracle, architecture, child-oracle]
created: 2026-01-10
source: Children's Day 2026 - Architecture Decision
---

# ## Data vs Knowledge Boundary

## Data vs Knowledge Boundary

**Category**: Principle (for all agents)

### The Rule

Domain data (headlines, API responses, database rows) belongs in **domain stores** (DuckDB, vector DB, application databases).

Oracle stores only:
- **Patterns** discovered about how things work
- **Learnings** about systems, tools, workflows
- **Philosophy** and principles
- **Retrospectives** about sessions

### Never Store in Oracle

- Raw data from APIs
- Content dumps (headlines, articles, records)
- Database query results
- Lists of items

### Examples

| ✅ Oracle | ❌ Not Oracle |
|-----------|---------------|
| "DuckDB handles batch inserts efficiently" | 3,110 headlines from cm_command |
| "Rate limiting needed for 7 APIs" | API response JSON |
| "FTS5 + ChromaDB = hybrid search" | Search result contents |

### Why This Matters

Oracle = External Brain for **patterns and wisdom**
Domain Store = Storage for **domain-specific data**

Mixing them pollutes the knowledge base and makes search unreliable.

### For Child Oracles

Arthur, Volt, and future children must follow this boundary. Domain data stays in their domain stores. Only patterns flow to Oracle.

---
*Added via Oracle Learn*
