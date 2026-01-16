# MAW Workflow Automation Patterns

> Learned: 2025-12-20
> Context: Understanding how MAW orchestrates multi-agent workflows

## Overview

MAW (Multi-Agent Workflow) provides workflow automation through shell scripts, environment configuration, and inter-agent communication. The system enables parallel agent execution with coordinated synchronization.

---

## Architecture Tiers

MAW uses a 3-tier agent architecture for workflow distribution:

| Tier | Agent | Role | Model | Responsibility |
|------|-------|------|-------|----------------|
| 1 (Strategic) | 0 | Orchestrator | claude | Thinks/decides, minimal tokens |
| 2 (Tactical) | 1 | Shadow | claude | Executes / commands for Agent 0 |
| 3 (Operational) | 2-5 | Executors | codex | Execute tasks via inbox requests |

### Key Principle

Agent 0 orchestrates but doesn't execute. Work flows down through tiers.

---

## Automation Triggers

### 1. Environment-Based (direnv)

When entering the repo directory, `.envrc` automatically:

```bash
# Auto-start agents when launching MAW
export AUTO_START_AGENTS=1

# MAW environment variables
export MAW_REPO_ROOT="$PWD"
export CODEX_WORKSPACE="$GIT_COMMON_DIR/.."
```

### 2. Session Startup

`maw start` triggers the workflow:

```bash
maw start [profile]    # Launch tmux session with layout
maw start profile1     # 2x2 grid layout
maw start profile5     # 6-pane dashboard
```

### 3. Command Dispatch

The `maw` function routes commands to appropriate scripts:

```bash
maw hey <agent> <message>   # Send message to agent
maw sync                    # Sync all worktrees
maw attach <agent>          # Attach to agent pane
maw peek                    # Check agent status
```

---

## Communication Patterns

### Inter-Agent Messaging (hey.sh)

The `maw hey` command sends messages to agent panes:

```bash
# Single agent
maw hey 1 "analyze this repository"
maw hey 2 "create auth feature plan"

# Broadcast to all
maw hey all "git pull"

# Root pane (main worktree)
maw hey root "git status"
```

**Implementation details:**
- Uses tmux `send-keys` for short messages
- Uses tmux `load-buffer` + `paste-buffer` for multiline/long content
- Sleep delays allow Claude to process before Enter key

### Agent-to-Pane Mapping

```bash
maw hey --list    # List available agents
maw hey --map     # Show agent → pane mapping
```

The mapping is dynamic based on worktree order:
- Agent 1 → pane 0
- Agent 2 → pane 1
- Root → detected by matching repo path

---

## Synchronization Workflows

### Smart Sync Pattern

`maw sync` (smart-sync.sh) safely updates all agents:

```bash
# Algorithm:
# 1. Find all agent worktrees
# 2. Check each worktree status
# 3. If clean → rebase onto main
# 4. If dirty → skip with warning
# 5. If conflict → abort and report
```

**Safety guarantees:**
- Never forces sync on dirty worktrees
- Uses rebase (not merge) for same commit hash
- Aborts and preserves state on conflicts

### Manual Sync Pattern

From any agent worktree:

```bash
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Commit local work
git add -A && git commit -m "my work"

# 2. Main rebases onto agent
git -C "$ROOT" rebase agents/N

# 3. Sync other agents
git -C "$ROOT/agents/1" rebase main
git -C "$ROOT/agents/2" rebase main

# 4. Push
git -C "$ROOT" push origin main
```

---

## State Management

### Focus Tracking

Each agent maintains `ψ/inbox/focus.md`:

```markdown
STATE: working|focusing|pending|jumped|completed
TASK: [current task description]
SINCE: 13:40
```

### Activity Logging

Append to `ψ/memory/logs/activity.log`:

```
2025-12-20 13:40 | working | create workflow automation docs
2025-12-20 13:55 | completed | docs committed
```

---

## Error Handling Patterns

### Conflict Recovery

When sync fails:

```bash
# Check status
git -C agents/N status

# Manual resolution
git -C agents/N rebase main

# If stuck, abort
git -C agents/N rebase --abort
```

### Dirty Worktree Handling

Smart sync skips dirty worktrees rather than forcing:

```
⚠ Has uncommitted changes:
 M src/feature.ts
 ?? src/new-file.ts
  → Skipping auto-sync (agent must commit first)
```

### Timeout Recovery

```bash
maw kill <agent>      # Kill single agent
maw kill-all          # Kill all sessions
maw start             # Fresh restart
```

---

## Best Practices

### Workflow Orchestration

1. **Agent 0 delegates, doesn't execute**
   - Send tasks via `maw hey`
   - Check results via `maw peek`
   - Avoid direct file operations

2. **Use parallel execution**
   - Send independent tasks to multiple agents simultaneously
   - Let sync consolidate results

3. **Commit before sync**
   - Always commit local changes before sync operations
   - Smart sync will skip dirty worktrees

### Communication Efficiency

1. **Short messages preferred**
   - Under 500 chars uses direct send-keys
   - Longer content uses buffer method

2. **Use inbox for complex requests**
   - Write to agent's `ψ/inbox/` for structured requests
   - Agent reads and responds to inbox

3. **Broadcast sparingly**
   - `maw hey all` useful for status checks
   - Avoid for complex, differentiated tasks

---

## Related Documentation

- `2025-12-20_maw-sync-internals.md` - Detailed sync patterns
- `2025-12-20_maw-hey-command-guide.md` - Message passing details
- `2025-12-20_maw-profiles-guide.md` - Layout configurations
- `2025-12-20_maw-error-recovery.md` - Recovery procedures
