# Oracle v2: Dual Database Connection Issue - Root Cause Analysis

**Date**: 2026-01-15
**Severity**: 🔴 Critical (Blocks onboarding, migration failures)
**Status**: Documented (awaiting fix)

## The Problem

Oracle v2 has **two independent SQLite database connections** that create a migration conflict:

1. **Drizzle ORM connection** (`src/db/index.ts`)
   - Uses `bun:sqlite` with Drizzle ORM
   - Exported as `db` for use in client/MCP code
   - Manages: FTS5, schema changes, vector embedding logic

2. **Server HTTP connection** (`src/server/db.ts`)
   - Uses raw `bun:sqlite` without Drizzle
   - Exported as `db` for use in server/handlers code
   - Manages: Logging tables, ad-hoc ALTER TABLE statements

## The Conflict

Both connections point to **the same database file** (`~/.oracle-v2/oracle.db`) but:

- **Drizzle connection** knows about migrations (sees them as applied)
- **Server connection** applies raw SQL DDL statements directly
- **No orchestration** between the two connection objects

### When Migration Fails

1. Person clones oracle-v2 (fresh clone)
2. Runs `bun run db:migrate` → applies `src/db/migrations/*.sql`
3. But `src/server/db.ts:initLoggingTables()` calls `ALTER TABLE` with try/catch
4. If the table doesn't exist yet, it fails silently ✅
5. If the table exists, the ALTER succeeds but bypasses Drizzle's tracking

### When Others Clone & Run

1. Person clones oracle-v2
2. Migrations don't run automatically (setup.sh doesn't call `db:migrate`)
3. `initLoggingTables()` runs on first server startup
4. It creates tables with DDL that Drizzle doesn't know about
5. Next time they run `db:generate`, Drizzle sees "unknown" tables
6. Migration file generated for tables that **shouldn't be in Drizzle** (they're FTS5-adjacent)

## Code Evidence

### Drizzle Connection (src/db/index.ts)
```typescript
import { drizzle } from 'drizzle-orm/bun-sqlite';
import { Database } from 'bun:sqlite';

const sqlite = new Database(DB_PATH);
export const db = drizzle(sqlite, { schema });
```

- Single connection created
- Wrapped by Drizzle ORM
- Exports `db` object with ORM methods

### Server Connection (src/server/db.ts)
```typescript
import { Database } from 'bun:sqlite';

export const db = new Database(DB_PATH);

export function initLoggingTables() {
  db.exec(`CREATE TABLE IF NOT EXISTS search_log (...)`);
  
  // Ad-hoc ALTER TABLE (not in migrations!)
  const tables = ['search_log', 'learn_log', 'document_access', 'consult_log'];
  for (const table of tables) {
    try {
      db.exec(`ALTER TABLE ${table} ADD COLUMN project TEXT`);
    } catch {
      // Column already exists, ignore
    }
  }
}
```

- **Separate connection** created independently
- **Direct SQL execution**, no ORM layer
- **Two parallel namespace issues**: Both export `db` with different types!

### Import Collision

| File | Import | Type | Usage |
|------|--------|------|-------|
| `src/server.ts` | `from './server/db.js'` | Raw SQLite | HTTP handlers |
| `src/server/handlers.ts` | `from './server/db.js'` | Raw SQLite | Logging, queries |
| `src/index.ts` | `new Database(dbPath)` | Raw SQLite | MCP server |
| Nowhere | `from './db/index.js'` | Drizzle ORM | **Never imported!** |

**Drizzle ORM is defined but never used in the runtime codebase!**

## Why This Fails on Others' Machines

### Scenario: New Developer Clones

```bash
git clone <oracle-v2>
bun install
bun run server  # or any command that imports server.ts
```

1. `src/server.ts` → imports `./server/db.js`
2. `initLoggingTables()` runs → creates logging tables with raw SQL
3. Tables exist in database but NOT tracked by Drizzle migrations
4. When they run `db:generate`, Drizzle introspects and sees tables
5. Migration file created for "new" tables
6. Git conflict or unexpected migration

### Scenario: Fresh Clone → Migrate → Run Server

```bash
bun run db:migrate  # Applies migrations
bun run server      # Server also calls initLoggingTables()
```

