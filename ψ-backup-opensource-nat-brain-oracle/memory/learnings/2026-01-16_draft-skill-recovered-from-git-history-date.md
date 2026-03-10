---
title: ## /draft Skill Recovered from Git History
tags: [skill, recovery, git, draft, history]
created: 2026-01-16
source: Oracle Learn
---

# ## /draft Skill Recovered from Git History

## /draft Skill Recovered from Git History

**Date**: 2026-01-16
**Category**: Skill Recovery

**What Happened**:
- /draft skill was missing from available skills
- Used `/trace` to search Oracle → no direct hit
- Used `git log --grep="draft"` → found commit `62ed9c0f`
- Recovered skill content with `git show 62ed9c0f:.claude/skills/draft/skill.md`

**Root Cause**: Original skill used `skill.md` (lowercase), Claude Code expects `SKILL.md` (uppercase)

**Recovery Steps**:
1. `git log --grep="draft"` → find the commit
2. `git ls-tree -r [hash] | grep draft` → find file path
3. `git show [hash]:[path]` → recover content
4. Create proper structure with `SKILL.md` (uppercase)
5. Copy to `~/.claude/skills/draft/` (real directory, not symlink)

**Key Pattern**: Git history is the ultimate backup. Even "deleted" skills can be recovered.

---
*Added via Oracle Learn*
