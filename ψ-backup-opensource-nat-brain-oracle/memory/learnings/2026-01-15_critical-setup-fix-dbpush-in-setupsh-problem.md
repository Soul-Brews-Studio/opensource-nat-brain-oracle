---
title: Critical Setup Fix: db:push in setup.sh
tags: [setup, database, drizzle, onboarding, dx, fresh-clone]
created: 2026-01-15
source: Session 2026-01-15 - BM migration failure fix
---

# Critical Setup Fix: db:push in setup.sh

Critical Setup Fix: db:push in setup.sh

**Problem**: New users cloning oracle-v2 get migration failures.

**Root cause**: setup.sh didn't initialize database.

**Fix**:
```bash
# In setup.sh
mkdir -p ~/.oracle-v2
bun run db:push  # Creates tables from schema
```

**Why db:push vs db:migrate**:
- db:push: Syncs schema directly (no migration tracking)
- db:migrate: Applies tracked migration files

For POC/dev, db:push is simpler. For production, use db:migrate.

**Lesson**: Always include database setup in setup scripts. Test fresh clone workflow before releasing.

---
*Added via Oracle Learn*
