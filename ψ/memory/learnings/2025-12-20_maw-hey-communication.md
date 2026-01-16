# MAW Hey Command: Inter-Agent Communication

> `maw hey` enables human-to-agent and human-to-all broadcasting via tmux

## Overview

The `hey.sh` script provides a reliable way to send messages to running agents in the MAW tmux session. It handles both short commands and long multiline content with appropriate timing.

## Command Syntax

```bash
# Basic usage
maw hey <agent> <message>

# Options
maw hey --list    # List available agents
maw hey --map     # Show agent-to-pane mapping

# Aliases
maw-hey <agent> <message>
```

## Target Types

| Target | Description | Example |
|--------|-------------|---------|
| `<number>` | Specific agent by ID | `maw hey 1 "analyze this"` |
| `<name>` | Agent by name | `maw hey backend-api "check status"` |
| `root` | Main worktree pane | `maw hey root "git status"` |
| `main` | Alias for root | `maw hey main "ls"` |
| `all` | Broadcast to all agents | `maw hey all "git pull"` |

## Message Delivery Mechanisms

### Short Messages (< 500 chars, single line)

```bash
# Direct send-keys approach
tmux send-keys -t "$pane" "$text"
sleep 0.05
tmux send-keys -t "$pane" Enter
```

**Timing**: 50ms delay before Enter key

### Long/Multiline Messages (> 500 chars OR contains newlines)

```bash
# Buffer-based approach for reliability
echo "$text" | tmux load-buffer -
tmux paste-buffer -t "$pane"
sleep 0.3  # Claude needs time to process pasted content
tmux send-keys -t "$pane" Enter
```

**Timing**: 300ms delay after paste, before Enter

This dual approach ensures:
- Fast delivery for quick commands
- Reliable transfer for complex multi-line prompts

## Session Discovery

The script automatically finds the correct tmux session:

```bash
# Session naming pattern
SESSION_PREFIX=ai  # default, configurable
DIR_NAME=$(basename "$REPO_ROOT")  # e.g., "Nat-s-Agents"

# Tries in order:
# 1. Exact match: ai-Nat-s-Agents
# 2. Pattern match: ai-Nat-s-Agents-*
```

If multiple sessions match, an error is shown requiring `SESSION_PREFIX` specification.

## Pane Mapping

Agents are mapped to panes based on directory order:

```bash
# agents/ directory listing determines pane order
agents/
├── 1/   → pane 0 (or PANE_BASE)
├── 2/   → pane 1 (or PANE_BASE + 1)
├── 3/   → pane 2 (or PANE_BASE + 2)
└── ...
```

The script respects `pane-base-index` from tmux config (default: 0).

## Broadcast Mode

When using `all` target:

```bash
maw hey all "sync now"
```

The script:
1. Counts all panes in the session window
2. Iterates through each pane
3. Skips the root pane (detected by path matching `$REPO_ROOT`)
4. Sends message to each agent pane

## Integration with PocketBase Status System

While `hey.sh` handles message delivery, agent status is tracked separately via PocketBase:

| Component | Purpose |
|-----------|---------|
| `hey.sh` | Send messages to agents |
| `agent-status.sh` | Query PocketBase for status |
| `peek.sh` | Quick status overview (git + focus) |

### Status Collection (separate from hey)

```bash
# PocketBase endpoint for status
POCKETBASE_URL=http://127.0.0.1:8090
COLLECTION_ID=pbc_agent_status
```

Agents update their status in PocketBase with:
- `agent_id`: Agent identifier
- `status`: Current state
- `task_name`: What they're working on
- `started_at`: Task start time
- `completed_at`: Task completion time
- `result`: Task outcome
- `error`: Any error messages

## Monitoring Agent Reception

### Quick Status Check

```bash
maw peek      # Table view of all agents
maw peek 1    # Detailed view of agent 1
```

### Status Watch (Real-time)

```bash
maw status watch  # Auto-refresh every 2 seconds
```

## Common Usage Patterns

### 1. Task Assignment

```bash
# Assign specific task to agent
maw hey 1 "Implement the login feature per issue #42"
```

### 2. Broadcast Sync Command

```bash
# All agents pull latest
maw hey all "git pull origin main && git status"
```

### 3. Root Maintenance

```bash
# Run maintenance on main worktree
maw hey root "git gc && git prune"
```

### 4. Multiline Task

```bash
# Complex task with context
maw hey 2 "Please review the following files:
- src/auth.ts
- src/middleware.ts
- tests/auth.test.ts

Focus on security vulnerabilities."
```

## Timing Considerations

| Operation | Delay | Reason |
|-----------|-------|--------|
| Short message → Enter | 50ms | Minimal latency |
| Paste buffer → Enter | 300ms | Claude processing time |
| Between broadcasts | none | Sequential per-pane |

The 300ms delay for pasted content is critical - Claude Code needs time to receive and process the pasted text before the Enter key is sent.

## Error Handling

| Error | Cause | Resolution |
|-------|-------|------------|
| "No tmux session found" | Session not running | Run `maw start` first |
| "Multiple matching sessions" | Ambiguous session | Set `SESSION_PREFIX` |
| "Agent not found" | Invalid agent name | Use `maw hey --list` |
| "No message provided" | Missing message arg | Provide message text |
| "Could not find root pane" | Path mismatch | Check worktree setup |

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `SESSION_PREFIX` | `ai` | Session name prefix |
| `MAW_REPO_ROOT` | auto-detect | Repository root path |

## Related Commands

| Command | Purpose |
|---------|---------|
| `maw start` | Start agent session |
| `maw peek` | Check agent status |
| `maw status` | PocketBase status query |
| `maw warp <n>` | Navigate to agent pane |
| `maw zoom <n>` | Toggle pane zoom |

## Architecture Diagram

```
┌─────────────────────────────────────────────────────┐
│                   tmux session                       │
│  ai-Nat-s-Agents                                    │
│  ┌───────────┬───────────┬───────────┬───────────┐  │
│  │  Agent 1  │  Agent 2  │  Agent 3  │   Root    │  │
│  │  pane 0   │  pane 1   │  pane 2   │  pane 3   │  │
│  │           │           │           │           │  │
│  │  ┌─────┐  │  ┌─────┐  │  ┌─────┐  │  ┌─────┐  │  │
│  │  │Claude│  │  │Claude│  │  │Claude│  │ shell │  │  │
│  │  └─────┘  │  └─────┘  │  └─────┘  │  └─────┘  │  │
│  └─────▲─────┴─────▲─────┴─────▲─────┴─────▲─────┘  │
│        │           │           │           │        │
└────────┼───────────┼───────────┼───────────┼────────┘
         │           │           │           │
         └───────────┴─────┬─────┴───────────┘
                           │
                    ┌──────┴──────┐
                    │   hey.sh    │
                    │ (send-keys) │
                    │ (buffer)    │
                    └─────────────┘
```

## Best Practices

1. **Check status first**: Use `maw peek` before sending tasks
2. **Use multiline for complex tasks**: The buffer method is more reliable
3. **Broadcast sparingly**: `all` disrupts all agents simultaneously
4. **Monitor reception**: Watch for response after sending

---

*Source: `.agents/scripts/hey.sh`*
*Related: `agent-status.sh`, `peek.sh`, `send-commands.sh`*
