# maw peek Table Format - Compact Visibility

**Date**: 2025-12-17

## What We Learned

- `maw peek` showing 71+ lines per run was too verbose for quick glance
- Table format condenses all agents into ~8 lines
- **Main was missing** - critical blind spot when Main has uncommitted changes

## The Problem

```
🔍 Peeking at all agents...

═══ Agent 1 ═══
✓ Clean
Focus:
  STATE: completed
  TASK: ...
Last commit:
  ...

═══ Agent 2 ═══
...
(repeat × 5 agents = 71+ lines)
```

## The Solution

```
🔍 Peeking at all agents...

Agent  │ Status   │ Task                           │ Commit
───────┼──────────┼────────────────────────────────┼────────
Main   │ 3m 4+    │ /learn esphome-fw             │ aeea06a
1      │ ✓        │ /sync command created          │ aeea06a
2      │ ✓        │ /sync command created          │ aeea06a
...
```

## Key Decisions

| Decision | Rationale |
|----------|-----------|
| Show Main first | Most important - controls syncing |
| `3m 4+` status | Quick count: 3 modified, 4 untracked |
| Truncate task to 30 chars | Fit in one line |
| Keep detail view | `maw peek 1` for deep dive |

## How Things Connect

- Visibility → Better coordination
- `maw peek` + `maw peek main` = two levels of detail
- Fits with learning mode: understand before acting

## Tags

`maw` `peek` `observability` `multi-agent` `ux`
