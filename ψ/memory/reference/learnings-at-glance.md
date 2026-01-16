---
title: Learnings at a Glance
created: 2025-12-12
tags: [index, quick-reference, learnings, workshop]
---

# Learnings at a Glance

Quick lookup for all 11 learnings + key insights

---

## All Learnings Ranked by Teaching Priority

### TIER 1: Foundation (Teach First - Essential)

| # | Title | Core Message | Use Case |
|---|-------|--------------|----------|
| 001 | Delegate Reading | Use Haiku for data, Opus for decisions | Token efficiency |
| 002 | Context-Finder FIRST | Make delegation your default reflex | Workflow habit |
| 004 | Human Confirmation | Create → Show → Ask → Commit | Quality gates |
| 005 | File Size Check | wc -l before you read | Token budgeting |

**Total Teaching Time**: 80 minutes
**Key Takeaway**: Subagent workflow = foundation of agentic systems

---

### TIER 2: Architecture (Teach Second - Structural)

| # | Title | Core Message | Use Case |
|---|-------|--------------|----------|
| 000 | Naming Philosophy | Names are structure, structure is communication | Project design |
| 006 | Plugin System | Auto-discovery > explicit paths | Framework design |
| 007 | Knowledge Distillation | Retrospective → Log → Learning → CLAUDE.md | Knowledge management |
| 008 | Active Context | Keep ephemeral spaces empty | Focus management |

**Total Teaching Time**: 95 minutes
**Key Takeaway**: Good architecture emerges from solving real problems

---

### TIER 3: Polish (Teach Third - Nuance)

| # | Title | Core Message | Use Case |
|---|-------|--------------|----------|
| 003 | S2T Uncertainty | Balance confirmation with speed | UX with speech input |
| 009 | Subagent Limits | Delegation has constraints | Tool selection |
| 010 | Hide Details | Wrap ugly code in clean interfaces | UX/presentation |
| 011 | Font Licensing | Check licenses before shipping | Compliance |

**Total Teaching Time**: 70 minutes
**Key Takeaway**: Excellence lives in the details

---

## Learning Files Location

