---
title: ## Oracle-v2 Feature Development Pattern
tags: [oracle-v2, feature-development, drizzle, mcp, migration, pattern]
created: 2026-01-10
source: Session 2026-01-10 - Issue #17 Implementation
---

# ## Oracle-v2 Feature Development Pattern

## Oracle-v2 Feature Development Pattern

When adding new features to oracle-v2:

### 1. Database Schema (Drizzle ORM)
- Add table to `src/db/schema.ts` using Drizzle syntax
- Update `drizzle.config.ts` tablesFilter to include new table
- Run `bun run db:generate` to create migration
- Run `bun run db:push` to apply (or use existing DB if already created)

### 2. Handler Module
- Create `src/[feature]/types.ts` for TypeScript interfaces
- Create `src/[feature]/handler.ts` for CRUD operations
- Export functions that take `Database` as first parameter

### 3. MCP Tools
- Add tool definitions to `ListToolsRequestSchema` in `src/index.ts`
- Add switch cases in `CallToolRequestSchema` handler
- Create `handleX` methods in OracleMCPServer class
- Import handler functions and types at top of file

### 4. Migration Best Practice
- Let Drizzle handle migrations, don't embed SQL in handler code
- Use `bun run db:generate` then `bun run db:push`
- Table should exist before MCP server starts

### Files to modify:
1. `src/db/schema.ts` - Drizzle table definition
2. `drizzle.config.ts` - Add table to tablesFilter
3. `src/[feature]/types.ts` - TypeScript types
4. `src/[feature]/handler.ts` - CRUD functions
5. `src/index.ts` - MCP tools + handlers

Example: Issue #17 Trace Log feature

---
*Added via Oracle Learn*
