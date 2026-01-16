---
title: ## MAW Sync: Merge vs Rebase When Histories Diverge
tags: [git, merge, rebase, maw, conflict-resolution, multi-agent, sync]
created: 2026-01-04
source: 2026-01-04 MAW sync session
---

# ## MAW Sync: Merge vs Rebase When Histories Diverge

## MAW Sync: Merge vs Rebase When Histories Diverge

**Problem**: Main and agents/3 had 58 vs 48 divergent commits. Rebase kept failing with cherry-pick conflicts.

**Solution**: Use `git merge` instead of `git rebase` when histories are too divergent.

### When to Use Each

| Situation | Use | Why |
|-----------|-----|-----|
| Agent 1 commit behind main | `rebase` | Linear history, clean |
| Agent has different commits | `rebase` | Still linear if few commits |
| 50+ divergent commits | `merge` | Rebase will conflict repeatedly |
| Handoff file conflicts | `--ours` | Auto-generated, either version OK |

### The Pattern That Worked

```bash
# 1. Fetch first
git fetch origin

# 2. Try rebase
git rebase origin/main
# If fails with many conflicts...

# 3. Abort and merge instead
git rebase --abort
git merge origin/main -m "merge: sync with origin"

# 4. Resolve conflicts (handoff files = use ours)
git checkout --ours "ψ/inbox/handoff/*.md"
git add -A && git commit

# 5. Push, then sync agents
git push origin main
maw sync
```

### Anti-patterns

- `git reset --hard` - Blocked by safety hook (good!)
- Force pushing - Never do this
- Rebasing 50+ commits - Will conflict repeatedly

### Root Cause

Agent 3 had separate work that wasn't synced for days. The longer agents stay unsynced, the harder it is to merge back.

---
*Added via Oracle Learn*
