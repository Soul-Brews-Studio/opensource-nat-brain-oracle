---
date: 2026-01-01
tags: [rust, cli, sqlite, database, path]
context: Data-Aware RAG - Rust CLI connecting to TypeScript-created database
---

# Rust CLI Database Path Pattern

## Problem

The Rust CLI was looking for `{collection}.db` (e.g., `documents.db`) in the current directory, while the TypeScript CLI stores data at `data/sqlite.db`.

## The Fix

Hardcode the relative path to match the TypeScript CLI:

```rust
pub async fn run(collection: &str, debug: bool) -> Result<()> {
    // Use data/sqlite.db as default (same as TypeScript CLI)
    let db_path = "data/sqlite.db".to_string();
```

## Why It Matters

1. **Dual CLI Consistency** - Both TypeScript and Rust CLIs should access the same data
2. **User Experience** - Users shouldn't need to specify paths differently for each CLI
3. **Data Integrity** - Single source of truth for indexed documents

## Schema Alignment

Also fixed column name mismatch:

| TypeScript Schema | Rust Code (Before) | Fix |
|-------------------|-------------------|-----|
| `created_at` | `indexed_at` | Use `created_at` |

```sql
-- TypeScript creates this
CREATE TABLE documents (
  ...
  created_at TEXT DEFAULT (datetime('now'))
);

-- Rust was expecting 'indexed_at'
-- Fixed to use 'created_at'
SELECT id, source_file, created_at FROM documents
ORDER BY created_at DESC LIMIT 5
```

## npm Scripts for Convenience

Added to package.json:

```json
{
  "rust:run": "./cli-rust/target/debug/rag",
  "rust:search": "./cli-rust/target/debug/rag search",
  "rust:stats": "./cli-rust/target/debug/rag stats --debug"
}
```

Usage:
```bash
cd ψ/lab/data-aware-rag
bun run rust:stats           # Show database stats
bun run rust:search "oracle" # FTS search
```

## Key Learning

> "When building a second CLI in a different language, match the database paths and schema exactly. Test with actual data before assuming it works."

The Rust CLI now correctly reads all 42,145 documents indexed by the TypeScript CLI.
