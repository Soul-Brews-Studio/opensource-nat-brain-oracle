# maw start Command Guide

> Comprehensive guide to the Multi-Agent Workspace startup system

## Overview

`maw start` launches a tmux session with multiple agent panes, each automatically warped to their respective worktree directories. It handles profile-based layouts, direnv configuration, and optional auto-starting of AI agents.

```bash
# Basic usage
maw start              # Uses profile0 (default)
maw start profile6     # Use specific profile
maw start --detach     # Start in background
maw start --prefix dev # Custom session prefix
```

---

## Command Options

| Option | Description |
|--------|-------------|
| `<profile>` | Profile name (e.g., `profile0`, `profile6`, `profile14`) |
| `--detach`, `-d` | Start session in background, don't attach |
| `--prefix <name>` | Custom session name prefix |

### Session Naming

Default: `ai-<repo-name>` (e.g., `ai-Nat-s-Agents`)

With prefix: `<prefix>-ai-<repo-name>` (e.g., `dev-ai-Nat-s-Agents`)

---

## Profile System

Profiles define pane layout and window structure. Located in `.agents/profiles/`.

### Available Profiles

| Profile | Layout Type | Agents | Description |
|---------|-------------|--------|-------------|
| `profile0` | three-horizontal | 3 | Three side-by-side panes |
| `profile1` | two-pane | 2 | Top/bottom split |
| `profile2` | three-pane | 3 | Left + two right panes |
| `profile6` | grid-3x2 | 5+monitor | 3x2 grid with monitor |
| `profile14` | six-horizontal-2win | 5+monitor | Two windows, 3 panes each |

### Layout Types Explained

#### Single Window Layouts

```
three-horizontal (profile0):
┌─────────────────────────────────────────────┐
│ Agent 1     │ Agent 2     │ Agent 3         │
└─────────────────────────────────────────────┘

two-pane:
┌─────────────────────────────────────────────┐
│                 Agent 1                     │
├─────────────────────────────────────────────┤
│                 Agent 2                     │
└─────────────────────────────────────────────┘

grid-3x2 (profile6):
┌───────────┬───────────┬───────────┐
│ Agent 1   │ Agent 2   │ Agent 3   │
├───────────┼───────────┼───────────┤
│ Agent 4   │ Agent 5   │ Monitor   │
└───────────┴───────────┴───────────┘
```

#### Multi-Window Layouts

```
six-horizontal-2win (profile14):

WINDOW 0: Execution Layer
┌─────────────┬─────────────┬─────────────┐
│ Agent 1     │ Agent 2     │ Agent 3     │
└─────────────┴─────────────┴─────────────┘

WINDOW 1: Specialization + Monitor
┌─────────────┬─────────────┬─────────────┐
│ Agent 4     │ Agent 5     │ Monitor     │
└─────────────┴─────────────┴─────────────┘
```

### Creating Custom Profiles

```bash
# .agents/profiles/my-profile.sh
#!/bin/bash
# Profile: My Custom Layout

LAYOUT_TYPE="three-horizontal"

# Optional dimension overrides
CENTER_WIDTH=66    # Center pane percentage
RIGHT_WIDTH=50     # Right pane percentage

# For grid layouts
GRID_ROWS=2
GRID_COLS=3
GRID_TOP_HEIGHT=50
```

---

## Auto-Warp Functionality

**Auto-warp** automatically navigates each pane to its corresponding agent worktree directory after session creation.

### How It Works

1. Script detects all panes in the session
2. Maps each pane index to an agent directory
3. Sends `cd '/path/to/agents/N'` to each pane
4. Each pane lands in its agent worktree

### Mapping Logic

The mapping depends on `LAYOUT_TYPE`:

