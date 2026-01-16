# Handoff MCP v3

MCP server for session handoff management with Drizzle ORM.

## Features

- **handoff_create**: Create session handoffs with done/pending/learnings
- **handoff_read**: Read recent handoffs to continue work
- **handoff_search**: Search handoffs by keyword (FTS5)

## Installation

```bash
cd ψ/lab/handoff-mcp-v3
npm install
npm run build
```

## Configuration

Add to Claude Code config:

```json
{
  "mcpServers": {
    "handoff-mcp-v3": {
      "command": "node",
      "args": ["ψ/lab/handoff-mcp-v3/dist/index.js"]
    }
  }
}
```

Or install via plugin:

```bash
claude plugins add plugins/handoff-mcp-v3
```

## Architecture

- **Source of truth**: Markdown files in `ψ/inbox/handoff/`
- **Search index**: SQLite + FTS5 in `data/handoffs.db` (ephemeral)
- **ORM**: Drizzle for type-safe schema

## Development

```bash
npm run dev      # Watch mode
npm run build    # Build TypeScript
npm run db:generate  # Generate migrations
npm run db:migrate   # Run migrations
```

## License

MIT
