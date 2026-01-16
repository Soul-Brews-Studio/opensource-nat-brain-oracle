---
title: Oracle-v2 DB Migration Failure Root Cause:
tags: [oracle-v2, database, migration, drizzle, sqlite, anti-pattern, open-source]
created: 2026-01-14
source: Session 2026-01-15 - Oracle-v2 open source prep
---

# Oracle-v2 DB Migration Failure Root Cause:

Oracle-v2 DB Migration Failure Root Cause:

The dual database connection anti-pattern causes migration failures when others clone and run the project.

**The Problem:**
1. src/db/index.ts has Drizzle ORM connection (never used at runtime)
2. src/server/db.ts has raw SQLite with ad-hoc DDL (actually used)
3. setup.sh doesn't call db:migrate
4. Tables created by raw SQL aren't tracked by Drizzle

**Why It Fails:**
- First run: initLoggingTables() creates tables via raw ALTER TABLE
- Tables exist but Drizzle doesn't know about them
- Running db:generate sees "unknown" tables → unexpected migrations

**Solution:**
1. Remove ad-hoc DDL from runtime code
2. Consolidate to single Drizzle connection
3. Add db:migrate to setup.sh
4. Enforce migrations at startup

**Safe for open source?** YES - document the issues clearly, make it a learning opportunity (MISSION-05).

---
*Added via Oracle Learn*
