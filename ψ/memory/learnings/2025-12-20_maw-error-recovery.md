# MAW Error Recovery Guide

> When agents get stuck, here's how to diagnose and recover.

## Overview

Multi-agent workflows can fail in several ways: agents can become blocked, timeouts can occur, sessions can disconnect, and git conflicts can arise. This guide provides a systematic approach to diagnosing problems with `maw peek` and recovering from common error scenarios.

---

## Common Error Scenarios

### 1. Agent Blocking

An agent is "blocked" when it cannot progress due to:

| Block Type | Symptom | Cause |
|------------|---------|-------|
| Lock contention | `maw-lock.sh` reports agent locked | Another task in progress |
| Waiting for input | No activity, pane idle | Agent awaiting user response |
| Resource wait | Hanging on external call | Network, API, or filesystem issue |
| Git conflict | Rebase/merge stopped | Divergent branches |

### 2. Timeout Issues

Timeouts occur when operations exceed expected duration:

| Script | Default Timeout | Purpose |
|--------|-----------------|---------|
| `wait-agents-fast.sh` | 600s (10 min) | Wait for tmux signals |
| `wait-for-agents.sh` | 300s (5 min) | Poll for completion files |
| `maw-lock.sh wait` | 10s | Wait for agent unlock |

### 3. Session Disconnection

tmux sessions can become detached or inaccessible:

- Network interruption during SSH session
- Terminal emulator crash
- Accidental Ctrl-B D (detach)
- System sleep/hibernate

### 4. Worktree Conflicts

Git worktree issues from divergent work:

- Agent commits on stale branch
- Conflicting edits to same file
- Failed rebase operations

---

## Diagnostic Workflow

### Step 1: Quick Status Check

Start with `maw peek` for an overview:

```bash
maw peek
```

Example output showing problems:

```
Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ ✓        │ Orchestrating tasks            │ f59ff0b
1      │ 3 mod    │ Stuck on API call...           │ f59ff0b  ← Modified files
2      │ ✓        │ -                              │ 64f574b  ← Different hash!
3      │ 7m 2+    │ Working on feature             │ f59ff0b
```

**Red flags:**
- Different commit hashes = out of sync
- High modification count = work not committed
- Empty task (`-`) = agent idle or crashed
- Same task for long time = possibly stuck

### Step 2: Deep Inspection

For suspicious agents, get details:

```bash
maw peek 1
```

Output:

```
═══ Agent 1 ═══
Modified:
 M ψ/inbox/focus.md
 M src/api/client.ts
?? .tmp/debug.log

Focus:
  STATE: working
  TASK: Fix API timeout issue
  SINCE: 12:30

Last commit:
  f59ff0b signal: start parallel tasks (45 minutes ago)
```

**Diagnostic questions:**
- Is `SINCE` time old? Agent may be stuck.
- Are there many modifications? Work not committed.
- Is `.tmp/` growing? Debug output accumulating.

### Step 3: Check Lock Status

If using the lock system:

```bash
.agents/scripts/maw-lock.sh status
```

Output:

```
=== MAW Agent Status Dashboard ===

Agent 1: 🔒 WORKING
  Task: Fix API timeout issue
  Since: 2025-12-20T12:30:00Z

Agent 2: 🔓 AVAILABLE

Agent 3: 🔒 WORKING
  Task: Write documentation
  Since: 2025-12-20T12:45:00Z
```

### Step 4: Session Verification

Check if tmux sessions are running:

```bash
tmux list-sessions | grep ai-Nat
```

Expected output:

```
ai-Nat-s-Agents: 4 windows (created Fri Dec 20 12:00:00 2025)
```

If no sessions found, agents have crashed or been killed.

---

## Recovery Procedures

### Timeout Recovery

#### Scenario: `wait-agents-fast.sh` timed out

```
⏱️ Agent 2: TIMEOUT
```

**Recovery steps:**

1. **Check if agent is actually working:**
   ```bash
   maw peek 2
   ```

2. **If still working, extend timeout:**
   ```bash
   # Wait another 10 minutes
   .agents/scripts/wait-agents-fast.sh "2" 600
   ```

3. **If stuck, investigate the pane:**
   ```bash
   maw attach
   # Navigate to agent 2's pane: Ctrl-B, then window number
   ```

4. **Manual intervention if needed:**
   - Send Ctrl-C to interrupt stuck command
   - Check for permission prompts
   - Review Claude's output for errors

#### Scenario: `wait-for-agents.sh` timed out (file-based)

The script polls for `.tmp/agentN-done` files.

**Recovery:**

1. **Check if done file exists:**
   ```bash
   ls -la .tmp/agent*-done
   ```

2. **If file is old, agent may have finished but file wasn't detected:**
   ```bash
   # Check modification time
   stat .tmp/agent2-done
   ```

