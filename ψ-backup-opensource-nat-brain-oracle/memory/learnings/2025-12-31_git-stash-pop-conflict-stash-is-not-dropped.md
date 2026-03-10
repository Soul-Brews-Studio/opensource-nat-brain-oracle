---
title: ## Git Stash Pop Conflict - Stash is NOT Dropped
tags: [git, stash, conflict, rebase, safety]
created: 2025-12-31
source: Session 2025-12-31 - Learned from conflict
---

# ## Git Stash Pop Conflict - Stash is NOT Dropped

## Git Stash Pop Conflict - Stash is NOT Dropped

When `git stash pop` encounters a merge conflict:
- The stash is **NOT automatically dropped**
- Only `git stash apply` happens, not the `drop`
- You must manually `git stash drop` after resolving

**Recovery Pattern**:
```bash
# Conflict happened during stash pop
git checkout --theirs "conflicted-file"  # or --ours, or manual
git add "conflicted-file"
git stash drop  # REQUIRED - stash wasn't auto-dropped!
git push origin main
```

**Anti-pattern**:
```bash
# Don't chain stash pop with &&
git stash && git rebase && git stash pop && git push
# If pop fails, push never runs, stash remains
```

**Better pattern**:
```bash
# Handle stash separately
git stash
git rebase origin/main
git stash pop || git stash drop  # Drop even if pop fails
# Then handle any conflicts
```

---
*Added via Oracle Learn*
