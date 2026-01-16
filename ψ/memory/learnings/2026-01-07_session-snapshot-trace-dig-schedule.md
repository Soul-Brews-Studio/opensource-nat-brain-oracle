# Session Snapshot: /trace, /dig, and Schedule Consolidation

**Date**: 2026-01-07
**Duration**: ~1 hour (18:31 - 19:30)

## What We Learned

### 1. /trace vs /dig - Two Speeds of Knowledge Archaeology

| Command | Agents | Speed | Use Case |
|---------|--------|-------|----------|
| `/trace` | 5 | Thorough | Complete project history |
| `/dig` | 3 | Fast | Quick lookup, surface info |

**Pattern**: Start shallow (`/dig`), go deep if needed (`/trace`)

### 2. Agent-Spawning-Agent is the Real Innovation

The core concept isn't MAW (tmux + worktrees) - it's **agents creating agents**:
- Task tool spawning Haiku/Sonnet in parallel
- Main defines scope → Spawn N agents → Collect → Synthesize
- Pure MCP breakthrough (Jan 4): AI-to-AI coordination without external orchestration

### 3. Calendar Visualization Pattern

When showing schedules, always include:
```
    January 2026
Su Mo Tu We Th Fr Sa
             1  2  3
 4  5  6  7  8  9 10   ← TODAY (Wed 7)
11 12 13 14 15 16 17   ← Events annotated
...

X days until [next event]! 🔥
```

### 4. Schedule Consolidation - One Session, 7 Events

Captured in single session:
1. CP Foundation (Jan 12, 10:30) - FireMan project
2. VietJet VZ2107 (Jan 13, 20:50) - CNX→BKK
3. Bitkub (Jan 14, 14:00) - Agentic AI / Oracle
4. TAZ/Thus P. (Jan 15-16) - AI Coding meeting
5. Workshop Boy (Jan 20+) - Pinyo, rescheduled
6. Block Mountain (Jan 22-25) - Speaker slot Fri/Sat
7. MIsD Workshop (Jan 28) - SROI + Academic Writing

### 5. /fyi as Event Capture

Chat logs → structured info files:
- MIsD invitation → `ψ/memory/logs/info/`
- Thus P. group history → contact info, timeline, action items

## How Things Connect

```
/trace (deep) ←→ /dig (fast)
        ↓
  Oracle search
        ↓
  5 parallel agents (context-finder)
        ↓
  Comprehensive results
```

```
Chat logs → /fyi → info file
                     ↓
              Track update
                     ↓
              Calendar visualization
```

## Session Outputs

| Type | File |
|------|------|
| Command | `.claude/commands/dig.md` |
| Skill | `.claude/skills/schedule-calendar.md` |
| Track | `ψ/inbox/tracks/010-january-travel-workshops.md` (updated) |
| Info | `ψ/memory/logs/info/2026-01-07_*` (2 files) |
| Learning | `ψ/memory/learnings/2026-01-07_*` (4 files) |

## Action Items

- [ ] Book BKK→CNX return flight (Jan 17-18)
- [ ] Reply to MIsD invitation (Jan 28)
- [ ] Confirm Workshop Boy exact dates with Pinyo
- [ ] Wait for คำลี่ + TAZ call result (Jan 8, 11:00)

## Tags

`snapshot` `trace` `dig` `schedule` `calendar` `january-2026` `workflow`
