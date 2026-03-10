# MAW Sync Internals: How Synchronization Really Works

**Date**: 2025-12-20

## Executive Summary

MAW sync maintains identical commit states across all worktrees (main + agents/1..N) using **rebase** instead of **merge**. This design choice ensures every worktree shares the exact same commit hash after sync — a requirement for reliable multi-agent coordination.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     ORIGIN (GitHub)                      │
│                     main branch                          │
└────────────────────────┬────────────────────────────────┘
                         │ git fetch/push
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    MAIN WORKTREE                         │
│           /Users/.../Nat-s-Agents (main)                │
│               The orchestrator + origin sync point       │
└─────────┬────────────────────────────────────────────────┘
          │ git rebase / git -C
          ▼
    ┌─────┴─────┬─────────┬─────────┬─────────┐
    ▼           ▼         ▼         ▼         ▼
┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐
│agents/│ │agents/│ │agents/│ │agents/│ │agents/│
│   1   │ │   2   │ │   3   │ │   4   │ │   5   │
│branch:│ │branch:│ │branch:│ │branch:│ │branch:│
│agents/│ │agents/│ │agents/│ │agents/│ │agents/│
│   1   │ │   2   │ │   3   │ │   4   │ │   5   │
└───────┘ └───────┘ └───────┘ └───────┘ └───────┘
   ↑                                          ↑
   └──── Each has isolated filesystem ────────┘
```

**Key insight**: Git worktrees share `.git` internals but have independent working directories. This enables true parallel work without file conflicts.

---

## The Rebase Strategy: Why Not Merge?

### The Problem with Merge

```bash
# If agent 1 merges main:
git -C agents/1 merge main

# Result:
Main:     abc123 ← latest commit
Agent 1:  def456 ← DIFFERENT HASH (merge commit)
Agent 2:  abc123 ← same as main
```

Merge creates a **unique merge commit** with a new SHA. This means:
- Different hashes across worktrees
- Harder to verify sync status
- Git log diverges visually

### The Rebase Solution

```bash
# If agent 1 rebases onto main:
git -C agents/1 rebase main

# Result:
Main:     abc123 ← latest commit
Agent 1:  abc123 ← SAME HASH!
Agent 2:  abc123 ← SAME HASH!
```

Rebase **moves the branch pointer** to the target commit, preserving the exact SHA.

### Visual Proof

```
Before sync:
  Main:     f8f0ea9 docs: add sync patterns
  Agent 1:  777351a (behind by 1)
  Agent 2:  777351a (behind by 1)

After maw sync:
  Main:     f8f0ea9 docs: add sync patterns
  Agent 1:  f8f0ea9 ← SAME!
  Agent 2:  f8f0ea9 ← SAME!
```

---

## Two-Way Sync Flow

### Pattern A: Agent Work → Main → All Agents (Most Common)

When an agent completes work that should propagate to everyone:

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Agent commits their work (in their worktree)
git add -A && git commit -m "feat: new feature"

# 2. Main rebases onto agent (gets agent's commits)
git -C "$ROOT" rebase agents/1

# 3. Reconcile with origin (if collaborating)
git -C "$ROOT" pull --rebase origin main

# 4. Sync all agents to same hash
for i in 1 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase main
done

# 5. Push to origin
git -C "$ROOT" push origin main
```

**Result**: All worktrees at identical commit hash.

### Pattern B: Main Work → All Agents

When main has updates that agents need:

```bash
# 1. Commit on main
git add -A && git commit -m "docs: updated guidelines"

# 2. Sync all agents
for i in 1 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase main
done

# 3. Push
git push origin main
```

### Pattern C: Agent-Initiated Full Sync (POWERFUL!)

**Any agent can orchestrate the ENTIRE sync from their own worktree!**

```bash
# From agents/1 (or any agent), sync everything:
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Commit my work (local)
git add -A && git commit -m "my work"

# 2. Main rebases onto me (using git -C)
git -C "$ROOT" rebase agents/1

# 3. Reconcile with origin
git -C "$ROOT" pull --rebase origin main

# 4. Sync ALL other agents (not myself)
for i in 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase main
done

# 5. Sync myself to finalized main
git rebase main

# 6. Push
git -C "$ROOT" push origin main
```

**Why this is powerful**:
- Don't need to `cd` anywhere
- Don't need to "be in" main
- Control everything from your home base
- Agent autonomy WITH coordination power

---

## The `git -C` Pattern: Respecting Boundaries

### Why Not `cd`?

```bash
# ❌ Bad - cd runs in subprocess, doesn't affect parent
cd agents/1 && git status
pwd  # Still in original directory!

# ✅ Good - git -C operates directly on target
git -C agents/1 status
```

