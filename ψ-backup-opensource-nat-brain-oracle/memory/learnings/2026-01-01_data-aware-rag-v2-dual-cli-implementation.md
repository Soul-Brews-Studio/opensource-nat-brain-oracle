---
date: 2026-01-01
tags: [data-aware-rag, cli, rust, typescript, bun, speckit]
context: Data-Aware RAG v2 CLI implementation session
---

# Data-Aware RAG v2: Dual CLI Implementation

## What We Built

Created comprehensive spec/plan/tasks for Data-Aware RAG v2 with:
- Multi-format indexing (md, csv, json, yaml, txt)
- Explainable debug mode (pipeline steps with timing)
- Both TypeScript (Bun) and Rust CLI implementations

## Key Decisions

### TypeScript CLI (Quick Iteration)
- Uses existing indexer (117K records working)
- Commander.js + Chalk + Ora
- Integrates with existing React frontend
- Has import/module issues with Drizzle

### Rust CLI (Production Speed)
- clap for CLI parsing
- rusqlite for SQLite
- chromadb-rs for vector search
- Requires ChromaDB server running

## Architecture

```
data-aware-rag/
├── src/cli/           # TypeScript CLI (Bun)
│   ├── main.ts        # Entry point
│   └── commands/      # index, search, stats, serve
├── cli-rust/          # Rust CLI
│   └── src/
│       ├── main.rs    # Entry point
│       └── commands/  # explain, index, search, stats
├── frontend/          # React + Vite dashboard
└── data/              # SQLite database
```

## Current Status

| Component | TypeScript | Rust |
|-----------|------------|------|
| CLI framework | ✅ Commander.js | ✅ clap |
| Index command | ⚠️ Import issues | ✅ Works |
| Search command | ⚠️ Import issues | ✅ Works |
| Stats command | ⚠️ Import issues | ✅ Works |
| Debug mode | ✅ Designed | ✅ Works |
| ChromaDB | ⏳ Optional | ❌ Required |

## Debug Mode Output

Rust CLI with --debug shows:
```
[35m🔍 DEBUG MODE ENABLED[0m

[EXPLAIN] Starting data analysis...
[EXPLAIN] Found 290 files to analyze
[LOADER] learnings/2025-12-31_about-nat.md -> Markdown
[MARKDOWN] 2 sections found
  [0] "---" (161 chars)
  [1] "About Nat" (896 chars)
```

## Issues Encountered

### 1. TypeScript Import Conflicts
The existing codebase uses both:
- `bun:sqlite` (native SQLite)
- `drizzle-orm` (ORM layer)

Some files import `db` which doesn't exist in sqlite.ts.

**Fix**: Either standardize on one approach or create compatibility exports.

### 2. Rust ChromaDB Requirement
The Rust CLI fails if ChromaDB server isn't running:
```
Error: 404 Not Found: {"detail":"Not Found"}
```

**Fix**: Make ChromaDB optional, fall back to FTS5-only.

## Commands Reference

```bash
# TypeScript (when fixed)
bunx data-rag index ./docs --debug
bunx data-rag search "query" --debug
bunx data-rag stats

# Rust (works now)
./cli-rust/target/release/rag --debug explain ./docs
./cli-rust/target/release/rag --debug index ./docs
./cli-rust/target/release/rag search "query"
./cli-rust/target/release/rag stats
```

## Speckit Artifacts Created

- `specs/003-generic-markdown-rag/spec.md` - Full v2 spec
- `specs/003-generic-markdown-rag/plan.md` - 5-phase plan
- `specs/003-generic-markdown-rag/tasks.md` - 45 tasks

## Next Steps

1. Fix TypeScript imports (standardize on bun:sqlite)
2. Make Rust ChromaDB optional
3. Implement Phase 1 CLI fully
4. Add migration commands (Drizzle)
5. Fix frontend pagination (UX critic feedback)

## Key Learning

> "When you have two implementations (TS + Rust), keep the data layer consistent. Both should use the same database file and schema."

Currently:
- TypeScript uses `data/sqlite.db` (117K records)
- Rust uses `documents.db` (0 records)

Should standardize on one database path.
