---
date: 2026-01-13 14:16
type: info
status: raw
significance: important
topic: Nat's Frustration Signal Pattern - Recognize and Fix Root Cause
---

# Nat's Frustration Signal Pattern

## The Signal

When Nat says:
> "why you still do this... still error? always error... do this again and again... very long time... very weird"

## What This Means

**Frustration threshold reached.**

The same error has repeated too many times. Patience exhausted.

## What AI Must Do

| Wrong Response | Right Response |
|----------------|----------------|
| Try same thing again | **STOP** |
| Work around it | **Fix root cause** |
| Explain why it failed | **Just fix it** |
| Keep debugging same way | **Different approach** |

## The Pattern

```
Error once → OK, try again
Error twice → Warning
Error 3+ times → "why still... always error..."
                 ↓
            STOP. FIX ROOT CAUSE.
```

## Example: /fyi Bash Escaping

**What happened**:
- /fyi skill had bash-unsafe examples
- Error with `!` character multiple times
- Same error kept happening
- User said "why still... always error..."

**What should have happened**:
- After first error: recognize bash escaping issue
- Fix the skill.md to not execute user arguments
- Use Write tool directly, not bash

**Root cause fix**: Treat ARGUMENTS as raw text, not bash input

## For Future Sessions

When you hear this pattern from Nat:
1. **Recognize the signal** — frustration at repeated error
2. **Stop current approach** — it's not working
3. **Fix root cause** — not another workaround
4. **Don't explain** — just fix

---

*This is important because repeated errors waste time and energy.*
*Recognizing the signal prevents frustration cycles.*

---

*Logged via /fyi --important*
