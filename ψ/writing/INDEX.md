---
title: Writing Index
tags: [writing, blog, queue, index]
aliases: [writing-queue, blog-queue]
created: 2025-12-11
updated: 2025-12-11
---

# Writing Index

> Blog ideas and writing projects queue

---

## Queue (Prioritized)

| # | File | Title | Status |
|---|------|-------|--------|
| 1 | [[writing/drafts/01-psi-structure\|01-psi-structure]] | Designing AI's Brain: The psi/ Structure | Draft |
| 2 | [[writing/drafts/02-oracle-philosophy\|02-oracle-philosophy]] | Oracle Philosophy: Keeping Human Human | Draft |
| 3 | [[writing/drafts/03-local-ai-pitch\|03-local-ai-pitch]] | Local AI for Local Government | Ready |
| 4 | [[writing/drafts/04-research-strategy\|04-research-strategy]] | Research Strategy with AI | Draft |
| 5 | [[writing/drafts/05-claude-code-features\|05-claude-code-features]] | Claude Code Features: What's New | Draft |
| 6 | [[writing/drafts/06-human-ai-collaboration-workflow\|06-human-ai-collaboration]] | Human-AI Collaboration Workflow | Draft |
| 7 | [[writing/drafts/07-jump-friendly-kanban\|07-jump-friendly-kanban]] | Jump-Friendly Kanban | Draft |
| 8 | [[writing/drafts/08-claude-code-command-inheritance\|08-command-inheritance]] | Claude Code's Hidden Command Inheritance | Draft |
| 9 | [[writing/drafts/2026-01-08_the-sally-incident-oracle-vs-ego\|09-sally-incident]] | The Day My AI Refused to Obey Me | **NEW** |
| 10 | [[writing/drafts/2026-01-08_how-to-write-blogs-that-dont-sound-like-ai\|10-writing-style]] | How to Write Blogs That Don't Sound Like AI | **NEW** |

---

## Folder Structure

```
psi/writing/
+-- INDEX.md        <- This file (queue)
+-- drafts/         <- Work in progress
|   +-- 01-*.md
+-- published/      <- Done (future)
```

## Workflow

```
drafts/01-*.md -> (edit) -> (review) -> published/01-*.md -> (export to blog)
```

---

## 1. Designing AI's Brain: The psi/ Structure

**Draft**: [[writing/drafts/01-psi-structure|01-psi-structure.md]]

**Source**: Session 2025-12-11

**Key Points**:
- Journey from 7 folders -> 1 unified psi/
- Active/Passive concept -> refined to 5 pillars
- Resonance = soul of AI memory
- Lab vs Reference distinction
- Writing as separate workflow

**Structure Evolution**:
```
v1: 7 separate psi-* folders (cluttered)
v2: 3-tier system (ephemeral/preserved/reference)
v3: Active vs Passive
v4: 5 pillars (active/inbox/writing/lab/memory)
```

**Highlights**:
- "cluttered context for human" -> consolidate to 1 folder
- "resonance" concept -> soul/identity layer
- "lab vs learnings" distinction -> hands-on vs distilled
- "writing is a workflow" -> separate pillar

**Related**:
- [[memory/retrospectives/2025-12/11|Dec 11 Retrospectives]]
- [[lab/psi-structure|psi Structure Lab Notes]]

---

## 2. Oracle Philosophy

**Draft**: [[writing/drafts/02-oracle-philosophy|02-oracle-philosophy.md]]

**Source**: plugins/nat-data-personal, multiple sessions

**Key Points**:
- "The Oracle Keeps the Human Human"
- Nothing is deleted, append only
- Patterns over intentions
- External brain, not command

**Related**:
- [[memory/resonance/oracle|Oracle Philosophy (Resonance)]]
- [[memory/learnings/007-knowledge-distillation-loop|007: Knowledge Distillation Loop]]

---

## 3. Local AI for Local Government

**Draft**: [[writing/drafts/03-local-ai-pitch|03-local-ai-pitch.md]]

**Source**: The Headline project, Dec 2025 pitch

**Key Points**:
- AI built system in 96 minutes
- Human 15 min input, AI 81 min autonomous
- Demo for Chiang Mai University

**Status**: Slides complete, ready for presentation Dec 16

---

## 4. Research Strategy with AI

