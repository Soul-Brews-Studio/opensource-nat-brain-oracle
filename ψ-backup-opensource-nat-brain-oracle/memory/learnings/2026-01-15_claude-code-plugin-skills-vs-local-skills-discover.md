---
title: Claude Code plugin skills vs local skills discovery:
tags: [claude-code, plugins, skills, commands, namespacing, workaround, discovery]
created: 2026-01-15
source: Traced from Soul-Brews-Studio/mcp-marketplace debugging session
---

# Claude Code plugin skills vs local skills discovery:

Claude Code plugin skills vs local skills discovery:

**Issue**: Plugin skills don't show in CLI autocomplete (GitHub #10246). Only `/skills` list shows them.

**Workaround layers**:
1. Plugin `skills/` → Shows in `/skills` list, AI can invoke via Skill tool
2. Plugin `commands/` → Shows as `/plugin-name:command` (namespaced)
3. Local `~/.claude/skills/` → Shows as `/skill-name` (no prefix)
4. Local `~/.claude/commands/` → Shows as `/command` (no prefix)

**Key insight**: Plugin commands are ALWAYS prefixed with plugin name (e.g., `oracle-skills:rrr`). Only LOCAL files get clean `/rrr` names.

**Solution for distribution**: Plugin should include install script that creates symlinks in `~/.claude/skills/` or `~/.claude/commands/` for clean command names.

**SKILL.md frontmatter matters**: Skills without `name:` field show as `plugin:folder-name`. With `name:` field, they show as just `name`.

---
*Added via Oracle Learn*
