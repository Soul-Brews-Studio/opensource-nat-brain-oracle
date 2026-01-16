# MAW Hey Command Guide

> Send messages to agents from anywhere - the communication backbone of multi-agent workflows

## Overview

The `maw hey` command enables communication between the human operator and running Claude agents in a tmux-based multi-agent workspace. It sends text directly to agent panes, allowing you to issue commands, ask questions, or broadcast messages to multiple agents simultaneously.

**Location**: `.agents/scripts/hey.sh`

---

## Basic Syntax

```bash
maw hey <target> <message>
```

| Argument | Description |
|----------|-------------|
| `<target>` | Agent name (1, 2, 3...) or special target (root, all) |
| `<message>` | Text to send to the agent's input |

---

## Targets

### Agent Targets

Send to a specific agent by its worktree name:

```bash
maw hey 1 "analyze the authentication flow"
maw hey 2 "create unit tests for the API"
maw hey 3 "review the recent commits"
```

Agent names correspond to worktree directories in `agents/`:
- `agents/1/` → agent `1`
- `agents/2/` → agent `2`
- etc.

### Special Targets

| Target | Description |
|--------|-------------|
| `root` or `main` | The main worktree pane (not an agent) |
| `all` | Broadcast to ALL agent panes |

```bash
# Send git command to root pane
maw hey root "git status"

# Broadcast to all agents
maw hey all "please pause and wait for sync"
```

---

## How It Works

### 1. Session Discovery

The script finds the tmux session using naming convention:

```
${SESSION_PREFIX:-ai}-${DIR_NAME}
```

For a repo at `/path/to/Nat-s-Agents`:
- Expected session: `ai-Nat-s-Agents`
- With custom prefix: `${SESSION_PREFIX}-Nat-s-Agents`

### 2. Agent-to-Pane Mapping

Agents are mapped to panes based on directory order:

```
agents/
├── 1/   → pane 0
├── 2/   → pane 1
├── 3/   → pane 2
└── ...
```

The mapping uses `ls -d */ | sort` to enumerate agents, so numeric agents sort correctly (1, 2, 3...).

### 3. Message Delivery

The script uses two methods depending on content:

#### Simple Messages (< 500 chars, single line)

```bash
tmux send-keys -t "$pane" "$text"
tmux send-keys -t "$pane" Enter
```

Direct send-keys is fast but can have issues with special characters.

#### Complex Messages (multiline OR > 500 chars)

```bash
echo "$text" | tmux load-buffer -
tmux paste-buffer -t "$pane"
tmux send-keys -t "$pane" Enter
```

The buffer method:
1. Loads content into tmux's paste buffer
2. Pastes it into the target pane
3. Sends Enter to submit

**Why buffer method?** It handles:
- Newlines in the message
- Special characters that would break send-keys
- Very long messages that might exceed terminal limits

---

## Utility Commands

### List Available Agents

```bash
maw hey --list
# or
maw hey -l
```

Output:
```
Available agents:
  - 1
  - 2
  - 3

Special targets:
  - root  (main worktree pane)
  - all   (broadcast to all agents)
```

### Show Pane Mapping

```bash
maw hey --map
# or
maw hey -m
```

Output:
```
Agent to pane mapping:
  Agent '1' → pane 0 (agents/1)
  Agent '2' → pane 1 (agents/2)
  Agent '3' → pane 2 (agents/3)
  Root      → pane 3 (main worktree)
```

---

## Usage Examples

### Basic Communication

```bash
# Ask agent 1 to do something
maw hey 1 "read the README and summarize the project structure"

# Ask agent 2 to investigate
maw hey 2 "search for TODO comments in the codebase"

# Tell root to run a command
maw hey root "npm test"
```

### Multiline Messages

For complex prompts, use shell quoting:

```bash
maw hey 1 "Please do the following:
1. Read the authentication module
2. Identify security vulnerabilities
3. Create a report in ψ/active/"
```

Or use a heredoc:

```bash
maw hey 2 "$(cat <<'EOF'
Review this code pattern and suggest improvements:

function handleError(err) {
  console.log(err);
  return null;
}

Focus on:
- Error handling best practices
- Logging strategies
EOF
)"
```

### Coordination Patterns

```bash
# Pause all agents before sync
maw hey all "please pause current work - sync incoming"

# Resume after sync
maw hey all "sync complete, please continue"

# Assign parallel tasks
maw hey 1 "handle the frontend components"
maw hey 2 "handle the backend API"
maw hey 3 "write integration tests"
```

### With Context From Files

```bash
# Send file contents to agent
maw hey 1 "Review this file: $(cat src/auth.ts)"

# Send git diff
maw hey 2 "Review these changes: $(git diff HEAD~1)"
```

---

## Troubleshooting

### "No tmux session found"

```
Error: No tmux session found matching 'ai-Nat-s-Agents*'
```

**Solution**: Start the MAW session first:
```bash
maw start
```

### "Agent not found"

```
Error: Agent '5' not found
```

**Solution**: Check available agents:
```bash
maw hey --list
```

### Message Not Delivered

If the message doesn't appear in the agent pane:

1. **Check session is attached**: `tmux ls`
2. **Verify pane mapping**: `maw hey --map`
3. **Check if agent is busy**: The agent might be processing and hasn't shown the input yet

### Special Characters Issues

If your message has special characters that cause issues:

```bash
# Use single quotes for literal content
maw hey 1 'analyze the regex: ^[a-z]+$'

# Or escape special characters
maw hey 1 "analyze the regex: \^\[a-z\]+\$"
```

---

## Integration with Workflows

### Peek-Then-Hey Pattern

```bash
# Check what agents are doing
maw peek

# Then send targeted message
maw hey 2 "when you're done, please sync"
```

### Sync Coordination

```bash
# Before sync
maw hey all "sync starting - please commit or stash work"

# Perform sync
maw sync

# After sync
maw hey all "sync complete - you may continue"
```

---

## Technical Details

| Aspect | Value |
|--------|-------|
| Script location | `.agents/scripts/hey.sh` |
| Buffer threshold | 500 characters OR contains newlines |
| Send delay (simple) | 50ms between text and Enter |
| Send delay (buffer) | 100ms between paste and Enter |
| Session prefix default | `ai` |
| Pane base index | Respects tmux `pane-base-index` setting |

---

## See Also

- `maw peek` - View what agents are currently doing
- `maw sync` - Synchronize worktrees with main
- `maw start` - Start the multi-agent tmux session
- `.agents/scripts/start-agents.sh` - Session initialization
