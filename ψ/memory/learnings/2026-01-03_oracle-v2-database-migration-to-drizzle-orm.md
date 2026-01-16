---
title: **Oracle v2 Database Migration to Drizzle ORM**
tags: [drizzle, migration, sqlite, better-sqlite3, database, orm, typescript, schema]
created: 2026-01-03
source: Oracle v2 Drizzle migration - 2026-01-03
---

# **Oracle v2 Database Migration to Drizzle ORM**

**Oracle v2 Database Migration to Drizzle ORM**

## Migration Summary
Migrated Oracle v2 from raw better-sqlite3 to Drizzle ORM on 2026-01-03.

## Approach: Introspection, Not Rewrite
Used `drizzle-kit pull` to introspect existing oracle.db (37MB, 5500+ documents). This generated TypeScript schema automatically matching the existing database structure.

## What Was Migrated
**6 tables in Drizzle schema:**
- `oracle_documents` - Main document index (5.5K rows)
- `indexing_status` - Indexer progress tracking
- `search_log` - Search query logging (226 rows)
- `consult_log` - Consultation logging (15 rows)
- `learn_log` - Learning/pattern logging
- `document_access` - Document access logging (3.7K rows)

**Excluded from Drizzle (managed by SQLite):**
- `oracle_fts` - FTS5 virtual table
- `oracle_fts_*` - FTS5 internal tables (data, idx, content, docsize, config)

## Files Created
```
drizzle.config.ts     - Drizzle configuration for SQLite
src/db/schema.ts      - Type-safe table definitions
src/db/index.ts       - Drizzle client + raw sqlite export for FTS5
```

## npm Scripts Added
```bash
pnpm db:generate   # Generate migrations from schema changes
pnpm db:migrate    # Apply pending migrations
pnpm db:push       # Push schema directly (no migration file)
pnpm db:pull       # Introspect DB to regenerate schema
pnpm db:studio     # Open Drizzle Studio GUI
```

## Key Technical Details
1. **Drizzle + better-sqlite3 coexist** - Export both `db` (Drizzle) and `sqlite` (raw) from index.ts
2. **FTS5 via raw SQL** - Drizzle doesn't support virtual tables, use sqlite.exec() for FTS5
3. **Type export fix** - Use `type Database as DatabaseType` for TypeScript exports
4. **Tests unchanged** - All 45 existing tests pass without modification

## What Drizzle Provides
- Type-safe queries with IntelliSense
- Schema-as-code (version controlled)
- Migration generation from schema diffs
- Drizzle Studio for visual data browsing
- Future: relational queries, prepared statements

## What Remains Raw SQL
- FTS5 full-text search queries
- ChromaDB vector operations
- Complex hybrid search logic

---
*Added via Oracle Learn*
