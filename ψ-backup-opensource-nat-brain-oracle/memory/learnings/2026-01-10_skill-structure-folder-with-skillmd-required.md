---
title: ## Skill Structure - Folder with SKILL.md Required
tags: [skill, claude-code, structure, SKILL.md, folder, debugging]
created: 2026-01-10
source: skill-creator docs + Arthur debugging
---

# ## Skill Structure - Folder with SKILL.md Required

## Skill Structure - Folder with SKILL.md Required

**Date**: 2026-01-10
**Supersedes**: learning_2026-01-10_skill-file-format-name-field-required-dat

**Root Cause**: 
Skills must be **folders** containing `SKILL.md`, NOT single `.md` files.

**Wrong structure**:
```
.claude/skills/learn.md  ❌
```

**Correct structure**:
```
.claude/skills/learn/
└── SKILL.md  ✅
```

**SKILL.md requirements**:
- YAML frontmatter with `name:` and `description:`
- Markdown body with instructions

**Source**: `.codex/skills/.system/skill-creator/SKILL.md` documentation

**Fix applied**:
```bash
mkdir -p .claude/skills/learn
mv .claude/skills/learn.md .claude/skills/learn/SKILL.md
```

---
*Added via Oracle Learn*
