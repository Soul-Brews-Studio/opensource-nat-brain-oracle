---
title: "Delegate Reading to Sub-agents"
tags: [learning, pattern, delegation, context-finder]
date: 2025-12-09
---

# Learning 001: Delegate Reading to Sub-agents

**Date**: 2025-12-09
**Trigger**: Read 348-line file directly when context-finder already had the info

---

## The Mistake

Context-finder found the answer:
> "Luc*** info is in context/2025-12-09_workshop-requests.md"

What I did:
```
Read(context/2025-12-09_workshop-requests.md)  // 348 lines into main context
```

What I should have done:
```
Task(context-finder, "What's MISSING about Luc*** in that file?
                      Give me the section to update and what to add")
```

---

## The Rule

```
IF file > 100 lines
THEN delegate reading to context-finder
NEVER read context/, raw/, retrospectives/ directly in main

IF you need to EDIT a large file
THEN ask context-finder for:
  - What section needs updating
  - What line numbers
  - What content is missing
THEN do surgical Edit, not full Read
```

---

## Why This Matters

- Main agent context = expensive (Opus)
- Sub-agent context = cheap (Haiku)
- 348 lines in main = ~500 tokens wasted
- Pattern: Context-finder finds WHERE, main agent acts on WHAT

---

## The Pattern

```
1. Context-finder → search/find location
2. Context-finder → extract specific info needed
3. Main agent → decide action
4. Main agent → surgical Edit (not Read + Write)
```

---

*Learned from: Forgetting the delegation pattern mid-session*

---

## See Also

### Related Learnings
- [[memory/learnings/002-context-finder-first|002: Context-Finder FIRST, Always]] - Complementary rule
- [[memory/learnings/004-human-confirmation-loop|004: Human Confirmation Loop]] - When to check vs proceed

### Source Session
- [[memory/retrospectives/2025-12/10/13.56_full-day-plugin-psi-convention|Dec 10 Full Day Session]] - Where this pattern was reinforced

### Navigation
- [[HOME|Back to HOME]]
- [[memory/learnings|All Learnings]]
