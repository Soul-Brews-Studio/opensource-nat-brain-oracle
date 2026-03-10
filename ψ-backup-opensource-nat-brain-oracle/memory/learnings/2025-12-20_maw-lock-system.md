# MAW Lock System - Agent Task Tracking & Signal Coordination

**Created**: 2025-12-20
**Source**: `.agents/scripts/maw-lock.sh`
**Status**: Production-ready component of MAW conflict prevention system
**Related**: `MAW-COMPLETE-SYSTEM.md`, `2025-12-17_maw-sync-best-practices.md`

---

## Overview

The MAW Lock System provides **mutex-like coordination** for multi-agent workflows. It prevents task conflicts by tracking which agents are working on what, enabling signal-based completion detection, and maintaining a full audit trail of all task assignments.

### Core Philosophy

```
"Prevention over resolution" - Check BEFORE assigning, not AFTER conflicts occur
```

The lock system embodies the MAW safety principle: it's better to prevent an agent from getting a conflicting task than to resolve merge conflicts after the fact.

---

## Architecture

### Directory Structure

```
$REPO_ROOT/
├── .agent-locks/           # Lock files + activity log
│   ├── agent-1.lock        # JSON: task metadata
│   ├── agent-2.lock
│   ├── agent-3.lock
│   ├── activity.log        # All assignments/completions
│   └── completions.log     # Signal-based completions
│
└── .sync/                  # Shared signal directory (cross-worktree)
    ├── .gitkeep            # Keep in git
    └── agent-N-task-$$     # Signal files (PID-specific)
```

### Critical Design Decision

The `.sync/` directory uses `$REPO_ROOT/.sync/` (absolute path), NOT relative `.sync/`. This is essential because:

- Each agent worktree (`agents/1/`, `agents/2/`) is a separate working directory
- Relative paths would create **separate** `.sync/` directories per worktree
- Shared signals require a **single** location accessible from all worktrees

```bash
# WRONG - creates separate directories
SYNC_DIR=".sync"  # agents/1/.sync vs agents/2/.sync - signals never shared!

# CORRECT - shared location
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
SYNC_DIR="$REPO_ROOT/.sync"  # All agents access same directory
```

---

## Lock File Format

Lock files use JSON-like format for easy parsing by any tool:

```json
{
  "agent": 1,
  "task": "Create documentation for lock system",
  "status": "working",
  "started": "2025-12-20T14:30:00Z",
  "assigned_by": "nat",
  "branch": "agents/1",
  "signal": "/path/to/.sync/agent-1-task-12345",
  "pid": 12345
}
```

### Field Descriptions

| Field | Type | Purpose |
|-------|------|---------|
| `agent` | number | Agent number (1-5) |
| `task` | string | Task description |
| `status` | string | Always "working" when locked |
| `started` | ISO8601 | UTC timestamp of lock creation |
| `assigned_by` | string | Username who assigned task (from `whoami`) |
| `branch` | string | Agent's branch name (e.g., "agents/1") |
| `signal` | string | Path to signal file for completion detection |
| `pid` | number | Process ID of the locking process (for debugging) |

### assigned_by Tracking

The `assigned_by` field captures **who** assigned the task:

```bash
local assigned_by=$(whoami)  # Captures current user
```

This enables:
- **Audit trail**: Know who assigned what to whom
- **Debugging**: Trace task origin when issues occur
- **Multi-user support**: Different users can assign tasks, all tracked

### PID Tracking

The `pid` field stores the shell process ID:

```bash
local signal_file="$SYNC_DIR/agent-$agent-task-$$"  # $$ = current PID
"pid": $$
```

This enables:
- **Unique signal files**: Each assignment gets unique signal path
- **Process correlation**: Link signals to originating process
- **Stale lock detection**: Check if PID still running

---

## Core Functions

### 1. lock_agent - Create Lock

```bash
lock_agent <agent_num> <task_description>
```

**Behavior**:
1. Checks if agent already locked (prevents double-assignment)
2. Creates lock file with full metadata
3. Logs to activity.log
4. Returns unique signal file path

**Safety Guard**:
```bash
if [ -f "$lock_file" ]; then
    echo "Agent $agent is already locked!"
    cat "$lock_file" | head -5  # Show current task
    return 1  # FAIL - don't overwrite
fi
```

### 2. unlock_agent - Release Lock

```bash
unlock_agent <agent_num>
```

