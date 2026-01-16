---
title: ## Skill Design Patterns (from Anthropic's skill-creator)
tags: [skill-design, progressive-disclosure, context-efficiency, anthropic-patterns, degrees-of-freedom]
created: 2026-01-13
source: Anthropic skill-creator (example-skills)
---

# ## Skill Design Patterns (from Anthropic's skill-creator)

## Skill Design Patterns (from Anthropic's skill-creator)

### Core Philosophy
"Context window is a public good" — Only add what Claude doesn't already know. Challenge each piece: "Does this justify its token cost?"

### Degrees of Freedom
Match specificity to task fragility:
- **High freedom** (text instructions): Multiple valid approaches, context-dependent
- **Medium freedom** (pseudocode/parameterized scripts): Preferred pattern exists, some variation OK
- **Low freedom** (specific scripts): Fragile operations, consistency critical

Metaphor: Narrow bridge = guardrails (low freedom), Open field = many routes (high freedom)

### Progressive Disclosure (3 levels)
1. **Metadata** (name + description) — Always loaded (~100 words)
2. **SKILL.md body** — On trigger (<5k words, <500 lines)
3. **Bundled resources** — As needed (unlimited, can execute without reading)

### Critical: Description is the Trigger
"When to use" information goes in YAML frontmatter `description`, NOT in body. Body only loads AFTER triggering — so "When to Use" sections in body are useless.

### Skill Anatomy
```
skill-name/
├── SKILL.md (required)
├── scripts/    — Deterministic, repeatedly rewritten code
├── references/ — Documentation loaded as needed
└── assets/     — Output files (templates, images, fonts)
```

### Anti-patterns
- README.md, CHANGELOG.md, INSTALLATION_GUIDE.md — NO auxiliary docs
- Deeply nested references — Keep 1 level deep from SKILL.md
- Duplicating info in SKILL.md AND references — Pick one location

### Our /recap skill comparison
Good: Uses progressive disclosure (Haiku gathers → Opus renders)
Improve: Could move RICH MODE paths to references/paths.md

---
*Added via Oracle Learn*
