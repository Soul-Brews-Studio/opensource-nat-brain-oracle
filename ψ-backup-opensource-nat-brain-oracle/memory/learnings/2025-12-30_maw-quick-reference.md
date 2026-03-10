# MAW Quick Reference for AI Agents

> Copy this to any AI agent to enable MAW usage

## Setup
```bash
source .agents/maw.env.sh   # Enable maw commands
```

## Core Commands

| Command | Purpose | Speed |
|---------|---------|-------|
| `maw start profile14` | Start 5 agents in tmux | ~7s |
| `maw peek` | Status of all agents | <1s |
| `maw see` | View agent output (10 lines each) | <1s |
| `maw see -c` | Quick client check | <1s |
| `maw see 1` | Agent 1 output (20 lines) | <1s |
| `maw hey 1 "task"` | Send task to agent 1 | <1s |
| `maw hey all "task"` | Broadcast to all | <1s |
| `maw sync` | Sync all agents to main | ~3s |
| `maw watch` | Poll until all done | ongoing |

## Profiles

| Profile | Layout | Agents |
|---------|--------|--------|
| profile14 | 2 win × 3 panes | 1=Claude, 2-5=Codex |
| profile15 | 2 win × 3 panes | All Claude (needs implementation) |

## Workflow

```bash
# 1. Start session
maw start profile14

# 2. Check what's running
maw see -c

# 3. Send tasks
maw hey 1 "analyze auth flow"
maw hey 2 "search for TODOs"
maw hey 3 "run tests"

# 4. Monitor
maw see          # View output
maw peek         # Check status
maw watch        # Wait for completion

# 5. Collect results
maw sync         # Sync all to main
```

## Safety Rules

- NEVER force push
- Always `git push` before `maw sync`
- Use `git -C /path` not `cd` for worktree ops

## Client Detection

`maw see -c` detects:
- **Claude** (green) - opus/sonnet/haiku/bypass permissions
- **Codex** (yellow) - context left/shortcuts
- **Gemini** (magenta) - gemini/google
- **Shell** (dim) - plain shell

---

*Created: 2025-12-30*