**Behavior**:
1. Verifies lock exists
2. Extracts task name for logging
3. Logs completion to activity.log
4. Removes lock file

**Important**: Does NOT remove signal file (caller responsibility)

### 3. check_lock - Query Status

```bash
check_lock <agent_num>
```

**Return values**:
- Exit 0 + "UNLOCKED (available)" if no lock
- Exit 1 + lock contents if locked

### 4. show_all_locks - Dashboard

```bash
show_all_locks  # or: maw-lock.sh status
```

**Output**:
```
=== MAW Agent Status Dashboard ===

Agent 1: WORKING
  Task: Create documentation for lock system
  Since: 2025-12-20T14:30:00Z

Agent 2: AVAILABLE

Agent 3: WORKING
  Task: Implement API endpoint
  Since: 2025-12-20T14:25:00Z

Agent 4: AVAILABLE
Agent 5: AVAILABLE

Summary: 2 working, 3 available
```

### 5. maw_hey_smart - Auto-Lock Assignment

```bash
maw_hey_smart <agent_num> <task>  # or: maw-lock.sh hey 1 "task"
```

**This is the key integration point**. Instead of just `maw hey 1 "task"`, use the smart variant:

1. **Locks** the agent first
2. **Sends** the task via regular `maw hey`
3. **Reports** signal file for completion tracking

```bash
# Old way (no tracking)
maw hey 1 "Create documentation"

# New way (with tracking)
./.agents/scripts/maw-lock.sh hey 1 "Create documentation"
# or with alias:
maw-hey-smart 1 "Create documentation"
```

### 6. wait_for_agent - Signal-Based Wait

```bash
wait_for_agent <agent_num> [timeout_iterations]
```

**Behavior**:
1. Reads signal file path from lock
2. Polls for signal file existence (100ms intervals)
3. When signal detected: unlocks agent, removes signal, returns success
4. On timeout: returns failure

**Signal Flow**:
```
maw-hey-smart 1 "task"   →   Agent works   →   Agent creates signal file   →   wait_for_agent detects
      ↓                            ↓                       ↓                           ↓
   Lock created              Task runs              touch $signal_file            Auto-unlock
```

---

## Signal Coordination Pattern

### How Signals Work

The lock system uses **file-based signals** for cross-process coordination:

1. **Lock creation** defines signal path: `.sync/agent-1-task-12345`
2. **Agent completion** touches the signal file: `touch $signal`
3. **Waiter detects** file existence and unlocks

### Signal File Naming

```bash
local signal_file="$SYNC_DIR/agent-$agent-task-$$"
# Example: .sync/agent-1-task-45678
```

Components:
- `agent-N`: Which agent
- `task-$$`: PID for uniqueness

### Integration with wait.sh

The `wait.sh` script (separate from lock system) uses a different approach - it watches for **git commits**:

```bash
# wait.sh checks for commit changes
BASE=$(git -C "agents/$agent" rev-parse --short HEAD)
CURRENT=$(git -C "agents/$agent" rev-parse --short HEAD)
if [[ "$CURRENT" != "$BASE" ]]; then
    echo "Agent $agent committed: $CURRENT"
fi
```

**Two wait mechanisms**:
| Mechanism | Detection | Use Case |
|-----------|-----------|----------|
| `maw-lock.sh wait` | Signal file | Task completion (any task) |
| `wait.sh` | Git commit | Commit-based completion |

---

## Activity Logging

All assignments and completions are logged to `activity.log`:

```
2025-12-20T14:30:00Z | ASSIGN | Agent 1 | Create documentation for lock system
2025-12-20T14:45:00Z | COMPLETE | Agent 1 | Create documentation for lock system
2025-12-20T14:31:00Z | ASSIGN | Agent 2 | Run tests
2025-12-20T14:50:00Z | COMPLETE | Agent 2 | Run tests
```

### Log Format

```
<ISO8601 UTC timestamp> | <ACTION> | Agent <N> | <task description>
```

Actions:
- `ASSIGN`: Lock created
- `COMPLETE`: Lock released

---

## Command Reference

### Via maw-lock.sh

