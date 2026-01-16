# Module Export Alias Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG - TypeScript CLI import error

## The Problem

```
SyntaxError: Export named 'db' not found in module '.../sqlite.ts'
```

Files importing `db` but module only exports `sqlite`.

## The Fix

```typescript
// sqlite.ts
export const sqlite = new Database(DB_PATH, { create: true });

// Add alias for backwards compatibility
export const db = sqlite;
```

## Why This Pattern

| Approach | Pros | Cons |
|----------|------|------|
| Rename all imports | Consistent naming | Many file changes |
| Add export alias | One-line fix | Two names for same thing |
| Re-export from index | Clean API | Extra indirection |

**Decision**: Export alias - minimal change, zero risk.

## Detection

```bash
# Find what's exported
grep "^export" src/db/sqlite.ts

# Find what's imported
grep "import.*from.*sqlite" src/**/*.ts
```

## Anti-Pattern

```typescript
// BAD: Silently break consumers
// Old: export const db = ...
// New: export const sqlite = ...  // Breaks imports!

// GOOD: Add alias, don't remove
export const sqlite = new Database(...);
export const db = sqlite;  // Backwards compatible
```

## Key Insight

When renaming exports:
1. Keep old name as alias
2. Document deprecation if needed
3. Remove after all consumers migrate

---

*Module exports: Add aliases, don't break imports.*
