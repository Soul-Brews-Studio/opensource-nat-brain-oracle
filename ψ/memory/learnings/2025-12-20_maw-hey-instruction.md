# MAW Hey Workflow: Complete Parallel Task Execution Guide

**Date**: 2025-12-20
**Status**: Production Reference
**Audience**: Developers using Multi-Agent Worktree (MAW) system

---

## Overview

The `maw hey` command enables parallel task distribution to multiple AI agents running in isolated git worktrees. This guide covers the complete workflow from session start to task completion, including safety checkpoints and rollback procedures.

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `maw start [profile]` | Launch tmux session with agent panes |
| `maw hey <agent> "task"` | Send task to specific agent |
| `maw hey all "command"` | Broadcast to all agents |
| `maw peek` | Check all agent status (table view) |
| `maw peek <agent>` | Check specific agent (detailed view) |
| `maw sync` | Sync clean agents to main (rebase) |
| `maw attach` | Attach to existing session |
| `maw zoom <agent>` | Toggle pane zoom for agent |

---

## Complete Workflow

### Phase 1: Pre-Flight Safety Checkpoint

Before starting any parallel work, create a git tag as a checkpoint. This enables easy rollback if the parallel work goes wrong.

```bash
# Create checkpoint tag with timestamp
git tag pre-maw-$(date +%Y%m%d-%H%M%S)

# Verify tag was created
git tag -l 'pre-maw-*' | tail -1
```

**Expected output:**
```
pre-maw-20251220-115500
```

### Phase 2: Sync All Agents First

Ensure all agents are on the same commit as main before assigning work.

```bash
# Check current state
maw peek

# Sync all clean agents to main
maw sync
```

**Expected output from `maw peek`:**
```
🔍 Peeking at all agents...

Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ ✓        │ orchestrating parallel tasks   │ 90e58f6
1      │ ✓        │ -                              │ 90e58f6
2      │ ✓        │ -                              │ 90e58f6
3      │ ✓        │ -                              │ 90e58f6
4      │ ✓        │ -                              │ 90e58f6
5      │ ✓        │ -                              │ 90e58f6
```

**Expected output from `maw sync`:**
```
📡 Smart Sync - Syncing all agent worktrees from main

Found 5 agent worktrees: 1 2 3 4 5

=== Agent 1 ===
✓ Clean - rebasing onto main
  → Synced to 90e58f6

=== Agent 2 ===
✓ Clean - rebasing onto main
  → Synced to 90e58f6

[... continues for all agents ...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Summary:
✓ Synced: 5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 3: Start Agent Session

Launch the tmux session with your preferred layout profile.

```bash
# Start with default profile
maw start

# Or specify a profile
maw start profile0      # 3 horizontal panes
maw start profile8      # 5 agents + monitor (2 windows)
maw start profile14     # 6 horizontal (2 windows)
```

**Expected output:**
```
📋 Using profile: profile0
Starting session in root directory...
Adding pane 1 (center)...
Adding pane 2 (right)...
🔧 Configuring direnv in all worktrees...
🚀 Auto-warping panes to agent directories...
   AGENTS_ARRAY: 1 2 3 4 5
   📍 Pane 0 → Agent 1 (index=0)
   📍 Pane 1 → Agent 2 (index=1)
   📍 Pane 2 → Agent 3 (index=2)
✅ Auto-warp complete
✅ Started 5 agents in tmux session: ai-Nat-s-Agents
📍 Attaching to session...
```

### Phase 4: Assign Tasks with `maw hey`

Send tasks to specific agents using the `maw hey` command.

#### Single Agent Assignment

```bash
# Assign task to agent 1
maw hey 1 "Implement user authentication module"

# Assign task to agent 2
maw hey 2 "Write unit tests for API endpoints"

# Assign task to agent 3
maw hey 3 "Create database migration scripts"
```

**Expected output:**
```
📤 Sending to agent '1' (pane 0): Implement user authentication module
✅ Sent successfully
```

#### Broadcast to All Agents

```bash
# Send command to all agents
maw hey all "git status"

# Broadcast a query
maw hey all "What is your current focus?"
```

**Expected output:**
```
📢 Broadcasting to all agents: git status
✅ Broadcasted to all agent panes
```

#### Send to Root Pane

```bash
# Send command to main/root pane
maw hey root "maw peek"
maw hey main "git log -5"
```

### Phase 5: Monitor Progress

Continuously check agent status during parallel work.

```bash
# Table view of all agents
maw peek

# Detailed view of specific agent
maw peek 1
```

**Expected output from `maw peek 1`:**
```
═══ Agent 1 ═══
Modified:
 M src/auth/middleware.ts
?? src/auth/tests/

Focus:
  STATE: working
  TASK: Implement user authentication module
  SINCE: 11:55

Last commit:
  90e58f6 forward: ready to execute MAW trial (2 hours ago)
```

### Phase 6: Collect and Sync Work

When agents complete their tasks, collect their work into main.

#### Pattern A: Agent Commits → Main Rebases → All Sync

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Agent 1 commits their work
git -C "$ROOT/agents/1" add -A
git -C "$ROOT/agents/1" commit -m "feat: implement user auth module"

# 2. Main rebases onto agent 1 (gets their work)
git -C "$ROOT" rebase agents/1

# 3. Reconcile with origin (if remote has changes)
git -C "$ROOT" pull --rebase origin main

# 4. Sync all agents to same hash
git -C "$ROOT/agents/2" rebase main
git -C "$ROOT/agents/3" rebase main
git -C "$ROOT/agents/4" rebase main
git -C "$ROOT/agents/5" rebase main

# 5. Push to origin
git -C "$ROOT" push origin main
```

