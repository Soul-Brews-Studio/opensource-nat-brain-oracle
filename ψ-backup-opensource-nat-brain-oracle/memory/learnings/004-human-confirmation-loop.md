---
title: Human Confirmation Loop
created: 2025-12-09
severity: MEDIUM
source: Session feedback - AI committed without asking first
tags:
  - workflow
  - confirmation
  - human-in-the-loop
  - commands
aliases:
  - confirmation loop
  - human in the loop
---

# Human Confirmation Loop

## Context Links

- **Commits**: `f64ed63` (add to /rrr), `aaa5ddb` (add to /distill)
- **Source Retrospectives**:
  - [[18.30_retrospective-naming-pattern|Retrospective Naming Pattern]] - Human confirmation step added to /rrr
  - [[18.57_cellar-and-psi-adoption|Cellar and Psi Adoption]] - Full session with confirmation loop implementation
- **Related Learnings**:
  - [[000-naming-philosophy|Naming Philosophy]] - Complementary pattern
  - [[007-knowledge-distillation-loop|Knowledge Distillation Loop]] - Uses this pattern

---

## Key Insight

> **Create first, confirm before commit** — AI should show summary and ask for approval before finalizing.

---

## The Problem

| What We Tried | What Happened |
|---------------|---------------|
| Create file → commit immediately | User couldn't review or adjust |
| Trust AI output fully | Missed opportunities for refinement |

---

## The Solution

### Pattern: Confirm Before Commit

```markdown
สร้าง [file type] แล้ว: [filepath]

**สรุปสั้นๆ:**
- Key point 1
- Key point 2
- Key point 3

**ถามก่อน commit:**
- โอเคแบบนี้ไหม?
- ขาดอะไรไหม?
- เพิ่มตรงไหนไหม?

พร้อม commit หรือจะแก้ไขก่อน?
```

**When to use**: Any command that creates knowledge artifacts (retrospectives, learnings, logs)
**Why it works**: Human stays in control, can refine before permanent record

---

## Anti-Patterns

| Don't Do This | Do This Instead |
|---------------|-----------------|
| Create and commit silently | Show summary, ask confirmation |
| Assume output is perfect | Invite refinement |
| Skip human when time-pressed | Always ask (takes 5 seconds) |

---

## Summary

| Concept | Details |
|---------|---------|
| When | Before committing any generated content |
| What | Summary + 3 questions |
| Why | Human control, quality improvement |

---

## Apply When

- Running `/rrr` (retrospectives)
- Running `/distill` (learnings)
- Running `/snapshot` (logs)
- Any command that creates and commits files

---

## See Also

- [[003-speech-to-text-uncertainty|Speech to Text Uncertainty]] - Confirmation helps catch STT errors
- [[005-file-size-check-before-read|File Size Check]] - Another "check before act" pattern
- [[006-plugin-system-architecture|Plugin System Architecture]] - SessionStart hooks use similar principles
