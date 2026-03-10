---
title: "Communication Hub"
tags: [index, inbox, tracked, communication]
created: 2025-12-11
parent: "[[ψ-HOME|Home]]"
---

# Communication Hub

> คุยกับใคร? - Tracked communication center for focus, scheduling, and handoffs

---

## Quick Links

| File | Purpose | Updated |
|------|---------|---------|
| [[focus.md|focus]] | Current priority tasks and decisions | 2025-12-11 |
| [[schedule.md|schedule]] | Appointments and deadlines | 2025-12-11 |
| [[handoff/|handoff/]] | Session transfers and context | 2025-12-11 |
| [[external/|external/]] | External agent communication | - |

---

## Structure

```
inbox/
├── INDEX.md              ← You are here
├── focus.md              ← Current priority (NOW, pending decisions)
├── schedule.md           ← Appointments and deadlines
├── handoff/              ← Session handoff & context transfer
│   ├── YYYY-MM-DD.md     ← Session summary
│   └── YYYY-MM-DD-*.md   ← Topic-specific notes
└── external/             ← Other AI agents (future)
```

---

## File Details

### focus.md
- Current priority tasks (NOW section)
- Blocked items
- Decisions pending
- Quick context (deadlines, user state, preferences)
- Files to watch

**Usage**: Update before each session, check first thing

### schedule.md
- Upcoming appointments
- Deadlines (pitch, meetups, presentations)
- Event status tracking

**Usage**: Reference for timeline, source of truth for dates

### handoff/
- Session summaries (dated files)
- Context transfer between sessions
- Skills learned, decisions made

**File naming**: `YYYY-MM-DD.md` (session date) or `YYYY-MM-DD-topic.md` (specific topic)

**Usage**: Read at session start via `/recap`, created at session end via `rrr`

### external/
- Messages to/from other agents
- Multi-agent coordination (future)

**Usage**: Reserved for agent-to-agent communication

---

## Workflow

### At Session Start
```
1. Read [[schedule.md|schedule.md]] → Know your deadlines
2. Read [[focus.md|focus.md]] → Know your priorities
3. Read latest handoff/ → Get context from last session
4. (Optional) `/recap` → AI-generated summary
```

### During Session
```
- Update [[focus.md|focus.md]] as priorities shift
- Add notes to [[schedule.md|schedule.md]] if new appointments
- Reference files in "Files to watch" section
```

### At Session End
```
- Create handoff/YYYY-MM-DD.md summarizing session
- Update [[focus.md|focus.md]] with next priorities
- Run `rrr` command for full retrospective
```

---

## Current Focus

From [[focus.md|focus.md]]:

| Priority | Task | Status |
|----------|------|--------|
| NOW | พักผ่อน (user เหนื่อย) | In progress |
| DONE | Pitch slides generation | Complete |
| WATCH | md-cataloger decision | Pending |

---

## Rules

- inbox/ is **tracked in git** (unlike active/)
- [[focus.md|focus.md]] = single source of truth for NOW
- handoff/ files are **timestamped** (audit trail)
- [[schedule.md|schedule.md]] = authoritative for deadlines
- All updates are **logged with timestamps**

---

## See Also

- [[../active/INDEX.md|active/]] (Ephemeral research workspace)
- [[../memory/INDEX.md|memory/]] (Knowledge base and retrospectives)
- [CLAUDE.md](../../CLAUDE.md) - Main quick reference
- [CLAUDE_workflows.md](../../CLAUDE_workflows.md) - Short codes (rrr, /recap)

---

*This is the communication hub. Everything here matters and stays tracked.*
