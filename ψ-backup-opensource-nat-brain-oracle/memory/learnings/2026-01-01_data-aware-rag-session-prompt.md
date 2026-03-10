---
date: 2026-01-01
tags: [data-aware-rag, prompt, session, workflow]
context: Reusable prompt for Data-Aware RAG development sessions
---

# Data-Aware RAG Session Prompt

## The Prompt (Copy This)

```
Continue building Data-Aware RAG v2:

1. **Check handoff first**: Read ψ/inbox/handoff/latest
2. **Check tasks.md**: specs/003-generic-markdown-rag/tasks.md
3. **Update as you work**: Mark tasks [x] when done

Features needed:
- DB migrations (Drizzle for TS, Diesel for Rust)
- Data visualization
- CLI commands: index, search, stats, serve
- Multi-format: md, json, csv, yaml, txt
- Web frontend for testing queries
- **Explainable debug mode** - show every step with timing

Tech stack:
- TypeScript: bun, bunx, Commander.js, Chalk
- Rust: clap, rusqlite, chromadb, diesel
- Frontend: Vite, React

Rules:
- Every session must write lesson learned
- Handoff at 95% context
- Use --debug flag to show pipeline
- Group search results by file (not sections)
- Backend handles grouping, not frontend

Quick start:
cd ψ/lab/data-aware-rag
bun run cli stats --debug
bun run cli search "query" --debug
```

## Key Decisions Made

| Decision | Choice | Why |
|----------|--------|-----|
| Index granularity | Section level | Better search precision |
| Display granularity | File level | Better UX |
| Grouping location | Backend | Single source of truth |
| Default behavior | Grouped | Most common use case |
| CLI structure | Standalone rag.ts | Avoid Drizzle import conflicts |

## Common Issues & Fixes

### 1. Duplicate search results
**Fix**: Group by file in backend, use `--all` for sections

### 2. Drizzle import conflicts
**Fix**: Create standalone CLI using only bun:sqlite

### 3. Too few documents indexed
**Fix**: Use `--limit 5000` or higher

### 4. ChromaDB not running (Rust)
**Fix**: Start server or make optional with FTS5 fallback

## Commands Reference

```bash
# TypeScript CLI
bun run cli stats --debug
bun run cli search "query" --debug
bun run cli search "query" --all          # Show all sections
bun run cli index ./path --formats md     # Markdown only
bun run cli index ./path --clear --debug  # Fresh index

# Rust CLI (if built)
cd cli-rust && cargo run -- --debug stats
cd cli-rust && cargo run -- search "query"

# Frontend
bun run frontend:dev   # Dev server
bun run frontend:build # Production build

# Dashboard
bun run dashboard      # Port 8001
```

## Debug Pipeline Output

```
┌─────────────────────────────────────────────┐
│ Search Pipeline                              │
├─────────────────────────────────────────────┤
│ 1. [0ms]    Parse query  "oracle" → [oracle]│
│ 2. [1ms]    Open DB      bun:sqlite ready   │
│ 3. [2ms]    FTS5 search  7 raw hits         │
│ 4. [0ms]    Group files  4 files → top 4    │
├─────────────────────────────────────────────┤
│ Total: 3ms                                  │
└─────────────────────────────────────────────┘
```

## What to Update

After each session:
1. `specs/003-generic-markdown-rag/tasks.md` - Mark completed
2. `ψ/memory/learnings/` - New lesson learned
3. `ψ/inbox/handoff/` - Session handoff
