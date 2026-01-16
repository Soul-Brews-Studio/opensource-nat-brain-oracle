---
title: ## Debugging Pattern: /trace → Compare → Fix
tags: [debugging, trace, methodology, oracle, pattern, compare]
created: 2026-01-16
source: Oracle Learn
---

# ## Debugging Pattern: /trace → Compare → Fix

## Debugging Pattern: /trace → Compare → Fix

**Date**: 2026-01-16
**Category**: Debugging Methodology

**The Pattern**:

```
1. Problem occurs
   ↓
2. /trace [keywords] → Search Oracle for similar issues
   ↓
3. Find related learnings (even if not exact match)
   ↓
4. Compare working vs broken (what's different?)
   ↓
5. Identify the difference
   ↓
6. Fix and verify
   ↓
7. Log to Oracle (extend knowledge for future)
```

**Example**: /physical skill not discovered
- /trace found "skill must be folder" learning
- Compared hours (working) vs physical (broken)
- Difference: real dir vs symlink
- Fix: cp -r instead of ln -s
- Logged: symlink discovery limitation

**Why This Works**:
- Oracle accumulates related knowledge over time
- Even partial matches guide investigation
- Compare pattern reveals subtle differences
- Each fix extends Oracle for future sessions

---
*Added via Oracle Learn*
