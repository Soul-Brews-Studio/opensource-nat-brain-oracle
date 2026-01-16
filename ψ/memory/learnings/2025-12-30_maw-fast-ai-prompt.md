# MAW Fast AI Prompt

> Copy this to any AI agent to enable MAW multi-agent orchestration

## Setup (run once)
```bash
source .agents/maw.env.sh
```

## Core Commands
```bash
maw start profile15     # Start 5 Claude agents
maw see -c              # Check all clients (should show 5x Claude)
maw hey N "task"        # Send task to agent N (1-5)
maw hey all "task"      # Broadcast to all
maw see                 # View all agent output
maw peek                # Check agent status
maw sync                # Sync all to main
```

## Direct Pane Targeting
```bash
maw hey @2 "msg"        # Direct to pane 2
maw hey 0:1 "msg"       # Window 0, Pane 1
maw hey 1:1 "msg"       # Window 1, Pane 1 (agents 4-5)
```

## 5-Agent Parallel Task Pattern
```bash
# Dispatch different tasks to each agent
maw hey 1 "Task for agent 1"
maw hey 2 "Task for agent 2"
maw hey 3 "Task for agent 3"
maw hey 4 "Task for agent 4"
maw hey 5 "Task for agent 5"

# Wait and check
sleep 20 && maw peek
maw see
```

## Quick Demo (one-liner)
```bash
tmux kill-server; source .agents/maw.env.sh && maw start profile15 && sleep 6 && maw see -c && maw hey all "Ready for work" && maw see
```

## File Locations
- Agents work in: `agents/N/` (worktrees)
- To see agent files: `find agents/N/ -name "*.py"`
- To collect: Agents commit, then `maw sync`

## Golden Rules
- NEVER force push
- NEVER push to main directly
- Use `maw sync` to collect agent work
- Check `maw see -c` to verify all Claude

---
*Created: 2025-12-30*
