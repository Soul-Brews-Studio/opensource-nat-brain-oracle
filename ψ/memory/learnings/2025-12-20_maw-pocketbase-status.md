# MAW PocketBase Agent Status Tracking

This document focuses specifically on the agent status tracking system within PocketBase. For the broader inbox/messaging system, see `2025-12-20_maw-pocketbase.md`.

---

## Overview

The `agent_status` collection in PocketBase provides real-time visibility into what each agent is working on. Unlike the file-based `focus.md` approach (which is local to each worktree), PocketBase status is centralized and queryable from anywhere.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                  PocketBase (127.0.0.1:8090)                    │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              agent_status Collection                     │   │
│  │  ─────────────────────────────────────────────────────  │   │
│  │  agent_id      │ text     │ "agent1", "agent2", etc.    │   │
│  │  status        │ text     │ pending/working/completed   │   │
│  │  task_name     │ text     │ "Creating users collection" │   │
│  │  started_at    │ datetime │ 2025-12-20T13:30:00Z        │   │
│  │  completed_at  │ datetime │ 2025-12-20T13:32:00Z        │   │
│  │  result        │ json     │ {"collection_id": "abc123"} │   │
│  │  error         │ text     │ Error message if failed     │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              ↑                                  │
└──────────────────────────────┼──────────────────────────────────┘
                               │ REST API
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
   ┌────┴────┐           ┌─────┴─────┐          ┌────┴────┐
   │ Agent 1 │           │ Agent 3   │          │ Monitor │
   │ (updates│           │ (updates  │          │ (reads) │
   │  status)│           │  status)  │          │         │
   └─────────┘           └───────────┘          └─────────┘
```

---

## Status Lifecycle

Each agent task flows through these states:

```
pending → working → completed
                ↘ failed
```

| Status | Description | Typical Duration |
|--------|-------------|------------------|
| `pending` | Task received, not yet started | Seconds |
| `working` | Agent actively processing | Seconds to minutes |
| `completed` | Task finished successfully | Terminal state |
| `failed` | Task encountered error | Terminal state |

---

## Scripts Analysis

### 1. agent-status.sh

**Location**: `.agents/scripts/agent-status.sh`

**Purpose**: CLI tool for querying agent status from PocketBase

**Commands**:
```bash
# List all agent statuses (default)
maw status list

# Watch status in real-time (2-second refresh)
maw status watch

# Get detailed status for specific agent
maw status <agent_id>
```

**Key Implementation Details**:

```bash
# Configuration (environment-overridable)
POCKETBASE_URL="${POCKETBASE_URL:-http://127.0.0.1:8090}"
COLLECTION_ID="${COLLECTION_ID:-pbc_agent_status}"

# Query API with sorting (newest first)
curl -s "$POCKETBASE_URL/api/collections/$COLLECTION_ID/records?sort=-created"

# Filter by agent_id
curl -s "$POCKETBASE_URL/api/collections/$COLLECTION_ID/records?filter=(agent_id=\"$agent_id\")&sort=-created&limit=1"
```

**Output Format (Table)**:
```
────────────────────────────────────────────────────────────────
Agent    | Status       | Task                 | Started
────────────────────────────────────────────────────────────────
agent1   | working      | Creating collection  | 2025-12-20T13:30
agent3   | completed    | Running tests        | 2025-12-20T13:28
────────────────────────────────────────────────────────────────
```

### 2. check-agent-status.sh

**Location**: `.agents/scripts/check-agent-status.sh`

**Purpose**: Simpler Python-based status checker with emoji indicators

**Key Implementation**:
```python
status_emoji = {
    "pending": "⏳",
    "working": "🔄",
    "completed": "✅",
    "failed": "❌"
}.get(status, "❓")

print(f"{status_emoji} Agent {agent_id}: {status.upper()}")
```

**Output Format**:
```
📊 Agent Status from PocketBase:
================================
🔄 Agent agent1: WORKING
   Task: Creating collection
✅ Agent agent3: COMPLETED
   Task: Running tests
   Done: 2025-12-20T13:32:00Z
```

---

## API Reference

### Read Operations

**List all statuses**:
```bash
curl http://127.0.0.1:8090/api/collections/agent_status/records
```

**Get latest status for agent**:
```bash
curl "http://127.0.0.1:8090/api/collections/agent_status/records?filter=(agent_id='agent1')&sort=-created&limit=1"
```

**Get statuses sorted by creation**:
```bash
curl "http://127.0.0.1:8090/api/collections/agent_status/records?sort=-created"
```

### Write Operations

**Create status record (start task)**:
```bash
curl -X POST http://127.0.0.1:8090/api/collections/agent_status/records \
  -H "Content-Type: application/json" \
  -d '{
    "agent_id": "agent1",
    "status": "working",
    "task_name": "Creating users collection",
    "started_at": "2025-12-20T13:30:00Z"
  }'
