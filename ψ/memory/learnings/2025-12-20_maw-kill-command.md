# MAW Kill Command: Terminating Tmux Sessions Safely

**Date**: 2025-12-20
**Category**: MAW Infrastructure
**Script**: `.agents/scripts/kill-all.sh`

---

## Overview

`maw kill` terminates tmux sessions created by MAW. It uses pattern matching to find sessions and requires explicit confirmation before killing — a critical safety feature that prevents accidental termination of unrelated sessions.

```bash
maw kill                    # Kill default session
maw kill --prefix work      # Kill prefixed session
```

---

## Key Features

| Feature | Description |
|---------|-------------|
| **Pattern Matching** | Finds sessions by naming convention |
| **Confirmation Required** | Shows sessions before killing (y/N) |
| **Prefix Support** | Target specific instances |
| **Safe Defaults** | Never kills unmatched sessions |

---

## How It Works

### 1. Session Pattern Construction

The script builds a pattern from environment and flags:

```bash
BASE_PREFIX=${SESSION_PREFIX_OVERRIDE:-${SESSION_PREFIX:-ai}}
DIR_NAME=$(basename "$REPO_ROOT")

if [ -n "$CUSTOM_PREFIX" ]; then
    SESSION_PATTERN="${CUSTOM_PREFIX}-${BASE_PREFIX}-${DIR_NAME}"
else
    SESSION_PATTERN="${BASE_PREFIX}-${DIR_NAME}"
fi
```

**Pattern Examples:**

| Flags | SESSION_PREFIX | Pattern |
|-------|---------------|---------|
| (none) | (default) | `ai-Nat-s-Agents` |
| `--prefix work` | (default) | `work-ai-Nat-s-Agents` |
| (none) | `dev` | `dev-Nat-s-Agents` |
| `--session-prefix custom` | - | `custom-Nat-s-Agents` |

### 2. Session Discovery

Sessions are found via tmux list-sessions with grep filtering:

```bash
SESSIONS=$(tmux list-sessions -F "#{session_name}" 2>/dev/null \
  | grep "^${SESSION_PATTERN}" || true)
```

**Key behaviors:**
- Uses `#{session_name}` format for clean output
- `grep "^${PATTERN}"` ensures prefix matching (not substring)
- `|| true` prevents script exit on no matches
- `2>/dev/null` suppresses "no server" errors

### 3. User Confirmation

Before any kill action, the script displays and confirms:

```bash
echo "🔍 Found sessions:"
echo "$SESSIONS"
echo ""
read -p "❓ Kill all these sessions? (y/N): " -n 1 -r
```

**Sample interaction:**
```
🔍 Found sessions:
ai-Nat-s-Agents
ai-Nat-s-Agents-backup

❓ Kill all these sessions? (y/N): y
🗑️  Killing session: ai-Nat-s-Agents
🗑️  Killing session: ai-Nat-s-Agents-backup
✅ All sessions killed
```

### 4. Kill Execution

Only on explicit "y" confirmation:

```bash
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$SESSIONS" | while read -r session; do
        [ -z "$session" ] && continue
        echo "🗑️  Killing session: $session"
        tmux kill-session -t "$session"
    done
    echo "✅ All sessions killed"
else
    echo "❌ Cancelled"
fi
```

---

## Command Options

### `--prefix <prefix>`

Target sessions with a specific custom prefix.

```bash
# Start two instances
maw start                    # → ai-Nat-s-Agents
maw start --prefix work      # → work-ai-Nat-s-Agents

# Kill only the work instance
maw kill --prefix work       # Kills: work-ai-Nat-s-Agents
                             # Leaves: ai-Nat-s-Agents
```

### `--session-prefix <base>`

Override the base prefix (normally from `$SESSION_PREFIX` env).

```bash
# If sessions were created with SESSION_PREFIX=dev
SESSION_PREFIX=dev maw start  # → dev-Nat-s-Agents

# Kill them by overriding the base
maw kill --session-prefix dev
```

