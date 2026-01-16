# MAW tmux Configuration Guide

> Complete reference for the Multi-Agent Workflow tmux configuration

## Configuration File Location

MAW uses a dedicated tmux configuration at `.agents/config/tmux.conf`. The loading priority:

```
1. $TMUX_CONF environment variable (if set)
2. .agents/config/tmux.conf (default)
3. $REPO_ROOT/.tmux.conf (fallback)
```

---

## Core Settings

### Mouse Support (Full)

```bash
set -g mouse on                          # Enable mouse globally
bind -n MouseDown1Pane select-pane -t=   # Click pane to select
bind -n MouseDrag1Border resize-pane -M  # Drag border to resize
bind -n MouseDown1Status select-window -t=  # Click status bar window
bind -n MouseDown3Pane paste-buffer      # Right-click to paste
```

### Scroll Behavior

```bash
# Smart wheel scrolling - handles scroll in copy mode AND regular mode
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" \
    "send-keys -M" \
    "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M
```

### Terminal & Color

```bash
set -g default-terminal "screen-256color"   # 256 color support
set -ga terminal-overrides ",*256col*:Tc"   # True color override
```

---

## Pane Navigation

### Keyboard Shortcuts (tmux default prefix: Ctrl+b)

| Key | Action |
|-----|--------|
| `Ctrl+b ←` | Move to pane on left |
| `Ctrl+b →` | Move to pane on right |
| `Ctrl+b ↑` | Move to pane above |
| `Ctrl+b ↓` | Move to pane below |
| `Ctrl+b o` | Cycle through panes |
| `Ctrl+b q` | Show pane numbers (press number to jump) |
| `Ctrl+b z` | Toggle zoom (fullscreen current pane) |

### Mouse Navigation

| Action | Result |
|--------|--------|
| Click on pane | Select that pane |
| Drag border | Resize panes |
| Click window name | Switch window |
| Right-click | Paste buffer |
| Scroll wheel | Scroll history (enters copy mode) |

### MAW Commands for Navigation

```bash
maw warp 2        # Warp terminal to agent 2's worktree
mw 3              # Shorthand: warp to agent 3
maw zoom 1        # Toggle zoom on agent 1's pane
maw hey 2 "msg"   # Send message to agent 2's pane
```

---

## Vi-Mode Copy

```bash
setw -g mode-keys vi   # Use vi keys in copy mode
```

### Copy Mode Bindings

| Key | Action |
|-----|--------|
| `v` | Begin selection (visual mode) |
| `y` | Copy selection and exit |
| `Mouse drag` | Select text + auto-copy |
| `Ctrl+b [` | Enter copy mode |
| `q` | Exit copy mode |

### Copy-Paste Workflow

```bash
# Enter copy mode
Ctrl+b [

# Navigate with vi keys (h,j,k,l)
# Start selection with 'v'
# Yank with 'y'

# Paste with right-click OR:
Ctrl+b ]
```

---

## Status Bar

### Style Configuration

```bash
# Overall status bar
set -g status-style 'bg=colour234 fg=colour39'

# Left side: session name
set -g status-left '#[fg=colour16,bg=colour39,bold] #S #[fg=colour39,bg=colour234]'

# Right side: date + time
set -g status-right '#[fg=colour226,bg=colour234]#[fg=colour16,bg=colour226,bold] %d/%m #[fg=colour39]#[fg=colour16,bg=colour39,bold] %H:%M:%S '

# Window status
setw -g window-status-style 'fg=colour246 bg=colour234'
setw -g window-status-current-style 'fg=colour16 bg=colour39 bold'
setw -g window-status-format ' #I:#W#F '
setw -g window-status-current-format ' #I:#W#F '
```

### Pane Border Colors

```bash
set -g pane-active-border-style 'fg=colour39,bg=default'  # Active: cyan
set -g pane-border-style 'fg=colour244,bg=default'        # Inactive: gray
```

---

## Performance Settings

```bash
set -g history-limit 10000    # Scrollback buffer lines
set -sg escape-time 0         # No delay for escape key
set -g base-index 1           # Windows start at 1 (not 0)
setw -g pane-base-index 1     # Panes start at 1 (not 0)
```

---

## Plugins (TPM)

### Plugin Manager Setup

```bash
# Set plugin path
set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"

# Plugins
set -g @plugin 'tmux-plugins/tpm'           # Plugin manager
set -g @plugin 'tmux-plugins/tmux-sensible' # Sensible defaults
set -g @plugin 'wfxr/tmux-power'            # Status bar theme

# Theme configuration
set -g @tmux_power_theme 'gold'
set -g @tmux_power_show_upload_speed true
set -g @tmux_power_show_download_speed true

# Initialize TPM (must be at end)
run '~/.tmux/plugins/tpm/tpm'
```

### Installing Plugins

```bash
# From command line
~/.tmux/plugins/tpm/bin/install_plugins

# From within tmux
Ctrl+b I   # (capital I)
```

---

## Configuration Reload

### Reload Binding

```bash
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
```

### Usage

```bash
Ctrl+b r   # Reload config and show message
```

### MAW Auto-Reload

The start script broadcasts config reload to all panes:

```bash
# From start-agents.sh
tmux send-keys -t "$pane_id" "tmux source-file $conf_path" C-m
```

---

## Session & Pane Reference

### How MAW References Panes

```bash
# Session naming
SESSION_NAME="maw-${REPO_NAME}"  # e.g., maw-Nat-s-Agents

# Pane reference format
${SESSION_NAME}:${WINDOW_INDEX}.${PANE_INDEX}

# Example: Agent 2 in window 1
maw-Nat-s-Agents:1.2
```

### Listing Sessions and Panes

```bash
# List sessions
tmux list-sessions

# List panes in current session
tmux list-panes

# List panes with paths
tmux list-panes -F "#{pane_index} #{pane_current_path}"
```

---

## Common Tasks

### Resize Panes

| Method | How |
|--------|-----|
| Mouse | Drag pane border |
| Keys | `Ctrl+b :resize-pane -D 5` (down 5 lines) |
| Keys | `Ctrl+b :resize-pane -R 10` (right 10 cols) |

### Split Panes

```bash
Ctrl+b %   # Split vertically (left/right)
Ctrl+b "   # Split horizontally (top/bottom)
```

### Kill Panes/Windows

```bash
Ctrl+b x   # Kill current pane (with confirm)
Ctrl+b &   # Kill current window (with confirm)
```

---

## Troubleshooting

### Config Not Loading

```bash
# Check if config exists
ls -la .agents/config/tmux.conf

# Manually source
tmux source-file .agents/config/tmux.conf

# Verify settings
tmux show-options -g
```

### Pane Base Index Issues

```bash
# Check current setting
tmux show-window-options -gv pane-base-index

# Should be 1 for MAW (not 0)
```

### Mouse Not Working

```bash
# Verify mouse setting
tmux show-options -g mouse
# Should show: mouse on

# Re-enable if needed
tmux set -g mouse on
```

---

## Related Guides

| Guide | Content |
|-------|---------|
| `maw-cheatsheet.md` | Quick command reference |
| `maw-troubleshooting.md` | Problem solving |
| `maw-start-guide.md` | Session startup |

---

*Last Updated: 2025-12-20*
