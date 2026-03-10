---
title: Oracle v2 Quick Reference Cheatsheet
tags: [oracle, reference, cheatsheet, mcp, architecture, troubleshooting]
created: 2026-01-05
source: Documentation consolidation
---

# Oracle v2 Quick Reference Cheatsheet

> Quick operations guide for Oracle v2 - the self-improving knowledge system.

---

## Architecture at a Glance

```
┌─────────────────────────────────────────────────────────────┐
│                     MCP Server Layer                        │
│  oracle_search | oracle_consult | oracle_learn | ...        │
└────────────────────────┬────────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┐
         ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  FTS5       │  │  ChromaDB   │  │  HTTP API   │
│ (keywords)  │  │ (semantic)  │  │ (dashboard) │
└─────────────┘  └─────────────┘  └─────────────┘
         │               │               │
         └───────────────┼───────────────┘
                         ▼
              ┌─────────────────────┐
              │  SQLite oracle.db   │
              │  6,077 documents    │
              │  176 unique concepts│
              └─────────────────────┘
                         ▲
                         │
         ┌───────────────┴───────────────┐
         │        ψ/memory/**/*.md       │
         │  resonance/ → principles      │
         │  learnings/ → patterns        │
         │  retrospectives/ → history    │
         └───────────────────────────────┘
```

**Stack**: TypeScript + Node.js + SQLite (FTS5) + ChromaDB + React
**Ports**: Backend HTTP: 37778 | Frontend Vite: 3000

---

## Database Schema

### Core Tables

| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `oracle_documents` | Document metadata | id, type, source_file, concepts (JSON), indexed_at |
| `oracle_fts` | Full-text search (FTS5) | content, BM25 ranking |

### Logging Tables (Append-Only)

| Table | Purpose |
|-------|---------|
| `search_log` | query, mode, results_count, search_time_ms |
| `consult_log` | decision, context, principles_found, guidance |
| `learn_log` | document_id, pattern_preview, concepts |
| `document_access` | document_id, access_type, created_at |

### Document Types

| Type | Source | Count |
|------|--------|-------|
| `principle` | ψ/memory/resonance/*.md | 295 |
| `learning` | ψ/memory/learnings/*.md | 2,575 |
| `retro` | ψ/memory/retrospectives/**/*.md | 3,207 |

---

## Core MCP Commands

### Search Operations

| Command | Use When | Example |
|---------|----------|---------|
| `oracle_search` | Finding specific knowledge | `query: "git force push safety"` |
| `oracle_consult` | Making decisions | `decision: "should I use Redis or SQLite?"` |
| `oracle_reflect` | Random inspiration | No params needed |
| `oracle_list` | Browsing documents | `type: "learning", limit: 10` |

### Search Modes

```
oracle_search(query, mode)
  - hybrid (default): FTS5 + vector combined
  - fts: Keywords only, faster
  - vector: Semantic only, slower
```

### Writing Operations

| Command | Use When | Example |
|---------|----------|---------|
| `oracle_learn` | Adding new patterns | `pattern: "...", concepts: ["git", "safety"]` |
| `oracle_thread` | Multi-turn discussion | `message: "...", threadId: 123` |

### Administrative

| Command | Use When |
|---------|----------|
| `oracle_stats` | Check health, document counts |
| `oracle_concepts` | Browse all tags with counts |
| `oracle_threads` | List discussion threads |

---

## Search Patterns

### Good vs Bad Queries

| Bad (Generic) | Good (Specific) |
|---------------|-----------------|
| `project migration` | `dustboy spinoff migration` |
| `git workflow` | `force push main prevention` |
| `error handling` | `TypeScript BetterSQLite3 type export` |

### Search Before Task Pattern

```
1. oracle_threads(status="all")     # Check if someone working on it
2. oracle_search("[project] [task]") # Search with specifics
3. oracle_list(type="learning", limit=10) # Recent patterns
```

---

## Performance Troubleshooting

### Slow Searches

