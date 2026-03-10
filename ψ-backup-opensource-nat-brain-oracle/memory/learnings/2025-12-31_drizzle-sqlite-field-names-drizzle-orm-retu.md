---
title: **Drizzle + SQLite Field Names**: Drizzle ORM returns camelCase fields (updatedA
tags: [drizzle, sqlite, naming, typescript]
created: 2025-12-31
source: Oracle Learn
---

# **Drizzle + SQLite Field Names**: Drizzle ORM returns camelCase fields (updatedA

**Drizzle + SQLite Field Names**: Drizzle ORM returns camelCase fields (updatedAt) but raw SQLite queries return snake_case (updated_at). When mixing Drizzle and raw SQL, use column aliases: `SELECT s.updated_at as updatedAt FROM snippets s`

---
*Added via Oracle Learn*
