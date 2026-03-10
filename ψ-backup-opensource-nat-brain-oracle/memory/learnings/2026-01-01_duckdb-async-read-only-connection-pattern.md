---
date: 2026-01-01
tags: [duckdb, database, bun, async, pattern]
context: Headline Visualizer - DuckDB connection issues
---

# DuckDB Async Read-Only Connection Pattern

## The Problem

When connecting to a DuckDB database that's already open in another process, you get a lock error:

```
IO Error: Could not set lock on file "headlines.duckdb":
Conflicting lock is held in /path/to/Python.app (PID 9538)
```

## The Solution

Use `duckdb-async` with read-only mode:

```typescript
import { Database } from 'duckdb-async'

// Open in read-only mode to avoid lock conflicts
const db = await Database.create(DB_PATH, { access_mode: 'READ_ONLY' })
```

## Key Learnings

### 1. Use Absolute Paths

Relative paths from `import.meta.dir` don't work when the script is run from different directories:

```typescript
// ❌ Bad: Relative path breaks when cwd changes
const DB_PATH = '../../tmp/headline-db/headlines.duckdb'

// ✅ Good: Compute absolute path from script location
const PROJECT_ROOT = import.meta.dir.replace('/src/api', '')
const REPO_ROOT = PROJECT_ROOT.replace('/ψ/lab/headline-visualizer', '')
const DB_PATH = `${REPO_ROOT}/tmp/headline-db/headlines.duckdb`
```

### 2. Check Column Names

DuckDB column names may differ from expected schema. Use `DESCRIBE table` to check:

```sql
DESCRIBE messages;
```

Then use `AS` to alias columns in queries:

```sql
SELECT message_timestamp AS timestamp FROM messages
```

### 3. duckdb vs duckdb-async

| Package | Usage |
|---------|-------|
| `duckdb` | Node-style callbacks, synchronous |
| `duckdb-async` | Promise-based, works with async/await |

For Bun servers, always use `duckdb-async`:

```typescript
const rows = await db.all<Row>('SELECT * FROM table')
```

## Pattern Template

```typescript
import { Database } from 'duckdb-async'

const PORT = 8002
const DB_PATH = resolveAbsolutePath('path/to/db.duckdb')

let db: Database | null = null

async function getDb(): Promise<Database> {
  if (!db) {
    db = await Database.create(DB_PATH, { access_mode: 'READ_ONLY' })
  }
  return db
}

// Use in handlers
async function handleQuery(): Promise<Response> {
  const database = await getDb()
  const rows = await database.all<Row>('SELECT * FROM table')
  return Response.json({ rows })
}
```

## Key Statement

> "When building data visualizers over existing databases, always assume the database is locked by another process. Use read-only connections and absolute paths to avoid runtime surprises."
