---
title: # /learn vs /project learn — The Clone-First Pattern
tags: [learn, project, ghq, symlink, clone, pattern]
created: 2026-01-12
source: Debug Session 2026-01-12
---

# # /learn vs /project learn — The Clone-First Pattern

# /learn vs /project learn — The Clone-First Pattern

## The Problem (Jan 12, 2026)

When user ran `/learn https://github.com/...`:
- AI tried to `git clone` directly to ψ/learn/repo/
- This FAILS because the path uses Unicode (ψ) and cd breaks
- Multiple clone attempts, messy errors

## The Solution

**/learn** = Explore existing local repo (3 Haiku agents → docs)
**/project learn** = Clone via ghq + symlink first

**Correct flow:**
```
1. /project learn [url]  → ghq clone → symlink to ψ/learn/repo/
2. /learn [name]         → 3 agents explore → create docs
```

**Or /learn detects URL and calls script automatically:**
```bash
bash .claude/skills/project/scripts/learn.sh "$URL"
```

## Why ghq?

- Single source of truth: ~/Code/github.com/owner/repo
- ψ/learn/ only has symlinks (not actual repos)
- Updates: `ghq get -u` everywhere
- No disk duplication

## Key Script

`.claude/skills/project/scripts/learn.sh`:
- Parses URL/owner/repo/name formats
- Uses `ghq get` for clone
- Creates symlink with owner structure
- Registers to slugs.yaml

---
*Added via Oracle Learn*
