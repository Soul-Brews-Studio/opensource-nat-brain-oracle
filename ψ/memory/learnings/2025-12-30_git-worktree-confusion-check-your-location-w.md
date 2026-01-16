---
title: ## Git Worktree Confusion - Check Your Location
tags: [git, worktree, agents, context, lesson-learned]
created: 2025-12-30
source: Oracle Learn
---

# ## Git Worktree Confusion - Check Your Location

## Git Worktree Confusion - Check Your Location

When shell prompt shows wrong branch/worktree, verify with `pwd` and `git status` before operations.

### The Problem
Session started in agents/1 worktree but should be in main. Changes to files affected wrong worktree context.

### Detection Signs
- Prompt shows `agent/1` or wrong branch name
- `pwd` returns `/path/to/Nat-s-Agents/agents/1`
- Rebase/commit operations behave unexpectedly

### Solution
```bash
# Check current location
pwd

# Navigate to correct worktree
cd /Users/nat/Code/github.com/laris-co/Nat-s-Agents

# Verify
git status
```

### Key Points
1. ALWAYS check `pwd` at session start
2. Use `git -C /path` for cross-worktree operations
3. Ralph loop should be started from correct context
4. File edits with absolute paths work regardless of pwd, but git context matters

---
*Added via Oracle Learn*
