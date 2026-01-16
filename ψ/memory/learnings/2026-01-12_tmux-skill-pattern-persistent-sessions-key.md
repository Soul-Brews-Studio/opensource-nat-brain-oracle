---
title: # tmux Skill Pattern - Persistent Sessions
tags: [tmux, skill, remote, session, persistent, send-keys]
created: 2026-01-12
source: Session 2026-01-12: tmux skill refinement
---

# # tmux Skill Pattern - Persistent Sessions

# tmux Skill Pattern - Persistent Sessions

## Key Fix: Persistent bash shell first, then send commands

### Wrong (session dies when command finishes)
```bash
./run.sh host session "long-command"  # session gone after
```

### Right (persistent shell)
```bash
./run.sh host session              # starts bash
./send.sh host session "command"   # runs in bash
./send.sh host session "C-c"       # can interrupt
./send.sh host session "another"   # session still alive
```

## Script Fixes Applied

### run.sh
- Now creates `bash --login` session first
- Optional command sent after session created
- Session persists after command completes

### send.sh  
- Auto-detects special keys (C-c, C-d) via regex `^C-[a-z]$`
- Special keys sent WITHOUT Enter
- Regular commands get Enter appended
- `--raw` flag to force no Enter

### check.sh
- Changed from log file to `tmux capture-pane`
- More reliable for interactive sessions
- Instant output, no waiting

## Workflow
```bash
./run.sh user@host session           # 1. Start
./send.sh user@host session "cmd"    # 2. Send commands
./check.sh user@host session 20      # 3. See output
./send.sh user@host session "C-c"    # 4. Interrupt if needed
./kill.sh user@host session          # 5. Cleanup
```

---
*Added via Oracle Learn*
