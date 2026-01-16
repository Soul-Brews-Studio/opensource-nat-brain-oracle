# Lesson: Verify Data Before Creating Demo Content

**Date**: 2025-12-22
**Context**: Arthur demo script had wrong FloodBoy timeline

## What Happened

AI created demo script with fictional data:
```
Timeline: กันยายน 2025  (WRONG)
```

Real timeline from git history:
```
First commit: 2024-11-19 (esphome-fw repo)
Project existed BEFORE repo was created
Timeline: 1 year+ (not 3 months)
```

## Root Cause

1. AI made up "September 2025" without checking
2. Didn't search `esphome-fw` repo (only checked newer repos)
3. Assumed demo content could be fictional
4. User had to catch and correct the error

## Lesson

**Before writing ANY timeline/date in demo content:**

1. Run `/trace [project]` to find ALL repos
2. Check `git log --reverse | head` for first commits
3. Ask user: "When did [project] actually start?"
4. Note: First git commit != project start (often later)

## Pattern

```
Demo content about real projects = MUST verify facts
Demo content about fictional projects = Can be creative
```

## Key Insight

> **"backup floodboy fw" as 2nd-day commit = FloodBoy existed BEFORE the repo**

Git history shows when code was tracked, not when work started.

---

*Discovered during Arthur demo prep session*
