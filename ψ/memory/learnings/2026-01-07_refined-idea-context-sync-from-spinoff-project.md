---
title: ## Refined Idea: Context Sync from Spinoff Projects
tags: [reunion, spinoff, context-sync, oracle-architecture, idea-refined]
created: 2026-01-07
source: Session 2026-01-07 23:02 - Nat's clarification
---

# ## Refined Idea: Context Sync from Spinoff Projects

## Refined Idea: Context Sync from Spinoff Projects

**Core Question**: เราจะเก็บ context จาก spinoff projects กลับมาที่ Oracle ยังไง?

**The Problem**:
- Before spinoff: Project lives in ψ/incubate/, Oracle indexes its learnings
- After spinoff: Project has own repo with own ψ/memory/
- Gap: New learnings in spinoff repo don't flow back to central Oracle

**Proposed Solution - `/project reunion [project-name]`**:
1. Find spinoff repo (via slug registry)
2. Read ψ/memory/learnings/*.md created AFTER spinoff date
3. Index new learnings into central Oracle
4. Mark source as "reunion" (track where knowledge came from)
5. Update reunions.yaml with sync timestamp

**Data Structure**:
```yaml
# ψ/memory/reunions.yaml
my-project:
  repo: ~/Code/github.com/org/my-project
  spinoff_date: 2026-01-05
  last_reunion: 2026-01-07
  learnings_synced: 3
```

**Key Insight**: Spinoff frequency is increasing. Manual reunion is unsustainable. Need automated or semi-automated solution.

---
*Added via Oracle Learn*
