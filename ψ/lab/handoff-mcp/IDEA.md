---
title: "Handoff MCP - Auto Context Management"
created: 2025-12-31
status: built
inspired_by: claude-mem
---

# Handoff MCP - Auto Context Management

## Concept

An MCP server that automatically manages session handoffs and context continuity.

## Inspiration from claude-mem

Learn from claude-mem's approach:
- Auto-capture via hooks
- Session summaries
- Timeline context
- Progressive documentation

## Proposed Tools

### 1. `handoff_create`
Auto-generate handoff from current session state.

```typescript
handoff_create({
  done: string[],      // What was completed
  pending: string[],   // What's left
  context: string      // Key context to preserve
})
```

### 2. `handoff_read`
Get latest handoff for session continuity.

```typescript
handoff_read({
  limit: number  // How many recent handoffs
})
```

### 3. `handoff_search`
Find past handoffs by topic.

```typescript
handoff_search({
  query: string,
  dateRange?: { start: string, end: string }
})
```

## Architecture

```
┌─────────────────────────────────────┐
│         Handoff MCP Server          │
├─────────────────────────────────────┤
│  Storage: ψ/inbox/handoff/*.md      │
│  Index: SQLite FTS5                 │
│  Hooks: SessionStart, SessionEnd    │
└─────────────────────────────────────┘
```

## Minimal MVP

1. `handoff_create` - Write structured handoff
2. `handoff_read` - Read latest handoff
3. Hook integration for auto-display

## Implementation Status

- [x] Create MCP server skeleton
- [x] Implement handoff_create
- [x] Implement handoff_read
- [x] Implement handoff_search with FTS5
- [ ] Hook integration for auto-display
- [ ] Register in Claude settings

## Usage

```bash
# Install
cd ψ/lab/handoff-mcp && npm install

# Run
npm run dev
```

## Registration

Add to `.claude/settings.json`:
```json
{
  "mcpServers": {
    "handoff-mcp": {
      "command": "npx",
      "args": ["tsx", "ψ/lab/handoff-mcp/src/server.ts"]
    }
  }
}
```

---

*Built 2025-12-31*