```

**Update status (complete task)**:
```bash
curl -X PATCH http://127.0.0.1:8090/api/collections/agent_status/records/<record_id> \
  -H "Content-Type: application/json" \
  -d '{
    "status": "completed",
    "completed_at": "2025-12-20T13:32:00Z",
    "result": {"collection_id": "abc123"}
  }'
```

**Update status (failure)**:
```bash
curl -X PATCH http://127.0.0.1:8090/api/collections/agent_status/records/<record_id> \
  -H "Content-Type: application/json" \
  -d '{
    "status": "failed",
    "completed_at": "2025-12-20T13:31:00Z",
    "error": "Collection already exists"
  }'
```

---

## Comparison: PocketBase Status vs focus.md

| Aspect | PocketBase Status | focus.md |
|--------|-------------------|----------|
| **Location** | Centralized database | Per-worktree file |
| **Access** | API from anywhere | File read from worktree |
| **History** | Multiple records per agent | Single current state |
| **Query** | Rich filtering/sorting | grep/cat |
| **Persistence** | Database-backed | Git-tracked |
| **Real-time** | Queryable instantly | Requires file sync |

### When to Use Which

| Scenario | Recommended |
|----------|-------------|
| Quick status check from any location | PocketBase |
| Task history audit | PocketBase |
| Current focus for retrospectives | focus.md |
| Git-based activity tracking | focus.md |
| Cross-agent coordination | PocketBase |
| Offline access | focus.md |

---

## Integration with maw peek

The `maw peek` command combines both approaches:

```bash
# Shows file-based focus.md status
maw peek        # Table view of all agents
maw peek 1      # Detailed view of agent 1
```

**peek.sh reads**:
- Git status (modified/new files)
- `ψ/inbox/focus.md` task
- Last commit hash

**Future Enhancement**: Could integrate PocketBase status for richer view.

---

## Startup Integration

PocketBase starts automatically with MAW:

```bash
# From start-agents.sh
POCKETBASE_DIR="$REPO_ROOT/.agents/pocketbase"

# Start if not running
if ! nc -z 127.0.0.1 8090 2>/dev/null; then
  (cd "$POCKETBASE_DIR" && pocketbase serve --http=127.0.0.1:8090 &)
fi
```

**Admin Dashboard**: http://127.0.0.1:8090/_/

---

## Usage Patterns

### Pattern 1: Agent Self-Reporting

Agents update their own status when starting/completing tasks:

```bash
# Start of task
curl -X POST http://127.0.0.1:8090/api/collections/agent_status/records \
  -d '{"agent_id": "agent3", "status": "working", "task_name": "Building feature"}'

# ... do work ...

# End of task
curl -X PATCH http://127.0.0.1:8090/api/collections/agent_status/records/$ID \
  -d '{"status": "completed", "result": {"files_created": 3}}'
```

### Pattern 2: Coordinator Monitoring

Main agent or monitor checks all agents:

```bash
# Quick status check
maw status list

# Watch for changes
maw status watch
```

### Pattern 3: Waiting for Completion

Wait for specific agent to finish:

```bash
while true; do
  status=$(curl -s "http://127.0.0.1:8090/api/collections/agent_status/records?filter=(agent_id='agent4')" | jq -r '.items[0].status')
  [ "$status" = "completed" ] && break
  sleep 2
done
echo "Agent 4 finished!"
```

---

## Schema Details

```json
{
  "name": "agent_status",
  "type": "base",
  "fields": [
    {
      "name": "agent_id",
      "type": "text",
      "required": true,
      "options": {
        "min": 1,
        "max": 50
      }
    },
    {
      "name": "status",
      "type": "text",
      "options": {
        "pattern": "^(pending|working|completed|failed)$"
      }
    },
    {
      "name": "task_name",
      "type": "text",
      "options": {
        "max": 200
      }
    },
    {
      "name": "started_at",
      "type": "datetime"
    },
    {
      "name": "completed_at",
      "type": "datetime"
    },
    {
      "name": "result",
      "type": "json"
    },
    {
      "name": "error",
      "type": "text",
      "options": {
        "max": 1000
      }
    }
  ]
}
```

---

## Troubleshooting

### Status Not Updating

```bash
# Check PocketBase is running
nc -z 127.0.0.1 8090 && echo "Running" || echo "Not running"

# Verify collection exists
curl http://127.0.0.1:8090/api/collections/agent_status

# Check for API errors
curl -v http://127.0.0.1:8090/api/collections/agent_status/records
```

### No Records Found

```bash
# Create initial status
curl -X POST http://127.0.0.1:8090/api/collections/agent_status/records \
  -H "Content-Type: application/json" \
  -d '{"agent_id": "test", "status": "pending", "task_name": "Test task"}'
```

### Watch Command Not Refreshing

The watch command uses `sleep 2` between refreshes. If terminal doesn't clear:
```bash
# Clear terminal manually
clear && maw status list
```

---

## Related Documentation

- **Inbox System**: `2025-12-20_maw-pocketbase.md` (full inbox + status)
- **peek Command**: Uses file-based focus.md approach
- **Agent Coordination**: Combines both approaches for full visibility

---

**Last Updated**: 2025-12-20
