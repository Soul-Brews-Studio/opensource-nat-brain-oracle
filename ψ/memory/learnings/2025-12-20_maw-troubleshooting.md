# MAW Troubleshooting Guide

> Diagnostic and repair guide for Multi-Agent Workflow toolkit issues

---

## Quick Diagnostics

### System Health Check

```bash
# Check if maw is available
type maw 2>/dev/null || echo "maw not loaded"

# Check tmux sessions
tmux list-sessions 2>/dev/null || echo "No tmux sessions"

# Check worktrees
git worktree list

# Check direnv status
direnv status

# Check if in correct directory
pwd
```

---

## Session Issues

### Session Won't Start

**Symptom**: `maw start` fails or hangs

**Diagnostics**:
```bash
# Check for orphan sessions
tmux list-sessions

# Check for lock files
ls -la .agents/*.lock 2>/dev/null

# Verify worktrees exist
ls -la agents/
```

**Fixes**:
```bash
# 1. Kill orphan sessions
maw kill

# 2. Force clean start
maw kill && maw start

# 3. If still failing, check profile
maw start --profile 0  # Use simple profile

# 4. Nuclear option: full tmux reset
tmux kill-server
maw start
```

### Cannot Attach to Session

**Symptom**: `maw attach` says "no session found"

**Diagnostics**:
```bash
# List all sessions (including partial matches)
tmux list-sessions 2>&1

# Check session naming
echo "Expected prefix: ai-$(basename $PWD)"
```

**Fixes**:
```bash
# 1. Attach directly with name
tmux attach -t ai-Nat-s-Agents  # Adjust name

# 2. If session name changed, use wildcard
tmux attach -t $(tmux list-sessions -F '#{session_name}' | head -1)

# 3. If no session exists, start new one
maw start
```

### Session Exists But Panes Empty

**Symptom**: Tmux session shows but panes are blank/unresponsive

**Fixes**:
```bash
# 1. Send test command to verify responsiveness
maw send "echo test"

# 2. Check if shells are alive
tmux list-panes -s -F "#{pane_id}: #{pane_pid}"

# 3. Restart specific pane
# Navigate to pane with Ctrl+b + arrow keys
# Exit and restart: exit (or Ctrl+d) then shell starts fresh
```

---

## Auto-Warp Issues

### Panes Not Warping to Agent Directories

**Symptom**: Panes stay in root directory instead of `agents/N`

**Diagnostics**:
```bash
# Check current pane directory
pwd  # From within the pane

# Check if agent directories exist
ls -la agents/
```

**Fixes**:
```bash
# 1. Manual warp from within pane
maw warp 1  # Or: cd agents/1

# 2. Force direnv reload
direnv allow && direnv reload

# 3. Restart with explicit warp
maw kill && AUTO_START_AGENTS=0 maw start
# Then manually: maw warp 1, maw warp 2, etc.
```

### Auto-Warp Timing Issues

**Symptom**: Warp happens before shell is ready, commands appear garbled

**Cause**: The `sleep` delays in `start-agents.sh` may be too short

**Workaround**:
```bash
# After session starts, re-warp manually
maw warp 1
maw warp 2
maw warp 3
```

---

## Direnv Issues

### `maw` Command Not Found

**Symptom**: `maw: command not found` in subshell or new terminal

**Diagnostics**:
```bash
# Check if .envrc is allowed
direnv status

# Check if maw.env.sh exists
ls -la .agents/maw.env.sh
```

**Fixes**:
```bash
# 1. Allow direnv in current directory
direnv allow

# 2. Force reload
direnv reload

# 3. Manual source (temporary fix)
source .agents/maw.env.sh

# 4. Use maw executable directly (for subshells)
.agents/scripts/maw peek  # Direct execution
```

### Direnv Not Loading in Worktree

**Symptom**: Commands work in root but not in `agents/N`

**Diagnostics**:
```bash
# Check .envrc in agent directory
cat agents/1/.envrc
# Should reference parent .envrc
```

**Fixes**:
```bash
# 1. Allow direnv in the worktree
cd agents/1 && direnv allow

# 2. If .envrc missing, check symlinks
ls -la agents/1/.envrc

# 3. Use direnv exec pattern (from any directory)
direnv exec /path/to/root maw peek
```

### Direnv Slow/Hanging

**Symptom**: Long delays when changing directories

**Fixes**:
```bash
# 1. Silence direnv output
export DIRENV_LOG_FORMAT=""

# 2. Check for expensive operations in .envrc
time (direnv allow && cd agents/1)

# 3. If using nix, check nix-direnv caching
# Add use_nix or use_flake caching
```

---

## Sync Conflicts

### Rebase Conflicts Between Agents

**Symptom**: `git rebase main` fails with conflicts in agent worktree

**Diagnostics**:
```bash
# Check conflict status
git -C agents/1 status

# See what's conflicting
git -C agents/1 diff --name-only --diff-filter=U
```

**Fixes**:
```bash
# 1. Abort and try fresh
git -C agents/1 rebase --abort
git -C agents/1 reset --hard origin/agents/1
git -C agents/1 rebase main

# 2. If conflicts are simple, resolve manually
cd agents/1
# Edit conflicting files
git add .
git rebase --continue

# 3. Use ours/theirs for specific files
git checkout --ours file.txt  # Keep agent version
git checkout --theirs file.txt  # Keep main version
```

### Main Branch Ahead/Behind

**Symptom**: Agent branches diverged from main

**Diagnostics**:
```bash
# Check divergence
git log main..agents/1 --oneline  # Agent commits not in main
git log agents/1..main --oneline  # Main commits not in agent
```

