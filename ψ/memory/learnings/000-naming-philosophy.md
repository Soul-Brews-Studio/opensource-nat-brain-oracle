---
title: Naming Philosophy
created: 2025-12-09
severity: HIGH
source: Adopted from Weyermann ψ-learnings/004-psi-naming.md
tags:
  - meta
  - naming
  - philosophy
  - structure
aliases:
  - naming convention
  - file naming
---

# Naming Philosophy

**Created**: 2025-12-09
**Severity**: HIGH
**Source**: Adopted from Weyermann ψ-learnings/004-psi-naming.md

## Key Insight

> Naming matters. A good name transforms a technical decision into something memorable and meaningful.

## The Philosophy

### Knowledge Hierarchy

```
Retrospectives (20-50KB)  →  Logs (3-5KB)  →  Learnings (1-2KB)
       ↓                         ↓                  ↓
   exhaustive               summaries           distilled
   "what happened"         "what matters"      "what to remember"
```

Each layer serves a purpose. Don't skip levels.

### Folder = Scope, Filename = Identity

```
retrospectives/2025-12/09/18.19_cellar-flutter-scaffold.md
       ↓          ↓     ↓              ↓
    domain    year-mo  day    time + identity
```

- **Domain folder**: What kind of knowledge (retrospectives, logs, learnings)
- **Date folders**: When it happened (enables "what happened on day X?")
- **Filename**: Time + descriptive slug (scannable without opening)

### Descriptive > Cryptic

```
✅ 18.19_cellar-flutter-scaffold.md
❌ 18.19.md
❌ retro-5.md
```

The filename should tell a story.

### Numbered = Critical

```
learnings/
├── 000-naming-philosophy.md   ← meta
├── 001-delegate-reading.md    ← critical incident
├── 002-context-finder-first.md
└── general-pattern.md         ← unnumbered = general
```

Numbers indicate sequence and importance. Use sparingly.

## Why Not ψ Prefix?

Weyermann uses `ψ-` (psi) for "psyche" — the mind/soul of the project.

We chose **not** to adopt ψ because:
1. Simpler folder names are easier to type
2. Our structure is already semantic (learnings/, logs/, retrospectives/)
3. Focus on content patterns, not naming conventions

We adopted the **structure** and **philosophy**, not the prefix.

## Patterns Adopted from Weyermann

| Pattern | Our Implementation |
|---------|-------------------|
| Day as folder | `retrospectives/YYYY-MM/DD/` |
| HH.MM timestamps | `HH.MM_descriptive-slug.md` |
| Numbered learnings | `001-topic.md` for critical |
| README in each folder | Explains format |
| Knowledge hierarchy | Retro → Log → Learning |

## Apply When

- Creating any new knowledge folder
- Naming any documentation file
- Deciding between numbered vs unnumbered
- Questioning "should I add more structure?"

## The Golden Rule

> Good structure comes from solving real problems, not from theory.

Don't over-engineer. Add structure when pain demands it.

---

## See Also

### Related Learnings
- [[memory/learnings/006-plugin-system-architecture|006: Plugin System Architecture]] - Psi folder structure implementation
- [[memory/learnings/007-knowledge-distillation-loop|007: Knowledge Distillation Loop]] - How layers use this naming

### Core Philosophy
- [[memory/resonance/oracle|Oracle Philosophy]] - "Nothing is Deleted" principle

### Navigation
- [[HOME|Back to HOME]]
- [[memory/learnings|All Learnings]]
