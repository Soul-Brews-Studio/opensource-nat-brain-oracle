---
title: "/trace --found: Explicit Discovery Logging"
tags: [trace, found, oracle, learning, skill-enhancement]
created: 2026-01-15
source: Session 2026-01-15 - MISSION-04 creation
---

# /trace --found: Explicit Discovery Logging

## The Problem

When tracing multiple times and finally finding something, how does the user tell the AI "I found it"?

Previous approach was purely implicit — AI guessed based on:
- User saying "found it!", "this is it"
- User implementing something
- Time proximity to trace

But users wanted explicit control.

## The Solution

Added `--found` flag to /trace skill:

```bash
/trace --found              # AI infers from last trace context
/trace --found "description" # Override with explicit description
```

## How AI Infers

AI tracks session traces:
```yaml
session_traces:
  - query: "bun shell testing"
    timestamp: "00:39"
    files_read: ["schedule.test.ts"]
    keywords: ["bun:test", "bun:$"]
```

When user says `--found`:
1. Look at most recent trace
2. Extract pattern from files read
3. Generate learning description
4. Log to Oracle with concepts

## Key Insight

> "Found" can be both implicit AND explicit.
> Give users the option, don't force one approach.

The implicit detection still works — AI observes implementation.
But `--found` gives users confidence their discovery was logged.

---

*From: Creating MISSION-04 Hooks Challenge session*
