# MAW Kill Command — Complete Guide

> Learn: How to safely terminate MAW agent sessions

**Source**: `.agents/scripts/kill-all.sh`, `.agents/maw.env.sh`
**Related**: `maw remove`, `maw start`, `maw attach`

---

## What is `maw kill`?

`maw kill` terminates all tmux sessions created by MAW (Multi-Agent Workflow Kit) for the current project. It's the clean way to stop all agents without affecting other tmux sessions.

### Quick Usage

```bash
# Kill all agents for current project
maw kill

# With custom prefix
maw kill --prefix my-prefix

# With custom session prefix
maw kill --session-prefix custom
```

---

## What It Terminates

### Session Pattern Matching

The command kills tmux sessions matching this pattern:

```
{SESSION_PREFIX}-{REPO_DIR_NAME}
```

| Variable | Default | Source |
|----------|---------|--------|
| `SESSION_PREFIX` | `ai` | Environment or `--session-prefix` |
| `REPO_DIR_NAME` | Current repo folder name | Derived from `$REPO_ROOT` |

### Example Patterns

| Repo Location | Sessions Matched |
|---------------|------------------|
| `/Users/nat/Nat-s-Agents` | `ai-Nat-s-Agents*` |
| `/Users/nat/my-project` | `ai-my-project*` |
| With `--prefix dev` | `dev-ai-Nat-s-Agents*` |

### What Gets Killed

| Killed | NOT Killed |
|--------|------------|
| All agent panes in tmux session | Other unrelated tmux sessions |
| Claude Code processes in agents | Claude Code in main terminal |
| Background shell jobs in agents | Your main terminal |

---

## Safety Checks

### 1. Confirmation Prompt

The script **always asks for confirmation** before killing:

```
🔍 Found sessions:
ai-Nat-s-Agents

❓ Kill all these sessions? (y/N):
```

You must type `y` or `Y` to proceed. Pressing Enter or any other key cancels.

### 2. Safe Pattern Matching

The script uses **exact prefix matching** (`^${SESSION_PATTERN}`):
- Only kills sessions that START with the pattern
- Won't accidentally kill sessions from other projects
- Won't kill sessions with similar but different names

### 3. No Force Flags

Unlike some other commands, `maw kill`:
- Has NO `--force` or `-f` flag
- Cannot skip confirmation
- Always shows what it will kill before doing so

---

## Options Reference

| Option | Description | Example |
|--------|-------------|---------|
| `--prefix <prefix>` | Add custom prefix to session pattern | `maw kill --prefix team` |
| `--session-prefix <base>` | Override base prefix (default: `ai`) | `maw kill --session-prefix dev` |

### Option Interaction

```bash
# Default: pattern = "ai-RepoName"
maw kill

# With --prefix: pattern = "team-ai-RepoName"
maw kill --prefix team

# With --session-prefix: pattern = "dev-RepoName"
maw kill --session-prefix dev

# Both: pattern = "team-dev-RepoName"
maw kill --prefix team --session-prefix dev
```

---

## How It Works (Step by Step)

```
1. Determine SCRIPT_DIR from script location
   └── cd "$(dirname "${BASH_SOURCE[0]}")" && pwd

2. Calculate REPO_ROOT (parent of .agents)
   └── cd "$AGENT_ROOT/.." && pwd

3. Build session pattern
   └── ${CUSTOM_PREFIX}-${SESSION_PREFIX}-${DIR_NAME}
   └── Or: ${SESSION_PREFIX}-${DIR_NAME} if no custom prefix

4. List matching tmux sessions
   └── tmux list-sessions -F "#{session_name}" | grep "^${PATTERN}"

5. If no sessions found → exit with message
   └── "ℹ️  No sessions found matching: pattern*"

6. Display found sessions
   └── "🔍 Found sessions:"
   └── [list of sessions]

7. Ask for confirmation
   └── read -p "❓ Kill all these sessions? (y/N): " -n 1 -r

8. If confirmed (y/Y):
   └── Loop through sessions
   └── tmux kill-session -t "$session"
   └── "🗑️  Killing session: $session"

9. Final status
   └── "✅ All sessions killed" or "❌ Cancelled"
```

---

## Related Commands

### `maw remove` — Full Cleanup

While `maw kill` only stops tmux sessions, `maw remove` does more:

| Action | `maw kill` | `maw remove` |
|--------|------------|--------------|
| Kill tmux sessions | ✅ | ✅ (first step) |
| Remove worktrees | ❌ | ✅ |
| Delete branches | ❌ | ✅ (if merged) |
| Prune references | ❌ | ✅ |

```bash
# Just stop agents (can restart later)
maw kill

# Full teardown (need to run setup again)
maw remove
```

### `maw start` — Restart After Kill

After killing, restart agents with:

```bash
maw start
```

---

## Common Scenarios

### Scenario 1: Stop All Agents for Lunch Break

```bash
maw kill
# Agents stopped, worktrees preserved
# Resume later with: maw start
```

### Scenario 2: Agent is Stuck/Frozen

```bash
maw kill
# All agents killed (including stuck one)
maw start
# Fresh start
```

### Scenario 3: Project Done, Full Cleanup

```bash
maw remove
# Kills sessions AND removes worktrees
```

### Scenario 4: Multiple MAW Projects

```bash
# In project A
cd /path/to/project-a
maw kill  # Only kills project-a sessions

# In project B
cd /path/to/project-b
maw kill  # Only kills project-b sessions
```

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success (or no sessions found) |
| 1 | Invalid option provided |

---

## Session Naming Convention

Understanding how MAW names sessions helps predict what gets killed:

```
{prefix}-{repo-name}
   │         │
   │         └── basename of repo root
   └── "ai" by default, or SESSION_PREFIX env var
```

Sessions are created by `start-agents.sh` with names like:
- `ai-Nat-s-Agents`
- `ai-my-project`
- `dev-Nat-s-Agents` (with custom prefix)

---

## What Happens to Agents?

When a session is killed:

1. **tmux session terminates**
2. **Claude Code processes receive SIGHUP**
3. **Any unsaved context is lost**
4. **Worktrees remain intact**
5. **Git state preserved**

### Data That Survives

| Survives | Lost |
|----------|------|
| Committed code | Unsent messages |
| Worktree files | Running Claude Code sessions |
| Git branches | In-progress tool calls |
| Focus files | Background shell jobs |

---

## Best Practices

### Before Killing

```bash
# Optional: Check what's happening first
maw peek

# Optional: Sync changes
git add -A && git commit -m "WIP before kill"
```

### After Killing

```bash
# Restart when ready
maw start

# Or attach to verify it's dead
maw attach  # Should fail/show no sessions
```

### Emergency Kill (if maw kill doesn't work)

```bash
# Direct tmux kill (use exact session name)
tmux kill-session -t ai-Nat-s-Agents

# Or kill all tmux (CAUTION: kills ALL tmux sessions)
tmux kill-server
```

---

## Script Location

The kill script is located at:
```
.agents/scripts/kill-all.sh
```

Invoked via:
```
maw kill [options]
```

Or directly:
```bash
./.agents/scripts/kill-all.sh [options]
```

---

## Summary

| Aspect | Details |
|--------|---------|
| **Purpose** | Terminate all MAW agent tmux sessions |
| **Safety** | Confirmation required, no force flag |
| **Scope** | Only current project's sessions |
| **Preserves** | Worktrees, branches, files |
| **Destroys** | Running sessions, unsaved context |
| **Alias** | `maw-kill` = `maw kill` |

---

*Last updated: 2025-12-20*
*Source: kill-all.sh analysis*
