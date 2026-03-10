---
title: MCP Marketplace Skills Discovery Pattern
tags: [plugin, marketplace, skills, discovery, claude-code, structure]
created: 2026-01-15
source: Session 2026-01-15 - Soul Brews MCP Marketplace creation
---

# MCP Marketplace Skills Discovery Pattern

## The Problem

When creating a marketplace repo with multiple plugins, skills inside plugins are NOT automatically discovered.

## What Works

The working oracle-skills plugin (from oracle-skills marketplace) has BOTH files in `.claude-plugin/`:

```
oracle-skills/
└── .claude-plugin/
    ├── plugin.json       ← Plugin metadata
    └── marketplace.json  ← Declares skills explicitly!
```

### plugin.json (metadata only)
```json
{
  "name": "oracle-skills",
  "version": "1.0.3",
  "description": "13 skills"
}
```

### marketplace.json (declares skills)
```json
{
  "name": "oracle-skills",
  "plugins": [{
    "name": "oracle-skills",
    "source": "./",
    "skills": [
      "./skills/trace",
      "./skills/recap",
      "./skills/rrr",
      ...
    ]
  }]
}
```

## Key Insight

**Skills need explicit declaration** in `marketplace.json` with the `"skills": [...]` array.

Without this array:
- Plugin installs successfully
- Commands work (if any)
- Skills are NOT discovered

## Monorepo Structure

For a marketplace with multiple plugins:

```
mcp-marketplace/
├── .claude-plugin/
│   └── marketplace.json      ← Root: lists all plugins
├── oracle-skills/
│   └── .claude-plugin/
│       ├── plugin.json       ← Metadata
│       └── marketplace.json  ← Skills array (needed!)
└── ralph-soulbrews/
    └── .claude-plugin/
        └── plugin.json       ← Commands-only, no marketplace.json needed
```

## Still Debugging

Skills still not loading after install despite correct structure. May need:
- Different file structure
- Symlinks created differently
- Cache clearing
- Restart Claude Code

---
*Learning from Soul Brews MCP Marketplace debugging*
