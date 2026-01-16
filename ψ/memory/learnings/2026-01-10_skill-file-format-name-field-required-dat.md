---
title: ## Skill File Format - name: Field Required
tags: [skill, claude-code, frontmatter, debugging, arthur]
created: 2026-01-10
source: Children's Day 2026 - /learn skill debugging
---

# ## Skill File Format - name: Field Required

## Skill File Format - name: Field Required

**Date**: 2026-01-10
**Issue**: Custom skill `/learn` not showing in Claude Code autocomplete

**Root Cause**: 
Missing `name:` field in skill frontmatter. Only had `description:`.

**Wrong format**:
```markdown
---
description: Quick shortcut for...
---
```

**Correct format**:
```markdown
---
name: learn
description: Quick shortcut for...
---
```

**How discovered**:
- Compared Arthur's learn.md with working skills in Nat-s-Agents
- Working skills like `context-finder.md` have both `name:` and `description:`

**Fix applied**:
Added `name: learn` to `/Users/nat/Code/github.com/laris-co/the-headline-mono/.claude/skills/learn.md`

**Prevention**:
Always include both `name:` and `description:` in skill frontmatter.

---
*Added via Oracle Learn*