**Fixes**:
```bash
# Proper sync pattern (from any worktree):
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# 1. Commit agent work
git add -A && git commit -m "agent work"

# 2. Main rebases onto agent (to get agent's commits)
git -C "$ROOT" rebase agents/1

# 3. All other agents rebase onto main
git -C "$ROOT/agents/2" rebase main
git -C "$ROOT/agents/3" rebase main

# 4. Push
git -C "$ROOT" push origin main
```

### Focus.md Conflicts

**Symptom**: Multiple agents editing same `ψ/inbox/focus.md`

**Prevention**:
- Each agent should only edit their OWN `agents/N/ψ/inbox/focus.md`
- Never edit root's `ψ/inbox/focus.md` from agent worktree

**Fix**:
```bash
# Accept the latest version
git checkout --theirs ψ/inbox/focus.md
git add ψ/inbox/focus.md
git rebase --continue
```

---

## Agent Startup Issues

### AI Agents Don't Auto-Start

**Symptom**: Panes warp but Claude/Codex doesn't launch

**Diagnostics**:
```bash
# Check AUTO_START_AGENTS setting
echo $AUTO_START_AGENTS

# Check if claude/codex commands exist
which claude
which codex
```

**Fixes**:
```bash
# 1. Enable auto-start
export AUTO_START_AGENTS=1
maw kill && maw start

# 2. Manual start in each pane
# Navigate to pane, then:
claude --dangerously-skip-permissions

# 3. Check command availability
brew install claude  # If missing
```

### Wrong AI Tool Launched

**Symptom**: Claude launches where Codex should, or vice versa

**Info**: Current profile assigns:
- Agent 1: Claude (shadow)
- Agents 2-5: Codex (executors)

**Fix**: Edit `.agents/scripts/start-agents.sh` in the `auto_start_agents()` function to change assignments.

### PocketBase Not Starting

**Symptom**: Inbox system unavailable

**Diagnostics**:
```bash
# Check if running
nc -z 127.0.0.1 8090 && echo "Running" || echo "Not running"

# Check logs
cat .agents/pocketbase/*.log 2>/dev/null
```

**Fixes**:
```bash
# 1. Start manually
cd .agents/pocketbase && pocketbase serve --http=127.0.0.1:8090 &

# 2. Check if port is blocked
lsof -i :8090

# 3. Kill and restart
pkill pocketbase
sleep 1
cd .agents/pocketbase && pocketbase serve --http=127.0.0.1:8090 &
```

---

## Profile/Layout Issues

### Wrong Number of Panes

**Symptom**: Expected 6 panes but got 3 (or vice versa)

**Cause**: Profile mismatch or fewer agents than expected

**Diagnostics**:
```bash
# Check how many agents exist
ls agents/ | wc -l

# Check current profile
echo $PROFILE  # During start
```

**Fixes**:
```bash
# 1. Use explicit profile
maw start --profile 6  # For 6-agent grid

# 2. Create more agents if needed
maw agents add 4
maw agents add 5
maw kill && maw start
```

### Pane Sizes Wrong

**Symptom**: Panes are uneven or too small

**Fixes**:
```bash
# 1. Resize manually with mouse (if enabled)

# 2. Use tmux keybindings
# Ctrl+b + arrow keys (resize)
# Ctrl+b + Space (cycle layouts)

# 3. Equalize panes
# Ctrl+b + E (if bound) or:
tmux select-layout -t ai-Nat-s-Agents tiled
```

---

## Network/External Issues

### GitHub Operations Failing

**Symptom**: Push/pull fails from agent

**Diagnostics**:
```bash
# Check remote
git remote -v

# Test connection
ssh -T git@github.com
```

**Fixes**:
```bash
# 1. Ensure SSH agent has keys
ssh-add -l
ssh-add ~/.ssh/id_ed25519

# 2. Check if worktree has correct remote
git -C agents/1 remote -v
# Should match main repo's remote
```

---

## Recovery Procedures

### Full Reset (Nuclear Option)

When nothing else works:

```bash
# 1. Kill everything
maw kill
tmux kill-server 2>/dev/null

# 2. Clean worktree state
git worktree prune

# 3. Reinstall agents
maw remove  # Confirm deletion
maw install

# 4. Fresh start
maw start
```

### Single Agent Recovery

```bash
# 1. Remove broken agent
git worktree remove agents/3 --force

# 2. Recreate
maw agents add 3

# 3. Verify
ls -la agents/3/
```

---

## Diagnostic Commands Reference

| Command | Purpose |
|---------|---------|
| `maw peek` | Show all agent status |
| `maw peek detail` | Detailed status with focus info |
| `git worktree list` | List all worktrees |
| `tmux list-sessions` | Show tmux sessions |
| `tmux list-panes -s` | Show all panes in session |
| `direnv status` | Check direnv state |
| `git -C agents/N status` | Check specific agent git state |

---

## Common Error Messages

| Error | Cause | Fix |
|-------|-------|-----|
| `maw: command not found` | direnv not loaded | `direnv allow` |
| `No agents detected` | Worktrees not created | `maw install` |
| `Session already exists` | Previous session running | `maw attach` or `maw kill` |
| `Repository has no commits` | Empty git repo | Create initial commit |
| `Worktree locked` | Previous operation interrupted | `git worktree unlock agents/N` |
| `Cannot rebase: dirty` | Uncommitted changes | Commit or stash first |

---

## Best Practices to Avoid Issues

1. **Always use `git -C`** - Never `cd` to other worktrees
2. **Commit before sync** - Dirty worktrees cause conflicts
3. **One agent per worktree** - Don't share focus.md
4. **Check before push** - Use `maw peek` to verify state
5. **Keep sessions clean** - `maw kill` before starting fresh

---

*Last Updated: 2025-12-20*
