---
title: ## Plugin Skill Discovery - Unsolved Mystery (Jan 13, 2026)
tags: [plugin, skill-discovery, claude-code, unsolved, debugging]
created: 2026-01-13
source: Oracle Learn
---

# ## Plugin Skill Discovery - Unsolved Mystery (Jan 13, 2026)

## Plugin Skill Discovery - Unsolved Mystery (Jan 13, 2026)

**Context**: Attempted to create installable plugin with 13 skills.

**What Works**:
- Project-level skills (`.claude/skills/*/SKILL.md`) ✅
- Global skills (`~/.claude/skills/*/SKILL.md`) ✅ 

**What Doesn't Work**:
- Plugin skills from `~/.claude/plugins/cache/*/skills/` ❌

**Tried**:
1. Renamed `skill.md` → `SKILL.md` (uppercase)
2. Added explicit `skills` array to marketplace.json
3. Added `strict: false`
4. Matched Anthropic's document-skills structure

**Anthropic's Working Setup**:
- `anthropic-agent-skills/document-skills/69c0b1a06741/skills/pdf/SKILL.md`
- Shows as `document-skills:pdf` in autocomplete

**Our Non-Working Setup**:
- `oracle-skills/oracle-skills/1.0.2/skills/trace/SKILL.md`
- Never shows in autocomplete

**Hypothesis**: Plugin skill discovery may require something we haven't found yet - possibly related to how marketplaces register plugins or a specific config file.

**Workaround**: Use project-level skills (copy to `.claude/skills/`) or global skills (`~/.claude/skills/`).

**Next Steps**: Ask in Claude Code community or read more plugin source code.

---
*Added via Oracle Learn*
