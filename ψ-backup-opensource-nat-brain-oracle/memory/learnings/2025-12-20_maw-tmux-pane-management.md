# MAW tmux Pane Management

> Complete guide to pane indexing, addressing, and communication in Multi-Agent Workflow

## Overview

MAW manages multiple AI agents across tmux panes. Understanding pane indexing is critical for:
- Sending commands to specific agents (`send-keys`)
- Capturing agent output (`capture-pane`)
- Monitoring agent status (`list-panes`)
- Debugging pane warp issues

---

## Pane Addressing Format

### Full Address Structure

```
SESSION:WINDOW.PANE
```

| Component | Example | Description |
|-----------|---------|-------------|
| SESSION | `ai-Nat-s-Agents` | Session name from `$SESSION_PREFIX-$DIR_NAME` |
| WINDOW | `0`, `1`, `2` | Window index (0-based by default) |
| PANE | `0`, `1`, `2`... | Pane index within window |

### Example Addresses

```bash
ai-Nat-s-Agents:0.0    # Window 0, Pane 0 (first pane)
ai-Nat-s-Agents:0.2    # Window 0, Pane 2 (third pane)
ai-Nat-s-Agents:1.1    # Window 1, Pane 1 (second pane)
```

### Using Pane IDs

Alternatively, use `#{pane_id}` (format: `%N`):

```bash
tmux list-panes -F "#{pane_id}: #{pane_current_path}"
# Output:
# %0: /Users/nat/Code/.../Nat-s-Agents
# %1: /Users/nat/Code/.../Nat-s-Agents/agents/1
# %2: /Users/nat/Code/.../Nat-s-Agents/agents/2

tmux send-keys -t %1 "echo hello" C-m
```

---

## Pane Base Index

### Detection Logic

MAW auto-detects `pane-base-index` to handle both 0-based and 1-based configurations:

```bash
# From start-agents.sh
PANE_BASE=$(tmux show-window-options -t "$SESSION_NAME":"$WINDOW_INDEX" -v pane-base-index 2>/dev/null)
if [ -z "$PANE_BASE" ]; then
    PANE_BASE=$(tmux show-window-options -gv pane-base-index 2>/dev/null)
fi
if [ -z "$PANE_BASE" ]; then
    PANE_BASE=0  # Default fallback
fi
```

### The pane_ref() Helper

MAW uses a helper function for consistent pane addressing:

```bash
pane_ref() {
    local offset=$1
    local pane_index=$((PANE_BASE + offset))
    printf '%s:%s.%s' "$SESSION_NAME" "$WINDOW_INDEX" "$pane_index"
}

# Usage:
tmux send-keys -t "$(pane_ref 0)" "pwd" C-m    # First pane
tmux send-keys -t "$(pane_ref 2)" "git status" C-m  # Third pane
```

### Checking Your Configuration

```bash
# Global setting
tmux show-options -g pane-base-index

# Window-specific
tmux show-window-options -v pane-base-index

# Common configurations:
# pane-base-index 0  ← Panes: 0, 1, 2, 3... (default)
# pane-base-index 1  ← Panes: 1, 2, 3, 4... (vim-friendly)
```

---

## send-keys: Sending Commands to Panes

### Basic Syntax

```bash
tmux send-keys -t TARGET "COMMAND" C-m
```

| Flag | Description |
|------|-------------|
| `-t TARGET` | Pane address (session:window.pane or %id) |
| `C-m` | Send Enter key (Ctrl+M = newline) |
| `-l` | Send literally (disable key lookup) |

### Simple Commands

```bash
# Send command to agent 1
tmux send-keys -t ai-Nat-s-Agents:0.1 "git status" C-m

# Clear screen first
tmux send-keys -t ai-Nat-s-Agents:0.1 "clear" C-m
```

### Long/Multiline Content (Buffer Method)

For content with newlines or special characters, use tmux buffers:

```bash
# Load content into buffer
echo "This is a
multiline
message" | tmux load-buffer -

# Paste to target pane
tmux paste-buffer -t ai-Nat-s-Agents:0.1

# Send Enter to execute
sleep 0.3  # Allow paste to complete
tmux send-keys -t ai-Nat-s-Agents:0.1 Enter
```

### MAW's send_message() Implementation

From `hey.sh`:

```bash
send_message() {
    local pane=$1
    local text=$2

    # For multiline content, use buffer method
    if [[ "$text" == *$'\n'* ]] || [[ ${#text} -gt 500 ]]; then
        echo "$text" | tmux load-buffer -
        tmux paste-buffer -t "$pane"
        sleep 0.3  # Claude needs time to process
        tmux send-keys -t "$pane" Enter
    else
        # Simple send for short single-line
        tmux send-keys -t "$pane" "$text"
        sleep 0.05
        tmux send-keys -t "$pane" Enter
    fi
}
```

### Broadcasting to All Panes

```bash
# Using hey.sh
maw hey all "git pull"

# Manual implementation:
for pane_id in $(tmux list-panes -s -t "$SESSION_NAME" -F "#{pane_id}"); do
    tmux send-keys -t "$pane_id" "direnv allow" C-m
done
```

---

## capture-pane: Reading Pane Content

### Basic Syntax

```bash
tmux capture-pane -t TARGET -p [-S START] [-E END]
```

| Flag | Description |
|------|-------------|
| `-t TARGET` | Pane address |
| `-p` | Print to stdout (instead of buffer) |
| `-S START` | Start line (negative = from bottom) |
| `-E END` | End line |
| `-J` | Join wrapped lines |

### Capture Recent Output

```bash
# Last 50 lines
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -50

# Last 20 lines, trimmed
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -20 | tail -15

# Entire scrollback
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -
```

### Pattern: Send Command and Capture

```bash
# Send command
maw hey 1 "git log -3 --oneline"

# Wait for execution
sleep 1

# Capture result
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -10 | tail -5
```

### Capture for Monitoring (maw peek pattern)

While `maw peek` uses git commands, capture-pane is useful for:

```bash
# Check if agent is idle (empty prompt)
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -5 | grep -q '^>'

# Look for error messages
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -20 | grep -i error

# Check Claude completion signals
tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -10 | grep -q 'User:'
```

---

## list-panes: Discovering Pane Information

### Basic Listing

```bash
# All panes in session
tmux list-panes -t ai-Nat-s-Agents

# All panes across all windows (-s = session)
tmux list-panes -s -t ai-Nat-s-Agents
```

### Custom Format Output

```bash
# Pane index and path
tmux list-panes -t ai-Nat-s-Agents -F "#{pane_index}: #{pane_current_path}"

# Window and pane with PID
tmux list-panes -s -t ai-Nat-s-Agents -F "#{window_index}:#{pane_index} pid=#{pane_pid}"

# Full detail for debugging
tmux list-panes -s -F "#{pane_id} #{window_index}:#{pane_index} #{pane_current_path} #{pane_pid}"
```

### Format Variables

| Variable | Description |
|----------|-------------|
| `#{pane_id}` | Unique pane ID (%0, %1...) |
| `#{pane_index}` | Index within window |
| `#{window_index}` | Parent window index |
| `#{pane_current_path}` | Current working directory |
| `#{pane_pid}` | Process ID in pane |
| `#{pane_width}` | Width in columns |
| `#{pane_height}` | Height in rows |

### Finding Root Pane by Path

```bash
ROOT_PANE=$(tmux list-panes -t "$SESSION_NAME:$WINDOW_INDEX" \
    -F "#{pane_index} #{pane_current_path}" | \
    grep "$REPO_ROOT\$" | cut -d' ' -f1)
```

---

## Auto-Warp: Mapping Panes to Agents

### The auto_warp_panes() Function

MAW automatically navigates each pane to its corresponding agent directory:

```bash
auto_warp_panes() {
    local panes
    panes=$(tmux list-panes -s -t "$SESSION_NAME" -F "#{window_index}:#{pane_index}")

    while IFS=: read -r win_idx pane_idx; do
        # Calculate agent index based on layout type
        if [ "$LAYOUT_TYPE" = "six-pane" ]; then
            # Skip root panes (0 and 5)
            if [ "$pane_idx" -eq 0 ] || [ "$pane_idx" -eq 5 ]; then
                continue
            fi
            agent_index=$((pane_idx - 1))
        elif [ "$LAYOUT_TYPE" = "grid-3x2" ]; then
            agent_index=$((pane_idx - PANE_BASE))
        else
            agent_index=$((pane_idx - PANE_BASE))
        fi

        # Warp pane to agent directory
        local agent_name="${AGENTS_ARRAY[$agent_index]}"
        local agent_dir="$AGENTS_DIR/$agent_name"
        tmux send-keys -t "$target_pane" "cd '$agent_dir'" C-m
    done <<< "$panes"
}
```