### Best Practices

```bash
# Check status without leaving
git -C agents/1 status --porcelain

# Commit in agent's worktree
git -C agents/1 add -A
git -C agents/1 commit -m "message"

# Rebase agent onto main
git -C agents/1 rebase main

# Never do this:
cd agents/1 && git push  # Pollutes shell state
```

**Principle**: "Respect worktree boundaries" — use `git -C`, tmux, or signal files to interact.

---

## Conflict Handling

### Pre-Sync: The Peek Check

**Always peek before sync** to avoid overwriting uncommitted work:

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Check if origin has new commits (another session active?)
git fetch origin
behind=$(git rev-list --count HEAD..origin/main)
if [ "$behind" -gt 0 ]; then
  echo "⚠️ Origin has $behind new commits!"
  git log --oneline HEAD..origin/main
fi

# 2. Check all agent worktrees for uncommitted work
for i in 1 2 3 4 5; do
  changes=$(git -C "$ROOT/agents/$i" status --short | wc -l)
  [ "$changes" -gt 0 ] && echo "⚠️ agents/$i has $changes uncommitted files"
done
```

### Smart Sync Algorithm

The conceptual algorithm for smart sync:

```bash
# Pseudocode for smart-sync behavior
for each agent in agents/1..N:
  status = git -C agents/$i status --porcelain

  if status is CLEAN:
    # Safe to sync
    git -C agents/$i rebase main
    if rebase_failed:
      git -C agents/$i rebase --abort
      report "Conflict in agent $i - manual resolution needed"
    else:
      report "✅ Agent $i synced"

  elif status is DIRTY:
    # Uncommitted work - don't touch!
    report "⚠️ Agent $i has uncommitted work"
    list modified files
    # Do NOT sync - let agent commit first

  else:
    report "❌ Agent $i in error state"
```

### If Rebase Conflicts

```bash
# Smart sync auto-aborts on conflict
# Manual resolution:
git -C agents/N rebase main
# ... fix conflicts in agents/N worktree ...
git -C agents/N add -A
git -C agents/N rebase --continue
```

### If Push Rejected

```bash
# Never force push!
# Instead, reconcile:
git pull --rebase origin main
git push
```

---

## Finding the Main Repo from Worktree

A common need: "I'm in agents/1, where's the main repo?"

```bash
# Problem: git rev-parse --show-toplevel returns WORKTREE root
# Solution: Use git-common-dir

find_main_repo() {
  local git_common_dir
  git_common_dir=$(git rev-parse --git-common-dir)
  if [[ "$git_common_dir" == ".git" ]]; then
    git rev-parse --show-toplevel  # Already in main
  else
    cd "$git_common_dir/.." && pwd  # Go to main repo
  fi
}

# Usage from any agent:
ROOT=$(find_main_repo)
git -C "$ROOT" status  # Now operating on main
```

---

## Per-Agent Logging (Conflict-Free Writes)

### The Problem

```bash
# ❌ All agents writing to same file = merge conflicts!
echo "msg" >> .agent-locks/activity.log
```

### The Solution

```bash
# ✅ Each agent writes to their own prefixed file
echo "msg" >> .agent-logs/agent-1.activity.log
echo "msg" >> .agent-logs/agent-2.activity.log
```

**Pattern**: `agent-{N}.{type}.log`

**Result**: No merge conflicts during sync because files don't overlap.

---

## Anti-Patterns to Avoid

| ❌ Don't | ✅ Do |
|---------|-------|
| `cd agents/1 && git...` | `git -C agents/1 ...` |
| `git merge main` | `git rebase main` |
| `git push --force` | `git pull --rebase && git push` |
| Sync without checking | `maw peek` first |
| Shared log files | Per-agent prefix logs |
| Fetch from origin in agent | Fetch in main, sync via rebase |

---

## Quick Reference

| Goal | Command |
|------|---------|
| See all agents | `maw peek` |
| See one agent | `maw peek 1` |
| Sync all to main | `for i in 1..5; git -C agents/$i rebase main` |
| Agent commits | `git add -A && git commit -m "msg"` |
| Main gets agent work | `git rebase agents/N` |
| Reconcile with origin | `git pull --rebase origin main` |
| Verify same hash | `git log -1 --oneline` across all |

---

## Key Insight: Same Hash = Truth

When all worktrees show the same commit hash:
- ✅ Everyone has the same code
- ✅ No hidden divergence
- ✅ Safe to start new parallel work
- ✅ git log is identical everywhere

This is why we rebase, not merge. Merge creates divergent hashes that obscure the true sync state.

---

## Tags

`maw` `sync` `rebase` `git-C` `worktree` `conflict-handling` `internals`
