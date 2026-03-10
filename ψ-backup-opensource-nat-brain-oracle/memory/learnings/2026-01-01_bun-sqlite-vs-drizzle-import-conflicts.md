---
date: 2026-01-01
tags: [bun, sqlite, drizzle, imports, typescript, cli]
context: Data-Aware RAG v2 - Resolving import conflicts
---

# bun:sqlite vs Drizzle Import Conflicts

## The Problem

When building a CLI that uses the same database as a web frontend:
- Frontend uses Drizzle ORM (`drizzle-orm`)
- CLI wants direct SQLite access (`bun:sqlite`)
- Importing both causes conflicts

```
Error: Export named 'db' not found in './sqlite.ts'
```

## Root Cause

The codebase had two database modules:
1. `src/db/sqlite.ts` - Direct bun:sqlite access, exports `sqlite`
2. `src/db/schema.ts` - Drizzle schema, expects `db` export

Some files import from both, expecting different exports.

## The Solution

**Create a standalone CLI entry point that ONLY uses bun:sqlite**

Instead of trying to fix all imports:

```typescript
// src/cli/rag.ts - Standalone, no Drizzle
import { Database } from 'bun:sqlite';

const DB_PATH = resolve(import.meta.dir, '../../data/sqlite.db');
const db = new Database(DB_PATH);

// Direct SQL queries
const total = db.query('SELECT COUNT(*) as count FROM documents').get();
```

## Why This Works

1. **Isolation**: CLI doesn't touch Drizzle code
2. **Same Database**: Points to exact same SQLite file
3. **No Migration Needed**: Uses same tables/schema
4. **Debug Mode Works**: Full control over query timing

## Key Commands

```bash
# Works without Drizzle conflicts
bun run cli stats --debug
bun run cli search "query" --debug
bun run cli serve --port 8001
```

## Pattern Summary

| Approach | When to Use |
|----------|-------------|
| Drizzle ORM | Web server with complex queries, migrations |
| bun:sqlite direct | CLI tools, scripts, one-off queries |
| Both (isolated) | Different entry points, same DB file |

## Lesson

> "When ORM conflicts block progress, create isolated entry points that use the native driver directly. Same database, different code paths."
