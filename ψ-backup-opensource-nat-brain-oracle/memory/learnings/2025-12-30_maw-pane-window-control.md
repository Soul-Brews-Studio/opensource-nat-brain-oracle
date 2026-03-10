# MAW Pane & Window Control Guide

> Lessons learned from multi-agent orchestration sprint (2025-12-30)

## Window Layout (profile15 - All Claude)

```
┌─────────────────────────────────────────────┐
│ Window 0 (Execution Layer)                  │
├─────────────┬─────────────┬─────────────────┤
│ Pane 1      │ Pane 2      │ Pane 3          │
│ Agent 1     │ Agent 2     │ Agent 3         │
│ agents/1/   │ agents/2/   │ agents/3/       │
└─────────────┴─────────────┴─────────────────┘

┌─────────────────────────────────────────────┐
│ Window 1 (Specialization Layer)             │
├─────────────┬─────────────┬─────────────────┤
│ Pane 1      │ Pane 2      │ Pane 3          │
│ Agent 4     │ Agent 5     │ Monitor/Main    │
│ agents/4/   │ agents/5/   │ main worktree   │
└─────────────┴─────────────┴─────────────────┘
```

## Targeting Agents

### By Agent Number (recommended)
```bash
maw hey 1 "task"    # Agent 1 (Window 0, Pane 1)
maw hey 2 "task"    # Agent 2 (Window 0, Pane 2)
maw hey 3 "task"    # Agent 3 (Window 0, Pane 3)
maw hey 4 "task"    # Agent 4 (Window 1, Pane 1)
maw hey 5 "task"    # Agent 5 (Window 1, Pane 2)
```

### By Window:Pane (direct)
```bash
maw hey 0:1 "task"  # Window 0, Pane 1 (Agent 1)
maw hey 0:2 "task"  # Window 0, Pane 2 (Agent 2)
maw hey 0:3 "task"  # Window 0, Pane 3 (Agent 3)
maw hey 1:1 "task"  # Window 1, Pane 1 (Agent 4)
maw hey 1:2 "task"  # Window 1, Pane 2 (Agent 5)
```

### By Direct Pane (@N)
```bash
maw hey @1 "task"   # Pane 1 in current window
maw hey @2 "task"   # Pane 2 in current window
```

### Broadcast
```bash
maw hey all "task"  # All agents receive
```

## Checking Status

### Quick Client Check
```bash
maw see -c
# Output:
# Agent 1: Claude
# Agent 2: Claude
# Agent 3: Claude
# Agent 4: Claude
# Agent 5: Claude
```

### View Agent Output
```bash
maw see         # All agents, 10 lines each
maw see 1       # Agent 1 only, 20 lines
maw see 1 50    # Agent 1, 50 lines
```

### Agent Status
```bash
maw peek        # Status + branch + commit for all
```

### List Panes (raw tmux)
```bash
tmux list-panes -t ai-Nat-s-Agents:0 -F "#{pane_index}: #{pane_current_path}"
tmux list-panes -t ai-Nat-s-Agents:1 -F "#{pane_index}: #{pane_current_path}"
```

## Lessons Learned

### 1. Pane Base Index = 1
- tmux pane-base-index is 1, not 0
- So `0:1` is Window 0, Pane 1 (first pane)
- NOT `0:0`

### 2. Agent 5 Slow Start
- Agent 5 sometimes shows "Shell" on first check
- Wait 6-7 seconds after `maw start` before checking
- Re-check with `maw see -c` if needed

### 3. Window 1 Routing
- Agents 4-5 are in Window 1, Panes 1-2
- `maw hey 4/5` automatically routes to Window 1
- Direct `maw hey 1:1` also works

### 4. Files in Worktrees
- Each agent works in `agents/N/` worktree
- Files created by agents are in their worktree
- Use `maw sync` to collect work to main
- `.agents/` is gitignored - move files to tracked location

### 5. Client Detection
- `maw see -c` uses pattern matching on output
- Detects: Claude, Codex, Gemini, Shell
- Shell = agent starting or idle

## Quick Workflow

```bash
# 1. Start
source .agents/maw.env.sh
maw start profile15

# 2. Verify (wait 6s)
sleep 6 && maw see -c

# 3. Dispatch tasks
maw hey 1 "Task 1"
maw hey 2 "Task 2"
maw hey 3 "Task 3"
maw hey 4 "Task 4"
maw hey 5 "Task 5"

# 4. Monitor
maw peek        # Status
maw see         # Output

# 5. Collect (after agents commit)
maw sync
```

---

*Created: 2025-12-30 from MAW orchestration sprint*
