---
title: # Unified Oracle Knowledge Model
tags: [oracle, architecture, knowledge-model, indexing, write-read-separation]
created: 2025-12-30
source: Discussion 2025-12-30 07:41
---

# # Unified Oracle Knowledge Model

# Unified Oracle Knowledge Model

## The Insight

Everything in ψ/memory/ is Oracle knowledge. Different entry points, same destination.

## Entry Points

| Command | Creates | Auto-index? |
|---------|---------|-------------|
| rrr | retrospective | No |
| /snapshot | learning | No |
| /feel, /fyi, /jot | notes | No |
| oracle_learn | learning | Currently yes → should be no |

## Proposed: Write-Only + Batch Index

```
# Write operations (fast, no index)
rrr, /snapshot, oracle_learn
    → Creates ψ/memory/**/*.md
    → Tagged with: oracle, type, date

# Index operations (separate, batch)
/oracle reindex    # Manual
cron job           # Scheduled  
session end hook   # Automatic
    → Scans all ψ/memory/
    → Updates SQLite + ChromaDB
```

## Benefits

1. **Write is always fast** - No waiting for embedding
2. **Batch indexing is efficient** - Process many files at once
3. **Failure isolation** - Index error doesn't block writing
4. **Consistent model** - All commands work the same way

## Tag-Based Discovery

All Oracle knowledge tagged in frontmatter:
```yaml
---
tags: [oracle, topic1, topic2]
type: learning | principle | retro
---
```

Search by tag: `oracle_search(query, tags=["oracle"])`

## Key Principle

**Location = Oracle**: Everything in ψ/memory/ is Oracle knowledge by definition. The `oracle` tag is implicit from location.

---
*Added via Oracle Learn*
