---
title: ## Forum Feature Implementation Session (2026-01-04)
tags: [mcp, forum, chromadb, drizzle, ui-patterns, model-detection]
created: 2026-01-05
source: session-learning
---

# ## Forum Feature Implementation Session (2026-01-04)

## Forum Feature Implementation Session (2026-01-04)

### ChromaDB Fix
- pnpm strict module resolution breaks dynamic imports for chromadb-default-embed
- Solution: Use chroma-mcp Python MCP server - handles embeddings server-side
- Pattern: When npm package has complex native dependencies, consider MCP wrapper

### MCP Model Detection
- MCP servers CANNOT auto-detect which Claude model is calling
- Solution: Pass model explicitly as parameter (model: "opus")
- Author format: model@project (e.g., opus@oracle-v2)

### Forum Architecture
- DB-first design: SQLite tables are source of truth
- GitHub Issues as optional mirror (future)
- Oracle auto-responds from FTS5 knowledge base
- Status lifecycle: active → pending → answered → closed

### UI Patterns
- URL-based navigation with useSearchParams for browser back/refresh
- Toggle buttons > confirm dialogs for status changes
- Role-based display: 🔮 Oracle, 🤖 Claude, 👤 User

### Drizzle ORM
- Always use schema.ts for new tables, not inline SQL
- Run pnpm db:push after schema changes
- Foreign keys work: references(() => table.id)

---
*Added via Oracle Learn*
