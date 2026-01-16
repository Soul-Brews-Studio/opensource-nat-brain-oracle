---
title: Knowledge Distillation Loop - The Project Soul
created: 2025-12-10
source: /distill command - understanding project roots and iteration pattern
tags:
  - oracle-philosophy
  - distillation
  - iteration
  - knowledge-flow
  - claude-md
aliases:
  - distillation loop
  - three layer architecture
  - project soul
---

# Knowledge Distillation Loop - The Project Soul

## Context Links

- **Commits**: `c417c52` (modular CLAUDE), `6be2269` (psi-context tracking)
- **Source Retrospectives**:
  - [[18.57_cellar-and-psi-adoption|Cellar and Psi Adoption]] - Psi pattern foundation
  - [[21.16_context-overload-honest-feedback|Context Overload - Honest Feedback]] - Documentation loop insight
- **Related Learnings**:
  - [[004-human-confirmation-loop|Human Confirmation Loop]] - Core pattern used in distillation
  - [[006-plugin-system-architecture|Plugin System Architecture]] - Psi folder structure
  - [[000-naming-philosophy|Naming Philosophy]] - Naming conventions

---

## Key Insight

> **Knowledge flows through 3 layers (retrospectives → logs → learnings), each iteration distilling noise into signal, with CLAUDE.md as the final crystallization of wisdom.**

---

## The Three-Layer Architecture

```
┌─────────────────────────────────────────────────┐
│  Layer 1: RETROSPECTIVES (Exhaustive)          │
│  ψ-retrospectives/YYYY-MM/DD/HH.MM_slug.md    │
│  Trigger: rrr | Size: 20-50KB | Full narrative │
└────────────────────┬────────────────────────────┘
                     │ Extract patterns
                     ↓
┌─────────────────────────────────────────────────┐
│  Layer 2: LOGS (Snapshots)                      │
│  ψ-logs/YYYY-MM/DD_HH.MM_slug.md              │
│  Trigger: /snapshot | Size: 3-5KB | Quick      │
└────────────────────┬────────────────────────────┘
                     │ Identify reusable
                     ↓
┌─────────────────────────────────────────────────┐
│  Layer 3: LEARNINGS (Distilled)                 │
│  ψ-learnings/NNN-topic-name.md                 │
│  Trigger: /distill | Size: 1-2KB | Reusable    │
└────────────────────┬────────────────────────────┘
                     │ Crystallize
                     ↓
┌─────────────────────────────────────────────────┐
│  CLAUDE.md (Final Crystallization)              │
│  The accumulated wisdom of all iterations       │
│  Main agent can refine many times               │
└─────────────────────────────────────────────────┘
```

---

## The Problem

| What We Tried | What Happened |
|---------------|---------------|
| Single CLAUDE.md with everything | Became bloated, hard to navigate |
| No distillation process | Knowledge scattered, not reusable |
| AI commits without confirmation | Silent changes, quality drift |

---

## The Solution

### Pattern: Iterative Distillation Loop

```
SESSION → /rrr (human confirm) → /snapshot → /distill (human confirm) → CLAUDE.md update
                    ↑                                                          │
                    └──────────────────────────────────────────────────────────┘
                                        (many iterations)
```

**When to use**: After significant learning, before major commits
**Why it works**: Each layer removes noise, extracts signal, human stays in control

### The Human Confirmation Loop

```
สร้าง [artifact] แล้ว: [filepath]

**สรุปสั้นๆ:**
- Key insight
- Apply when

**ถามก่อน commit:**
- โอเคแบบนี้ไหม?
- ขาดอะไรไหม?

พร้อม commit หรือจะแก้ไขก่อน?
```

---

## Project Roots Relationship

```
.tmp/weyermann-malt-productpage/  ← SOURCE TEMPLATE
        │                            (modular 6-file pattern)
        │
        ↓ adopted by
Nat's Agents/CLAUDE.md            ← CURRENT PROJECT
        │                            (modular + Oracle Philosophy)
        │
        ↓ extracted to
.tmp/oracle-starter-kit/          ← MINIMAL TEMPLATE
                                     (philosophy-first for sharing)
```

---

## Oracle Philosophy Integration

The distillation loop embodies Oracle's 3 pillars:

| Pillar | Implementation |
|--------|----------------|
| **Nothing is Deleted** | All layers preserved in git |
| **Patterns Over Intentions** | Extract what happened, not planned |
| **External Brain** | AI holds knowledge, human decides |

---

## Anti-Patterns

| Don't Do This | Do This Instead |
|---------------|-----------------|
| Skip human confirmation | Always "ถามก่อน commit" |
| Update CLAUDE.md directly | Distill through layers first |
| One massive retrospective | Small snapshots → learnings |
| Copy template blindly | Adapt to project context |

---

## Summary

| Concept | Details |
|---------|---------|
| Layers | 3 (retrospectives → logs → learnings) |
| Final output | CLAUDE.md (lean hub) |
| Human control | Confirmation at each layer |
| Iteration | Main agent can refine many times |
| Philosophy | Oracle: "Keep the Human Human" |

---

## Apply When

- Setting up new project documentation
- After significant session with new learnings
- When CLAUDE.md feels outdated
- Before sharing project template
- During /distill command execution

---

## See Also

- [[001-delegate-reading|Delegate Reading]] - Token efficiency in distillation
- [[003-speech-to-text-uncertainty|Speech to Text Uncertainty]] - Quality gates in knowledge capture
- [[005-file-size-check-before-read|File Size Check]] - Efficiency patterns
- [[2025-12-10_nat-priorities-from-frequency|Nat Priorities from Frequency]] - Oracle philosophy implementation
