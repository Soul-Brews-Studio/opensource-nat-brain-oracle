---
title: **Oracle v2 Reindexing Note**
tags: [reindex, maintenance, todo]
created: 2026-01-03
source: Session note - 2026-01-03
---

# **Oracle v2 Reindexing Note**

**Oracle v2 Reindexing Note**

Reindex needed after adding new learnings via oracle_learn. The indexer does full rebuild (DELETE + rebuild from ψ/memory files), but preserves activity logs.

Command: `pnpm run index`

Note: Learnings added via oracle_learn create markdown files but aren't searchable until reindex runs.

---
*Added via Oracle Learn*
