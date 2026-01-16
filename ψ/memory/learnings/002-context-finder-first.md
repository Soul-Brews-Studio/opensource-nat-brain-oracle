---
title: "Context-Finder FIRST, Always"
tags: [learning, pattern, context-finder, delegation]
date: 2025-12-09
---

# Learning 002: Context-Finder FIRST, Always

**Date**: 2025-12-09
**Trigger**: User had to remind multiple times about using context-finder
**Severity**: HIGH — causes user frustration from repetition

---

## The Problem

User keeps having to say:
- "ใช้ context-finder นะ"
- "อย่าลืมนะว่าต้องใช้ context-finder"
- "ทำไมไม่ส่งให้ haiku ทำ"

This is exhausting for the user. Repetition = failure to learn.

---

## The Rule (MEMORIZE THIS)

```
BEFORE reading ANY file in these folders:
  - context/
  - raw/
  - retrospectives/
  - journal/
  - any file > 100 lines

ASK YOURSELF: "Can context-finder do this?"

ANSWER IS ALMOST ALWAYS: YES

THEN: Task(context-finder, "...")
NOT: Read(file)
```

---

## Why Context-Finder First

| Action | Cost | Who Pays |
|--------|------|----------|
| Main reads 348 lines | ~500 tokens | Opus (expensive) |
| Haiku reads 348 lines | ~500 tokens | Haiku (cheap) |
| Haiku returns summary | ~50 tokens | Main gets summary only |

**Result**: 10x cheaper, main context stays clean

---

## Checklist Before Every Search/Read

- [ ] Is this in context/, raw/, retrospectives/, journal/?
- [ ] Is file likely > 100 lines?
- [ ] Could I ask context-finder to find/summarize this?
- [ ] Am I about to Read() when I should Task()?

**If ANY checkbox = yes → Use context-finder**

---

## Examples

### BAD (what I keep doing wrong)
```
User: "หา info เกี่ยวกับ Luc***"
Me: Read(context/2025-12-09_workshop-requests.md)  // 348 lines!
```

### GOOD (what I should do)
```
User: "หา info เกี่ยวกับ Luc***"
Me: Task(context-finder, "Search for Luc*** in context/ and raw/
                          Return: budget, timeline, what's missing")
```

---

## When to Read Directly

ONLY when:
1. File is < 50 lines AND
2. You need to EDIT it AND
3. Context-finder already told you WHAT to edit

Even then, consider asking context-finder for line numbers first.

---

## Apology to User

ขอโทษที่ต้องพูดซ้ำหลายรอบ
Pattern นี้สำคัญมาก — จะไม่ลืมอีก

---

*This learning exists because I kept forgetting.
If I forget again, user should point me to this file.*

---

## See Also

### Related Learnings
- [[memory/learnings/001-delegate-reading|001: Delegate Reading to Sub-agents]] - Complementary pattern
- [[memory/learnings/005-file-size-check-before-read|005: File Size Check Before Read]] - Related efficiency rule

### Source Sessions
- [[memory/retrospectives/2025-12/10/13.56_full-day-plugin-psi-convention|Dec 10 Full Day Session]] - Where user had to remind multiple times
- [[memory/retrospectives/2025-12/10/10.07_rrr-subagent-workflow-test|Dec 10 rrr Workflow Test]] - Subagent pattern validation

### Navigation
- [[HOME|Back to HOME]]
- [[memory/learnings|All Learnings]]
