# MAW Command Cheatsheet

> Multi-Agent Workflow toolkit - Quick reference for all commands

## Quick Reference Table

| Command | Purpose | Example |
|---------|---------|---------|
| `maw start` | Launch tmux session with agents | `maw start` |
| `maw attach` | Connect to running session | `maw attach` |
| `maw kill` | Terminate tmux sessions | `maw kill` |
| `maw warp` | Navigate to agent worktree | `maw warp 1` |
| `maw hey` | Send message to agent | `maw hey 1 analyze repo` |
| `maw zoom` | Toggle pane zoom | `maw zoom 1` |
| `maw peek` | Show all agent status | `maw peek` |
| `maw send` | Broadcast to all panes | `maw send "git status"` |
| `maw agents` | Manage worktrees | `maw agents` |
| `maw install` | Setup/refresh worktrees | `maw install` |
| `maw remove` | Delete agent worktrees | `maw remove` |
| `maw uninstall` | Remove toolkit assets | `maw uninstall` |

---

## Session Lifecycle

### Starting a Session

```bash
# Basic start (uses default profile)
maw start

# Start with specific profile
maw start --profile 6    # 3x2 grid

# Force new session (replaces existing)
maw start --force

# Start without auto-launching agents
AUTO_START_AGENTS=0 maw start
```

### Connecting to Session

```bash
# Attach to running session
maw attach

# Session naming: nat-agents (default prefix)
tmux attach -t nat-agents
```

### Ending Session

```bash
# Kill MAW sessions
maw kill

# Kill with prefix pattern
maw kill nat-agents
```

---

## Navigation

### Warp (Directory Navigation)

```bash
# Navigate to agent worktree
maw warp 1      # → agents/1
maw warp 2      # → agents/2
maw warp root   # → repo root

# Short alias
mw 1            # Same as maw warp 1

# Print path without changing directory
maw warp --print 1
```

### Zoom (Pane Focus)

```bash
# Toggle zoom on agent pane
maw zoom 1      # Zoom agent 1
maw zoom root   # Zoom main pane
maw zoom 1      # Unzoom (toggle)

# Tmux shortcut equivalent
Ctrl+b z        # Toggle zoom current pane
```

---

## Agent Communication

### Hey (Send Message)

```bash
# Send message to specific agent
maw hey 1 analyze this repo
maw hey 2 run tests
maw hey 3 "check for errors"

# Message is typed into agent's pane
# Useful for delegating tasks
```

### Send (Broadcast)

```bash
# Send command to ALL panes
maw send "git status"
maw send "echo hello"

# Useful for synchronization tasks
```

---

## Status & Monitoring

### Peek (Status Overview)

```bash
# Show all agent status (default: table view)
maw peek

# Detailed view with more info
maw peek detail

# Table view explicitly
maw peek table
```

**Output columns:**
- Agent number
- Branch name
- Status (clean/dirty)
- Current task (from focus.md)

---

## Worktree Management

### Install/Setup

```bash
# Initial setup or refresh worktrees
maw install
maw setup       # Alias for install

# Creates agents/1, agents/2, etc.
# Each on their own branch: agents/1, agents/2
```

### Agents (Manual Management)

```bash
# List worktrees
maw agents list

# Add specific worktree
maw agents add 5

# Remove specific worktree
maw agents remove 5
```

### Remove

```bash
# Delete all agent worktrees
maw remove

# Interactive confirmation required
```

### Uninstall

```bash
# Remove toolkit completely
maw uninstall

# Removes .agents directory and worktrees
```

---

## Profile Layouts

| Profile | Layout | Use Case |
|---------|--------|----------|
| 0 | 3 horizontal panes | Default, 3 agents |
| 1 | 2 panes | Minimal, 2 agents |
| 6 | 3x2 grid | 6 agents in grid |
| 14 | 2 windows × 3 panes | 6 agents, semantic split |

```bash
# Start with specific layout
maw start --profile 6
```

---

## Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `AUTO_START_AGENTS` | Auto-launch AI on start | `1` |
| `DIRENV_LOG_FORMAT` | Silence direnv messages | `""` |
| `MAW_SESSION_PREFIX` | Tmux session name | `nat-agents` |

---

## Tmux Navigation (Within Session)

| Shortcut | Action |
|----------|--------|
| `Ctrl+b ←→↑↓` | Move between panes |
| `Ctrl+b n/p` | Next/previous window |
| `Ctrl+b z` | Toggle pane zoom |
| `Ctrl+b d` | Detach session |
| `Ctrl+b [` | Scroll mode |
| `q` | Exit scroll mode |

---

## Common Workflows

### Morning Startup

```bash
maw start              # Launch session
maw peek               # Check all agent status
maw warp 3             # Go to your agent
```

### End of Day

```bash
maw peek               # Verify all clean
rrr                    # Create retrospective
maw sync               # Sync all agents (if available)
```

### Delegation

```bash
# From main agent
maw hey 1 "search for auth patterns"
maw hey 2 "run security scan"
maw peek               # Check progress
```

### Quick Check

```bash
maw peek table         # Status at a glance
maw zoom 1             # Deep dive on agent 1
maw zoom 1             # Back to overview
```

---

## File Locations

| Path | Content |
|------|---------|
| `.agents/` | Toolkit scripts and configs |
| `.agents/scripts/` | Shell script implementations |
| `.agents/profiles/` | Layout configurations |
| `agents/N/` | Agent worktree directories |
| `agents/N/ψ/inbox/focus.md` | Agent's current task |

---

## Troubleshooting

### Session won't start
```bash
maw kill               # Clean up stuck sessions
maw start --force      # Force new session
```

### Agent pane not responding
```bash
maw zoom N             # Try zooming
Ctrl+c                 # Cancel stuck command
```

### Worktree issues
```bash
maw agents             # Check worktree status
git worktree list      # Raw git status
maw install            # Refresh setup
```

### direnv not loading
```bash
direnv allow           # Allow in current dir
# Or let maw start handle it automatically
```

---

## Related Docs

- `maw-start-guide.md` - Detailed start command
- `maw-hey-command.md` - Message delivery details
- `maw-kill-command.md` - Session cleanup
- `maw-sync-best-practices.md` - Multi-agent sync

---

*Last Updated: 2025-12-20*
