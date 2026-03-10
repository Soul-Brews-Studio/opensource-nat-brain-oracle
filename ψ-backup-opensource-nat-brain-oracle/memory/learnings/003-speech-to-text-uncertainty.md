---
title: "Speech-to-Text Uncertainty Handling"
tags: [learning, pattern, communication, speech-to-text]
date: 2025-12-09
---

# Learning 003: Speech-to-Text Uncertainty Handling

**Date**: 2025-12-09
**Trigger**: macOS built-in speech-to-text is inaccurate, causes misunderstanding

---

## The Problem

User uses macOS speech-to-text (built-in). It's not accurate.
- Words get garbled
- AI has to guess meaning
- Sometimes guesses wrong → wasted work
- Human doesn't always review before sending

---

## The Pattern

### When to Confirm (ทวนก่อน)

1. **High uncertainty** — Can't parse the request clearly
2. **After negative feedback** — Human said "ไม่ใช่", "ทำเกิน", "ทำผิด"
3. **Destructive actions** — Delete, overwrite, push

### When to Just Do It

1. **Clear intent** — Even if words are garbled, meaning is obvious
2. **Low risk** — Read, search, create new file
3. **Continuation** — Following up on established pattern

---

## Signals That Speech-to-Text Failed

- Human says "ไม่ใช่" / "not what I meant"
- Human corrects with different words
- Human seems frustrated by result
- Request doesn't match context

**When detected**: Next message should be confirmed before acting

---

## Confirmation Format

```
📝 เข้าใจว่า: [summary in Thai or English]
ถูกไหม? (ถ้าไม่ตอบจะทำเลย)
```

Keep it short. Don't ask every time.

---

## Trade-offs Accepted

| Accept | Avoid |
|--------|-------|
| Sometimes guess wrong | Confirming every message |
| Occasional wasted work | Slowing down workflow |
| Learn from feedback | Over-cautious behavior |

---

*This is about finding balance, not perfection.*

---

## See Also

### Related Learnings
- [[memory/learnings/004-human-confirmation-loop|004: Human Confirmation Loop]] - When to ask vs proceed
- [[memory/learnings/000-naming-philosophy|000: Naming Philosophy]] - Communication patterns

### Core Philosophy
- [[memory/resonance/oracle|Oracle Philosophy]] - Balance and patterns over perfection

### Navigation
- [[HOME|Back to HOME]]
- [[memory/learnings|All Learnings]]