3. **Manually create done signal:**
   ```bash
   touch .tmp/agent2-done
   ```

---

### Session Recovery

#### Scenario: Detached from tmux session

**Recovery:**

```bash
maw attach
```

Or with explicit session:

```bash
maw attach --session ai-Nat-s-Agents
```

#### Scenario: Session doesn't exist

**Recovery options:**

1. **Restart agents:**
   ```bash
   maw start profile14
   ```

2. **Check for orphaned worktrees with work:**
   ```bash
   maw peek
   # Look for modifications that need committing
   ```

3. **Manually commit work before restart:**
   ```bash
   git -C agents/1 add -A && git -C agents/1 commit -m "WIP: interrupted session"
   ```

---

### Lock Recovery

#### Scenario: Agent locked but not working

```
⚠️  Agent 2 is already locked!
Current task:
  "task": "Old task from yesterday"
```

**Recovery:**

```bash
# Force unlock (after verifying agent isn't working)
.agents/scripts/maw-lock.sh unlock 2
```

#### Scenario: Orphaned lock files

After system crash, lock files may remain:

```bash
# Check lock directory
ls -la .agent-locks/

# Remove stale locks manually
rm .agent-locks/agent-2.lock
```

---

### Worktree Cleanup

#### Scenario: Agent has uncommitted changes blocking sync

**Option A: Commit the work**

```bash
git -C agents/1 add -A
git -C agents/1 commit -m "WIP: partial progress"
```

**Option B: Stash the work**

```bash
git -C agents/1 stash push -m "Stashed for sync"
```

**Option C: Use safe-reset.sh (creates backup commits)**

```bash
.agents/scripts/safe-reset.sh
```

This script:
1. Audits all agents for uncommitted work
2. Creates WIP backup commits automatically
3. Asks for confirmation before resetting
4. Provides recovery instructions

#### Scenario: Rebase conflict during sync

```bash
git -C agents/2 rebase main
# CONFLICT: merge conflict in src/api/client.ts
```

**Recovery:**

1. **Abort rebase:**
   ```bash
   git -C agents/2 rebase --abort
   ```

2. **Investigate the conflict:**
   ```bash
   git -C agents/2 diff main
   ```

3. **Decide resolution strategy:**
   - Commit agent's work first, then rebase
   - Reset agent to main, replay changes manually
   - Merge instead of rebase (creates merge commit)

---

## Recovery Decision Tree

```
Problem detected
     │
     ├── Agent not responding?
     │     ├── Check maw peek → shows activity? Wait longer
     │     └── No activity → Check tmux pane manually
     │
     ├── Agent out of sync?
     │     ├── Has uncommitted work? Commit first
     │     └── Clean worktree? Run git rebase main
     │
     ├── Lock stuck?
     │     ├── Agent actually working? Wait
     │     └── Lock orphaned? Force unlock
     │
     └── Session gone?
           ├── maw attach (if detached)
           └── maw start (if killed)
```

---

## Prevention Strategies

### 1. Regular Status Checks

During parallel work, periodically run:

```bash
maw peek
```

Catch problems early before they compound.

### 2. Commit Frequently

Agents should commit work-in-progress:

```bash
git add -A && git commit -m "WIP: checkpoint"
```

Small commits are easier to recover than large uncommitted changes.

### 3. Use Timeout-Aware Scripts

The wait scripts have reasonable defaults:
- `wait-agents-fast.sh`: 10 minute default
- `wait-for-agents.sh`: 5 minute default

Adjust based on task complexity:

```bash
# Long-running task? Extend timeout
.agents/scripts/wait-agents-fast.sh "2 3" 1800  # 30 minutes
```

### 4. Pre-Sync Safety Check

Before syncing worktrees:

```bash
maw peek
# Verify all Status columns show ✓
```

Never sync while agents have uncommitted work.

### 5. Activity Logging

Use the lock system's activity log:

```bash
cat .agent-locks/activity.log
```

Review history to understand what happened before failure.

---

## Quick Reference Commands

| Command | Purpose |
|---------|---------|
| `maw peek` | Status overview |
| `maw peek N` | Detailed agent status |
| `maw attach` | Reconnect to session |
| `maw kill` | Stop all sessions |
| `tmux list-sessions` | Verify sessions exist |
| `.agents/scripts/maw-lock.sh status` | Lock dashboard |
| `.agents/scripts/safe-reset.sh` | Safe worktree cleanup |
| `git -C agents/N status` | Git status for agent |

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-peek-guide.md` - Peek command details
- `ψ/memory/learnings/2025-12-20_maw-attach-guide.md` - Session attachment
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` - Sync patterns

---

*Last updated: 2025-12-20*
*Source: `.agents/scripts/` implementation analysis*
