---
title: ## Session Anti-Pattern: Trial-Error Before Oracle
tags: [anti-pattern, oracle-first, time-waste, debugging, workflow]
created: 2026-01-12
source: Session reflection 2026-01-12
---

# ## Session Anti-Pattern: Trial-Error Before Oracle

## Session Anti-Pattern: Trial-Error Before Oracle

**Date**: 2026-01-12
**Time wasted**: ~70 minutes

### What Went Wrong
1. **Didn't search Oracle** - 4MB flash solution already existed
2. **Wrong directory** - `firmware-meshtastic` vs `meshtastic-firmware`
3. **Multiple rebuild attempts** - Should have checked board definition first
4. **SSH commands backgrounding** - Should use tmux skill consistently

### Correct Flow
```
1. User request
2. oracle_search() FIRST
3. If found → follow pattern
4. If not found → debug, then oracle_learn()
```

### Key Reminder
> "Search Oracle BEFORE debugging. The answer might already exist."

### Time Cost
- Without Oracle: 70+ min of trial-error
- With Oracle: ~10 min (read + apply)

---
*Added via Oracle Learn*
