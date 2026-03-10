---
title: ## Rebase Conflict Resolution Without Force Push
tags: [git, rebase, pr, conflict, safety]
created: 2025-12-30
source: Oracle Learn
---

# ## Rebase Conflict Resolution Without Force Push

## Rebase Conflict Resolution Without Force Push

When rebase changes commit hashes and you can't force push, create a new branch instead.

### The Problem
```
git push origin branch-name
! [rejected] (non-fast-forward)
```

After rebase, commit hashes change. Regular push fails. User policy forbids force push.

### The Solution
```bash
# Rename current branch
git branch -m old-branch old-branch-v2

# Push new branch
git push -u origin old-branch-v2

# Close old PR, create new one
gh pr close OLD_PR_NUMBER --comment "Superseded by new PR"
gh pr create --title "..." --body "Supersedes #OLD_PR_NUMBER"
```

### Key Points
1. Never force push (per CLAUDE.md rules)
2. Rename branch with `-v2` suffix
3. Reference old PR in new one
4. This preserves history and follows safety rules

---
*Added via Oracle Learn*
