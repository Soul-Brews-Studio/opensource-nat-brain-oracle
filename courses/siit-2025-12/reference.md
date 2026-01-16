# SIIT Workshop Reference: Teaching Content & Patterns

**Workshop**: SIIT Agentic AI (Dec 2025)
**Source**: 48 retrospectives analyzed (Sept 9 - Dec 12, 2025)

---

## Quick Reference: 8 Teaching Topics

| Rank | Topic | Time | Key Insight |
|------|-------|------|-------------|
| 1 | Pattern Recognition Over Intention | 1.5h | "Behavior reveals priority" |
| 2 | Deadline-Driven Mode Recognition | 1.5h | "Speed kills verification" |
| 3 | Parallel Agent Decomposition | 1.5h | "5 agents = 3x faster" |
| 4 | Subagent Context Boundaries | 1h | "Don't assume inheritance" |
| 5 | Knowledge Distillation Loop | 1.5h | "Ephemeral→Permanent" |
| 6 | Voice-to-Text Verification | 1h | "STT needs confirmation" |
| 7 | Plugin/Skill Architecture | 1h | "When to use what" |
| 8 | Collaboration Under Pressure | 1.5h | "Options>Completeness" |

---

## 11 Golden Learnings

| # | Core Rule | Application |
|---|-----------|-------------|
| 001 | "Delegate reading to subagent" | Token efficiency |
| 002 | "Context-finder first (before Read)" | Token efficiency |
| 003 | "STT creates ambiguity layer" | Verification protocol |
| 004 | "Human confirms; never auto-commit" | Safety guardrails |
| 005 | "wc -l before loading" | Performance |
| 006 | "Single source of truth for concepts" | Architecture |
| 007 | "Distillation loop matures knowledge" | Systems thinking |
| 009 | "Subagents don't inherit context" | Delegation patterns |
| 010 | "Hide implementation details" | API design |
| 011 | "Thai font licensing matters" | Localization |

---

## 4 Case Studies

### 1. The Verification Tax
- **Scenario**: Used unverified data in pitch deck under deadline
- **Teaching**: Patterns don't carry forward under urgency; make verification automatic

### 2. The Options Pattern
- **Discovery**: User wants options to refine, not perfect draft first
- **Teaching**: Collaborate by offering choices, not completeness

### 3. The Silent Hook Conflict
- **Finding**: Hook conflicts cause diary silence (no recordings)
- **Teaching**: Silence is data; absence is information

### 4. Multi-AI File Orchestration
- **Pattern**: Orchestrate multiple AIs via shared file prompts
- **Teaching**: Files as contracts between systems

---

## 5 Anti-Patterns

1. **Assumption Escalation** — Speed increases assumption rate; verify under deadline
2. **Context Leakage** — Subagents inherit less than you think; be explicit
3. **Silence as Noise** — Hook conflicts create data voids
4. **Lesson Forgetting** — Learning patterns don't persist under pressure; automate
5. **Perfect-First Fallacy** — Humans prefer options over completeness

---

## Workshop Scaling

| Duration | Content |
|----------|---------|
| 4h | Pattern Recognition + Hands-on Lab |
| 8h | 4 core modules + Lab |
| 16h (2-day) | All 5 modules + Oracle deep-dive + Plugin design |

---

## Facilitator Notes

### Key Metaphors
- **External Brain**: AI extends, not replaces human thinking
- **Oracle Philosophy**: Nothing deleted, timestamps = truth
- **Signal vs Noise**: Structure determines what you hear
- **Distillation Loop**: Knowledge matures from raw → wisdom

### Interactive Elements
- Live git log analysis
- Breakout: Find duplicate patterns
- Real-time retrospective writing
- Plugin design sprint

---

*Extracted from 48 retrospectives | Last updated: 2025-12-12*
