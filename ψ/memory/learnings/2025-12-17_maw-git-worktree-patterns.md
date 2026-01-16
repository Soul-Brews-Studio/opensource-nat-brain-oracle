# MAW Git Worktree Patterns

**Date**: 2025-12-17

## What We Learned

### 1. `git -C` vs `cd` for Worktrees

**Problem**: Shell scripts can't change parent shell's directory
**Solution**: Use `git -C <path>` to operate on worktrees without `cd`

```bash
# Bad - cd runs in subprocess, doesn't affect parent
cd agents/1 && git status

# Good - git -C operates directly
git -C agents/1 status
```

**Proof**:
```bash
git -C agents/1 status --porcelain  # Works from anywhere
git -C agents/1 merge main          # Merges without cd
git -C agents/1 rebase main         # Rebases without cd
```

### 2. Rebase vs Merge for Same Hash

**Problem**: Merge creates unique commit → different hashes across agents
**Solution**: Rebase moves branch pointer → same hash

```bash
# Merge (different hashes)
git -C agents/1 merge main    # Creates merge commit → unique hash

# Rebase (same hash)
git -C agents/1 rebase main   # Moves branch to main → same hash
```

**Proof**:
```
Before rebase:
  Main: 777351a
  Agent 1: 777351a

After main has new commit:
  Main: f8f0ea9

After rebase:
  Agent 1: f8f0ea9 ← SAME!
```

### 3. Two-Way Sync Pattern

When agent has work that main needs:

```bash
# Step 1: Agent rebases onto main (gets main's updates)
git -C agents/1 rebase main

# Step 2: Main rebases onto agent (gets agent's work)
git rebase agents/1

# Step 3: All agents sync
maw sync
```

**Result**: All worktrees at same commit hash.

### 4. Per-Agent Prefix for Conflict-Free Logs

**Problem**: Shared log files cause merge conflicts on sync
**Solution**: Prefix naming `agent-{N}.{type}.log`

```
# Bad (conflicts)
.agent-locks/activity.log  ← All agents write here

# Good (no conflicts)
.agent-logs/agent-1.activity.log  ← Only agent 1 writes
.agent-logs/agent-2.activity.log  ← Only agent 2 writes
.agent-logs/agent-main.activity.log  ← Only main writes
```

**Proof**:
```bash
# From agent 1 worktree
maw log activity "Hello from agent 1"
# → Writes to .agent-logs/agent-1.activity.log

# From agent 2 worktree
maw log activity "Hello from agent 2"
# → Writes to .agent-logs/agent-2.activity.log

# No conflict on sync!
```

### 5. Find Main Repo Root from Worktree

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
```

## How Things Connect

```
git -C ──────► Respect worktree boundaries
    │
    ▼
rebase ──────► Same commit hash
    │
    ▼
maw sync ────► All agents synchronized
    │
    ▼
prefix logs ─► No merge conflicts
```

## Key Insight: Listen First

When user says "should be same" → solve the problem, don't explain why it's different.

**Wrong approach**: "Different hashes is correct git behavior because..."
**Right approach**: "To get same hash, use rebase instead of merge"

## Commands Created

| Command | Purpose |
|---------|---------|
| `maw sync` | Rebase all agents onto main (same hash) |
| `maw log <type> <msg>` | Write to per-agent log file |
| `maw warp --print <N>` | Output path for subprocess use |
| `maw-warp <N>` | Shell function that actually changes dir |

## Tags

`git` `worktree` `rebase` `maw` `sync` `conflict-free` `git-C`
