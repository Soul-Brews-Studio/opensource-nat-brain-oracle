# /fyi — Log Information

Record this info: $ARGUMENTS

## Instructions

1. Create an info log file at `ψ/memory/logs/info/[YYYY-MM-DD]_[HH-MM]_[slug].md`

2. Use this format:
```markdown
# Info: [brief title]

**Time**: [timestamp]
**Category**: [work/personal/health/learning/other]

## Details
[The information being logged]

## Context
[Why this matters, what it relates to]

## Cross-references
[Related logs, patterns, or sessions]
```

3. AI should add relevant context from current session

4. Tag for future searchability

## Examples

Input: `/fyi slept at 4am last night`

Output file: `ψ/memory/logs/info/2026-01-08_12-00_sleep-4am.md`
```markdown
# Info: Late sleep - 4am

**Time**: 2026-01-08 12:00
**Category**: health

## Details
Slept at 4am last night.

## Context
Was working on workshop deadline. This follows pattern of deadline-driven late nights.

## Cross-references
- Similar to 2026-01-05 (3am sleep before presentation)
- Feeling log from morning shows "tired"
```

---

Input: `/fyi meeting moved to 3pm Thursday`

Output file: `ψ/memory/logs/info/2026-01-08_10-15_meeting-rescheduled.md`
```markdown
# Info: Meeting rescheduled to Thursday 3pm

**Time**: 2026-01-08 10:15
**Category**: work

## Details
Meeting moved from Wednesday to Thursday 3pm.

## Context
Workshop planning meeting with team.

## Cross-references
- Original meeting was in calendar for Wednesday
- Related to workshop delivery preparation
```
