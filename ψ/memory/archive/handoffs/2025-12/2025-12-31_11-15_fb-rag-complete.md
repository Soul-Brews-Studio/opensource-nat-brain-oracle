---
title: "FB RAG Demo Complete + Speckit Practice"
date: 2025-12-31 11:15
context_at_handoff: ~40%
status: handoff
---

# FB RAG Demo + Speckit Practice

## Session Summary

Long run practice session continuing from previous. Created 2 more CLIs (063, 064) with full speckit workflow, then built Facebook RAG demo.

## Apps Created This Session

| Branch | App | Tech | Status |
|--------|-----|------|--------|
| 063-bookmark-cli | Bookmark Manager | Bun+Drizzle+FTS5 | ✓ Committed |
| 064-snippet-manager | Code Snippets | Full Speckit | ✓ Committed |
| 062-fb-embedder | Facebook RAG | SQLite vectors | ✓ Updated |

## FB RAG Pipeline (Complete)

```
DuckDB (47k records)
    ↓ ETL (documented in ETL.md)
CSV (15k filtered)
    ↓ local-embedder (transformers.js)
SQLite vectors (5,233 docs, 47MB)
    ↓ cosine similarity
Web UI (localhost:3456)
```

### Files Created/Updated

```
ψ/lab/fb-embedder/
├── data/extracted/
│   ├── ETL.md           # ETL documentation
│   ├── messages.csv     # 10k messages
│   ├── posts.csv        # 4.8k posts
│   └── comments.csv     # 298 comments
├── src/
│   ├── scripts/embed-csv.ts  # Embedding pipeline
│   ├── db/chroma.ts          # Updated: type filter
│   └── web/server.ts         # RAG UI with type filter
```

### Demo Working

```bash
# Start server
cd ψ/lab/fb-embedder && bun run src/web/server.ts

# API Examples
curl "http://localhost:3456/api/search?q=coffee"           # All types
curl "http://localhost:3456/api/search?q=beer&type=post"   # Posts only
curl "http://localhost:3456/api/search?q=beer&type=message" # Messages only
```

### Search Results

| Query | Type | Top Score | Example |
|-------|------|-----------|---------|
| coffee | all | 61.5% | "Pale Coffee" |
| beer | post | 31.6% | Brewing article |
| beer | message | 70.0% | "beer ที่ไปส่งอั้น" |

## Learnings Captured (Oracle)

1. **Bun Path Resolution** - Use `import.meta.dir` not `Bun.main`
2. **Drizzle Field Names** - camelCase vs snake_case in raw SQL

## Uncommitted Changes

- `ψ/lab/fb-embedder/src/db/chroma.ts` - Type filter added
- `ψ/lab/fb-embedder/src/web/server.ts` - UI with filter buttons

## Git Status

- Branch: main (20 commits ahead of origin)
- Need to push to origin

## Next Steps

1. Commit fb-embedder RAG updates
2. Push to origin
3. Continue speckit practice (065+)
4. User wants to index ALL data (not just 10k sample)

## Tech Stack (Proven)

- Bun runtime
- Drizzle ORM + bun:sqlite
- Commander.js CLI
- FTS5 for text search
- SQLite for vector storage
- local-embedder for embeddings

---
Session: Long run practice with Ralph Loop
Pattern: Speckit workflow + MCP tools
