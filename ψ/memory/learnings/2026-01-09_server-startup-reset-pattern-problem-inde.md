---
title: ## Server Startup Reset Pattern
tags: [server, startup, reset, indexing, sqlite, bug-fix, transient-state]
created: 2026-01-09
source: Oracle Learn
---

# ## Server Startup Reset Pattern

## Server Startup Reset Pattern

**Problem**: Indexing status flags (`is_indexing=1`) can get stuck if process crashes mid-operation.

**Solution**: Reset transient state flags on server startup.

```typescript
// Reset stale indexing status on startup
// If server is starting, indexer isn't running - clear any stuck status
try {
  db.prepare('UPDATE indexing_status SET is_indexing = 0 WHERE id = 1').run();
  console.log('🔮 Reset indexing status on startup');
} catch (e) {
  // Table might not exist yet - that's fine
}
```

**Why this works**: If the server is starting, any previous indexer process is dead. The `is_indexing` flag is a runtime state, not persistent data - it should reflect current reality, not historical state.

**General principle**: Transient operation flags should be reset on startup. Only persist data that represents truth, not in-progress state.

---
*Added via Oracle Learn*
