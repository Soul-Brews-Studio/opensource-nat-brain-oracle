---
date: 2026-01-01
tags: [data-aware-rag, architecture, typescript, rust, cli, frontend]
context: Complete Data-Aware RAG v2 verification
---

# Data-Aware RAG Complete Architecture

## The Problem

Building a production RAG system requires many components:
- Multi-format indexing
- Full-text search + vector search
- Database migrations
- CLI for automation
- Web frontend for testing
- Explainable debug mode

Coordinating these across TypeScript + Rust is complex.

## The Solution: Dual-CLI Architecture

### TypeScript CLI (Bun)

```bash
bun run cli --help

Commands:
  stats           Show database statistics
  search <query>  Search indexed documents
  serve           Start web dashboard
  index <path>    Index files into the database
  migrate         Database migration commands
```

**Best for**: Interactive use, web serving, migrations

### Rust CLI (High Performance)

```bash
./cli-rust/target/release/rag --help

Commands:
  explain    Analyze data before indexing
  index      Index data into SQLite + ChromaDB
  search     Search indexed documents
  stats      Show collection statistics
  dashboard  Start dashboard server
```

**Best for**: Large datasets, batch processing, speed

## Key Components

| Component | Tech | Purpose |
|-----------|------|---------|
| SQLite + FTS5 | bun:sqlite | Full-text search |
| ChromaDB | chromadb | Vector embeddings |
| Drizzle ORM | drizzle-orm | DB migrations |
| Commander.js | commander | CLI parsing |
| Vite + React | vite, react | Web frontend |
| Rust + Clap | clap, rusqlite | High-perf CLI |

## Explainable Debug Mode

Every search shows the pipeline:

```
┌─────────────────────────────────────────────┐
│ Search Pipeline                              │
├─────────────────────────────────────────────┤
│ 1. [0ms]    Parse query  "oracle philosophy │
│ 2. [1ms]    Open DB      bun:sqlite ready   │
│ 3. [4ms]    FTS5 search  15 hits            │
│ 4. [0ms]    Group files  11 files → top 3   │
├─────────────────────────────────────────────┤
│ Total: 5ms                                  │
└─────────────────────────────────────────────┘
```

## Migration Commands

```bash
# Generate migration
bun run cli migrate generate add-embeddings

# Push schema
bun run cli migrate push

# Check status
bun run cli migrate status

# Open Drizzle Studio
bun run cli migrate studio
```

## Test Commands

```bash
# TypeScript CLI
bun run cli stats                          # 42,145 documents
bun run cli search "oracle" --debug        # FTS with timing
bun run cli search "oracle" --mode hybrid  # + vector search

# Rust CLI
./cli-rust/target/release/rag stats        # Fast stats
./cli-rust/target/release/rag search "oracle" --mode fts --debug

# Frontend
cd frontend && bun run dev                 # http://localhost:5173
```

## Hybrid Search Flow

```
Query → FTS5 Search ─┬─> Merge (RRF) → Rank → Results
                     │
       Vector Search ─┘
```

RRF (Reciprocal Rank Fusion) with k=60 combines both result sets.

## Key Learnings

1. **Dual CLI works well** - TypeScript for dev, Rust for prod
2. **Debug mode is essential** - Makes optimization visible
3. **FTS5 is fast** - Sub-100ms for 40K+ documents
4. **ChromaDB needs server** - Hybrid search requires running instance
5. **Drizzle migrations** - `push` for dev, `generate` for prod

## Key Statement

> "A complete RAG system needs both speed (Rust) and flexibility (TypeScript). The explainable debug mode transforms a black box into a transparent pipeline."
