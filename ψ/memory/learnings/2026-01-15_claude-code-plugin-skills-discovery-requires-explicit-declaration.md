---
title: Claude Code Plugin Skills Discovery Requires Explicit Declaration
tags: [plugin, skills, marketplace, claude-code, debugging, discovery]
created: 2026-01-15
source: Session 2026-01-15 - Soul Brews MCP Marketplace debugging
---

# Claude Code Plugin Skills Discovery Requires Explicit Declaration

## The Problem

Plugin installed successfully but skills were not found/available.

```bash
/plugin install oracle-skills@soul-brews-studio-mcp
# ✓ Installed... but /trace, /rrr, etc. not available
```

## Root Cause

Skills are NOT auto-discovered from `skills/` folder. They need explicit declaration in the plugin's `marketplace.json`:

**Wrong** (skills folder exists but not declared):
```json
{
  "name": "oracle-skills",
  "plugins": [
    {
      "name": "oracle-skills",
      "source": "./"
    }
  ]
}
```

**Correct** (skills explicitly listed):
```json
{
  "name": "oracle-skills",
  "plugins": [
    {
      "name": "oracle-skills",
      "source": "./",
      "skills": [
        "./skills/trace",
        "./skills/rrr",
        "./skills/recap",
        "./skills/feel",
        "./skills/fyi"
      ]
    }
  ]
}
```

## Key Insight

Each plugin in a marketplace needs its OWN `marketplace.json` inside `.claude-plugin/` that declares skills, even if there's a root marketplace.json for the overall marketplace.

## Structure That Works

```
mcp-marketplace/
├── .claude-plugin/
│   └── marketplace.json          ← Lists plugins (source paths)
└── oracle-skills/
    ├── .claude-plugin/
    │   ├── plugin.json           ← Plugin metadata
    │   └── marketplace.json      ← MUST have skills: [] array
    └── skills/
        ├── trace/SKILL.md
        └── ...
```

## Debugging Method

Compare working plugin vs non-working:
```bash
# Check working (installed)
cat ~/.claude/plugins/cache/oracle-skills/.claude-plugin/marketplace.json

# Check broken (new)
cat mcp-marketplace/oracle-skills/.claude-plugin/marketplace.json
```

Look for missing `skills: []` array.

---
*Discovered when Soul Brews MCP Marketplace skills weren't appearing after install*
