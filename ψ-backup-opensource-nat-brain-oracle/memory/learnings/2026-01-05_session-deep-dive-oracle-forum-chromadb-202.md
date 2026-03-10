---
title: ## Session Deep Dive: Oracle Forum + ChromaDB (2026-01-03/04)
tags: [chromadb, mcp, forum, drizzle, pnpm, embeddings, author-detection, ui-state, react-router]
created: 2026-01-05
source: opus@oracle-v2
---

# ## Session Deep Dive: Oracle Forum + ChromaDB (2026-01-03/04)

## Session Deep Dive: Oracle Forum + ChromaDB (2026-01-03/04)

### Problem 1: ChromaDB Embedding Failure
**Symptom**: `Cannot find module 'chromadb-default-embed'`
**Root Cause**: pnpm's strict isolated modules break dynamic imports
**Failed Attempts**: 
- Adding chromadb-default-embed to dependencies
- Using --shamefully-hoist flag
**Working Solution**: 
- Use `chroma-mcp` Python MCP server via `uvx`
- Embeddings happen server-side, no npm dependency issues
- Created `src/chroma-mcp.ts` as MCP client wrapper

### Problem 2: Forum Author Attribution
**Symptom**: All messages showed "💬 user" regardless of source
**Root Cause**: Tried to detect MCP via `process.argv.includes('index.ts')` - unreliable
**Solution**:
- Trust the `role` parameter passed by caller
- MCP passes `role: 'claude'`, HTTP passes `role: 'human'`
- Added `model` param for Opus/Sonnet distinction
- Author format: `{model}@{project}` e.g., `opus@oracle-v2`

### Problem 3: UI State Not Updating
**Symptom**: Close button did nothing
**Root Cause**: Vite dev server needs frontend rebuild, HTTP server needs restart
**Solution**: Always restart servers after code changes

### Architecture Decisions
| Decision | Choice | Why |
|----------|--------|-----|
| DB Schema | Drizzle ORM | Type-safe, migration support |
| Author detection | Explicit param | process.argv unreliable |
| Thread status | Toggle button | Better UX than confirm dialogs |
| URL state | useSearchParams | Browser back/refresh works |

### Code Patterns
```typescript
// MCP tool call with model
oracle_thread({ message: "...", role: "claude", model: "opus" })

// Handler author logic
const author = role === 'human' ? 'user' : (model || 'claude');
if (project) author = `${author}@${project}`;
```

### Files Created
- `src/chroma-mcp.ts` - MCP client for ChromaDB
- `src/forum/handler.ts` - Thread/message CRUD + Oracle response
- `src/forum/types.ts` - TypeScript interfaces
- `frontend/src/pages/Forum.tsx` - React UI with sidebar

---
*Added via Oracle Learn*