All files in: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/learnings/`

| File | Words | Focus | Created |
|------|-------|-------|---------|
| 000-naming-philosophy.md | 620 | Meta | Dec 9 |
| 001-delegate-reading.md | 390 | Efficiency | Dec 9 |
| 002-context-finder-first.md | 410 | Workflow | Dec 9 |
| 003-speech-to-text-uncertainty.md | 360 | UX | Dec 9 |
| 004-human-confirmation-loop.md | 420 | Process | Dec 9 |
| 005-file-size-check-before-read.md | 380 | Pattern | Dec 9 |
| 006-plugin-system-architecture.md | 3620 | Technical | Dec 10 |
| 007-knowledge-distillation-loop.md | 1340 | Philosophy | Dec 10 |
| 008-active-context-design.md | 290 | Structure | Dec 11 |
| 009-subagent-context-limitation.md | 310 | Constraint | Dec 11 |
| 010-hide-implementation-details.md | 290 | UX | Dec 11 |
| 011-thai-font-licensing.md | 350 | Compliance | Dec 11 |

**Total**: 9,360 words (9.3K words of distilled wisdom)

---

## Cross-Cutting Patterns

### Pattern Recognition Across Learnings

**Pattern 1: Size-Based Decision Making**
- Appears in: 001, 002, 005, 008
- Core: "Small overhead in checking → big payoff in efficiency"

**Pattern 2: The Confirmation Loop**
- Appears in: 004, 007
- Core: "Create → Show → Ask → Approve"

**Pattern 3: Delegation Hierarchy**
- Appears in: 001, 002, 005, 009
- Core: "Choose right agent for right task"

**Pattern 4: Oracle Philosophy Implementation**
- Appears in: 000, 007, 008, 010
- Core: "Nothing is Deleted, Patterns Over Intentions"

---

## One-Sentence Summaries

1. **Delegate Reading**: "Cheap agents gather, expensive agents decide"
2. **Context-Finder First**: "Search before you read"
3. **S2T Uncertainty**: "Confirm high-risk, assume low-risk"
4. **Confirmation Loop**: "Show, ask, then commit"
5. **File Size Check**: "Five-second check saves two minutes"
6. **Naming Philosophy**: "Names carry meaning and structure"
7. **Distillation Loop**: "Each layer removes noise"
8. **Active Context**: "Ephemeral means delete-able"
9. **Subagent Limits**: "Data gathering ≠ output writing"
10. **Hide Details**: "Ugly command → clean wrapper"
11. **Font Licensing**: "Check before you ship"

---

## Teaching Flow (3-Session Workshop)

### Before Workshop
- Skim all 11 learning files (30 min)
- Pick teaching examples that resonate
- Prepare exercises based on TIER 1

### Session 1: Foundations (2.5h)
- Delegate Reading (001)
- File Size Check (005)
- Context-Finder First (002)
- Human Confirmation (004)
- **Exercise**: Build simple context-finder workflow

### Session 2: Architecture (2.5h)
- Naming Philosophy (000)
- Knowledge Distillation (007)
- Plugin System (006)
- Active Context Design (008)
- **Exercise**: Design project knowledge structure

### Session 3: Integration (2h)
- Subagent Limits (009)
- Hide Details (010)
- S2T Uncertainty (003)
- **Capstone**: Build multi-agent agentic system

---

## Most Teachable Moments

**Token Economics** (captures engineers immediately):
- 348 lines → 500 Opus tokens wasted
- vs 50 Haiku tokens if delegated
- = 10x cost savings

**The "Aha!" Moments**:
- Confirmation loop prevents silent failures
- Active context should be empty
- Subagents can't know full context
- File size check = programmatic decision

**The Anti-Patterns**:
- Reading when you should delegate
- Confirming every message (wastes time)
- Accumulating in active/context/
- Expecting subagent to write final output

---

## Resources for Instructors

**Primary Sources**:
- Learnings files themselves (in ψ/memory/learnings/)
- Retrospectives that sourced each learning (in ψ/memory/retrospectives/)
- CLAUDE.md (project wisdom extracted from learnings)

**Secondary Sources**:
- CLAUDE_safety.md (safety rules from learnings)
- CLAUDE_workflows.md (workflows from learnings)
- CLAUDE_lessons.md (anti-patterns from learnings)

**Live Examples**:
- Show actual commits mentioned in each learning
- Reference real retrospectives for context
- Use actual file sizes/costs from DustBoy example

---

## Success Metrics for Workshop

**Participants understand**:
- [ ] When to delegate vs. read directly
- [ ] How to check file sizes before reading
- [ ] What confirmation loop prevents
- [ ] Why knowledge has layers
- [ ] How plugins auto-discover
- [ ] When to confirm vs. trust

**Participants can build**:
- [ ] Subagent workflow for their project
- [ ] Knowledge architecture for their project
- [ ] Plugin with auto-discovered components
- [ ] Confirmation loop in their code

**Participants adopt**:
- [ ] Delegation habit (use context-finder first)
- [ ] Size-checking habit (wc -l before read)
- [ ] Confirmation habit (show before commit)
- [ ] Layer-based thinking (retrospective → learning)

---

## Document Map

```
ψ/memory/
├── learnings/               ← Source files (11 learnings)
├── reference/
│   ├── workshop-teaching-content.md   ← Detailed curriculum
│   ├── learnings-at-glance.md         ← This file
│   └── ...
├── retrospectives/          ← Sessions that created learnings
├── logs/                    ← Quick snapshots
└── resonance/
    └── oracle.md            ← Philosophy foundation
```

---

*Created: 2025-12-12*
*Source: 11 distilled learnings*
*Update Frequency: Add new learnings as they emerge*