The migrations include `CREATE TABLE IF NOT EXISTS` for all tables.
`initLoggingTables()` is idempotent (uses `IF NOT EXISTS`), so it works.
But: Two separate connections managed two separate "schema states."

## Files Involved

### Schema Definition
| File | Purpose | Issue |
|------|---------|-------|
| `src/db/schema.ts` | Drizzle schema definition | Incomplete (missing FTS5) |
| `src/db/migrations/0000_unknown_viper.sql` | Initial schema | 185 lines, includes logging tables |
| `src/db/migrations/0001_chunky_dark_phoenix.sql` | Add supersede columns | Migration tracking (not in use) |
| `src/db/migrations/0002_mixed_rhodey.sql` | Add provenance columns | Migration tracking (not in use) |

### Runtime Code
| File | Purpose | Issue |
|------|---------|-------|
| `src/db/index.ts` | Drizzle ORM setup | **Never used at runtime** |
| `src/server/db.ts` | Server HTTP DB setup | **Uses separate connection, raw SQL** |
| `src/server.ts` | HTTP server entry point | Imports `server/db.js` not `db/index.js` |
| `src/index.ts` | MCP server entry point | Creates own `new Database(dbPath)` |
| `drizzle.config.ts` | Drizzle configuration | Configured but migrations not enforced |

### Root Cause Summary

```
Intended Architecture:
  Drizzle ORM (src/db/index.ts) → manages all DDL
    ↓
  Single connection, migration-tracked

Actual Architecture:
  src/db/index.ts (unused)
    
  src/server/db.ts (raw SQLite, separate connection)
  src/index.ts (raw SQLite, separate connection)
    ↓
  Two parallel connections, migrations not enforced
```

## The Migration Problem in Detail

### drizzle.config.ts Configuration
```typescript
export default defineConfig({
  dialect: 'sqlite',
  schema: './src/db/schema.ts',
  out: './src/db/migrations',
  tablesFilter: [
    'oracle_documents',
    'indexing_status',
    'search_log',
    'consult_log',
    'learn_log',
    'document_access',
    'forum_threads',
    'forum_messages',
    'decisions',
    'trace_log',
  ],
});
```

- Configuration is correct
- Migrations are generated
- **But migrations are never enforced** at runtime!
- `db:migrate` command exists but is never called during setup or startup

### setup.sh Never Calls db:migrate
```bash
#!/bin/bash
echo "🔧 Installing root dependencies..."
bun install

echo "🔧 Installing frontend dependencies..."
cd frontend && bun install

echo "🔨 Building frontend..."
bun run build

echo "✅ Setup complete! Run: bun run server"
```

No database initialization! Migrations are manual.

### Server Startup Never Checks Migrations
```typescript
// src/server.ts - line ~69
try {
  initLoggingTables();  // Raw SQL CREATE/ALTER
} catch (e) {
  console.error('Failed to initialize logging tables:', e);
}
```

Direct SQL, no Drizzle migration framework.

## Technical Details: SQLite + Bun:sqlite

### Multiple Connections to Same File
SQLite allows multiple connections to the same database file, but:

| Property | Behavior |
|----------|----------|
| File locking | SQLite uses file-level locks (WAL mode = fine-grained) |
| Transaction isolation | Each connection has own transaction state |
| Schema cache | Each connection independently caches schema |
| Migration tracking | No built-in feature (Drizzle adds this) |

**Problem**: Two connections can have stale schema views after DDL changes.

### WAL Mode Helps But Doesn't Solve This
```typescript
// src/db/index.ts could enable WAL:
sqlite.exec("PRAGMA journal_mode=WAL");
```

WAL improves concurrency but doesn't sync schema views between connections.

## Impact: When It Works vs. Breaks

### ✅ Works (Same Person, Continuous Development)
1. Person runs `bun run server`
2. `src/server/db.ts:initLoggingTables()` creates tables
3. Person edits schema, runs `db:generate` (generates migrations)
4. Person runs `db:migrate` (applies migrations)
5. Both connections see same schema because same process

### ❌ Breaks (Fresh Clone / Collaborator)
1. Fresh clone of repo
2. `setup.sh` runs (no db:migrate call)
3. Person runs `bun run server`
4. `src/server/db.ts:initLoggingTables()` creates tables (fresh database)
5. Person later runs `db:generate`
6. Drizzle introspects database and sees tables created by server, not by migration
7. Git shows migration file changes (unwanted)
8. Or: Different state than person who originated the migrations

