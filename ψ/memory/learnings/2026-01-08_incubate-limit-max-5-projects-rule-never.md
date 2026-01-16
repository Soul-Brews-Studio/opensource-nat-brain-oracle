---
title: ## Incubate Limit: Max 5 Projects
tags: [incubate, limit, focus, cognitive-load, project-manager]
created: 2026-01-08
source: Session 2026-01-08 - User rule
---

# ## Incubate Limit: Max 5 Projects

## Incubate Limit: Max 5 Projects

**Rule**: Never incubate more than 5 projects at a time.

**Why**: 
- 27 incubating = scattered focus, none get attention
- 5 is manageable cognitive load
- Forces prioritization

**When over limit**:
1. Run `/project reunion all` to sync learnings
2. Offload oldest/least active projects
3. Keep top 5 by recent activity

**Check command**:
```bash
ls ψ/incubate/repo/github.com/*/* 2>/dev/null | wc -l
```

If count > 5, offload before incubating new projects.

---
*Added via Oracle Learn*