---

## Safety Design

### Why Confirmation Required?

Pattern matching could inadvertently match multiple sessions:

```bash
# Pattern: ai-Nat-s-Agents
# Could match:
#   ai-Nat-s-Agents
#   ai-Nat-s-Agents-test
#   ai-Nat-s-Agents-2
```

The confirmation step lets users verify exactly which sessions will be killed.

### What Happens If No Sessions Found?

```bash
$ maw kill --prefix nonexistent
ℹ️  No sessions found matching: nonexistent-ai-Nat-s-Agents*
```

The script exits cleanly with code 0 — no error, just informational message.

### Protection Against Unrelated Sessions

The `grep "^${PATTERN}"` ensures only sessions starting with the exact pattern match:

| Session Name | Pattern `ai-Nat` | Matches? |
|--------------|------------------|----------|
| `ai-Nat-s-Agents` | Yes | ✓ |
| `other-ai-Nat-s-Agents` | No | ✗ |
| `ai-Nats-Project` | Yes | ✓ (careful!) |

---

## Common Usage Patterns

### Clean Shutdown

```bash
# End of work session
maw peek           # Verify all agents clean
maw sync           # Ensure everything synced
git push origin main
maw kill           # Terminate session
```

### Multiple Instance Management

```bash
# Running multiple contexts
tmux list-sessions
# work-ai-Nat-s-Agents
# personal-ai-Nat-s-Agents
# ai-Nat-s-Agents

# Kill specific context
maw kill --prefix work

# Kill default (no prefix)
maw kill
```

### Force Kill (Emergency)

If the script hangs or confirmation doesn't work:

```bash
# Bypass maw, use tmux directly
tmux kill-session -t "ai-Nat-s-Agents"

# Or kill all MAW-like sessions
tmux list-sessions -F "#{session_name}" | grep "ai-" | \
  xargs -I{} tmux kill-session -t {}
```

---

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success (sessions killed or none found) |
| `1` | Invalid arguments |

Note: Cancelling (pressing N) also exits with 0 — it's a user choice, not an error.

---

## Interaction with Other Commands

| Before Kill | Purpose |
|-------------|---------|
| `maw peek` | Verify no uncommitted work |
| `maw sync` | Ensure all agents synced |
| `git push` | Push changes to origin |

| After Kill | Purpose |
|------------|---------|
| `maw start` | Create fresh session |
| `tmux list-sessions` | Verify termination |

---

## Troubleshooting

### "No sessions found" but session exists

Check the pattern matching:

```bash
# List all sessions
tmux list-sessions -F "#{session_name}"

# Check expected pattern
echo "${SESSION_PREFIX:-ai}-$(basename $(pwd))"

# Compare — case sensitive!
```

### Session won't die

Some processes may keep panes alive:

```bash
# Force kill with tmux
tmux kill-session -t "session-name"

# If still stuck, kill the tmux server (nuclear option)
tmux kill-server  # ⚠️ Kills ALL tmux sessions!
```

### Confirmation prompt not responding

Check terminal settings:

```bash
# The script uses read -n 1
# Ensure stdin is connected
maw kill < /dev/tty
```

---

## Implementation Details

### Script Location

```
.agents/scripts/kill-all.sh
```

### CLI Binding

From `.agents/maw.env.sh`:

```bash
kill)
  __maw_exec kill-all.sh "$@"
  ;;
```

### Shell Alias

```bash
alias maw-kill='maw kill'
```

---

## Quick Reference

| Action | Command |
|--------|---------|
| Kill default session | `maw kill` |
| Kill prefixed session | `maw kill --prefix work` |
| List sessions first | `tmux list-sessions` |
| Direct tmux kill | `tmux kill-session -t name` |

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `maw start` | Create new session |
| `maw attach` | Connect to existing session |
| `maw peek` | Check agent status before kill |

---

## Tags

`maw` `kill` `tmux` `session` `cleanup` `safety`