```bash
# Lock operations
./.agents/scripts/maw-lock.sh lock 1 "task"    # Create lock
./.agents/scripts/maw-lock.sh unlock 1         # Release lock
./.agents/scripts/maw-lock.sh check 1          # Check status

# Dashboard
./.agents/scripts/maw-lock.sh status           # All agents
./.agents/scripts/maw-lock.sh dashboard        # Alias

# Smart assignment
./.agents/scripts/maw-lock.sh hey 1 "task"     # Lock + send

# Wait for completion
./.agents/scripts/maw-lock.sh wait 1           # Default timeout
./.agents/scripts/maw-lock.sh wait 1 200       # 200 iterations (~20s)
```

### Recommended Aliases (.envrc)

```bash
alias maw-lock='./.agents/scripts/maw-lock.sh lock'
alias maw-unlock='./.agents/scripts/maw-lock.sh unlock'
alias maw-status='./.agents/scripts/maw-lock.sh status'
alias maw-hey-smart='./.agents/scripts/maw-lock.sh hey'
alias maw-wait='./.agents/scripts/maw-lock.sh wait'
```

---

## Best Practices

### 1. Always Use Smart Assignment

```bash
# Instead of:
maw hey 1 "task"

# Use:
maw-hey-smart 1 "task"  # or maw-lock.sh hey 1 "task"
```

This ensures:
- No double-assignment
- Task tracking
- Signal-based completion

### 2. Check Before Manual Assignment

```bash
maw-status  # Check who's available first
maw-hey-smart 2 "task"  # Assign to available agent
```

### 3. Clean Up Stale Locks

If an agent crashes without unlocking:

```bash
maw-unlock 1  # Manual unlock
# Or check if lock is stale:
cat .agent-locks/agent-1.lock | grep pid  # Check if PID still running
```

### 4. Use Absolute Paths for Signals

When creating custom signal patterns:

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
SIGNAL="$REPO_ROOT/.sync/my-custom-signal"
touch "$SIGNAL"  # Always absolute!
```

---

## Integration Points

### With MAW Conflict Prevention

The lock system is part of the 8-pattern conflict prevention system:

| Pattern | Lock System Role |
|---------|------------------|
| Status Check Before Assignment | `check_lock` prevents double-assignment |
| WIP Commits Before Sync | Works with safe-reset.sh |
| Smart Locks | Core implementation |
| Signal-Based Coordination | `wait_for_agent` |

### With hey.sh

`hey.sh` handles the tmux communication:
```bash
send_message "$TARGET_PANE" "$MESSAGE"
```

`maw-lock.sh hey` wraps this with lock tracking:
```bash
if lock_agent "$agent" "$task"; then
    source "$REPO_ROOT/.envrc" && maw hey "$agent" "$task"
fi
```

### With wait.sh

Two complementary approaches:
- `maw-lock.sh wait`: Signal-file based (any completion)
- `wait.sh`: Git-commit based (tracks HEAD changes)

---

## Troubleshooting

### "Agent is already locked"

```bash
maw-status  # See current task
maw-unlock 1  # If task is done but not unlocked
```

### Signal not detected

Check signal path in lock file:
```bash
cat .agent-locks/agent-1.lock | grep signal
# Verify file exists:
ls -la /path/to/.sync/agent-1-task-*
```

### Activity log growing large

Log rotation is not built-in. Manual cleanup:
```bash
tail -1000 .agent-locks/activity.log > .agent-locks/activity.log.new
mv .agent-locks/activity.log.new .agent-locks/activity.log
```

---

## Design Decisions

### Why JSON-like Format?

- Human-readable (debug-friendly)
- Parseable by any language (grep, jq, Python)
- Self-documenting (field names visible)

### Why File-Based Signals?

- Cross-process compatible
- Works across different shells
- No external dependencies (no Redis, no DB)
- Visible for debugging (`ls .sync/`)

### Why PID in Lock?

- Uniqueness guarantee for signal files
- Stale lock detection (check if PID running)
- Audit trail for debugging

---

## Summary

The MAW Lock System provides:

1. **Mutex-like locking** to prevent double-assignment
2. **Signal coordination** for completion detection
3. **Full audit trail** via activity.log
4. **Rich metadata** (assigned_by, PID, timestamp, branch)
5. **Smart integration** with `maw hey` via `maw-hey-smart`

It's a key component of the "prevention over resolution" philosophy that makes multi-agent workflows safe and predictable.

---

**File Stats**: ~300 lines | Covers: lock files, signals, PID tracking, integration
**See Also**: `MAW-COMPLETE-SYSTEM.md`, `maw/INDEX.md`, `2025-12-17_maw-sync-best-practices.md`
