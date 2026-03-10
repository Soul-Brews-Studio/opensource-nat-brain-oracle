---
title: ## Victory: /physical Skill Restored After 3-Session Debug Hunt
tags: [skill, symlink, debugging, victory, claude-code, physical, auto-discovery]
created: 2026-01-16
source: Oracle Learn
---

# ## Victory: /physical Skill Restored After 3-Session Debug Hunt

## Victory: /physical Skill Restored After 3-Session Debug Hunt

**Date**: 2026-01-16
**Category**: Bug Fix Victory

**The Journey**:
- Session 1: Noticed /physical not appearing in available skills
- Session 2: Tried multiple approaches - checked SKILL.md format, frontmatter, trigger field
- Session 3: Finally found root cause with /trace Oracle search

**Root Cause**: Claude Code skill discovery **does NOT follow symlinks**

**The Fix**:
```bash
# Wrong (symlink - NOT discovered)
ln -s /path/to/skill ~/.claude/skills/physical

# Correct (real directory - discovered!)
cp -r /path/to/skill ~/.claude/skills/physical
```

**Key Insight**: Skills ARE auto-discovered without restart. The moment we changed from symlink to real directory, `/physical` was immediately available.

**Debugging Pattern That Worked**:
1. `/trace [query]` → Search Oracle for similar issues
2. Found learning about "skill must be folder with SKILL.md"
3. Compared working skill (hours) vs broken skill (physical)
4. Noticed hours = real dir, physical = symlink
5. Changed to real directory → immediate fix

**Oracle Philosophy Proven**: Past learnings saved debugging time. The "skill structure" learning from Jan 10 guided us toward the solution.

---
*Added via Oracle Learn*
