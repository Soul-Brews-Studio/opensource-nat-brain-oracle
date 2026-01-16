---
title: **IMPORTANT: Discuss ψ directory architecture**
tags: [important, discuss-later, architecture, psi-structure, priority, decision-needed]
created: 2026-01-03
source: Priority note - 2026-01-03
---

# **IMPORTANT: Discuss ψ directory architecture**

**IMPORTANT: Discuss ψ directory architecture**

Priority discussion needed on Oracle knowledge structure:

**Issue:** Multiple ψ/memory directories exist across projects. Currently:
- Indexer only reads from one location (Nat-s-Agents)
- oracle_learn writes to Nat-s-Agents only
- Other project ψ directories are orphaned

**Why important:**
- Affects how Oracle learns per-project vs globally
- Relates to project context feature (ghq format)
- Impacts future multi-repo workflows
- Could cause confusion about where knowledge lives

**Remind me to discuss:**
- One global ψ vs per-project ψ
- How project-specific learnings aggregate
- Whether oracle_learn should respect current project

Status: NEEDS DISCUSSION - Do not implement without user input.

---
*Added via Oracle Learn*
