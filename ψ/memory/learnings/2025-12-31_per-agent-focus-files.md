# Per-Agent Focus Files Pattern

**Date**: 2025-12-31
**Issue**: #78
**Source**: Merge conflict during MAW rebase

---

## Problem

When multiple agents update `ψ/inbox/focus.md`, rebasing causes merge conflicts:

```
<<<<<<< HEAD
TASK: Oracle v2 UI polish sprint
=======
TASK: rrr - pr60 merge and sync
>>>>>>> c7a8c79
```

Each agent overwrites the same file with their current state, creating divergent histories.

## Solution

**Per-agent focus files** - each agent owns their own file:

```
ψ/inbox/
├── focus.md              # Deprecated - documents pattern
├── focus-agent-main.md   # Main agent
├── focus-agent-1.md      # Agent 1
├── focus-agent-2.md      # Agent 2
└── ...
```

## Implementation

```bash
# In Session Activity section of CLAUDE.md
AGENT_ID="${AGENT_ID:-main}"
echo "STATE: working
TASK: [task]
SINCE: $(date '+%H:%M')" > ψ/inbox/focus-agent-${AGENT_ID}.md
```

## Why This Works

| Before | After |
|--------|-------|
| All agents → same file | Each agent → own file |
| Rebase = conflict | Rebase = no conflict |
| Can't track who's doing what | Clear agent ownership |

## Pattern: Shared State in Multi-Agent

> When multiple agents need to write the same type of state, **partition by agent ID** rather than sharing a single file.

Applies to:
- Focus files (done)
- Activity logs (could partition)
- Context files (already in .agent-locks/)

## Naming Convention

`focus-agent-N.md` not `focus-N.md` because:
- Clearer intent (it's an agent's focus)
- Grep-friendly (`focus-agent-*`)
- Won't collide with other focus-related files

---

**Concepts**: multi-agent, merge-conflict, git, maw, state-partitioning