## The FTS5 Complexity

`src/db/index.ts` has FTS5 setup code:
```typescript
export function initFts5() {
  sqlite.exec(`
    CREATE VIRTUAL TABLE IF NOT EXISTS oracle_fts USING fts5(
      id UNINDEXED,
      content,
      concepts,
      tokenize='porter unicode61'
    )
  `);
}

export function rebuildFts5WithStemmer() {
  // ... complex FTS5 rebuild logic
}
```

**But**:
- FTS5 is a virtual table (not tracked by Drizzle)
- This code is defined but never called at runtime
- `initLoggingTables()` in `server/db.ts` doesn't call this
- FTS5 table is created ad-hoc somewhere else (or not created at all?)

## Summary: The Two-System Problem

| Aspect | Drizzle Path | Server Path | Result |
|--------|-------------|------------|--------|
| **Connection** | `src/db/index.ts` | `src/server/db.ts` | Separate objects, same file |
| **Schema management** | Migration files | Raw SQL in function | Unsynced |
| **Runtime usage** | Not imported | Imported everywhere | Only server version used |
| **FTS5** | Defined here | Not called | Orphaned code |
| **Logging tables** | In migrations | Created by `initLoggingTables()` | Unsynced |
| **Enforcement** | Manual (`db:migrate`) | Automatic (on server startup) | Inconsistent |

## How to Reproduce

**On fresh clone:**
```bash
git clone https://github.com/laris-co/oracle-v2.git
cd oracle-v2
bun install
bun run server  # Creates tables via server/db.ts:initLoggingTables()
# Kill server
bun run db:generate  # Introspects database
# Check git diff - migration files may have changed!
```

**Why it breaks:**
- `db:generate` introspects the actual database file
- Server created tables via raw SQL
- Drizzle sees them as "new" tables
- Generates migration for tables that already exist

## Solution Outline (Not Yet Implemented)

### Option 1: Consolidate to Drizzle (Recommended)
- Keep only `src/db/index.ts`
- Move `initLoggingTables()` logic to proper migrations
- Remove `src/server/db.ts` separate connection
- Enforce migrations at startup via `drizzle-kit migrate` CLI call
- One connection object, managed consistently

### Option 2: Consolidate to Raw SQL
- Remove Drizzle ORM wrapper
- Keep `src/server/db.ts` approach everywhere
- Manual migration tracking (timestamp-based, with hash checking)
- More code, less ORM overhead

### Option 3: Hybrid (Current State)
- Keep both connections
- Add migration enforcement at startup
- Better: Use only one in production, other for testing
- **This is what's happening now** (broken)

## Lessons Learned

- **Pattern**: Don't have two connection objects pointing to same DB without coordination
- **Pattern**: Never have DDL statements in functions that run automatically (use migrations)
- **Anti-pattern**: Leaving ORM wrapper (Drizzle) unused while manual SQL runs
- **Insight**: Setup scripts must enforce migrations, not leave to manual steps
- **Anti-pattern**: `try/catch` on ALTER TABLE is code smell (should use IF NOT EXISTS or migrations)

## References

- `src/db/index.ts` - Unused Drizzle connection + FTS5 orphaned code
- `src/server/db.ts` - Active raw SQLite connection + ad-hoc DDL
- `src/db/schema.ts` - Schema definition (not complete)
- `src/db/migrations/` - Migration files (not enforced at runtime)
- `drizzle.config.ts` - Drizzle configuration (migrations not auto-run)
- `setup.sh` - Setup script (doesn't call db:migrate)
- `src/server.ts` - Server startup (doesn't enforce migrations)

## Related Issues

- **#21** (Jan 2026): Hono.js migration - HTTP server restructure
- **#22** (Jan 2026): Provenance tracking - Added columns via migration
- **#23** (Jan 2026): Auto-detect project - No schema changes
- **Not filed**: Dual database connection root cause

---

**Status**: Ready for fix in next iteration
**Effort**: Medium (1-2 hours to consolidate to single connection + enforce migrations)
**Risk**: Low (migrations are tracked, can test with fresh database)
