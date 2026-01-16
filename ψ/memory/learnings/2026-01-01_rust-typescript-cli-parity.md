---
date: 2026-01-01
tags: [rust, typescript, cli, dual-cli, database]
context: Data-Aware RAG - Building Rust CLI alongside TypeScript CLI
---

# Rust + TypeScript CLI Parity Pattern

## The Goal

Build two CLIs that share the same database:
- **TypeScript CLI** (`bun run cli`) - Quick prototyping, easier to modify
- **Rust CLI** (`./cli-rust/target/debug/rag`) - Fast, type-safe, production-ready

## What Must Match

| Aspect | Must Match | Why |
|--------|-----------|-----|
| Database path | `data/sqlite.db` | Both read/write same data |
| Schema columns | `created_at` not `indexed_at` | SQL queries must work |
| Table structure | Same column order | INSERT statements |
| FTS5 setup | Same virtual table | Search compatibility |

## Implementation

### TypeScript Creates Database

```typescript
// src/db/sqlite.ts
const db = new Database('data/sqlite.db');
db.run(`CREATE TABLE documents (
  id TEXT PRIMARY KEY,
  content TEXT NOT NULL,
  source_file TEXT NOT NULL,
  source_type TEXT DEFAULT 'unknown',
  content_type TEXT DEFAULT 'text',
  metadata TEXT DEFAULT '{}',
  created_at TEXT DEFAULT (datetime('now'))
)`);
```

### Rust Must Match Exactly

```rust
// cli-rust/src/commands/index.rs
let db_path = "data/sqlite.db".to_string();
std::fs::create_dir_all("data")?;

conn.execute(
    "CREATE TABLE IF NOT EXISTS documents (
        id TEXT PRIMARY KEY,
        content TEXT NOT NULL,
        source_file TEXT NOT NULL,
        source_type TEXT DEFAULT 'unknown',
        content_type TEXT DEFAULT 'text',
        metadata TEXT DEFAULT '{}',
        created_at TEXT DEFAULT (datetime('now'))
    )",
    [],
)?;
```

## Common Mistakes

| Mistake | Impact | Fix |
|---------|--------|-----|
| Different column name | Query fails | Match exactly |
| Different default | Data inconsistency | Copy from TypeScript |
| Relative vs absolute path | Wrong database | Use same relative path |
| Missing directory creation | File not found | `create_dir_all` |

## Testing Parity

```bash
# TypeScript indexes
bun run cli index ./path --debug

# Rust reads the same data
./cli-rust/target/debug/rag stats --debug
# Should show same document count!

# Rust can also index
./cli-rust/target/debug/rag index ./other --dry-run --debug
```

## Key Learning

> "When building a second CLI in another language, treat the first CLI's database as the source of truth. Copy schemas exactly, test with real data, and always run both CLIs against the same database to verify parity."

## Current Status

Both CLIs now share:
- Same database: `data/sqlite.db`
- Same schema: 7 columns including `created_at`
- Same FTS5: `documents_fts` virtual table
- Same commands: `stats`, `search`, `index`
