---
title: Ask Before Iterate on Format Changes
tags: [process, iteration, communication, format]
created: 2026-01-16
source: /learn skill redesign session
---

# Ask Before Iterate on Format Changes

**Date**: 2026-01-16
**Category**: Process Improvement

## The Pattern

When user requests format changes to a skill or tool:
1. Show 2-3 format options (A, B, C)
2. Let user pick before implementing
3. Then iterate on the chosen direction

## The Anti-Pattern

What I did:
1. Implemented format A (too short)
2. User said "more" → implemented B (single file)
3. User said "want old structure" → implemented C (4 files)
4. User said "revert" → wasted 30 minutes

## Why This Matters

- Format preferences are subjective
- Multiple valid approaches exist
- Iterating without direction = wasted cycles
- User knows their preference faster than AI can guess

## The Fix

Before major format changes:
```
"Here are 3 options:
A) Single file, ~100 lines (minimal)
B) 4 files, ~200 lines (balanced)
C) 4 files, ~400 lines (detailed)

Which do you prefer?"
```

Then implement once.

## Related

- Style guide: `ψ/memory/resonance/style.md`
- /learn skill: `~/.claude/skills/learn/SKILL.md`