### Layout-Specific Mapping

| Layout | Pane 0 | Pane 1 | Pane 2 | Pane 3 | Pane 4 | Pane 5 |
|--------|--------|--------|--------|--------|--------|--------|
| `three-horizontal` | Agent 1 | Agent 2 | Agent 3 | - | - | - |
| `six-pane` | Root | Agent 1 | Agent 2 | Agent 3 | Agent 4 | Root |
| `grid-3x2` | Agent 1 | Agent 2 | Agent 3 | Agent 4 | Agent 5 | Agent 6 |
| `grid-3x2-full` | Agent 1 | Agent 2 | Agent 3 | Agent 4 | Agent 5 | Monitor |

---

## Multi-Window Layouts

### Window Indexing

Multi-window layouts use separate window indices:

```bash
WINDOW_0=$WINDOW_INDEX       # First window (usually 0 or 1)
WINDOW_1=$((WINDOW_INDEX + 1))  # Second window
```

### Addressing Cross-Window Panes

```bash
# Window 0, pane 1
tmux send-keys -t "$SESSION_NAME:$WINDOW_0.$((PANE_BASE + 1))" "cmd" C-m

# Window 1, pane 2
tmux send-keys -t "$SESSION_NAME:$WINDOW_1.$((PANE_BASE + 2))" "cmd" C-m
```

### Window-Specific Listing

```bash
# List panes in window 0
tmux list-panes -t ai-Nat-s-Agents:0

# List panes in window 1
tmux list-panes -t ai-Nat-s-Agents:1
```

---

## Troubleshooting

### Pane Not Found

```bash
# Check if session exists
tmux has-session -t ai-Nat-s-Agents

# List all panes with full info
tmux list-panes -s -t ai-Nat-s-Agents -F "#{window_index}:#{pane_index} #{pane_current_path}"
```

### Wrong Pane Base Index

```bash
# Symptom: Pane numbers don't match expected
# Check actual pane indices:
tmux list-panes -t ai-Nat-s-Agents:0 -F "#{pane_index}"

# Verify base index:
tmux show-options -g pane-base-index
```

### send-keys Not Executing

```bash
# Common issues:
# 1. Missing C-m (Enter key)
tmux send-keys -t pane "cmd" C-m  # ← Need C-m

# 2. Pane in copy mode
tmux send-keys -t pane q  # Exit copy mode first

# 3. Special characters need escaping
tmux send-keys -t pane "echo 'hello'" C-m  # Quote properly
```

### capture-pane Empty

```bash
# Check scrollback exists
tmux capture-pane -t pane -p -S - | wc -l

# Pane might be too new - wait for output
sleep 1
tmux capture-pane -t pane -p -S -20
```

---

## Quick Reference

### Essential Commands

```bash
# Send command to pane
tmux send-keys -t SESSION:WIN.PANE "command" C-m

# Capture pane output
tmux capture-pane -t SESSION:WIN.PANE -p -S -50

# List panes with paths
tmux list-panes -s -t SESSION -F "#{window_index}:#{pane_index} #{pane_current_path}"

# Check pane-base-index
tmux show-options -g pane-base-index

# Select pane
tmux select-pane -t SESSION:WIN.PANE
```

### MAW Shortcuts

```bash
maw hey 1 "task"      # send-keys wrapper
maw hey all "cmd"     # broadcast to all
maw peek              # status via git -C
maw zoom 1            # toggle pane zoom
maw warp 2            # cd to agent dir
```

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-hey-instruction.md` - Hey command details
- `ψ/memory/learnings/2025-12-20_maw-peek-guide.md` - Peek monitoring
- `ψ/memory/learnings/2025-12-20_maw-profile-system.md` - Layout configurations
- `ψ/memory/learnings/2025-12-20_maw-tmux-config.md` - tmux configuration

---

*Last updated: 2025-12-20*
*Source: start-agents.sh, hey.sh implementation analysis*
