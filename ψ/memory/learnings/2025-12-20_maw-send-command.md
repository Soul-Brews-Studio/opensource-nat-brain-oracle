# MAW Send Command - Broadcasting to Multiple Panes

> Complete guide to `maw send` for bulk command distribution across tmux panes

## Overview

The `maw send` command broadcasts predefined commands to multiple tmux panes simultaneously. Unlike `maw hey` which sends messages interactively to specific agents, `maw send` executes template-based command arrays for batch operations.

**Script**: `.agents/scripts/send-commands.sh`

---

## Quick Start

```bash
# Basic usage
maw send

# With custom prefix
maw send --prefix dev

# With specific session
maw send --session ai-my-project
```

---

## How It Works

### 1. Session Discovery

The script first locates the target tmux session:

```bash
# Session naming convention
BASE_PREFIX=${SESSION_PREFIX:-ai}
DIR_NAME=$(basename "$REPO_ROOT")

# Resulting session name patterns:
#   ai-Nat-s-Agents           (default)
#   dev-ai-Nat-s-Agents       (with --prefix dev)
#   custom-session-name       (with --session)
```

### 2. Command Array

Commands are defined in a predefined array:

```bash
PANE_COMMANDS=(
    "pwd"    # Pane 1
    "pwd"    # Pane 2
    "pwd"    # Pane 3
    "pwd"    # Pane 4
    "pwd"    # Pane 5
    "pwd"    # Pane 6
)
```

### 3. Sequential Distribution

Commands are sent to panes in order:

```bash
PANE_INDEX=1
for cmd in "${PANE_COMMANDS[@]}"; do
    if [ -n "$cmd" ]; then
        tmux send-keys -t "$SESSION_NAME":${WINDOW_INDEX}.$PANE_INDEX "$cmd" C-m
        PANE_INDEX=$((PANE_INDEX + 1))
    fi
done
```

---

## Command Parameters

| Flag | Description | Example |
|------|-------------|---------|
| `--prefix` | Custom session prefix | `--prefix dev` |
| `--session` | Exact session name | `--session ai-my-project` |

---

## maw send vs maw hey

| Feature | `maw send` | `maw hey` |
|---------|-----------|-----------|
| **Purpose** | Bulk predefined commands | Interactive messaging |
| **Target** | All panes sequentially | Specific agent by name |
| **Input** | Hardcoded array | Dynamic CLI argument |
| **Multiline** | Not supported | Buffer-based paste |
| **Use Case** | Setup, reset, diagnostics | Task assignment |

### When to Use `maw send`

- Initial environment setup (pwd, direnv allow)
- Bulk status checks across all agents
- Reset operations (clear screens)
- Diagnostic commands (git status on all)

### When to Use `maw hey`

- Assigning tasks to specific agents
- Sending multi-line instructions
- Dynamic command distribution
- Broadcasting with `maw hey all`

---

## Customizing Commands

### Editing the Command Array

To send different commands, edit the `PANE_COMMANDS` array in `send-commands.sh`:

```bash
PANE_COMMANDS=(
    "git status"           # Agent 1: check status
    "git log -3 --oneline" # Agent 2: recent commits
    "ls -la"               # Agent 3: list files
    "pwd"                  # Agent 4: current dir
    ""                     # Agent 5: skip (empty)
    "date"                 # Agent 6: current time
)
```

### Dynamic Command Generation

For runtime customization, create a wrapper script:

```bash
#!/bin/bash
# custom-send.sh - Dynamic command distribution

REPO_ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
SESSION_NAME="ai-Nat-s-Agents"
COMMAND="$1"

WINDOW_INDEX=$(tmux list-windows -t "$SESSION_NAME" -F "#{window_index}" | head -1)
PANE_COUNT=$(tmux list-panes -t "$SESSION_NAME:$WINDOW_INDEX" | wc -l)

for ((i=1; i<=PANE_COUNT; i++)); do
    tmux send-keys -t "$SESSION_NAME:$WINDOW_INDEX.$i" "$COMMAND" C-m
done
```

Usage:
```bash
./custom-send.sh "git pull --rebase"
```

---

## Queue Management

### Sequential Execution Model

MAW's send command uses a simple sequential model without explicit queuing:

```
Pane 1 → Command 1 → [immediate]
Pane 2 → Command 2 → [immediate]
Pane 3 → Command 3 → [immediate]
...
```

Each command is sent immediately after the previous one without waiting for completion.

### Timing Considerations

```bash
# Commands sent instantly - no delay between panes
for cmd in "${PANE_COMMANDS[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
    # No sleep here - commands fire rapidly
done
```

### Adding Delays for Heavy Commands

For commands requiring processing time:

```bash
for cmd in "${PANE_COMMANDS[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
    sleep 0.5  # Wait 500ms between commands
done
```

---

## Command Batching Patterns

### Pattern 1: Uniform Command

Send the same command to all panes:

```bash
PANE_COMMANDS=(
    "git fetch origin"
    "git fetch origin"
    "git fetch origin"
    "git fetch origin"
    "git fetch origin"
)
```

Or use a loop:

```bash
COMMAND="git fetch origin"
for pane in $(tmux list-panes -t "$SESSION_NAME" -F "#{pane_index}"); do
    tmux send-keys -t "$SESSION_NAME:$WINDOW_INDEX.$pane" "$COMMAND" C-m
done
```

### Pattern 2: Role-Based Commands

Different commands per agent role:

```bash
PANE_COMMANDS=(
    "claude --dangerously-skip-permissions"  # Agent 1: Claude
    "codex --dangerously-bypass-approvals"   # Agent 2: Codex
    "codex --dangerously-bypass-approvals"   # Agent 3: Codex
    "maw status watch"                        # Agent 4: Monitor
    ""                                        # Agent 5: Skip
    ""                                        # Agent 6: Skip
)
```

### Pattern 3: Staged Execution

Commands that build on each other:

```bash
# Stage 1: Preparation
PANE_COMMANDS=("clear" "clear" "clear")
# Execute...

# Stage 2: Status check
PANE_COMMANDS=("git status" "git status" "git status")
# Execute...

# Stage 3: Pull updates
PANE_COMMANDS=("git pull" "git pull" "git pull")
# Execute...
```

### Pattern 4: Conditional Skipping

Skip panes by leaving commands empty:

```bash
PANE_COMMANDS=(
    "task 1"   # Execute
    ""         # Skip pane 2
    "task 3"   # Execute
    ""         # Skip pane 4
    "task 5"   # Execute
)
```

---

## Error Handling

### Session Not Found

```bash
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Error: Session '$SESSION_NAME' not found"
    echo "Run .agents/scripts/start-agents.sh first to create the session"
    exit 1
fi
```

**Resolution**:
```bash
# Start the session first
maw start

# Then send commands
maw send
```

### Pane Index Mismatch

If pane indices don't match expectations:

```bash
# Check actual pane indices
tmux list-panes -t "$SESSION_NAME" -F "#{pane_index}: #{pane_current_path}"

# Verify pane-base-index setting
tmux show-options -g pane-base-index
```

### Command Execution Failures

Commands are sent blindly - no return value checking:

```bash
# send-keys doesn't report command success/failure
tmux send-keys -t "$pane" "might-fail-command" C-m
# ↑ Always exits 0, even if command fails in pane
```

**Workaround**: Capture pane output after execution:

```bash
# Send command
tmux send-keys -t "$pane" "git status" C-m

# Wait for execution
sleep 1

# Check output
tmux capture-pane -t "$pane" -p -S -10 | grep -q "error" && echo "Command failed"
```

### Empty Command Array

Empty commands are silently skipped:

```bash
for cmd in "${PANE_COMMANDS[@]}"; do
    if [ -n "$cmd" ]; then  # ← Skip empty
        tmux send-keys -t "$pane" "$cmd" C-m
    fi
done
```

---

## Integration with Other MAW Commands

### Combined Workflow

```bash
# 1. Start session
maw start profile14

# 2. Wait for initialization
sleep 3

# 3. Send setup commands
maw send

# 4. Verify with peek
maw peek
```

### Scripting Example

```bash
#!/bin/bash
# full-reset.sh - Complete agent reset

# Kill existing session
maw kill

# Start fresh
maw start profile14

# Wait for panes to initialize
sleep 5

# Send initialization commands
maw send

# Verify all agents are ready
maw peek

echo "✅ All agents reset and ready"
```

---

## Advanced Usage

### Multi-Window Sending

For layouts with multiple windows:

```bash
# Window 0
tmux send-keys -t "$SESSION_NAME:0.1" "cmd" C-m
tmux send-keys -t "$SESSION_NAME:0.2" "cmd" C-m

# Window 1
tmux send-keys -t "$SESSION_NAME:1.1" "cmd" C-m
tmux send-keys -t "$SESSION_NAME:1.2" "cmd" C-m
```

### Parallel Execution with Background

For truly parallel execution:

```bash
for pane in $(tmux list-panes -t "$SESSION_NAME" -F "#{pane_index}"); do
    (tmux send-keys -t "$SESSION_NAME:$WINDOW_INDEX.$pane" "$COMMAND" C-m) &
done
wait  # Wait for all background jobs
```

### Combining with maw hey

```bash
# Bulk initialization with send
maw send

# Then targeted task assignment with hey
maw hey 1 "analyze this repository structure"
maw hey 2 "create a plan for refactoring"
maw hey 3 "write tests for the auth module"
```

---

## Quick Reference

### Common Commands

```bash
# Basic send
maw send

# With prefix
maw send --prefix dev

# With exact session
maw send --session my-ai-session
```

### Check Session Status

```bash
# Is session running?
tmux has-session -t ai-Nat-s-Agents && echo "Running" || echo "Not running"

# List all panes
tmux list-panes -t ai-Nat-s-Agents -F "#{pane_index}: #{pane_current_path}"
```

### Debug Output

```bash
# Run with verbose output
bash -x .agents/scripts/send-commands.sh 2>&1 | head -50
```

---

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Session not found" | Session not started | Run `maw start` first |
| Commands sent to wrong panes | pane-base-index mismatch | Check `tmux show-options -g pane-base-index` |
| Commands appear but don't execute | Missing `C-m` | Verify script has `C-m` suffix |
| Some panes skipped | Empty array entries | Check `PANE_COMMANDS` array |
| Garbled output | Special characters | Quote commands properly |

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-hey-command-guide.md` - Interactive messaging
- `ψ/memory/learnings/2025-12-20_maw-tmux-pane-management.md` - Pane addressing details
- `ψ/memory/learnings/2025-12-20_maw-start-guide.md` - Session creation
- `ψ/memory/learnings/2025-12-20_maw-profile-system.md` - Layout configurations

---

*Last updated: 2025-12-20*
*Source: .agents/scripts/send-commands.sh analysis*
