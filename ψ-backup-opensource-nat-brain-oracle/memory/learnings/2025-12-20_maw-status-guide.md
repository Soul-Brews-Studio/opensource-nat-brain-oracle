# maw status Command Guide

> Comprehensive guide to monitoring MAW agent status through both local and database-based views.

---

## Overview

MAW provides two complementary status monitoring systems:

| System | Command | Data Source | Best For |
|--------|---------|-------------|----------|
| **Local Peek** | `maw peek` | Git status + focus.md | Quick local check |
| **Database Status** | `agent-status.sh` | PocketBase | Real-time task tracking |

---

## Part 1: maw peek (Local Status)

### What It Shows

The `maw peek` command provides a quick snapshot of all agent worktrees by reading:
- Git working tree status (modified/new files)
- Current task from `ψ/inbox/focus.md`
- Latest commit hash

### Basic Usage

```bash
# Table view of all agents
maw peek

# Detailed view of specific agent
maw peek 1
maw peek 2
maw peek main
```

### Output Format

**Table View** (`maw peek`):
```
🔍 Peeking at all agents...

Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ ✓        │ Document maw status command    │ 0c58a79
1      │ 3 mod    │ Implement feature X            │ abc1234
2      │ 2m 1+    │ Refactor auth module           │ def5678
```

**Status Indicators**:
| Symbol | Meaning |
|--------|---------|
| `✓` | Clean (no changes) |
| `N mod` | N modified files |
| `N new` | N new/untracked files |
| `Nm N+` | N modified + N new files |
| `N chg` | N other changes |

### Detailed View

**Single Agent** (`maw peek 1`):
```
═══ Agent 1 ═══
Modified:
 M src/feature.ts
 M tests/feature.test.ts
?? src/new-file.ts

Focus:
  STATE: working
  TASK: Implement feature X
  SINCE: 14:30

Last commit:
  abc1234 feat: add validation logic (2 hours ago)
```

### How It Works

1. **Git Status**: Runs `git -C <worktree> status --porcelain`
2. **Focus File**: Reads `ψ/inbox/focus.md` for current task
3. **Commit**: Runs `git log -1 --format="%h"`

### Key Benefits

- **No External Dependencies**: Works purely on local files
- **Instant Response**: No network calls
- **Worktree Boundary Respect**: Uses `git -C` pattern
- **Read-Only**: Never modifies any state

---

## Part 2: Database Status (agent-status.sh)

### Purpose

For real-time task tracking with persistent history, MAW uses PocketBase to store agent status records. This enables:
- Task status persistence across restarts
- Real-time monitoring with auto-refresh
- Query specific agent history
- Audit trail for debugging

### Direct Script Usage

Since the `maw status` command may not be wired in all environments, you can call the scripts directly:

```bash
# List all agent statuses
.agents/scripts/agent-status.sh list

# Watch mode (auto-refresh every 2 seconds)
.agents/scripts/agent-status.sh watch

# Query specific agent
.agents/scripts/agent-status.sh 2
```

### Commands Reference

| Command | Description |
|---------|-------------|
| `list` | Show all agents' current status |
| `watch` | Real-time watcher with 2s refresh |
| `<agent_id>` | Show specific agent status details |

### Output Examples

**List View**:
```
📊 Agent Status Summary

────────────────────────────────────────────────────────────────
Agent    | Status       | Task                 | Started
────────────────────────────────────────────────────────────────
2        | working      | refactor-auth        | 2025-12-20T14:30
3        | completed    | fix-validation       | 2025-12-20T14:15
1        | pending      | -                    | -
────────────────────────────────────────────────────────────────

Total records: 3
```

**Watch Mode**:
```
🔍 Agent Status Monitor - 2025-12-20 14:35:22

📊 Agent Status Summary
[... same as list view ...]

Refreshing in 2 seconds... (Ctrl+C to stop)
```

**Agent Detail**:
```
📋 Status for Agent 2

{
  "agent_id": "2",
  "status": "working",
  "task_name": "refactor-auth",
  "started_at": "2025-12-20T14:30:00Z",
  "completed_at": null,
  "result": null,
  "error": null
}
```

### Status Values

| Status | Meaning | Emoji |
|--------|---------|-------|
| `pending` | Task assigned, not started | ⏳ |
| `working` | Currently processing | 🔄 |
| `completed` | Task finished successfully | ✅ |
| `failed` | Task encountered error | ❌ |

### Environment Variables

```bash
# PocketBase URL (default: http://127.0.0.1:8090)
export POCKETBASE_URL="http://localhost:8090"

# Collection ID (default: pbc_agent_status)
export COLLECTION_ID="pbc_agent_status"
```

