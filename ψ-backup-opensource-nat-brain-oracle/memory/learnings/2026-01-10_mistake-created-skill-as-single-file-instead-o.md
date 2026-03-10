---
title: ## Mistake: Created Skill as Single File Instead of Folder
tags: [skill, mistake, debugging, SKILL.md, folder-structure, documentation]
created: 2026-01-10
source: Arthur /learn skill debugging session
---

# ## Mistake: Created Skill as Single File Instead of Folder

## Mistake: Created Skill as Single File Instead of Folder

**Date**: 2026-01-10
**Category**: Debugging Mistake

**The Mistake**:
Created `/learn` skill as `.claude/skills/learn.md` (single file).
Spent ~10 minutes debugging why skill wasn't loading.

**What Happened**:
1. Created `.claude/skills/learn.md` with correct frontmatter
2. Added `name:` field thinking that was the issue
3. Still didn't work
4. Finally read skill-creator docs

**Root Cause**:
Skills MUST be **folders** with `SKILL.md` inside:
```
.claude/skills/learn/SKILL.md  ✅
.claude/skills/learn.md        ❌
```

**Why Confused**:
- Nat-s-Agents has both patterns (legacy single files + correct folders)
- Assumed single `.md` files work because they exist
- Those single files are likely orphaned/unused

**Lesson**:
Always check official docs (skill-creator) before assuming patterns from existing code.

**Time Lost**: ~10 minutes
**Fix**: `mkdir learn && mv learn.md learn/SKILL.md`

---
*Added via Oracle Learn*
