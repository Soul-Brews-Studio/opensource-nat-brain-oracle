---
title: # The Great Archive Migration — Jan 11, 2026
tags: [migration, archive, skills, plugin, nat-agents-core, jan-2026]
created: 2026-01-11
source: Migration Session 2026-01-11
---

# # The Great Archive Migration — Jan 11, 2026

# The Great Archive Migration — Jan 11, 2026

## Timeline

### Phase 1: Analysis (21:15-21:20)
- Traced command usage in Jan 2026
- Found only 25 of 79 commands had any mentions
- Identified deprecated: /trace-v2, /project find

### Phase 2: Mass Archive (21:20-21:40)
| Action | Count |
|--------|-------|
| Archived unused commands | 28 |
| Archived ALL commands | 79 |
| Archived project skills | 20 |
| Archived user skills | 15 |
| Archived specs | 38 |

**Key move**: Relocated `_archive` from `.claude/commands/_archive/` to `.claude/_archive/` — stops Claude loading them.

### Phase 3: Restore as Skills (21:44-22:33)
| Time | Skill | Notes |
|------|-------|-------|
| 21:44 | trace, rrr, recap, learn | Core 4 |
| 21:50 | project | 10 scripts |
| 21:57 | context-finder | Subagent |
| 22:02 | where-we-are | Merged /now |
| 22:07 | trace (updated) | Merged /trace-oracle with flags |
| 22:18 | forward | Handoff |
| 22:33 | feel | Structured format |

### Phase 4: Improvements
- /trace: Oracle first → extend if < 3 results
- /rrr: Save without asking
- /feel: Added energy:N and trigger:X format

## Final State

| Category | Before | After |
|----------|--------|-------|
| Commands | 79 | 0 |
| Active Skills | 35 | 9 |
| Specs | 38 | 0 |

## The 9 Survivors

1. trace — Find (Oracle first)
2. context-finder — Search subagent
3. rrr — Retrospective
4. recap — Fresh start
5. learn — Explore codebase
6. project — Clone & track
7. where-we-are — Session awareness
8. forward — Handoff
9. feel — Mood logging

## Philosophy

> **Archive-First Development**: Archive aggressively, trust git, restore = upgrade opportunity.

## For Future Plugin (nat-agents-core v2)

Bundle these skills + agents + philosophy into one installable package.

All archived items preserved in `.claude/_archive/` with full git history.

---
*Added via Oracle Learn*
