# MAW Session Management

> Complete guide to managing tmux session lifecycle in Multi-Agent Workspace

## Overview

MAW uses tmux sessions to organize multiple agent panes. The session lifecycle is managed through three core commands: `start`, `attach`, and `kill`. Sessions follow a naming convention that allows multiple independent workspaces.

## Session Naming Convention

Sessions are named using the pattern: `[prefix-]<base>-<repo>`

| Component | Source | Default | Example |
|-----------|--------|---------|---------|
| `prefix` | `--prefix` flag | (none) | `work-` |
| `base` | `$SESSION_PREFIX` env | `ai` | `ai` |
| `repo` | Directory name | - | `Nat-s-Agents` |

**Examples:**
```bash
# Default session name
ai-Nat-s-Agents

# With custom prefix
work-ai-Nat-s-Agents

# With custom SESSION_PREFIX
SESSION_PREFIX=dev → dev-Nat-s-Agents
```

## Core Commands

### `maw start [profile] [options]`

Creates a new tmux session with agent panes.

```bash
# Basic start (uses profile0)
maw start

# Start with specific profile
maw start profile6    # 6-agent grid layout

# Start in detached mode
maw start -d
maw start --detach

# Start with custom prefix (for multiple instances)
maw start --prefix work
```

**Behavior:**
1. Checks if session already exists
2. If exists: prompts to attach (or attaches in detached mode)
3. If not: creates new session with configured layout
4. Runs `direnv allow` in all panes automatically
5. Sends startup commands to each agent pane

### `maw attach [options]`

Connects to an existing session.

```bash
# Attach to default session
maw attach

# Attach to prefixed session
maw attach --prefix work

# Attach to specific session by name
maw attach --session my-session
```

**Error handling:**
- If session not found: lists available sessions
- If tmux not installed: shows error message

### `maw kill [options]`

Terminates sessions matching the pattern.

```bash
# Kill default session
maw kill

# Kill prefixed sessions
maw kill --prefix work

# Override session prefix matching
maw kill --session-prefix dev
```

**Safety features:**
- Shows matching sessions before killing
- Requires confirmation (y/N prompt)
- Pattern-based matching prevents accidental kills

## Session Detection

The scripts detect existing sessions before acting:

```bash
# Check if session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

# List sessions matching pattern
tmux list-sessions -F "#{session_name}" | grep "^${PATTERN}"
```

## Lifecycle States

```
┌─────────────────────────────────────────────────────────┐
│                   Session Lifecycle                      │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  [No Session] ──maw start──▶ [Running] ──maw kill──▶ ✕  │
│       ▲                          │                       │
│       │                          │                       │
│       └──────────────────────────┘                       │
│              (session closed)                            │
│                                                          │
│  [Running] ◀──maw attach──▶ [Attached]                  │
│       │              │                                   │
│       │              └── detach (Ctrl+b d) ──┘          │
│       │                                                  │
│       └── maw start ──▶ "Already running" prompt        │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## Prefix System

The prefix system enables multiple independent MAW instances:

```bash
# Work context
maw start --prefix work
# Creates: work-ai-Nat-s-Agents

# Personal context
maw start --prefix personal
# Creates: personal-ai-Nat-s-Agents

# Both can run simultaneously
tmux list-sessions
# work-ai-Nat-s-Agents
# personal-ai-Nat-s-Agents

# Attach to specific context
maw attach --prefix work

# Kill specific context
maw kill --prefix personal
```

## Direnv Integration

Sessions automatically configure direnv:

1. **Pre-session**: Runs `direnv-allow.sh` for all worktrees
2. **Post-creation**: Broadcasts `direnv allow` to each pane
3. **Skip option**: `SKIP_DIRENV_ALLOW=1 maw start`

```bash
# The direnv broadcast sends to each pane:
tmux send-keys -t "$pane_id" "direnv allow >/dev/null" C-m
```

## Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `SESSION_PREFIX` | Base prefix for session names | `ai` |
| `SKIP_DIRENV_ALLOW` | Skip direnv setup | (unset) |
| `TMUX_CONF` | Custom tmux config path | (auto-detected) |

## Shell Aliases

For convenience, MAW provides aliases:

```bash
maw-start   # → maw start
maw-attach  # → maw attach
maw-kill    # → maw kill
```

## Troubleshooting

### Session won't start

```bash
# Check for existing session
tmux list-sessions

# Kill orphaned session
tmux kill-session -t ai-Nat-s-Agents

# Check for initialization errors
git -C /path/to/repo rev-parse --verify HEAD
```

### Can't attach to session

```bash
# Verify session exists
tmux has-session -t ai-Nat-s-Agents && echo "exists"

# List all sessions
tmux list-sessions -F "#{session_name}"

# Attach with explicit name
tmux attach-session -t ai-Nat-s-Agents
```

### Kill not working

```bash
# Check pattern matching
tmux list-sessions -F "#{session_name}" | grep "ai-"

# Force kill specific session
tmux kill-session -t "session-name"
```

## Quick Reference

| Action | Command |
|--------|---------|
| Start default session | `maw start` |
| Start with profile | `maw start profile6` |
| Start detached | `maw start -d` |
| Start new instance | `maw start --prefix work` |
| Attach to session | `maw attach` |
| Attach to instance | `maw attach --prefix work` |
| Kill session | `maw kill` |
| Kill instance | `maw kill --prefix work` |
| List sessions | `tmux list-sessions` |
| Detach from session | `Ctrl+b d` |

---

*See also: [maw-start-guide.md](2025-12-20_maw-start-guide.md), [maw-troubleshooting.md](2025-12-20_maw-troubleshooting.md)*