| Symptom | Cause | Fix |
|---------|-------|-----|
| >500ms search | ChromaDB cold start | Use `mode: "fts"` for quick queries |
| 0 results | Wrong keywords | Try `mode: "vector"` for semantic |
| Too many results | Generic query | Add concept filter |

### Database Health Check

```bash
# Check stats
oracle_stats()

# Expected healthy response:
{
  "fts_status": "healthy",
  "chroma_status": "connected",
  "fts_indexed": 6077
}
```

### Reindexing

```bash
# When: After adding files directly to ψ/memory/
cd oracle-v2
pnpm run index

# Note: oracle_learn adds don't need reindex
# Reindex preserves: search_log, consult_log, learn_log
```

---

## Cost Model: Context Efficiency

### Token Economics

| Operation | Token Cost | When to Use |
|-----------|------------|-------------|
| `oracle_search` | ~200-500 | Quick lookups |
| `oracle_consult` | ~500-1000 | Decisions needing synthesis |
| `oracle_list` | ~100-300 | Browsing |
| Read full file | ~1000-5000 | Only when search insufficient |

### Context-Finder Survival Pattern

```
Main Agent (Opus)          Subagent (Haiku)
      │                          │
      │  "search for X"          │
      ├─────────────────────────>│
      │                          │ oracle_search()
      │                          │ read results
      │   "found: summary"       │
      │<─────────────────────────┤
      │                          │
      ▼                          ▼
   Saves tokens              Cheap, fast
```

**Rule**: Main agent delegates search to Haiku subagents. Only read files when search results insufficient.

---

## Anti-Patterns

### 1. Search Without Specificity

```
# Bad: Generic terms find generic patterns
oracle_search("project setup")

# Good: Include project name and action
oracle_search("oracle-v2 server modularization")
```

### 2. Skipping Thread Check

```
# Bad: Start task, duplicate work
start_working_on_feature()

# Good: Check if already in progress
oracle_threads(status="active")
then start_working_on_feature()
```

### 3. FTS-Only for Semantic Queries

```
# Bad: Keywords miss semantic matches
oracle_search("feeling frustrated debugging", mode="fts")

# Good: Use hybrid for emotional/contextual queries
oracle_search("feeling frustrated debugging", mode="hybrid")
```

### 4. Main Agent Reading Everything

```
# Bad: Opus reads 50 files directly
for file in files:
    read(file)  # 50k tokens wasted

# Good: Delegate to Haiku
Task(subagent_type="context-finder",
     prompt="find files related to X")
```

### 5. oracle_learn Without Concepts

```
# Bad: No tags = hard to find later
oracle_learn(pattern="Use git -C not cd")

# Good: Concepts enable filtered search
oracle_learn(pattern="Use git -C not cd",
             concepts=["git", "worktree", "multi-agent"])
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────┐
│              ORACLE QUICK ACTIONS               │
├─────────────────────────────────────────────────┤
│ Find knowledge:   oracle_search(query)          │
│ Get guidance:     oracle_consult(decision)      │
│ Add pattern:      oracle_learn(pattern, tags)   │
│ Check health:     oracle_stats()                │
│ Browse tags:      oracle_concepts()             │
│ List docs:        oracle_list(type, limit)      │
│ Random wisdom:    oracle_reflect()              │
│ Discuss:          oracle_thread(message)        │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│              BEFORE STARTING TASK               │
├─────────────────────────────────────────────────┤
│ 1. oracle_threads(status="all")                 │
│ 2. oracle_search("[project] [action]")          │
│ 3. oracle_list(type="learning", limit=10)       │
└─────────────────────────────────────────────────┘
```

---

## HTTP API Quick Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/health` | GET | Server status |
| `/search?q=...` | GET | Full-text search |
| `/consult?q=...` | GET | Decision guidance |
| `/reflect` | GET | Random wisdom |
| `/list` | GET | Browse documents |
| `/learn` | POST | Add pattern |
| `/stats` | GET | Database stats |
| `/graph` | GET | Knowledge graph data |

---

*Last updated: 2026-01-05*
*Oracle v2 version: 0.2.0*
