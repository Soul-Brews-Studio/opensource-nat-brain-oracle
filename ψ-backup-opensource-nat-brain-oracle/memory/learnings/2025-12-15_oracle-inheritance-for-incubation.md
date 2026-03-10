# Learning: ORACLE Inheritance for Incubation

**Date**: 2025-12-15
**Context**: Discussing how to apply ORACLE patterns to incubated projects
**Decision**: Inheritance model (not copy, not symlink)

## The Problem

Incubated projects in `ψ/incubate/repo/` need:
- CLAUDE.md instructions
- Skills system
- Memory structure
- Codename awareness

But we don't want:
- Duplicated files that diverge
- Broken symlinks when repos move
- Manual sync overhead

## The Solution: Inheritance

```
ORACLE (parent)
├── CLAUDE.md                    # Master instructions
├── CLAUDE_safety.md
├── .claude/skills/              # Core skills
└── ψ/memory/resonance/          # Shared identity

    ↓ inherits

INCUBATED PROJECT (child)
├── CLAUDE.md                    # Points to parent + local overrides
├── .claude/skills/              # Project-specific skills only
└── ψ/ (optional)                # Local brain if needed
```

## Implementation Pattern

### Child Project CLAUDE.md

```markdown
# [Project Name]

> Inherits from ORACLE: `/path/to/Nat-s-Agents/CLAUDE.md`

## Parent Rules Apply
- Safety rules (CLAUDE_safety.md)
- Git workflow (CLAUDE_workflows.md)
- Subagent patterns (CLAUDE_subagents.md)

## Local Overrides

### Project-Specific Context
[Project-specific instructions here]

### Local Skills
- Custom skills in `.claude/skills/`

### Codename
This project is: **HEADLINE** (or whatever)
```

### How It Works

1. **Claude reads child CLAUDE.md first**
2. **Sees inheritance declaration**
3. **Loads parent rules as base**
4. **Applies local overrides**

## Benefits

| Benefit | How |
|---------|-----|
| **Single source of truth** | Parent CLAUDE.md is master |
| **No duplication** | Child only has overrides |
| **Flexible** | Each project can customize |
| **Portable** | Projects can graduate out |

## Current Incubated Projects

| Project | Codename | Inherits ORACLE? |
|---------|----------|------------------|
| headline-analyzer | HEADLINE | Yes (to apply) |
| the-headline | - | Yes (to apply) |
| multi-agent-workflow-kit | - | Yes (to apply) |

## Implementation Steps

1. **Create child CLAUDE.md template**
2. **Apply to each incubated project**
3. **Test inheritance works**
4. **Document any project-specific overrides**

## Example: headline-analyzer

```markdown
# headline-analyzer

> Inherits from ORACLE: `../../Nat-s-Agents/CLAUDE.md`

## Codename: HEADLINE

## Local Context
- News headline analysis dashboard
- DuckDB + Streamlit
- Demo asset for ANTIGRAVITY pitch

## Local Commands
- /analyze [url] — Analyze news source
- /dashboard — Start Streamlit UI
```

## Key Insight

> "ORACLE is not just this repo — it's a pattern that can propagate to any project Nat works on."

The inheritance model means:
- **Learn once, apply everywhere**
- **Improvements flow downstream**
- **Projects can diverge when needed**
- **Graduation path is clear** (copy CLAUDE.md when independent)

## Related

- `ψ/memory/resonance/project-codenames.md` — Codename registry
- `CLAUDE.md` — Parent ORACLE instructions
- `ψ/incubate/` — Where inherited projects live

---

*Status: Concept defined, ready to implement*