| Layout | Pane → Agent Mapping |
|--------|---------------------|
| `three-horizontal` | Pane 0 → Agent 1, Pane 1 → Agent 2, Pane 2 → Agent 3 |
| `grid-3x2` | Pane 0-5 → Agents 1-5 (Pane 5 = Monitor, skipped) |
| `six-horizontal-2win` | Window 0: Panes 0-2 → Agents 1-3; Window 1: Panes 0-1 → Agents 4-5 |

### Monitor Panes

Certain layouts reserve a pane for monitoring:

- `grid-3x2-full`: Pane 5 runs `maw status watch`
- `grid-2x3`: Bottom-right runs `maw status watch`
- `six-horizontal-2win`: Window 1 Pane 2 runs `maw status watch`

Monitor panes are NOT warped to agent directories.

---

## direnv Integration

The start script handles direnv configuration for all worktrees.

### Pre-Session Setup

Before creating the tmux session:

```bash
# Runs .agents/scripts/direnv-allow.sh
# Allows direnv in root and all agent worktrees
```

### Broadcast to Panes

After pane creation:

```bash
# Sends "direnv allow >/dev/null" to each pane
# Ensures .envrc is loaded in all shells
```

### Skip direnv

```bash
SKIP_DIRENV_ALLOW=1 maw start
```

---

## Session Lifecycle

### Startup Flow

```
1. Parse arguments (profile, --detach, --prefix)
2. Source profile configuration
3. Run direnv-allow.sh across worktrees
4. Create tmux session
5. Split panes according to layout
6. Load tmux.conf
7. Broadcast direnv allow
8. Auto-warp panes to agent directories
9. Start PocketBase (inbox system)
10. Optionally auto-start AI agents
11. Attach to session (unless --detach)
```

### Existing Session Handling

If session already exists:

- **Interactive mode**: Prompt to attach
- **Detached mode**: Print attach command and exit

```bash
# If ai-Nat-s-Agents exists:
ℹ️ Session 'ai-Nat-s-Agents' already running
❓ Attach to existing session? [y/N]:
```

---

## Auto-Start Agents

Optional feature to automatically launch AI agents in panes.

### Enable

```bash
AUTO_START_AGENTS=1 maw start
```

### Agent Commands

| Agent | Command |
|-------|---------|
| Agent 1 | `claude --dangerously-skip-permissions` |
| Agents 2-5 | `codex --dangerously-bypass-approvals-and-sandbox --enable web_search_request` |

### Multi-Window Distribution

- **Window 0 (Execution)**: Agents 1-3
- **Window 1 (Specialization)**: Agents 4-5 + Monitor (skipped)

---

## PocketBase Integration

The start script automatically starts PocketBase for the agent inbox system.

```bash
# Started on http://127.0.0.1:8090
# Data stored in .agents/pocketbase/
```

Checks if already running before starting:
- If port 8090 is available → starts PocketBase
- If already running → skips with info message

---

## Troubleshooting

### Pane Base Index Issues

If panes don't warp correctly, check tmux pane-base-index:

```bash
tmux show-options -g pane-base-index
# Should match your tmux.conf setting (usually 0 or 1)
```

### direnv Not Loading

```bash
# Force reload
direnv allow
# Or skip entirely
SKIP_DIRENV_ALLOW=1 maw start
```

### Session Cleanup

```bash
# Kill stuck session
tmux kill-session -t ai-Nat-s-Agents

# Start fresh
maw start
```

---

## Quick Reference

```bash
# Common usage patterns
maw start                     # Default profile, attach
maw start profile14           # Multi-window layout
maw start -d                  # Detached mode
maw start --prefix work       # Custom prefix

# Environment variables
AUTO_START_AGENTS=1           # Auto-launch AI agents
SKIP_DIRENV_ALLOW=1           # Skip direnv setup
SESSION_PREFIX=dev            # Default session prefix

# After start
tmux attach-session -t ai-Nat-s-Agents  # Attach manually
maw peek                               # Check all agent status
maw status watch                       # Live monitoring
```

---

*Last Updated: 2025-12-20*
