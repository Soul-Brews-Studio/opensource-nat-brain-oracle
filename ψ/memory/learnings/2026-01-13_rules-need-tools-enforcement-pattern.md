---
title: Rules Need Tools — Enforcement Pattern
tags: [discipline, rules, tooling, enforcement, golden-rules, learning]
created: 2026-01-13
source: Session 2026-01-13 - Breaking Golden Rule #13 twice
---

# Rules Need Tools — Enforcement Pattern

**Date**: 2026-01-13
**Context**: Added Golden Rule #13 then broke it twice

## The Pattern

Rules without tools are suggestions. To make a rule stick:

```
Rule → Tool → Habit
```

## Example: Golden Rule #13

1. **Rule**: "Query markdown, don't Read"
2. **Tool**: `/md` skill with `query.sh`
3. **Habit**: Always reach for `/md` instead of Read tool

## The Learning Cycle

```
Mistake → Correction → Rule → Tool → Oracle → Habit
```

- **Mistake**: Used Read tool on schedule.md
- **Correction**: User said "you read it direct again?"
- **Rule**: Added Golden Rule #13 to CLAUDE.md
- **Tool**: Created /md skill
- **Oracle**: Learned to oracle_learn
- **Habit**: Now use /md by default

## Key Insight

> "The rule didn't stick until I broke it and got caught."

Real-time user correction creates stronger learning than documentation alone. The user's challenge — "prove me" — forced implementation, not just acknowledgment.

## Application

When adding a new rule:
1. Document the rule (CLAUDE.md)
2. Create enforcement tool (skill/script)
3. Log to Oracle (oracle_learn)
4. Practice publicly (demonstrate)
5. Get corrected when wrong (user feedback)