### Requirements

- **PocketBase** must be running
- **agent_status** collection must exist with schema:
  - `agent_id` (text)
  - `status` (text)
  - `task_name` (text)
  - `started_at` (datetime)
  - `completed_at` (datetime)
  - `result` (json)
  - `error` (text)

---

## Part 3: Alternative Status Check (check-agent-status.sh)

A simpler Python-based status checker:

```bash
.agents/scripts/check-agent-status.sh
```

**Output**:
```
📊 Agent Status from PocketBase:
================================
🔄 Agent 2: WORKING
   Task: refactor-auth
✅ Agent 3: COMPLETED
   Task: fix-validation
   Done: 2025-12-20T14:20:00Z
```

This script provides a compact emoji-based view suitable for quick checks.

---

## When to Use Which

| Scenario | Recommended Tool |
|----------|------------------|
| Quick check of local changes | `maw peek` |
| See what agents are working on | `maw peek` |
| Monitor multi-agent session | `agent-status.sh watch` |
| Debug task failures | `agent-status.sh <id>` |
| Audit historical tasks | Query PocketBase directly |
| Worktree sync check | `maw peek` |

---

## Integration with tmux Layouts

Some MAW layouts auto-start the status watcher in a dedicated pane:

| Layout | Status Pane | Auto-Runs |
|--------|-------------|-----------|
| `grid-3x2-full` | Pane 5 | `maw status watch` |
| `grid-2x3` | Bottom-right | `maw status watch` |
| `six-horizontal-2win` | Window 1 Pane 2 | `maw status watch` |

The monitor pane provides persistent visibility into agent activity during development sessions.

---

## Comparison: peek vs status

| Feature | `maw peek` | `agent-status.sh` |
|---------|------------|-------------------|
| Data source | Local files | PocketBase DB |
| Network required | No | Yes |
| Persistence | No | Yes |
| Real-time watch | No | Yes (2s refresh) |
| Task history | No | Yes |
| Git status | Yes | No |
| Focus.md reading | Yes | No |
| Dependencies | Git only | PocketBase + curl + jq |

### Complementary Usage

For comprehensive monitoring:
1. Use `maw peek` to check git status and local state
2. Use `agent-status.sh watch` for task progression tracking

---

## Troubleshooting

### peek shows wrong task
The task is read from `ψ/inbox/focus.md`. Ensure agents update this file:
```bash
# Focus file format
STATE: working
TASK: [description]
SINCE: [time]
```

### status shows "Failed to fetch"
```bash
# Check PocketBase is running
curl -s http://127.0.0.1:8090/api/health

# Verify collection exists
curl -s "http://127.0.0.1:8090/api/collections/pbc_agent_status/records"
```

### No status records found
Agents must actively update their status via the PocketBase API:
```bash
# Example status update
curl -X POST "http://127.0.0.1:8090/api/collections/pbc_agent_status/records" \
  -H "Content-Type: application/json" \
  -d '{"agent_id": "2", "status": "working", "task_name": "my-task"}'
```

### watch mode not updating
- Verify PocketBase is responding
- Check for network issues
- Ensure `jq` is installed for JSON parsing

---

## Best Practices

### Before Starting Work
```bash
# Check all agents' local state
maw peek

# Verify no uncommitted work conflicts
```

### During Multi-Agent Sessions
```bash
# Keep status watcher in a dedicated pane
.agents/scripts/agent-status.sh watch

# Or use peek for quick spot checks
maw peek 1
```

### After Session Completion
```bash
# Final check all agents
maw peek

# Verify all tasks completed
.agents/scripts/agent-status.sh list
```

---

## Related Commands

| Command | Purpose | See Guide |
|---------|---------|-----------|
| `maw kill` | Terminate agent sessions | `2025-12-20_maw-kill-guide.md` |
| `maw start` | Launch agent sessions | `2025-12-20_maw-start-guide.md` |
| `maw hey` | Send messages to agents | `2025-12-20_maw-hey-guide.md` |
| `maw sync` | Synchronize worktrees | Smart-sync documentation |

---

## Summary

The MAW status system provides visibility through two complementary approaches:

1. **maw peek**: Fast local checks using git and focus files
   - No dependencies beyond git
   - Shows file changes + current task + latest commit
   - Table or detailed view

2. **agent-status.sh**: Database-backed task tracking
   - Persistent history in PocketBase
   - Real-time watch mode
   - Agent-specific detail queries

Use both together for comprehensive multi-agent monitoring during development sessions.

---

*Last Updated: 2025-12-20*
