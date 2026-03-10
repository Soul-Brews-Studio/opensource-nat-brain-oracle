---
title: **Handoff MCP v4 Implementation Pattern**
tags: [bun, drizzle, mcp, plugin, fts5, handoff]
created: 2025-12-31
source: Handoff MCP v4 Implementation - 2025-12-31
---

# **Handoff MCP v4 Implementation Pattern**

**Handoff MCP v4 Implementation Pattern**

Tech stack that works well together:
- **Bun runtime**: Native SQLite via `bun:sqlite`, fast HTTP with `Bun.serve()`, no build step needed
- **Drizzle ORM**: Type-safe schema, but requires manual table creation (not auto-migrate) with bun:sqlite
- **FTS5**: Full-text search with special character escaping (`? * + - ( ) ^ ~ " ' :`)

Mode detection: Use explicit `--mcp` flag instead of TTY detection (`!process.stdin.isTTY`) - TTY detection unreliable across contexts.

Plugin structure for Claude Code:
```
plugins/plugin-name/
├── .claude-plugin/plugin.json  # name, version, description
├── .mcp.json                   # mcpServers config
└── (optional) commands/, hooks/
```

Must add to marketplace.json plugins array + bump version for `claude plugin install` to find it.

---
*Added via Oracle Learn*
