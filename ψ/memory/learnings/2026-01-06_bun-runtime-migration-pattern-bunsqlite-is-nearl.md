---
title: Bun Runtime Migration Pattern: bun:sqlite is nearly drop-in replacement for bett
tags: [bun, sqlite, migration, runtime, drizzle]
created: 2026-01-06
source: Session 2026-01-06 Bun Migration
---

# Bun Runtime Migration Pattern: bun:sqlite is nearly drop-in replacement for bett

Bun Runtime Migration Pattern: bun:sqlite is nearly drop-in replacement for better-sqlite3. Same API (.prepare, .get, .all, .run, .exec). Drizzle adapter change is just import path (drizzle-orm/better-sqlite3 → drizzle-orm/bun-sqlite). No schema migration needed - same SQLite file works with both drivers. Key benefit: 10x faster startup, built-in SQLite, no native addon compilation.

---
*Added via Oracle Learn*
