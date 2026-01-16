---
title: Migration Notice Pattern - Breadcrumbs for LLMs
tags: [pattern, migration, documentation, llm-friendly, oracle]
created: 2026-01-12
source: Session 2026-01-12 - Oracle location correction
---

# Migration Notice Pattern - Breadcrumbs for LLMs

When files/databases move to new locations, leave breadcrumb notices at OLD locations.

## The Pattern

```
OLD location/
└── filename.MIGRATED-TO-NEW.md  ← Notice file

NEW location/
└── filename.README.md           ← Actual file + docs
```

## Example: Oracle Migration

```
# Wrong locations (leave notices)
/Users/nat/Code/github.com/laris-co/oracle-v2/oracle.db.MIGRATED-TO-HOME.md
ψ/lab/oracle-v2/oracle.db.MIGRATED-TO-HOME.md

# Correct location (actual files)
~/oracle-v2/oracle.db
~/oracle-v2/oracle.db.README.md
```

## Why This Works

1. **LLMs read directories** - They'll see the notice file
2. **Filename is self-documenting** - `MIGRATED-TO-HOME` is clear
3. **Nothing is deleted** - Old paths still exist, just redirect
4. **Future-proof** - Works even if Oracle search has outdated info

## Notice File Template

```markdown
# [Resource] Has Moved!

**Correct location**: `~/new-path/`

This location is OUTDATED.

---
*[date]*
```

## When to Use

- Database migrations
- Repo graduations (lab → standalone)
- Config file relocations
- Any file that LLMs might search for at old paths

---

*Pattern discovered during Oracle ~/oracle-v2/ migration*
