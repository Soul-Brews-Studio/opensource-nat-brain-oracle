---
title: **Oracle v2 Indexing Flow**
tags: [indexing, architecture, flow, oracle-v2, sqlite, chromadb]
created: 2026-01-03
source: Documentation - 2026-01-03
---

# **Oracle v2 Indexing Flow**

**Oracle v2 Indexing Flow**

How Oracle indexes knowledge from markdown files:

```
ORACLE_REPO_ROOT=/Users/nat/.../Nat-s-Agents
         ↓
    pnpm run index
         ↓
   src/indexer.ts scans ψ/memory/**/*.md
         ↓
   Parses: resonance/ (principles)
           learnings/ (patterns)  
           retrospectives/ (history)
         ↓
   Stores in oracle.db (at ψ/lab/oracle-v2/oracle.db)
         ↓
   Also stores in ChromaDB (vectors for semantic search)
         ↓
   Searchable via oracle_search, /search endpoint
```

**Key paths:**
- Source markdown: `Nat-s-Agents/ψ/memory/**/*.md`
- SQLite database: `Nat-s-Agents/ψ/lab/oracle-v2/oracle.db`
- ChromaDB vectors: `Nat-s-Agents/ψ/lab/oracle-v2/chroma/`
- Server code: `oracle-v2/src/` (separate repo)

**Reindex command:** `pnpm run index`
- Full rebuild (DELETE + rebuild from files)
- Preserves activity logs (search_log, consult_log, etc.)
- New learnings via oracle_learn need reindex to be searchable

---
*Added via Oracle Learn*
