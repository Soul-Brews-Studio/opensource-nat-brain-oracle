# MAW Zoom: Pane Maximize/Restore Guide

> Complete guide to pane zooming, focus management, and layout recovery in Multi-Agent Workflow

## Overview

`maw zoom` toggles tmux zoom state for a specific pane, allowing you to maximize a single agent's view to full screen or restore it to the normal multi-pane layout. This is essential for:

- **Focus work**: Dedicate full screen to one agent's task
- **Code review**: Maximize output for detailed inspection
- **Debugging**: Expand error messages and stack traces
- **Context switching**: Quickly shift attention between agents

---

## Command Syntax

```bash
maw zoom <agent>          # Toggle zoom for agent pane
maw zoom root             # Toggle zoom for main worktree pane
maw zoom --list           # List available agents
maw zoom --help           # Show usage help
```

### Arguments

| Argument | Description | Examples |
|----------|-------------|----------|
| `<agent>` | Agent name or number | `1`, `2`, `backend-api` |
| `root` | Main worktree pane | (special target) |
| `main` | Alias for root | (alternative) |
| `--list`, `-l` | Show available agents | |
| `--help`, `-h` | Show usage information | |

---

## How It Works

### The tmux Command

`maw zoom` wraps `tmux resize-pane -Z`:

```bash
tmux resize-pane -Z -t SESSION:WINDOW.PANE
```

| Flag | Purpose |
|------|---------|
| `-Z` | Toggle zoom state |
| `-t TARGET` | Specify pane address |

### Toggle Behavior

Zoom is a **toggle operation**:

```
Normal Layout  →  maw zoom 1  →  Agent 1 Fullscreen
Agent 1 Fullscreen  →  maw zoom 1  →  Normal Layout
```

The **same command** zooms and unzooms. There's no separate "unzoom" command.

### Visual State Indicators

When a pane is zoomed, tmux indicates this in the status bar:

```
[ai-Nat-s-Agents:0 (zoomed)]
```

---

## Pane Addressing

### Session Discovery

The script automatically finds your MAW session:

```bash
# Pattern: $SESSION_PREFIX-$DIR_NAME
# Example: ai-Nat-s-Agents

# The script checks:
# 1. Exact match: ai-Nat-s-Agents
# 2. With suffix: ai-Nat-s-Agents-*
```

### Agent to Pane Mapping

Agents are mapped to pane indices based on their directory order:

```bash
# agents/ directory listing → pane index
agents/1/  → PANE_BASE + 0
agents/2/  → PANE_BASE + 1
agents/3/  → PANE_BASE + 2
# ...etc
```

### Pane Base Index

MAW respects your tmux `pane-base-index` configuration:

```bash
# Check your setting
tmux show-options -g pane-base-index

# If pane-base-index = 0: Panes are 0, 1, 2...
# If pane-base-index = 1: Panes are 1, 2, 3...
```

---

## Keyboard Shortcuts

### Native tmux Zoom

You can also zoom using the tmux keyboard shortcut:

```
Ctrl+b z     # Toggle zoom on currently focused pane
```

This is the **same** operation as `maw zoom`, but:
- Works on the **currently selected** pane
- Requires focus to be on the pane you want to zoom

### Navigation While Zoomed

While zoomed, you can still navigate:

| Keys | Action |
|------|--------|
| `Ctrl+b n` | Next window |
| `Ctrl+b p` | Previous window |
| `Ctrl+b :` | Command mode |
| `Ctrl+b z` | Unzoom (return to layout) |

**Note**: Arrow key navigation (`Ctrl+b →`) will **not work** while zoomed because there are no visible sibling panes.

---

## Focus Management

### Focus vs Zoom

| Command | Effect | Use Case |
|---------|--------|----------|
| `maw zoom 1` | Maximize pane to fullscreen | Deep focus on one agent |
| `Ctrl+b →` | Move focus to adjacent pane | Quick status check |
| `tmux select-pane -t X` | Focus specific pane | Programmatic focus |

### Selecting Before Zooming

To zoom a non-focused pane:

```bash
# Option 1: Use maw zoom with agent name
maw zoom 2  # Zooms agent 2 regardless of current focus

# Option 2: Select then keyboard zoom
Ctrl+b → → (navigate to pane)
Ctrl+b z   (zoom it)
```

### Zoom and Focus Interaction

When you zoom a pane, it becomes the focused pane. When you unzoom:
- Focus remains on the previously zoomed pane
- Layout returns to normal
- All panes become visible again

---

## Layout Recovery

### Normal Unzoom

```bash
# Simply toggle again
maw zoom 1   # If zoomed, this restores layout
```

### Emergency Layout Reset

If zoom state gets confused:

