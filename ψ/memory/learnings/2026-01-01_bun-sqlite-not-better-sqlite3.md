---
title: "Bun uses bun:sqlite, not better-sqlite3"
date: 2026-01-01
concepts: [bun, sqlite, compatibility, database]
---

# Bun uses bun:sqlite, not better-sqlite3

## The Problem

When using Bun runtime, `better-sqlite3` throws an error:

```
error: 'better-sqlite3' is not yet supported in Bun.
Track the status in https://github.com/oven-sh/bun/issues/4290
```

## The Fix

Use Bun's native `bun:sqlite` instead:

```typescript
// ❌ Wrong - doesn't work with Bun
import Database from 'better-sqlite3';
const db = new Database('data.db');

// ✅ Correct - native Bun SQLite
import { Database } from 'bun:sqlite';
const db = new Database('data.db', { create: true });
```

## API Differences

| Feature | better-sqlite3 | bun:sqlite |
|---------|---------------|------------|
| Import | `import Database from 'better-sqlite3'` | `import { Database } from 'bun:sqlite'` |
| Create | `new Database(path)` | `new Database(path, { create: true })` |
| Prepare | `db.prepare(sql)` | `db.prepare(sql)` |
| Query | `stmt.all()` | `db.query(sql).all()` |

## Benefits of bun:sqlite

- Zero dependencies (built into Bun)
- Faster (native implementation)
- Same API patterns as better-sqlite3
- FTS5 works out of the box

---

*Fixed: Data-Aware RAG Pipeline 2026-01-01*
