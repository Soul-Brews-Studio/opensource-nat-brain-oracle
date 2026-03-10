# Soul-Init: Full vs Minimal Pattern

**Date**: 2025-12-23
**Context**: Workshop repo ไม่ต้องการ full ψ/ structure

## The Problem

`/soul-init` creates 15+ folders:
```
ψ/
├── active/      ← rarely used
├── inbox/       ← complex, needs focus.md
├── writing/     ← repo might have own slides/
├── lab/         ← rarely used
├── incubate/    ← only for main workspace
├── learn/       ← only for main workspace
└── memory/      ← THIS is what matters
    ├── resonance/     ← rarely used
    ├── learnings/     ← ✅ useful
    ├── retrospectives/← ✅ useful
    └── logs/          ← rarely used
```

Most repos only need `memory/`.

## Solution: Two Commands

| Command | Creates | Use for |
|---------|---------|---------|
| `/soul-init` | Full 5-pillar + Obsidian | Main workspace (Nat-s-Agents) |
| `/soul-lite` | Just memory/ | Workshop, library, simple repos |

### Minimal Structure
```
ψ/
├── HOME.md
├── WIP.md
└── memory/
    ├── retrospectives/
    └── learnings/
```

5 items instead of 15+.

## When to Use

- **soul-init**: Main brain repo, needs incubate/learn symlinks
- **soul-lite**: Standalone project, just needs history

## Key Insight

> "Not everything needs full complexity"

A workshop repo doesn't need incubate/learn symlinks.
It just needs to remember what happened (retrospectives) and what was learned (learnings).

---

**Tags**: #soul #psi #minimal #pattern