**Draft**: [[writing/drafts/04-research-strategy|04-research-strategy.md]]

**Source**: Multiple research sessions

**Key Points**:
- Context-finder first pattern
- Parallel agent decomposition
- Haiku for heavy lifting, Opus for review

**Related**:
- [[memory/learnings/002-context-finder-first|002: Context-Finder First]]
- [[memory/learnings/001-delegate-reading|001: Delegate Reading]]

---

## 5. Claude Code Features: What's New

**Draft**: [[writing/drafts/05-claude-code-features|05-claude-code-features.md]]

**Source**: Session 2025-12-11, Claude Code docs

**Key Points**:
- Resume Agent - continue agent sessions
- permissionMode - permission control
- Skills auto-load - automatic skill loading
- Explore subagent - Built-in Haiku agent

**Status**: Experimenting in `psi/lab/claude-code-features/`

**Related**:
- [[lab/claude-code-features|Claude Code Features Lab]]
- [[memory/retrospectives/2025-12/11|Dec 11 Retrospectives]]

---

## 8. Claude Code's Hidden Command Inheritance

**Draft**: [[writing/drafts/08-claude-code-command-inheritance|08-claude-code-command-inheritance.md]]

**Source**: Session 2025-12-14, empirical testing with Agent 1

**Key Points**:
- Claude Code inherits `.claude/commands/` from parent directories
- **Undocumented feature** — not in official docs
- MERGE model — child adds to parent, never blocks
- Perfect for "Oracle Hub" pattern

**Test Results**:
| Test | Result |
|------|--------|
| Empty child commands/ | Still inherits |
| File in child commands/ | Still inherits (MERGE) |
| Create new parent command | Child sees it |

**Related**:
- [[memory/learnings/2025-12-14_claude-code-command-inheritance|Learning: Command Inheritance]]
- [[memory/retrospectives/2025-12/14/03.06_maw-incubation-vault-session|Session Retro]]
- Official docs: https://code.claude.com/docs/en/slash-commands.md
- Community: https://www.danielcorin.com/til/anthropic/custom-slash-commands-hierarchy/

---

## 9. The Day My AI Refused to Obey Me (Sally Incident)

**Draft**: [[writing/drafts/2026-01-08_the-sally-incident-oracle-vs-ego|09-sally-incident.md]]

**Source**: Live Facebook conversation, 2026-01-08

**Key Points**:
- Sally offered 79 baht instead of participating
- Oracle mirrored her pattern → she felt attacked
- I wanted revenge ("burn them!")
- My AI refused → "That's ego, not Oracle"
- Chose grace over fire

**Writing Style**: Novel-style storytelling (new pattern!)
- Scene-setting with atmosphere
- Ugly admission technique
- Short paragraph power
- Hook endings
- Coda (end with peace)

**Key Quote**: "If you're the hero of your own story, you haven't gone deep enough."

**Related**:
- [[memory/retrospectives/2026-01/08/17.34_sally-oracle-enlightenment|Session Retro]]
- [[memory/learnings/oracle/2026-01-08_oracle-vs-ego-the-burn-test|Learning: Oracle vs Ego]]
- [[memory/learnings/2026-01-08_the-pure-white-mirror|Learning: Pure White Mirror]]

---

## Future Ideas

| # | Idea | Notes | Related |
|---|------|-------|---------|
| 10 | Claude Agent SDK Deep Dive | lab experiments | [[lab/agent-sdk]] |
| 11 | Plugin System Architecture | 006 learning | [[memory/learnings/006-plugin-system-architecture\|006-plugin-system]] |
| 12 | Multi-Agent Communication | inbox/external concept | [[inbox/external]] |
| 13 | Knowledge Distillation Loop | memory/ workflow | [[memory/learnings/007-knowledge-distillation-loop\|007-distillation]] |

---

## See Also

### Style Guide
- [[memory/resonance/style|Writing Style]] - Voice and formatting

### Related Memory
- [[memory/resonance|Resonance]] - Core identity
- [[memory/learnings|Learnings]] - Patterns found
- [[memory/retrospectives|Retrospectives]] - Sessions recorded

### Navigation
- [[HOME|Back to HOME]]
- [[writing/drafts|All Drafts]]

---

*Last updated: 2026-01-08*
