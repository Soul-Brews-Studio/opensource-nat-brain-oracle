---
title: **Multiple ψ directories - needs architecture decision**
tags: [architecture, decision-needed, psi-structure, knowledge-organization, project-context]
created: 2026-01-03
source: Architecture discussion - 2026-01-03
---

# **Multiple ψ directories - needs architecture decision**

**Multiple ψ directories - needs architecture decision**

Oracle v2 currently has two ψ/memory locations:

1. **oracle-v2/ψ/memory/** - Local project notes (small)
2. **Nat-s-Agents/ψ/memory/** - Main knowledge base (424+ files, indexed)

**Current behavior:**
- Indexer reads from Nat-s-Agents (via ORACLE_REPO_ROOT)
- oracle_learn writes to Nat-s-Agents
- oracle-v2/ψ is orphaned/unused by the system

**Options to consider:**
1. Keep separate (project notes vs global wisdom)
2. Symlink oracle-v2/ψ → Nat-s-Agents/ψ
3. Move and consolidate into single location
4. Per-project ψ that aggregates into global

**Questions:**
- Should each project have its own ψ?
- How do project-specific learnings relate to global Oracle wisdom?
- Should oracle_learn support writing to current project's ψ?

This affects the "project context" feature (Issue #8) - Oracle knowing which repo it's in.

---
*Added via Oracle Learn*
