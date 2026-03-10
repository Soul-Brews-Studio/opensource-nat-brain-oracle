# Why Incubated Projects Can't See Oracle MCP

**Date**: 2026-01-02
**Context**: headline-rag in ψ/incubate/ can't query Oracle MCP

## The Problem

When you `cd` into an incubated project and run Claude Code:

```bash
cd ψ/incubate/repo/github.com/laris-co/headline-rag
claude
```

Oracle MCP tools (`oracle_search`, `oracle_consult`, etc.) are **not available**.

## Why This Happens

### MCP Configuration is Per-Project

Claude Code loads MCP servers from `.claude.json` based on **current working directory**, not symlink source.

```
~/.claude.json
├── mcpServers (global)
└── projects
    └── /Users/nat/Code/.../Nat-s-Agents  ← Oracle configured HERE
        └── mcpServers
            └── oracle-v2 ✅
```

When you're in headline-rag, Claude looks for:
1. `headline-rag/.claude.json` (doesn't exist)
2. `~/.claude.json` projects → `/Users/nat/Code/.../headline-rag` (not configured)

### Symlinks Don't Inherit Config

```
ψ/incubate/repo/.../headline-rag  →  ~/Code/.../headline-rag
        ↑                                    ↑
   symlink in Nat-s-Agents           actual repo location

Claude resolves symlink → uses headline-rag's config → no Oracle
```

## Solutions

### Option 1: Add Oracle to headline-rag's config (Recommended)

Edit `~/.claude.json`, add headline-rag project:

```json
{
  "projects": {
    "/Users/nat/Code/github.com/laris-co/headline-rag": {
      "mcpServers": {
        "oracle-v2": {
          "type": "stdio",
          "command": "npx",
          "args": ["tsx", "/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/lab/oracle-v2/src/index.ts"]
        }
      }
    }
  }
}
```

### Option 2: Stay in Nat-s-Agents, reference headline-rag

```bash
# Don't cd into headline-rag
cd ~/Code/github.com/laris-co/Nat-s-Agents
claude

# Then reference headline-rag via symlink path
# Oracle is available because you're in Nat-s-Agents
```

### Option 3: Create shared MCP config file

Create `.mcp.json` in headline-rag that references Oracle:

```json
{
  "mcpServers": {
    "oracle-v2": {
      "type": "stdio",
      "command": "npx",
      "args": ["tsx", "/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/lab/oracle-v2/src/index.ts"]
    }
  }
}
```

## Quick Fix Command

Add Oracle to all incubated laris-co projects:

```bash
# Get current Oracle config
ORACLE_CONFIG=$(cat ~/.claude.json | jq '.projects["/Users/nat/Code/github.com/laris-co/Nat-s-Agents"].mcpServers["oracle-v2"]')

# For each incubated project, add Oracle MCP
for repo in ~/Code/github.com/laris-co/headline-rag ~/Code/github.com/laris-co/the-headline; do
  # Add to ~/.claude.json projects
  jq --arg path "$repo" --argjson oracle "$ORACLE_CONFIG" \
    '.projects[$path].mcpServers["oracle-v2"] = $oracle' ~/.claude.json > /tmp/claude.json.tmp \
    && mv /tmp/claude.json.tmp ~/.claude.json
done
```

## Visual Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     ~/.claude.json                          │
├─────────────────────────────────────────────────────────────┤
│ projects:                                                   │
│   /Users/.../Nat-s-Agents:                                  │
│     mcpServers:                                             │
│       oracle-v2: ✅ CONFIGURED                              │
│                                                             │
│   /Users/.../headline-rag:                                  │
│     mcpServers: ❌ NOT CONFIGURED (add oracle-v2 here!)    │
└─────────────────────────────────────────────────────────────┘

When in Nat-s-Agents → Oracle ✅
When in headline-rag → Oracle ❌ (until configured)
```

## Key Insight

> **MCP servers are bound to project paths, not repo relationships.**
>
> Symlinks in ψ/incubate/ don't make incubated projects "part of" Nat-s-Agents.
> Each project needs its own MCP configuration.

## Related

- `ψ/lab/oracle-v2/` - Oracle MCP server source
- `~/.claude.json` - Claude Code configuration
- `/mcp` command in Claude Code - view MCP status

---

## Changes Applied (2026-01-02 00:19)

### Global Oracle (Recommended)

Added Oracle to **global** `mcpServers` in `~/.claude.json`:

```json
{
  "mcpServers": {
    "oracle-v2": {
      "type": "stdio",
      "command": "npx",
      "args": ["tsx", "/Users/nat/Code/.../oracle-v2/src/index.ts"]
    }
  }
}
```

**Result**: Oracle is now available in **ALL projects** - no per-project config needed!

### Also Added Per-Project (for reference)

| Project | Path | Oracle Status |
|---------|------|---------------|
| headline-rag | `/Users/nat/Code/.../laris-co/headline-rag` | ✅ Added |
| the-headline | `/Users/nat/Code/.../laris-co/the-headline` | ✅ Added |

**To test** (from any project):
```bash
cd ~/Code/github.com/laris-co/headline-rag
claude
# Oracle tools now available: oracle_search, oracle_consult, oracle_reflect
```

---

*Pattern: incubate-oracle-visibility*
