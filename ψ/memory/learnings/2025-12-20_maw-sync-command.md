# MAW Sync Command: Smart Synchronization for Multi-Agent Worktrees

**Date**: 2025-12-20
**Category**: MAW Infrastructure
**Script**: `.agents/scripts/smart-sync.sh`

---

## Overview

`maw sync` is the intelligent synchronization command that keeps all agent worktrees aligned with the main branch. It uses **rebase** (not merge) to ensure identical commit hashes across all worktrees — a critical requirement for reliable multi-agent coordination.

```bash
maw sync    # Sync all clean agent worktrees to main
```

---

## Key Features

| Feature | Description |
|---------|-------------|
| **Smart Detection** | Only syncs clean worktrees; skips dirty ones |
| **Rebase Strategy** | Uses rebase for identical commit hashes |
| **Conflict Safety** | Auto-aborts on conflict, preserves agent state |
| **Boundary Respect** | Uses `git -C` pattern, never `cd` |
| **Clear Reporting** | Color-coded summary of sync status |

---

## How It Works

### 1. Worktree Discovery

The script discovers all agent worktrees by parsing `git worktree list`:

```bash
# Filters for worktrees matching: agents/N with branch agents/N
while IFS= read -r line; do
  path=$(echo "$line" | awk '{print $1}')
  branch=$(echo "$line" | awk '{print $3}' | tr -d '[]')

  if [[ "$path" =~ agents/[0-9]+$ ]] && [[ "$branch" =~ ^agents/ ]]; then
    agents+=("$(basename "$path")")
  fi
done < <(git worktree list | tail -n +2)
```

### 2. Status Classification

Each agent worktree is classified before any sync attempt:

| Status | Detection Method | Action |
|--------|-----------------|--------|
| **Clean** | `git status --porcelain` returns empty | Safe to rebase |
| **Dirty** | `git status --porcelain` has output | Skip with warning |
| **Conflict** | Rebase fails | Abort and report |

### 3. Smart Sync Algorithm

```
for each agent in agents/1..N:
  status = git -C agents/$i status --porcelain

  if status is CLEAN:
    attempt: git -C agents/$i rebase main

    if rebase succeeds:
      report "✓ Synced to [hash]"
      increment success_count

    else (conflict):
      execute: git -C agents/$i rebase --abort
      report "✗ Rebase conflict - manual resolution needed"
      increment conflict_count

  else (DIRTY):
    report "⚠ Has uncommitted changes"
    show first 3 changed files
    increment dirty_count
```

---

## The Rebase Strategy

### Why Rebase Instead of Merge?

**Merge creates divergent history:**
```
Main:     abc123 ← latest commit
Agent 1:  def456 ← DIFFERENT HASH (merge commit)
Agent 2:  abc123 ← same as main
```

**Rebase preserves hash identity:**
```
Main:     abc123 ← latest commit
Agent 1:  abc123 ← SAME HASH!
Agent 2:  abc123 ← SAME HASH!
```

### Practical Benefits

| Aspect | With Rebase | With Merge |
|--------|-------------|------------|
| **Commit Hash** | Identical across all | Different per worktree |
| **Sync Verification** | Easy (compare hashes) | Complex (analyze DAG) |
| **Git Log** | Linear, identical | Divergent, confusing |
| **Conflict Detection** | Clear pre/post | Hidden in merge commits |

### The Core Rebase Command

```bash
# Smart sync uses this internally:
git -C agents/$N rebase main

# This moves the agent branch pointer to main's HEAD
# No merge commit created - same SHA preserved
```

---

## Conflict Detection & Handling

### Pre-Sync Detection (Dirty Worktree)

```bash
worktree_status=$(git -C "$agent_dir" status --porcelain)

if [ -z "$worktree_status" ]; then
  # Clean - proceed with rebase
else
  # Dirty - skip this agent
  echo "⚠ Has uncommitted changes:"
  echo "$worktree_status" | head -3
fi
```

**Sample output for dirty worktree:**
```
=== Agent 2 ===
⚠ Has uncommitted changes:
 M src/config.ts
?? temp-notes.md
  → Skipping auto-sync (agent must commit first)
```

### During-Sync Detection (Rebase Conflict)

```bash
if git -C "$agent_dir" rebase main 2>&1; then
  echo "→ Synced to $(git rev-parse --short HEAD)"
else
  # Conflict detected - immediately abort to preserve state
  git -C "$agent_dir" rebase --abort 2>/dev/null || true
  echo "✗ Rebase conflict"
  echo "  → Manual resolution: git -C $agent_dir rebase main"
fi
```

**Key Safety Feature**: On any conflict, `rebase --abort` is called immediately. The agent's worktree is left exactly as it was before sync.

---

## The `git -C` Pattern

### Why Not `cd`?

```bash
# ❌ Bad - cd in subprocess doesn't affect parent shell
cd agents/1 && git status
pwd  # Still in original directory!

# ✅ Good - git -C operates directly on target
git -C agents/1 status
```

### Worktree Boundary Principle

Using `git -C` respects worktree boundaries:

| Approach | Effect |
|----------|--------|
| `cd` + git | Pollutes shell state, unreliable in scripts |
| `git -C` | Direct operation, no side effects |

```bash
# All these work without changing directory:
git -C agents/1 status --porcelain
git -C agents/1 rebase main
git -C agents/1 log -1 --oneline
```

---

## Output Summary

After syncing, the script provides a clear summary:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Summary:
✓ Synced: 3
⚠ Skipped (dirty): 1
✗ Conflicts: 1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

| Status | Color | Meaning |
|--------|-------|---------|
| ✓ Synced | Green | Successfully rebased onto main |
| ⚠ Skipped | Yellow | Has uncommitted work, untouched |
| ✗ Conflicts | Red | Rebase failed, aborted safely |

---

## Manual Resolution

### For Dirty Worktrees

The agent must commit their work first:

```bash
# In the agent's worktree (or using git -C)
git -C agents/N add -A
git -C agents/N commit -m "description of work"

# Then re-run sync
maw sync
```

### For Rebase Conflicts

Manual intervention required:

```bash
# Start the rebase manually
git -C agents/N rebase main

# In the agent worktree, fix conflicts in the affected files
# Then:
git -C agents/N add .
git -C agents/N rebase --continue

# Or abort if needed:
git -C agents/N rebase --abort
```

---

## Integration with MAW Workflow

### Pre-Sync: Always Peek First

```bash
maw peek      # Check all agent states
maw sync      # Now safe to sync
```

### Full Sync Cycle (Agent → Main → All)

```bash
# 1. Agent commits work
git -C agents/1 add -A && git -C agents/1 commit -m "feature"

# 2. Main rebases onto agent
git rebase agents/1

# 3. Sync all agents to new main
maw sync

# 4. Push to origin
git push origin main
```

---

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | All operations successful (including skips) |
| `1` | At least one rebase conflict occurred |

The script exits with error on conflicts so CI/scripts can detect issues:

```bash
maw sync || echo "Sync had conflicts - manual resolution needed"
```

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `maw peek` | View agent status before sync |
| `maw peek N` | Check specific agent |
| `maw status` | Overall workspace health |

---

## Tags

`maw` `sync` `rebase` `git-C` `conflict-detection` `smart-sync` `worktree`
