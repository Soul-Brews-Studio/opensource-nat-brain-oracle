# MAW Attach Command Guide

> Reconnect to running multi-agent tmux sessions

## Overview

The `maw attach` command connects your terminal to an existing MAW tmux session. This is essential for:
- Resuming work after closing a terminal
- Accessing agents from a different terminal window
- Reconnecting after SSH disconnections
- Monitoring agents while working elsewhere

## Basic Usage

```bash
# Attach to default session for current repo
maw attach

# Attach using alias
maw-attach
```

## Command Options

| Option | Description | Example |
|--------|-------------|---------|
| `--prefix <name>` | Attach to prefixed session | `maw attach --prefix work` |
| `--session <name>` | Attach to exact session name | `maw attach --session my-session` |
| `-h, --help` | Show usage information | `maw attach --help` |

## Session Naming Convention

MAW uses a predictable naming pattern for sessions:

```
<prefix>-ai-<repo-name>
```

| Component | Default | Description |
|-----------|---------|-------------|
| prefix | (none) | Optional custom prefix from `--prefix` |
| ai | Fixed | Standard identifier |
| repo-name | From directory | Name of repository directory |

### Examples

| Repo Directory | Prefix | Session Name |
|----------------|--------|--------------|
| Nat-s-Agents | (none) | ai-Nat-s-Agents |
| Nat-s-Agents | work | work-ai-Nat-s-Agents |
| my-project | dev | dev-ai-my-project |

## Session Discovery

When the target session isn't found, `maw attach` shows available sessions:

```
$ maw attach
❌ tmux session not found: ai-Nat-s-Agents
Available sessions:
  work-ai-Nat-s-Agents
  ai-other-project
```

This helps you find the correct session name if you used a custom prefix.

## Workflow Examples

### Standard Reconnection

```bash
# Terminal 1: Start agents
maw start --profile default

# Terminal 2 (later): Reconnect to same session
maw attach
```

### Multiple Projects

When working on multiple MAW-enabled projects simultaneously:

```bash
# Start agents with unique prefixes
cd ~/project-a && maw start --prefix alpha
cd ~/project-b && maw start --prefix beta

# Attach to specific project
maw attach --prefix alpha   # Connect to project A
maw attach --prefix beta    # Connect to project B
```

### Direct Session Access

If you know the exact tmux session name:

```bash
# Skip auto-detection, use exact name
maw attach --session ai-my-custom-session
```

### List All Sessions First

```bash
# See all active tmux sessions
tmux list-sessions

# Then attach to the one you want
maw attach --session <name-from-list>
```

## Integration with Other Commands

### After `maw start`

The start command shows attach instructions when session already exists:

```
💡 Attach with: tmux attach-session -t ai-Nat-s-Agents
```

### With `maw peek`

Use peek to check agent status before attaching:

```bash
# Check what agents are doing (read-only)
maw peek

# If you need to interact, then attach
maw attach
```

### With `maw kill`

If you need to restart a session:

```bash
# Kill existing session
maw kill

# Start fresh
maw start

# Attach from another terminal
maw attach
```

## Tmux Basics for Attached Sessions

Once attached, use these tmux commands:

| Action | Key Binding |
|--------|-------------|
| Detach (leave running) | `Ctrl-b d` |
| Switch panes | `Ctrl-b arrow-keys` |
| Zoom pane | `Ctrl-b z` |
| Next window | `Ctrl-b n` |
| Previous window | `Ctrl-b p` |
| List windows | `Ctrl-b w` |

### Detaching vs Exiting

- **Detach** (`Ctrl-b d`): Session keeps running, you can reattach later
- **Exit** (close terminal): Session keeps running if not killed
- **maw kill**: Terminates the session completely

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `SESSION_PREFIX` | Override default "ai" prefix |

Example:
```bash
export SESSION_PREFIX=dev
maw attach  # Attaches to dev-<repo>
```

## Troubleshooting

### "tmux session not found"

**Cause**: No matching session exists

**Solutions**:
1. Check if agents are running: `tmux list-sessions`
2. Verify you're in the correct repository
3. Check if you used a custom prefix when starting

### "tmux not found in PATH"

**Cause**: tmux is not installed

**Solution**:
```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux
```

### Wrong Session Attached

**Cause**: Multiple similar-named sessions

**Solution**: Use explicit session name:
```bash
tmux list-sessions
maw attach --session <exact-name>
```

### Nested Tmux Warning

If you're already in a tmux session, attaching creates nested sessions.

**Solution**: Detach first or use a different terminal:
```bash
# Detach current session
Ctrl-b d

# Then attach to the new one
maw attach
```

## Under the Hood

The attach.sh script:

1. Determines session name from repo directory
2. Applies custom prefix if provided
3. Uses session override if specified
4. Checks if tmux is available
5. Verifies session exists
6. Executes `tmux attach-session`

```
attach.sh flow:
┌──────────────────┐
│ Parse options    │
│ --prefix/session │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Build session    │
│ name from repo   │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Check tmux       │
│ installed        │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐     No
│ Session exists?  ├────────► Show available sessions
└────────┬─────────┘
         │ Yes
         ▼
┌──────────────────┐
│ tmux attach      │
│ -session -t NAME │
└──────────────────┘
```

## Best Practices

1. **Use consistent prefixes** across related projects
2. **Detach rather than kill** when stepping away temporarily
3. **Check `maw peek`** before attaching to understand agent state
4. **Use `--session`** when session names are ambiguous
5. **Keep terminal open** if you need persistent access

## Related Commands

| Command | Purpose |
|---------|---------|
| `maw start` | Create new session |
| `maw kill` | Terminate session |
| `maw peek` | View agent status (read-only) |
| `maw hey` | Send message to agents |

---

*Last Updated: 2025-12-20*
