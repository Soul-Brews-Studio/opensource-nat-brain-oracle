# Jump-Friendly Kanban

**Date**: 2025-12-14 02:18
**Context**: Designing task management for parallel + jumping work style

## Problem

Traditional kanban (Todo → Doing → Done) doesn't work when you:
- Work on multiple things in parallel
- Jump between tasks frequently
- Need to quickly see what's active vs parked

## Solution: Jump-Friendly Kanban

### Structure

```markdown
## 📋 Kanban

### ACTIVE
- 🔴 main task (NOW/focus)
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

### Legend

| Symbol | Meaning | When to use |
|--------|---------|-------------|
| 🔴 | NOW | Main focus task |
| 🟢 | PARALLEL | Also actively working |
| 🟡 | SOON | Next up in queue |
| [-] | PARKED | Jumped away, will return |
| [x] | DONE | Completed today |

### Design Principles

1. **Traffic Light Colors** - Instantly scannable
   - 🔴 = Stop here (focus)
   - 🟡 = Get ready (soon)
   - 🟢 = Go (parallel)

2. **Simple Characters** - Easy to type
   - `[-]` = parked (dash = paused)
   - `[x]` = done (standard checkbox)

3. **Sections not Columns** - Works in any markdown

## Flow

```
SOON 🟡 → ACTIVE 🔴/🟢 → DONE [x]
              ↑↓
           PARKED [-]
```

**Jump action**: 🔴 → [-] (move to PARKED)
**Return action**: [-] → 🔴 (move back to ACTIVE)

## Integration with /jump

When using `/jump [new topic]`:
1. Current 🔴 task moves to [-] PARKED
2. New topic becomes 🔴 in ACTIVE
3. WIP.md updated automatically

## WIP Structure

```
ψ/
├── WIP.md              ← current kanban
└── WIP-archive/        ← daily snapshots
    ├── 2025-12-13.md
    └── 2025-12-14.md
```

**Archive pattern**: 1 file per day, auto-archive on day change

## Why This Works

| Feature | Benefit |
|---------|---------|
| Color icons | Fast visual scan |
| Simple chars | Easy to type |
| PARKED section | Tracks jumped work |
| PARALLEL support | Multiple active items |
| Daily archive | Nothing lost (Oracle) |

## Related

- `/jump` command - topic switching
- `ψ/WIP.md` - current state
- `ψ/WIP-archive/` - history
- Oracle principle: Nothing is Deleted

## Tags

#kanban #productivity #jump #wip #workflow
