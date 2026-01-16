---
title: # Ralph-Loop Needs Exit Condition
tags: [ralph-loop, tooling, exit-condition, workflow, focus]
created: 2025-12-30
source: Session 2025-12-30 retrospective
---

# # Ralph-Loop Needs Exit Condition

# Ralph-Loop Needs Exit Condition

## What We Learned

Ralph-loop is a focus enforcement tool that fires on every response, reminding the agent to stay on task. However, it has no "done" detection - when all tasks are complete, it continues firing indefinitely.

**The Problem**: After completing 65/65 speckit tasks, the ralph-loop fired 100+ times with "make sure we are on speckit!" despite no remaining work. Each cycle consumed tokens and required a response.

**The Fix**: Manually delete `.claude/ralph-loop.local.md` when work is complete:
```bash
rm -f .claude/ralph-loop.local.md
```

## How Things Connect

| Tool | Purpose | Exit Condition |
|------|---------|----------------|
| Ralph-loop | Focus enforcement | None (manual cancel) |
| Speckit | Task tracking | All tasks [x] complete |
| /rrr | Session closure | Human confirms |

**Pattern**: Focus tools should either:
1. Auto-detect completion (check if all tasks done)
2. Have clear manual exit (user command, not deletion)
3. Timeout after N cycles without new work

## Prevention

Before starting ralph-loop, define:
- What "done" means (all speckit tasks complete? PR merged?)
- How to exit (command, file deletion, timeout)
- Maximum iterations before auto-stop

## Tags

`ralph-loop` `tooling` `focus` `exit-condition` `workflow`

---
*Added via Oracle Learn*
