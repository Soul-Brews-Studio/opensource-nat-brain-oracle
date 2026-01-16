# MAW Wait Command - Agent Completion Synchronization

> **Date**: 2025-12-20
> **Category**: MAW Toolkit / Multi-Agent Coordination
> **Location**: `.agents/scripts/wait.sh`

## Overview

The `maw wait` command provides efficient coordination for multi-agent workflows by detecting when agents have committed their work. It uses 1-second polling on git commit hashes, offering a balanced approach between responsiveness and resource usage.

## Command Syntax

```bash
# Basic usage - wait for default agents (1, 2, 3)
maw wait

# Wait for specific agents
maw wait 1 2

# Custom timeout (default: 300s)
maw wait --timeout 120
maw wait -t 60

# Combined
maw wait 2 3 4 --timeout 180
```

## How It Works

### Detection Mechanism

The command detects agent completion by monitoring git commit hashes:

1. **Baseline Recording**: Records current HEAD commit for each target agent
2. **Polling Loop**: Checks every 1 second if HEAD has changed
3. **Completion Detection**: When `git rev-parse --short HEAD` differs from baseline, agent is marked complete

```bash
# Internal implementation pattern
BASE=$(git -C "agents/$agent" rev-parse --short HEAD)
# ... wait loop ...
CURRENT=$(git -C "agents/$agent" rev-parse --short HEAD)
if [[ "$CURRENT" != "$BASE" ]]; then
    # Agent committed!
fi
```

### Why Commit-Based Detection?

| Approach | Pros | Cons |
|----------|------|------|
| **Git commits** | Reliable, meaningful, no false positives | 1s latency |
| File markers | Simple | Can be stale, requires cleanup |
| tmux signals | Instant (ms) | Complex, agent must send signal |

Git commits represent actual work completion. An agent that commits has definitively finished their task.

## Comparison with Legacy Scripts

### wait-for-agents.sh (File-based)

```bash
# Checks for .tmp/agent${N}-done files
if [ -f ".tmp/agent${AGENT}-done" ]; then
    MODIFIED=$(stat -f %m ".tmp/agent${AGENT}-done")
    # Check if recently modified
fi
```

**Issues**: Files can persist across sessions, requires manual cleanup, agents must explicitly create marker files.

### wait-agents-fast.sh (tmux Signal-based)

```bash
# Uses tmux wait-signal for instant response
tmux wait-signal "agent${AGENT}-complete"
```

**Issues**: Requires agents to send `tmux send-signal`, more complex setup, brittle across session restarts.

### maw wait (Git-based)

```bash
# Simply checks if commit hash changed
CURRENT=$(git -C "agents/$agent" rev-parse --short HEAD)
[[ "$CURRENT" != "$BASE" ]]
```

**Advantages**:
- No agent-side cooperation needed
- Works across session restarts
- Detects actual work completion
- Self-cleaning (git is the source of truth)

## Typical Workflow

### Human Orchestrating Multiple Agents

```bash
# 1. Send tasks to agents
maw hey 1 "implement the parser"
maw hey 2 "write unit tests"
maw hey 3 "update documentation"

# 2. Wait for all to commit
maw wait 1 2 3

# 3. Sync changes to main
maw sync
```

### Agent Waiting for Other Agents

From within an agent's Claude session:
```bash
# Wait for agent 2 to commit before proceeding
bash -c 'cd $(git rev-parse --show-toplevel) && source .agents/maw.env.sh && maw wait 2'
```

## Output Format

```
⏳ Waiting for agents: 1 2 3 (timeout: 300s)
   Agent 1 base: abc123
   Agent 2 base: def456
   Agent 3 base: ghi789
✅ Agent 2 committed: xyz999 (15s)
✅ Agent 1 committed: uvw888 (23s)
✅ Agent 3 committed: rst777 (45s)
🎉 All agents committed! (45s)
```

On timeout:
```
⏰ Timeout after 300s
   Pending: 3
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All agents committed within timeout |
| 1 | Timeout reached with pending agents |

## Implementation Details

### Temp File Usage

The script stores baseline commits in temp files:
```bash
$TMPDIR/maw-wait-base-1
$TMPDIR/maw-wait-base-2
# etc.
```

These are cleaned up on completion or timeout.

### Default Agents

When no agents specified, defaults to `1 2 3`. This matches the common 3-agent grid layout.

### Cross-Worktree Execution

Uses `git -C "agents/$agent"` pattern to check commits without changing directory, respecting worktree boundaries.

## Best Practices

1. **Set reasonable timeouts**: Match timeout to expected task duration
2. **Be specific**: List only the agents you're actually waiting for
3. **Combine with maw sync**: After wait completes, sync changes to main

## Integration with MAW Ecosystem

| Command | Relationship |
|---------|--------------|
| `maw hey` | Send task, then wait for completion |
| `maw sync` | Sync after wait confirms completion |
| `maw peek` | Check status while waiting (different terminal) |

## Edge Cases

### Agent Never Commits

The timeout mechanism handles this gracefully, reporting which agents are still pending.

### Agent Commits Multiple Times

Only the first commit triggers completion. The baseline is set once at start.

### Agent Worktree Doesn't Exist

Falls back to "unknown" baseline, which will never match a real commit hash.

---

*See also*: `2025-12-20_maw-workflow-automation.md`, `2025-12-17_maw-sync-best-practices.md`
