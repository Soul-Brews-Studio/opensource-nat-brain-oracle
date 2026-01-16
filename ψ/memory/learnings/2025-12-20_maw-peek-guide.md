# MAW Peek Command Guide

> Quick visibility into what all agents are doing — without interrupting them.

## Overview

`maw peek` is a read-only monitoring command that shows the status of all agent worktrees in the MAW (Multi-Agent Workflow) system. It's designed for fast, non-intrusive checks that don't require entering any agent's working directory.

```bash
# Quick glance at everyone
maw peek

# Deep dive into specific agent
maw peek 1
maw peek main
```

## Why Peek Exists

In a multi-agent workflow, the orchestrator (human or main agent) needs visibility without disruption:

| Problem | Peek Solution |
|---------|---------------|
| "What is agent 2 working on?" | Read their focus.md |
| "Has agent 1 committed yet?" | Show their last commit hash |
| "Are there uncommitted changes?" | Display modification count |
| "Is the system in sync?" | Compare commit hashes |

The key insight: **read from anywhere, modify locally**. Peek uses `git -C` to inspect other worktrees without changing the current directory.

---

## Table View (Default)

Running `maw peek` with no arguments shows a compact table of all agents:

```
🔍 Peeking at all agents...

Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ ✓        │ Orchestrating parallel tasks   │ f59ff0b
1      │ 2 mod    │ Create maw peek guide docum... │ f59ff0b
2      │ ✓        │ -                              │ f59ff0b
3      │ 1 new    │ Working on feature X           │ 64f574b
```

### Columns Explained

| Column | Source | Description |
|--------|--------|-------------|
| Agent | Worktree list | Main or agent number (1, 2, 3...) |
| Status | `git status --porcelain` | Clean (✓) or change summary |
| Task | `ψ/inbox/focus.md` | Current task from TASK: line |
| Commit | `git log -1 --format="%h"` | Latest commit hash |

---

## Status Indicators

The Status column uses color-coded indicators:

| Indicator | Color | Meaning |
|-----------|-------|---------|
| `✓` | Green | Working tree is clean (no uncommitted changes) |
| `N mod` | Yellow | N files modified (staged or unstaged) |
| `N new` | Yellow | N new untracked files |
| `Nm N+` | Yellow | N modified + N new files |
| `N chg` | Yellow | N total changes (fallback) |

### Status Detection Logic

```bash
# From peek.sh get_status()
mod=$(echo "$status" | grep -c "^ M\| M\|^M" || true)
new=$(echo "$status" | grep -c "^??" || true)
```

The script parses `git status --porcelain` output:
- `M` or ` M` = Modified files
- `??` = Untracked (new) files

---

## Detail View

For deeper inspection, specify an agent:

```bash
maw peek 1      # Agent 1 details
maw peek main   # Main worktree details
```

### Detail Output Example

```
═══ Agent 1 ═══
Modified:
 M ψ/inbox/focus.md
 M ψ/memory/logs/activity.log
?? ψ/memory/learnings/2025-12-20_maw-peek-guide.md

Focus:
  STATE: working
  TASK: Create maw peek guide documentation
  SINCE: 12:30

Last commit:
  f59ff0b signal: agent-2 complete (MAW-BLOG-002) (2 hours ago)
```

### Detail Sections

| Section | What It Shows |
|---------|---------------|
| Modified | First 5 changed files from `git status --porcelain` |
| Focus | Full contents of `ψ/inbox/focus.md` |
| Last commit | Hash, message, and relative time |

If more than 5 files are modified, shows `... and N more`.

---

## Usage Patterns

### Pattern 1: Pre-Sync Check

Before syncing worktrees, check if all agents have clean state:

```bash
maw peek
# Look for all ✓ in Status column
# If all clean → safe to sync
# If any have changes → they need to commit first
```

### Pattern 2: Progress Monitoring

During parallel work, periodically check progress:

```bash
# Quick status
maw peek

# If agent seems stuck, get details
maw peek 2
```

### Pattern 3: Commit Hash Comparison

The Commit column reveals sync state:

| Scenario | What You See |
|----------|--------------|
| All synced | Same hash everywhere |
| Agent ahead | Agent has different hash |
| Agent behind | Agent has older hash |

```
Agent  │ Commit
───────┼────────
Main   │ f59ff0b  ← Latest
1      │ f59ff0b  ← Synced
2      │ 64f574b  ← Behind (needs rebase)
3      │ f59ff0b  ← Synced
```

### Pattern 4: Task Discovery

When returning to a session, peek reveals what was happening:

```bash
maw peek
# Task column shows each agent's focus
# Empty task ("-") = idle or just started
```

---

## Implementation Details

### File Location

```
.agents/scripts/peek.sh
```

### Dependencies

- `git` - For status and log commands
- `bash` - Uses bash-specific features (BASH_REMATCH, `set -euo pipefail`)
- Worktree structure - Expects agents at `agents/N` paths

### Key Implementation Choices

| Choice | Reason |
|--------|--------|
| `git -C` not `cd` | Non-invasive, respects current directory |
| `--porcelain` | Machine-parseable, stable output format |
| Truncate to 30 chars | Fits in terminal table nicely |
| Color codes | Quick visual parsing |
| First 5 files only | Detail view stays readable |

### How It Discovers Agents

```bash
git worktree list
# Output:
# /path/to/repo                    abc1234 [main]
# /path/to/repo/agents/1           def5678 [agents/1]
# /path/to/repo/agents/2           ghi9012 [agents/2]

# Pattern match for agents/N
if [[ "$path" =~ agents/([0-9]+)$ ]]; then
  agent_num="${BASH_REMATCH[1]}"
  # ...
fi
```

---

## Color Codes

The script uses ANSI color codes:

```bash
GREEN='\033[0;32m'   # ✓ clean status
YELLOW='\033[1;33m'  # changes present
RED='\033[0;31m'     # (reserved for errors)
CYAN='\033[0;36m'    # headers/titles
DIM='\033[2m'        # subtle text
NC='\033[0m'         # reset
```

---

## Comparison with Other Commands

| Command | Purpose | Modifies? |
|---------|---------|-----------|
| `maw peek` | View agent status | No (read-only) |
| `maw hey` | Send task to agent | Yes (writes task file) |
| `maw sync` | Synchronize worktrees | Yes (git operations) |
| `maw start` | Launch agent sessions | Yes (starts processes) |

---

## Troubleshooting

### "No agents found"

Ensure worktrees exist:
```bash
git worktree list
```

If empty, agents haven't been created yet.

### Focus shows "-"

The agent's `ψ/inbox/focus.md` either:
- Doesn't exist (agent just started)
- Has no `TASK:` line
- Is empty

### Wrong commit hash

If an agent shows an old hash, they need to sync:
```bash
git -C agents/N rebase main
```

---

## Best Practices

1. **Peek before sync** - Always check status before running sync commands
2. **Use detail view sparingly** - Table view is usually sufficient
3. **Trust the Task column** - Agents update focus.md when working
4. **Watch commit hashes** - Diverging hashes indicate sync needed

---

## Related Documentation

- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` - Sync patterns
- `ψ/memory/learnings/2025-12-20_maw-hey-instruction.md` - Hey command guide
- `ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md` - Safety checkpoints

---

*Last updated: 2025-12-20*
*Source: `.agents/scripts/peek.sh` implementation analysis*