#### Pattern B: Using `maw sync` (Recommended)

```bash
# After agent commits their work...
maw sync
git push origin main
```

### Phase 7: Rollback If Needed

If parallel work goes wrong, use the checkpoint tag to rollback.

```bash
# Find your checkpoint
git tag -l 'pre-maw-*'

# Reset to checkpoint
git checkout pre-maw-20251220-115500

# Or hard reset (use with caution)
git reset --hard pre-maw-20251220-115500

# Re-sync all agents
maw sync
```

---

## Task Template Format

When assigning tasks via `maw hey`, use a structured format for clarity:

```bash
maw hey 1 "# Task: TASK-ID

## Objective
Brief description of what needs to be done

## Output
- File: expected output file path
- Format: expected format

## Instructions
1. Step one
2. Step two
3. Step three

## When Done
git add <files>
git commit -m \"description\"
touch .agent-signals/agent-1.done"
```

**Example:**

```bash
maw hey 1 "# Task: AUTH-001

## Objective
Implement JWT authentication middleware

## Output
- File: src/middleware/auth.ts
- Format: TypeScript

## Instructions
1. Create JWT validation function
2. Add token refresh logic
3. Write unit tests

## When Done
git add src/middleware/auth.ts
git commit -m \"feat: JWT auth middleware\"
touch .agent-signals/agent-1.done"
```

---

## Troubleshooting

### Agent Not Responding

**Symptoms**: `maw hey` shows success but agent pane is unresponsive

**Solutions**:

1. **Check if agent is in Claude/AI session**:
   ```bash
   maw peek 1  # Check agent status
   ```

2. **Check tmux pane exists**:
   ```bash
   tmux list-panes -t ai-Nat-s-Agents -F "#{pane_index} #{pane_current_path}"
   ```

3. **Manually send keystrokes**:
   ```bash
   # Send Ctrl+C to interrupt
   tmux send-keys -t "ai-Nat-s-Agents:0.0" C-c

   # Then resend the task
   maw hey 1 "your task"
   ```

4. **Restart specific agent pane**:
   ```bash
   # Kill and respawn the pane
   tmux kill-pane -t "ai-Nat-s-Agents:0.0"
   # Then restart session
   maw start
   ```

### Sync Conflicts

**Symptoms**: `maw sync` shows rebase conflict

**Solutions**:

1. **Manual conflict resolution**:
   ```bash
   # Go to conflicting agent
   cd agents/1

   # Resolve conflicts in files
   git add <resolved-files>
   git rebase --continue
   ```

2. **Abort and retry**:
   ```bash
   git -C agents/1 rebase --abort

   # Let agent commit first, then sync
   git -C agents/1 add -A
   git -C agents/1 commit -m "WIP: save work"
   maw sync
   ```

3. **Check for dirty worktrees**:
   ```bash
   # See which agents have uncommitted changes
   maw peek

   # Agent must commit before sync
   git -C agents/2 add -A
   git -C agents/2 commit -m "WIP"
   ```

### Dirty Worktree Blocking Sync

**Symptoms**: `maw sync` shows "Has uncommitted changes" and skips agent

**Expected behavior**: This is by design. Smart sync only syncs clean worktrees.

**Solutions**:

1. **Let agent commit first**:
   ```bash
   git -C agents/1 add -A
   git -C agents/1 commit -m "WIP: in progress work"
   maw sync
   ```

2. **Stash and sync**:
   ```bash
   git -C agents/1 stash
   maw sync
   git -C agents/1 stash pop
   ```

### Rollback Procedure

**When**: Parallel work caused issues, need to restore previous state

```bash
# 1. Find your checkpoint
git tag -l 'pre-maw-*'

# 2. See what changed since checkpoint
git log pre-maw-20251220-115500..HEAD --oneline

# 3. Soft reset (keeps changes, moves HEAD)
git reset --soft pre-maw-20251220-115500

# 4. Or hard reset (discards all changes)
git reset --hard pre-maw-20251220-115500

# 5. Force sync all agents to new HEAD
for i in 1 2 3 4 5; do
  git -C agents/$i reset --hard main
done

# 6. Verify all on same commit
maw peek
```

### Session Not Found

**Symptoms**: `maw hey` shows "No tmux session found"

**Solutions**:

```bash
# Check existing sessions
tmux list-sessions

# Start new session
maw start

# Or attach to existing
maw attach
```

---

## Best Practices

### Before Parallel Work

1. **Always create checkpoint tag**
2. **Run `maw sync` first**
3. **Verify all agents clean with `maw peek`**

### During Parallel Work

1. **Use `maw peek` frequently** to monitor progress
2. **Use `maw zoom <agent>`** to focus on specific agent
3. **Keep tasks independent** to avoid conflicts

### After Parallel Work

1. **Have each agent commit their work**
2. **Sync in order**: agent → main → other agents
3. **Push to origin** after verification
4. **Delete checkpoint tags** after successful completion:
   ```bash
   git tag -d pre-maw-20251220-115500
   ```

### Key Principles

| Rule | Why |
|------|-----|
| `git -C` not `cd` | Respect worktree boundaries |
| Rebase not merge | Same commit hash across all |
| Peek before sync | Know what you're syncing |
| Never force push | Preserve history |
| Checkpoint tags | Easy rollback |

---

## Tags

`maw` `hey` `parallel` `tmux` `worktree` `sync` `workflow` `agents`
