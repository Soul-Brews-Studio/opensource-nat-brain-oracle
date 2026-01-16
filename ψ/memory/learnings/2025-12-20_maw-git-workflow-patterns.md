# MAW Git Workflow Patterns

**Date**: 2025-12-20

## The Sync Pattern

### Core Flow: Agent Work to Main to All

```
Agent N commits → Main rebases → All agents sync → Push
```

```bash
# 1. Agent commits locally
git -C agents/N add -A && git -C agents/N commit -m "work"

# 2. Main absorbs agent work
git -C "$ROOT" rebase agents/N

# 3. Reconcile with remote
git -C "$ROOT" pull --rebase origin main

# 4. Sync all agents to main
maw sync  # or manual: git -C agents/M rebase main

# 5. Push
git -C "$ROOT" push origin main
```

### Agent-Initiated Sync (Key Power)

Any agent can orchestrate full sync using `git -C`:

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
git add -A && git commit -m "my work"
git -C "$ROOT" rebase agents/2        # Main gets my work
git -C "$ROOT" push origin main       # Push to remote
```

## Rebase Strategy

### Why Rebase, Not Merge

| Approach | Result | Hash |
|----------|--------|------|
| `git rebase main` | Linear history | Same across worktrees |
| `git merge main` | Merge commit | Unique per worktree |

**Rule**: Same hash = easier coordination. Rebase always.

### The Auto-Abort Pattern

`maw sync` uses safe conflict handling:

```bash
if git -C "$agent_dir" rebase main 2>&1; then
  echo "Synced"
else
  git -C "$agent_dir" rebase --abort  # Auto-abort!
  echo "Conflict - agent unchanged"
fi
```

**Never leave a worktree in conflict state automatically.**

### Manual Conflict Resolution

```bash
# When maw sync reports conflict:
git -C agents/N rebase main           # Start rebase
# ... edit conflicting files ...
git -C agents/N add <resolved-files>
git -C agents/N rebase --continue

# Or abort to start fresh:
git -C agents/N rebase --abort
```

## Focus.md Conflicts (Common Issue)

`ψ/inbox/focus.md` is edited by ALL agents constantly.

### Prevention Strategy

```bash
# Each agent OVERWRITES their own focus (no merge needed)
echo "STATE: working
TASK: My task
SINCE: $(date '+%H:%M')" > ψ/inbox/focus.md
```

### When Conflicts Happen

```bash
# focus.md conflict during rebase:
git checkout --theirs ψ/inbox/focus.md  # Accept main's version
git add ψ/inbox/focus.md
git rebase --continue

# Then immediately update your focus
echo "STATE: working
TASK: Resumed after sync
SINCE: $(date '+%H:%M')" > ψ/inbox/focus.md
```

### Alternative: Per-Agent Focus Files

```
ψ/inbox/focus-1.md  # Agent 1's focus
ψ/inbox/focus-2.md  # Agent 2's focus
```

No conflicts possible. Read all to see system state.

## Stash Handling

### MAW Preference: WIP Commits Over Stash

**Why?** Stash is local-only. WIP commits persist in history.

```bash
# Instead of stash:
git -C agents/N add -A
git -C agents/N commit -m "WIP: pre-sync backup"

# Now safe to sync
git -C agents/N rebase main

# To restore WIP state:
git -C agents/N reset --soft HEAD~1
```

### The safe-reset Pattern

From `safe-reset.sh`:

```bash
# 1. Create WIP backup
WIP_MESSAGE="WIP: pre-reset backup $(date +%Y-%m-%d_%H:%M:%S)"
git -C agents/N add -A
git -C agents/N commit -m "$WIP_MESSAGE"

# 2. Reset is now safe (work preserved in commit)
git -C agents/N reset --hard HEAD
git -C agents/N clean -fd

# 3. To recover:
git -C agents/N reset --soft HEAD~1  # WIP changes return
```

### When Stash Is Acceptable

```bash
# Quick local save (not syncing):
git stash push -m "quick save"

# Restore:
git stash pop
```

## Branch Naming

### Convention

```
main          # Source of truth
agents/1      # Agent 1 worktree branch
agents/2      # Agent 2 worktree branch
agents/N      # Pattern: agents/{number}
```

### Worktree ↔ Branch Mapping

```bash
# Worktree location → Branch
agents/1/     → agents/1
agents/2/     → agents/2

# Check current branch:
git -C agents/N branch --show-current
```

### Feature Branches (When Needed)

```bash
# For longer work that shouldn't sync immediately:
git -C agents/N checkout -b feature/my-feature

# Work in isolation...

# When ready to sync:
git -C agents/N checkout agents/N
git -C agents/N merge feature/my-feature
# Then follow normal sync pattern
```

## Quick Reference

| Goal | Command |
|------|---------|
| Check all agents | `maw peek` |
| Sync clean agents | `maw sync` |
| Agent commits | `git -C agents/N add -A && git -C agents/N commit -m "msg"` |
| Main absorbs | `git -C $ROOT rebase agents/N` |
| Resolve conflict | `git -C agents/N rebase --continue` |
| Abort conflict | `git -C agents/N rebase --abort` |
| WIP backup | `git -C agents/N commit -m "WIP: backup"` |
| Restore WIP | `git -C agents/N reset --soft HEAD~1` |

## Anti-Patterns

| Don't | Do |
|-------|-----|
| `git merge main` | `git rebase main` |
| `git push --force` | `git pull --rebase && git push` |
| Leave conflicts unresolved | Auto-abort, try again |
| Stash for multi-agent sync | WIP commits |
| `cd agents/N && git ...` | `git -C agents/N ...` |

## Tags

`maw` `git` `rebase` `sync` `conflict` `focus` `worktree` `patterns`
