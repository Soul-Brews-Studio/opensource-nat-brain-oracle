# Jump-Friendly Kanban — Blog Draft

**Created**: 2025-12-14 02:22 GMT+7
**Status**: Draft
**Author**: Human + AI collaboration

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Learning | `2025-12-14_jump-friendly-kanban.md` | Core system design |
| Retro | `20.25_jump-brewing-learn-structure.md` | Jump stack, workflow |
| Retro | `21.00_full-day-summary.md` | Simple beats complex |
| Learning | `2025-12-13_session-command-workflow.md` | Topic switching |
| Learning | `2025-12-13_auto-activity-logging-pattern.md` | State tracking |

---

## TL;DR

Traditional kanban breaks when you work in parallel and jump between tasks. Jump-Friendly Kanban adds a **PARKED** lane and uses traffic light colors for instant scanning. Simple enough to type, visual enough to scan.

---

## The Problem

Traditional kanban has three columns:
```
TODO → DOING → DONE
```

This works great if you:
- Work on one thing at a time
- Finish before starting the next
- Never get interrupted

But **real knowledge work** looks different:
- Working on 2-3 things in parallel
- Jumping to urgent items mid-task
- Returning to "parked" work later
- Context switching constantly

The traditional model forces you to either:
1. **Lie** — mark things "DOING" when they're actually paused
2. **Lose track** — forget what you jumped away from
3. **Abandon the system** — too much friction

---

## The Journey

### Attempt 1: More Columns
Added columns like "IN PROGRESS", "BLOCKED", "WAITING"...

**Result**: Too many columns. Cognitive load increased. Moving items between 6 columns takes longer than doing the work.

### Attempt 2: Tags/Labels
Used tags like `#active`, `#paused`, `#soon`...

**Result**: Tags are invisible at a glance. Still need to read text to understand status.

### Attempt 3: Priority Levels
P1, P2, P3 priority markers...

**Result**: Everything becomes P1. Priorities don't capture "jumped away but will return".

### Aha Moment

The key insight: **Jumping is not the same as deprioritizing.**

When you `/jump` to a new topic:
- The old task isn't less important
- It's **parked** — temporarily set aside
- You **will** return to it

This needs its own state, not a priority level.

---

## The Solution

### Jump-Friendly Kanban

```markdown
## Kanban

### ACTIVE
- 🔴 main task (focus)
- 🟢 parallel task (also doing)

### PARKED
- [-] jumped task 1
- [-] jumped task 2

### SOON
- 🟡 next task 1
- 🟡 next task 2

### DONE
- [x] completed 1
- [x] completed 2
```

### The Legend

| Symbol | Meaning | When to use |
|--------|---------|-------------|
| 🔴 | NOW | Main focus task |
| 🟢 | PARALLEL | Also actively working |
| 🟡 | SOON | Next up in queue |
| [-] | PARKED | Jumped away, will return |
| [x] | DONE | Completed |

### Why These Symbols?

**Traffic light colors** for active work:
- 🔴 Red = Stop here (this is your focus)
- 🟢 Green = Go (parallel work is fine)
- 🟡 Yellow = Get ready (coming up soon)

**Simple characters** for states:
- `[-]` = Dash inside = paused/parked
- `[x]` = Standard checkbox = done

The colors pop visually. The characters are easy to type.

---

## The Flow

```
SOON 🟡 → ACTIVE 🔴/🟢 → DONE [x]
              ↑↓
           PARKED [-]
```

**Starting work**: Move 🟡 to 🔴
**Jumping away**: Move 🔴 to [-]
**Returning**: Move [-] back to 🔴
**Finishing**: Move 🔴 to [x]
**Adding parallel**: Add 🟢 alongside 🔴

---

## The Pattern

### Key Takeaways

1. **Parallel work is normal** — Don't force single-tasking when multi-tasking is reality
2. **Jumping needs a home** — PARKED is different from TODO
3. **Visual scanning beats reading** — Colors > text labels
4. **Easy input matters** — If it's hard to update, you won't

### When to Apply

**Use this when:**
- You frequently switch contexts
- You work on multiple projects
- You get interrupted often
- You need to track "jumped" vs "new" items

**Don't use when:**
- Single-focus deep work sessions
- Team kanban boards (stick to standard columns)
- You rarely context switch

---

## Integration with Tools

### With `/jump` command

When using `/jump [new topic]`:
1. Current 🔴 automatically moves to [-] PARKED
2. New topic becomes 🔴 in ACTIVE
3. WIP.md updates with timestamp

### With Daily Archive

```
ψ/
├── WIP.md              ← current state
└── WIP-archive/        ← daily snapshots
    ├── 2025-12-13.md
    └── 2025-12-14.md
```

**Oracle principle**: Nothing is deleted. Git history + daily archive = infinite undo.

---

## Real Example

My actual WIP right now:

```markdown
### ACTIVE
- 🔴 headline incubation
- 🟢 WIP system design

### PARKED
- [-] ARTHUR clip (URGENT Mon)
- [-] Demo prep (URGENT Mon)

### SOON
- 🟡 brewing (sparge)
- 🟡 commit session
- 🟡 graph build

### DONE
- [x] CLAUDE v5.1
- [x] MAW setup
- [x] WIP-archive system
- [x] Jump-friendly kanban design
```

At a glance:
- 2 things active (red + green)
- 2 things parked (will return Monday)
- 3 things queued (yellow)
- 4 things done today (checked)

---

## Full Context (for AI continuation)

### Session Timeline
- 02:00 - Started headline incubation
- 02:10 - Jumped to WIP system design
- 02:14 - Designed kanban format
- 02:19 - Finalized traffic light system
- 02:22 - Created this draft

### Files Changed
- `ψ/WIP.md` — Updated with new kanban
- `ψ/WIP-archive/` — Created archive system
- `CLAUDE_workflows.md` — Added WIP Management section
- `ψ/memory/learnings/2025-12-14_jump-friendly-kanban.md` — Core docs

---

## Tags

`productivity` `kanban` `task-management` `parallel-work` `context-switching` `workflow`

---

## Writing Notes

### Tone
- Practical, problem-solving
- Personal experience driven
- Technical but accessible

### Target Audience
- Knowledge workers who context switch
- Developers, writers, creators
- People who've tried kanban and found it lacking

### Suggested Titles
1. "Jump-Friendly Kanban: Task Management for Context Switchers"
2. "Why Traditional Kanban Fails for Parallel Work (And What to Do Instead)"
3. "The PARKED Lane: A Missing Piece in Every Kanban Board"

### Next Steps
- [ ] Add screenshots/diagrams
- [ ] Review and polish
- [ ] Test with real usage for 1 week
- [ ] Publish

---

*Draft generated from session knowledge*
*Ready for human review and AI continuation*
