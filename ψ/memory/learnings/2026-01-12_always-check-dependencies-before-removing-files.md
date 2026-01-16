---
title: ## Always Check Dependencies Before Removing Files
tags: [cleanup, dependencies, verification, dead-code]
created: 2026-01-12
source: Session 2026-01-13
---

# ## Always Check Dependencies Before Removing Files

## Always Check Dependencies Before Removing Files

**Date**: 2026-01-13
**Context**: Removing deprecated parse-schedule.sh

### The Pattern

Before removing a file marked "deprecated":
1. Check if anything actually uses it: `grep -l "filename" **/*.sh`
2. Often files are already unused (like parse-schedule.sh)
3. Don't assume - verify

### This Session's Example

```bash
# Thought: calendar.sh needs parse-schedule.sh
# Check: grep -l "schedule.csv" .claude/skills/schedule/scripts/*.sh
# Found: calendar.sh creates its OWN temp CSV!
# Result: parse-schedule.sh was never used
```

### Commits

| File | Added | Removed |
|------|-------|---------|
| parse-tracks.sh | 54646c7f | 27ba409a |
| parse-schedule.sh | (never used) | 85511ee0 |

### Lesson

> "Check before assuming. Often 'deprecated' files are already dead code."

---
*Added via Oracle Learn*
