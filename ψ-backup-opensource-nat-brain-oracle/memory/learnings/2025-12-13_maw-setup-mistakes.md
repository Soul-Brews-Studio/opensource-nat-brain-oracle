# MAW Setup Mistakes & Lessons

> Snapshot: 23:22 Saturday 13 December 2025
> Session: Copying MAW from 000-workshop to Nat-s-Agents

## Mistakes Made

### 1. ❌ Tried to kill/restart MAW from Claude Code
**Problem**: `maw kill` has `read -p` confirmation prompt - hangs in non-interactive shell
**Solution**: Use `tmux kill-session -t ai-Nat-s-Agents` directly
**Lesson**: Check scripts for interactive prompts before running

### 2. ❌ Copied only profiles, not the start script
**Problem**: Profile14 (`six-horizontal-2win`) layout wasn't implemented in our start-agents.sh
**Result**: Got 1 window with 3 panes instead of 2 windows × 3 panes
**Solution**: Copy the ENTIRE start-agents.sh, not just profiles
**Lesson**: Profiles are just config - the script interprets them

### 3. ❌ Didn't check agents.yaml first
**Problem**: Our repo had only 3 agents defined, profile14 needs 5-6
**Result**: `maw setup` only created 3 worktrees
**Solution**: Copy agents.yaml first, then run `maw setup`
**Lesson**: Check config requirements before starting

### 4. ❌ Multiple restart attempts wasted time
**Problem**: Kept trying `maw kill && maw start` which hung
**Result**: Session stayed alive, confusion about state
**Solution**: Let subagent debug with direct tmux commands
**Lesson**: When stuck, delegate to subagent for investigation

### 5. ❌ Didn't trace what 000 had vs what we had
**Problem**: Jumped into copying without full diff
**Result**: Missed critical scripts (maw-wrapper, wait-agents-fast)
**Solution**: Run full comparison FIRST (subagent did this well)
**Lesson**: Analyze before acting

## What We Should Have Done

```
1. /trace maw                    # Find all MAW files
2. Subagent: diff 000 vs ours    # Full comparison
3. Copy agents.yaml              # Config first
4. maw setup                     # Create worktrees
5. Copy start-agents.sh          # Script with layout support
6. Copy profiles                 # Layout configs
7. tmux kill-session             # Direct kill (no prompt)
8. maw start profile14           # Start fresh
```

## Correct Order (for next time)

| Step | Command | Why |
|------|---------|-----|
| 1 | `diff .agents/ /source/.agents/` | See what's different |
| 2 | `cp agents.yaml` | Define agents first |
| 3 | `maw setup` | Create worktrees |
| 4 | `cp start-agents.sh` | Get layout support |
| 5 | `cp profiles/*.sh` | Get profile configs |
| 6 | `tmux kill-session -t <name>` | Clean kill |
| 7 | `maw start profile14` | Start with new layout |

## Key Files Copied

| File | Purpose |
|------|---------|
| `agents.yaml` | 5-agent config with roles |
| `start-agents.sh` | Layout implementation |
| `profiles/profile14.sh` | 2-window config |
| `profiles/profile6*.sh` | Grid layouts |
| `maw-wrapper.sh` | Subshell support |
| `wait-agents-fast.sh` | Completion polling |
| `agent-status.sh` | Status monitoring |

## Scripts That Need Interactive Input

⚠️ These scripts have `read -p` - won't work from Claude Code:
- `kill-all.sh` - asks "Kill all these sessions? (y/N)"
- Maybe others - check before running

## Working Commands (from Claude Code)

```bash
# Direct tmux (no prompts)
tmux kill-session -t ai-Nat-s-Agents
tmux list-sessions
tmux list-panes -t ai-Nat-s-Agents -a

# MAW commands that work
source .envrc && maw start profile14
source .envrc && maw hey 1 "message"
source .envrc && maw hey all "broadcast"
source .envrc && maw setup
```

## Time Wasted

- ~5 minutes on kill/restart loop
- ~3 minutes wondering why only 3 panes
- ~2 minutes on multiple failed approaches

**Total**: ~10 minutes that could have been 2 minutes with proper order

---

## Pattern Learned

> "Config → Setup → Script → Start"
> Not "Start → Wonder why broken → Debug → Realize missing pieces"

