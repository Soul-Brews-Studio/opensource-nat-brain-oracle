---
title: Learnings Index
tags: [moc, learnings, index]
created: 2025-12-10
aliases:
  - learnings
  - all learnings
---

# memory/learnings/

> **Location**: `ψ/memory/learnings/`
> **Git**: Tracked
> **Lifecycle**: Permanent

Distilled wisdom from sessions. The **soul** of what we've learned.

## Philosophy

> Knowledge flows: [[memory/logs|logs]] → [[memory/retrospectives|retrospectives]] → **[[memory/learnings|learnings]]** → [[memory/resonance|resonance]]

Learnings are the most refined layer — reusable patterns extracted from experience.

## Current Learnings (2025-12-11)

| # | Title | Topic | Key Insight |
|---|-------|-------|-------------|
| [[memory/learnings/007-knowledge-distillation-loop\|007]] | Knowledge Distillation Loop | Philosophy | Knowledge flows through 3 layers; CLAUDE.md is final crystallization |
| [[memory/learnings/006-plugin-system-architecture\|006]] | Plugin System Architecture | Technical | Claude Code uses auto-discovery; hooks must be in `hooks/hooks.json` folder |
| [[memory/learnings/005-file-size-check-before-read\|005]] | File Size Check Before Read | Pattern | Check file size before reading large files to avoid token waste |
| [[memory/learnings/004-human-confirmation-loop\|004]] | Human Confirmation Loop | Process | Ask user confirmation before destructive operations |
| [[memory/learnings/003-speech-to-text-uncertainty\|003]] | Speech-to-Text Uncertainty | UX | S2T may mishear; always show back what you understood |
| [[memory/learnings/002-context-finder-first\|002]] | Context-Finder First | Workflow | Run context-finder before other agents to set stage |
| [[memory/learnings/001-delegate-reading\|001]] | Delegate Reading | Efficiency | Use subagents (Haiku) to read files, main agent (Opus) to decide |
| [[memory/learnings/000-naming-philosophy\|000]] | Naming Philosophy | Meta | Names are structure; ψ prefix shows consciousness tier |

### Additional Learnings

| File | Topic | Key Insight |
|------|-------|-------------|
| [[memory/learnings/2025-12-10_nat-priorities-from-frequency\|Nat Priorities]] | Personality | Frequency = importance; what Nat mentions often is what matters |

## Naming Convention

```
memory/learnings/
├── 000-naming-philosophy.md    ← meta: why we name things
├── 001-delegate-reading.md     ← numbered: critical incidents
├── 002-context-finder-first.md ← episodes from debugging
├── 003-speech-to-text-uncertainty.md
├── 004-human-confirmation-loop.md
├── 005-file-size-check-before-read.md
├── 006-plugin-system-architecture.md
├── 007-knowledge-distillation-loop.md
└── pattern-name.md             ← unnumbered: general patterns
```

**Numbered (000-, 001-)**: Critical learnings from debugging sessions or breakthroughs
**Unnumbered**: General patterns and best practices (future)

## Today's Learning (2025-12-10)

### 006: Plugin System Architecture

**Core Discoveries**:
1. **Auto-discovery**: Claude Code doesn't need explicit paths in plugin.json
   - `commands/` folder → auto-discovered
   - `hooks/hooks.json` (MUST be in hooks/ subfolder, not root)
   - `agents/` folder → auto-discovered

2. **Hooks format must be root-level**:
   ```json
   {
     "SessionStart": [...]   // ✓ Correct
   }
   ```
   NOT:
   ```json
   {
     "hooks": {
       "SessionStart": [...]  // ✗ Wrong
     }
   }
   ```

3. **ψ Convention**: New consciousness-tier folder structure
   - `ψ-learnings/` — Learning capture (Tier 1)
   - `ψ-context/` — Timestamped knowledge base (Tier 2)
   - `ψ-logs/` — Session logs (Tier 3)
   - `ψ-retrospectives/` — Synthesis analysis (Tier 4)

4. **Subagent parallelism**: Send multiple tool calls in ONE message, not sequential

See `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-learnings/006-plugin-system-architecture.md` for full details.

## Template

```markdown
# [Topic Title]

**Created**: YYYY-MM-DD
**Severity**: [HIGH | MEDIUM | LOW]
**Source**: [What triggered this learning]

## Key Insight
> One sentence summary

## The Problem
What went wrong or what we discovered

## The Solution
Pattern or approach that works

## Apply When
- Trigger condition 1
- Trigger condition 2
```

## Related Folders

- [[memory/logs|logs/]] — Raw session snapshots (YYYY-MM-DD-HH:MM format)
- [[memory/retrospectives|retrospectives/]] — Detailed session analysis (by date/time)
- [[memory/resonance|resonance/]] — Core identity and philosophy

## Related Commands

- `/distill` — Create new learning from session
- `/rrr` — Generate session retrospective (uses subagent workflow)
- `/recap` — Context finder with scoring

## Navigation

- [[HOME|Back to HOME]]
- [[memory/seeds/INDEX|Seeds Index]] - Ideas waiting to grow
- [[memory/resonance/oracle|Oracle Philosophy]] - Guiding principles

