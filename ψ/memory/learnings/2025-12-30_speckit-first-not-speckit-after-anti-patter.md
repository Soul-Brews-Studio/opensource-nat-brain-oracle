---
title: ## Speckit-First, Not Speckit-After
tags: [speckit, workflow, anti-pattern, planning, lesson-learned]
created: 2025-12-30
source: Handoff-MCP development 2025-12-31
---

# ## Speckit-First, Not Speckit-After

## Speckit-First, Not Speckit-After

**Anti-pattern observed**: Building handoff-mcp first, then creating speckit retroactively.

**Correct pattern**:
1. `/speckit.specify` → Define user stories BEFORE coding
2. `/speckit.plan` → Technical design with `/debate`
3. `/speckit.tasks` → Acceptance criteria defined
4. THEN implement

**Why this matters**:
- Retroactive specs are documentation, not guidance
- Acceptance criteria written after code just describe what exists
- Design decisions made ad-hoc, not debated
- No opportunity to catch issues before building

**The fix**:
```
BEFORE: Build → Speckit (retroactive documentation)
AFTER:  Speckit → Debate → Build (guided development)
```

**When retroactive is acceptable**:
- Quick experiments in ψ/lab/
- Prototypes that might be thrown away
- Learning exercises

**When speckit-first is required**:
- Features going to production
- Anything in specs/ directory
- Work that others will maintain

---
*Added via Oracle Learn*
