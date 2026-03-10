---
title: ## Skill Development: Local Skills vs Plugin Skills
tags: [skill, local-skill, plugin-skill, architecture, claude-code, discovery]
created: 2026-01-16
source: Oracle Learn
---

# ## Skill Development: Local Skills vs Plugin Skills

## Skill Development: Local Skills vs Plugin Skills

**Date**: 2026-01-16
**Category**: Architecture Understanding

**Two Types of Skills in Claude Code**:

| Type | Location | Discovery |
|------|----------|-----------|
| Local Skills | `~/.claude/skills/` | Auto-discovered from real directories |
| Plugin Skills | Via marketplace | Discovered at plugin load time |

**Local Skill Requirements**:
1. Must be a **real directory** (not symlink)
2. Must contain `SKILL.md` file
3. Frontmatter needs `name:` and `description:`
4. `trigger:` field is optional

**Auto-Discovery Behavior**:
- No restart needed for local skills
- Skills appear immediately after adding to `~/.claude/skills/`
- Symlinks are NOT followed (critical gotcha)

**Maintenance Strategy**:
If maintaining skills in version control, you must:
- Either copy skills to ~/.claude/skills/ (manual sync)
- Or use a script to copy on changes
- Symlinks seem convenient but break discovery

---
*Added via Oracle Learn*
