---
title: ## Use Drizzle Migrations, Not Inline SQL
tags: [drizzle, migrations, database, schema]
created: 2026-01-03
source: Oracle Forum implementation feedback
---

# ## Use Drizzle Migrations, Not Inline SQL

## Use Drizzle Migrations, Not Inline SQL

**Anti-pattern**: Adding `CREATE TABLE IF NOT EXISTS` directly in db.ts
**Better**: Use Drizzle schema + migrations

**Why**:
- Schema changes are versioned
- Migrations are trackable in git
- Type-safe queries via Drizzle ORM
- `drizzle-kit push` handles schema sync

**Pattern**:
1. Add table to `src/db/schema.ts`
2. Run `pnpm db:push` to apply
3. Use Drizzle queries, not raw SQL

---
*Added via Oracle Learn*