```bash
# Method 1: Force unzoom with keyboard
Ctrl+b z    # Toggle zoom state

# Method 2: Reset window layout
Ctrl+b :
> select-layout even-horizontal

# Method 3: Restart session (last resort)
maw kill && maw start
```

### Layout Preservation

Zoom **does not** affect the underlying layout. The original pane sizes and positions are preserved and restored when you unzoom.

```
Before zoom:    [30%][40%][30%]
While zoomed:   [100%]
After unzoom:   [30%][40%][30%]  ← Same as before
```

---

## Multi-Window Considerations

### Window-Specific Zoom

Zoom only affects the current window. You can have:
- Window 1: Normal layout
- Window 2: Zoomed pane

Switching windows preserves each window's zoom state.

### Cross-Window Zoom

```bash
# Zoom pane in window 1
tmux resize-pane -Z -t ai-Nat-s-Agents:1.2

# Zoom pane in window 2
tmux resize-pane -Z -t ai-Nat-s-Agents:2.1
```

### Profile-Specific Behavior

| Profile | Windows | Zoom Behavior |
|---------|---------|---------------|
| profile0-5 | 1 | Single window zoom |
| profile8, profile14 | 2 | Per-window zoom states |

---

## Integration with Other Commands

### maw peek + maw zoom

```bash
# Check status of all agents
maw peek

# Zoom in on interesting agent
maw zoom 3

# Work with zoomed agent
# ...

# Unzoom and check all again
maw zoom 3
maw peek
```

### maw hey + maw zoom

```bash
# Send task to agent
maw hey 2 "analyze this file"

# Zoom to watch progress
maw zoom 2

# Unzoom when done
maw zoom 2
```

### maw warp + maw zoom

`maw warp` changes YOUR terminal directory.
`maw zoom` changes the TMUX pane view.

These are independent operations:
- `maw warp 2` = your shell goes to agents/2
- `maw zoom 2` = agent 2's pane fills the screen

---

## Troubleshooting

### "No tmux session found"

```bash
# Check if session exists
tmux list-sessions

# Start session if needed
maw start
```

### "Agent not found"

```bash
# List available agents
maw zoom --list

# Check agents directory
ls agents/
```

### Zoom Not Toggling

```bash
# Check pane state
tmux list-panes -t ai-Nat-s-Agents:0 \
  -F "#{pane_index}: zoomed=#{window_zoomed_flag}"

# Force toggle via keyboard
Ctrl+b z
```

### Wrong Pane Zoomed

This can happen if pane indexing doesn't match expectations:

```bash
# Debug: Check pane-to-path mapping
tmux list-panes -t ai-Nat-s-Agents:0 \
  -F "#{pane_index}: #{pane_current_path}"

# Verify pane-base-index
tmux show-options -g pane-base-index
```

---

## Best Practices

### When to Zoom

| Scenario | Recommendation |
|----------|----------------|
| Reading long output | ✅ Zoom for readability |
| Monitoring all agents | ❌ Keep unzoomed for overview |
| Debugging one agent | ✅ Zoom for focus |
| Quick status checks | ❌ Use `maw peek` instead |
| Sending commands | ❌ Can use `maw hey` unzoomed |
| Code review | ✅ Zoom for line-by-line inspection |

### Zoom Workflow Pattern

```
1. maw peek           # Overview of all agents
2. Identify agent of interest
3. maw zoom N         # Focus on that agent
4. Do deep work
5. maw zoom N         # Restore overview
6. Repeat as needed
```

### Avoid These Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Zooming then forgetting | Lose visibility into other agents | Use `maw peek` periodically |
| Manual pane resize | Breaks layout consistency | Use zoom toggle instead |
| Multiple simultaneous zooms | Confusion about state | Unzoom before switching focus |

---

## Quick Reference

```bash
# Basic zoom operations
maw zoom 1           # Zoom agent 1
maw zoom root        # Zoom main pane
maw zoom 1           # Unzoom (toggle)

# List agents
maw zoom --list

# Keyboard alternatives
Ctrl+b z             # Toggle current pane zoom

# Check zoom state
tmux list-panes -F "zoomed: #{window_zoomed_flag}"

# Emergency reset
Ctrl+b : select-layout even-horizontal
```

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-tmux-pane-management.md` - Pane addressing details
- `ψ/memory/learnings/2025-12-20_maw-cheatsheet.md` - All MAW commands
- `ψ/memory/learnings/2025-12-20_maw-profile-creation.md` - Layout configurations
- `ψ/memory/learnings/2025-12-13_maw-comprehensive-guide.md` - Full MAW guide

---

*Last updated: 2025-12-20*
*Source: .agents/scripts/zoom.sh, .codex/prompts/maw.zoom.md*
