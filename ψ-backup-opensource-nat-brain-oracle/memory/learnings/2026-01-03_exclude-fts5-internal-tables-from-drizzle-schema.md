---
title: **Exclude FTS5 internal tables from Drizzle schema**
tags: [drizzle, fts5, sqlite, schema, virtual-table]
created: 2026-01-03
source: Oracle v2 Drizzle migration - 2026-01-03
---

# **Exclude FTS5 internal tables from Drizzle schema**

**Exclude FTS5 internal tables from Drizzle schema**

When using Drizzle with SQLite FTS5, exclude the internal tables (oracle_fts_data, oracle_fts_idx, oracle_fts_content, oracle_fts_docsize, oracle_fts_config) from your schema. These are managed by SQLite's FTS5 engine, not by your application. Use tablesFilter in drizzle.config.ts to include only your actual tables. FTS5 virtual tables require raw SQL anyway since Drizzle doesn't support them natively.

---
*Added via Oracle Learn*
