---
title: **Speckit Full Workflow Practice - Session Timer**
tags: [speckit, workflow, practice, session-timer, drizzle, bun]
created: 2025-12-31
source: Oracle Learn
---

# **Speckit Full Workflow Practice - Session Timer**

**Speckit Full Workflow Practice - Session Timer**

Successfully practiced complete speckit workflow from specify to implementation:

1. `/speckit.specify` - Created spec with 4 user stories (start, stop, status, history)
2. `/speckit.plan` - Generated plan.md, research.md, data-model.md, quickstart.md
3. `/speckit.tasks` - Created 22 tasks organized by user story
4. Implemented all tasks manually (didn't use /speckit.implement)

Key observations:
- Workflow is smooth when following the sequence
- Constitution check catches philosophy alignment early
- User story organization makes implementation logical
- Each phase builds on previous artifacts

Technical decisions made:
- Bun + Drizzle ORM for consistency with handoff-mcp-v4
- Manual table creation (Drizzle with bun:sqlite quirk)
- Commander.js for CLI parsing
- Append-only sessions (Oracle philosophy)

Time to complete: ~10 minutes from specify to working CLI.

---
*Added via Oracle Learn*
