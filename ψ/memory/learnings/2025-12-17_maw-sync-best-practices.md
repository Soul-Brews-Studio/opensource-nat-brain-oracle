# MAW Sync Best Practices

**Date**: 2025-12-17

## The Golden Commands

```bash
maw peek          # Check what agents are doing (read-only)
maw peek 1        # Check specific agent
maw sync          # Sync all clean agents to main (rebase)
maw log activity "msg"  # Write to per-agent log
```

## Sync Patterns

### Pattern A: Agent Work → Main → All (Most Common)

When an agent has work that should go to everyone:

```bash
# 1. Agent commits their work
git -C agents/1 add -A
git -C agents/1 commit -m "description"

# 2. Main rebases onto agent (gets their work)
git rebase agents/1

# 3. Reconcile with origin (if needed)
git pull --rebase origin main

# 4. Sync all agents to same hash
maw sync

# 5. Push
git push origin main
```

### Pattern B: Main Work → All Agents

When main has work that agents need:

```bash
# 1. Commit on main
git add -A && git commit -m "description"

# 2. Sync all agents
maw sync

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

# 4. Sync ALL other agents
for i in 2 3 4 5; do
  git -C "$ROOT/agents/$i" rebase main
done

# 5. Push
git -C "$ROOT" push origin main
```

**Why this is powerful:**
- Don't need to `cd` anywhere
- Don't need to "be in" main
- Control everything from your home base
- Agent autonomy WITH coordination power

### Pattern D: Quick Check Before Sync

```bash
# Always peek first!
maw peek

# If dirty agents exist, decide:
# - Let them commit first, OR
# - Sync only clean agents (maw sync does this automatically)
```

## Key Principles

### 1. Use `git -C` Not `cd`

```bash
# ✅ Good - respects boundaries
git -C agents/1 status
git -C agents/1 commit -m "msg"

# ❌ Bad - pollutes shell state
cd agents/1 && git status
```

### 2. Rebase for Same Hash

```bash
# ✅ Rebase = same commit hash
git -C agents/1 rebase main    # Agent gets main's commits
git rebase agents/1            # Main gets agent's commits

# ❌ Merge = different hash (merge commit)
git -C agents/1 merge main     # Creates unique merge commit
```

### 3. Never Force Push

```bash
# ❌ NEVER
git push --force

# ✅ Safe reconciliation
git pull --rebase origin main
git push
```

### 4. Check Before Sync

```bash
# Always peek first
maw peek

# Smart sync skips dirty agents automatically
maw sync  # Safe - won't force sync dirty worktrees
```

## Two-Way Sync Flow

```
Agent does work
      ↓
git -C agents/N add -A && git -C agents/N commit
      ↓
Main rebases onto agent: git rebase agents/N
      ↓
Reconcile with origin: git pull --rebase origin main
      ↓
Sync all agents: maw sync
      ↓
Push: git push origin main
      ↓
All worktrees at same hash ✓
```

## Conflict Resolution

### If Rebase Conflicts

```bash
# maw sync auto-aborts on conflict
# Manual resolution:
git -C agents/N rebase main
# ... fix conflicts ...
git -C agents/N rebase --continue
```

### If Push Rejected

```bash
# Don't force push!
git pull --rebase origin main
git push
```

## Per-Agent Logging

```bash
# Each agent writes to their own file
maw log activity "Started task X"
# → .agent-logs/agent-1.activity.log

# No conflicts because each agent has separate file
# Pattern: agent-{N}.{type}.log
```

## Quick Reference

| Goal | Command |
|------|---------|
| See all agents | `maw peek` |
| See one agent | `maw peek 1` |
| Sync all to main | `maw sync` |
| Agent commits | `git -C agents/N add -A && git -C agents/N commit -m "msg"` |
| Main gets agent work | `git rebase agents/N` |
| Reconcile with origin | `git pull --rebase origin main` |
| Log activity | `maw log activity "msg"` |
| **Agent full sync** | `git -C $ROOT rebase agents/N && git -C $ROOT push` |

## 💡 Key Insight: Agent Autonomy

**Any agent can sync the entire system from their own space using `git -C`!**

This means:
- No need to switch to main worktree
- Full control from any agent
- True parallel autonomy with coordination power

## Anti-Patterns

| ❌ Don't | ✅ Do |
|---------|-------|
| `cd agents/1` | `git -C agents/1` |
| `git merge main` | `git rebase main` |
| `git push --force` | `git pull --rebase && git push` |
| Sync without checking | `maw peek` first |
| Shared log files | Per-agent prefix logs |

## Tags

`maw` `sync` `rebase` `git-C` `worktree` `best-practices`
