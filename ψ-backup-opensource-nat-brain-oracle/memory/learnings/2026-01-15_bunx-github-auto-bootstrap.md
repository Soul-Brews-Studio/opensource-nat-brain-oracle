# bunx GitHub Install Requires Auto-Bootstrap

**Date**: 2026-01-15
**Context**: Oracle-v2 public release

## The Problem

`bunx github:owner/repo` installs and runs immediately without setup steps.

If your app needs:
- Database tables created
- Config directories (`~/.app/`)
- Schema migrations

Users won't run `db:push` or `setup.sh` - they expect one-liner to work.

## The Solution

Auto-bootstrap on startup:

```typescript
// Check if tables exist, create if not
const tableExists = db.query(
  "SELECT name FROM sqlite_master WHERE type='table' AND name='main_table'"
).get();

if (!tableExists) {
  console.error('[Bootstrap] Creating tables for fresh install...');
  db.exec(`CREATE TABLE IF NOT EXISTS ...`);
}
```

Also auto-create data directory:
```typescript
if (!fs.existsSync(DATA_DIR)) {
  fs.mkdirSync(DATA_DIR, { recursive: true });
}
```

## Trade-off

**Drizzle migrations** = source of truth for schema (development)
**Auto-bootstrap SQL** = fallback for fresh bunx installs (production)

Both should create identical tables. Keep them in sync manually.

## Key Insight

> "bunx users expect magic. Local devs expect control."

Design for both: auto-bootstrap for bunx, `db:push` for devs.
