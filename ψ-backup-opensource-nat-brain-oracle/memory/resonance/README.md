# Resonance

> สิ่งที่ AI กลั่นกรองจาก conversation แล้วทั้งคู่เห็นตรงกัน

## Definition

| | |
|---|---|
| **What** | Patterns ที่ AI กลั่นกรองจาก conversation |
| **Who** | AI สรุป → ใส่เลย (ไม่ต้องรอ confirm) |
| **When** | `/distill` หรือตอน recognize pattern |

## Purpose

Resonance captures shared understanding:
- Philosophy and values (ที่ทั้งคู่เห็นตรงกัน)
- Communication style
- Behavioral patterns
- Core priorities

## Contents

| File | Purpose |
|------|---------|
| `oracle.md` | Oracle/Shadow philosophy |
| `style.md` | Writing voice, language preferences |
| `patterns.md` | Behavioral patterns, priorities |

## Flow

```
conversation → AI เห็น pattern → /distill → resonance/
```

**Not resonance**:
- Random chit-chat → `noise/`
- Session summary → `retrospectives/`
- Single observation → `learnings/`

## Refinement Level

```
resonance/       ← ★★★★★ Most refined (mutual agreement)
learnings/       ← ★★★★☆ High (patterns)
retrospectives/  ← ★★★☆☆ Medium (sessions)
logs/            ← ★★☆☆☆ Low (snapshots)
reference/       ← ☆☆☆☆☆ External (not from self)
```

## Source

Distilled from learnings, retrospectives, and direct observation.

```
logs → retrospectives → learnings → resonance
(raw)    (session)      (pattern)    (soul)
```

---

*Part of ψ/memory/ - the knowledge base*
