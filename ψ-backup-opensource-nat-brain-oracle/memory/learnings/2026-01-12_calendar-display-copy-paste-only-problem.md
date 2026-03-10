---
title: ## Calendar Display: Copy-Paste Only
tags: [calendar, cal, schedule, copy-paste, formatting]
created: 2026-01-12
source: Oracle Learn
---

# ## Calendar Display: Copy-Paste Only

## Calendar Display: Copy-Paste Only

**Problem**: Manually retyping `cal` output causes date alignment errors. Extra spaces shift days to wrong columns.

**Wrong approach**:
```
# Retyping with "extra formatting"
   Su Mo Tu We Th Fr Sa  
                1  2  3   ← shifted!
```

**Correct approach**:
```bash
cal $(date +"%m %Y")  # Copy output verbatim
```
Then add annotations at END of lines only.

**Rule**: Never manually recreate calendar grids. Copy-paste preserves exact spacing.

---
*Added via Oracle Learn*
