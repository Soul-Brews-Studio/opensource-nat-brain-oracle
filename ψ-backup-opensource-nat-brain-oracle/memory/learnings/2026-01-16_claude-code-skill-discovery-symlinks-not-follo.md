---
title: ## Claude Code Skill Discovery: Symlinks Not Followed
tags: [skill, claude-code, symlink, discovery, debugging]
created: 2026-01-16
source: Oracle Learn
---

# ## Claude Code Skill Discovery: Symlinks Not Followed

## Claude Code Skill Discovery: Symlinks Not Followed

**Date**: 2026-01-16
**Category**: Debugging Discovery

**The Issue**:
Skills in `~/.claude/skills/` that are **symlinks** to folders are NOT discovered by Claude Code.
Only **real directories** are scanned for SKILL.md files.

**Wrong approach**:
```bash
ln -s /path/to/skill ~/.claude/skills/skillname  ❌
```

**Correct approach**:
```bash
cp -r /path/to/skill ~/.claude/skills/skillname  ✅
```

**Why this matters**:
- Symlinks seem convenient for maintaining skills in version control
- But Claude Code's skill discovery doesn't follow symlinks
- Must copy the folder directly

**Fix**: Replace symlink with actual copy of the directory.

---
*Added via Oracle Learn*
