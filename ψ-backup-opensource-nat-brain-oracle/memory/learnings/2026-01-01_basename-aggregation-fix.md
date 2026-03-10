# Basename Aggregation Fix for Duplicate Entries

**Date**: 2026-01-01
**Context**: Data-Aware RAG v3 - fixing duplicate entries in topFiles display
**Impact**: Stats now show correct aggregated counts per unique filename

## The Problem

The `stats` command showed duplicate entries like:
```
   1. 361-370-energy-rhythm.md                42
   2. 361-370-energy-rhythm.md                42
   3. 361-370-energy-rhythm.md                42
   4. 361-370-energy-rhythm.md                42
```

Same filename appearing 4 times with same count, because files with identical basenames but different paths were shown as separate entries.

## Root Cause

The query grouped by full `source_file` path:
```sql
SELECT source_file as file, COUNT(*) as count
FROM documents
GROUP BY source_file
```

Then displayed only the basename:
```typescript
file: r.file.split('/').pop() || r.file
```

Result: Different paths with same basename → duplicate display names.

## The Fix

**Don't rely on SQLite string manipulation** (no `REVERSE()`, complex `SUBSTR`/`INSTR`).

Instead, aggregate in JavaScript:

```typescript
// Get all files with their counts
const allFiles = db.query(`
  SELECT source_file as file, COUNT(*) as count
  FROM documents
  GROUP BY source_file
`).all();

// Group by basename in JavaScript
const basenameGroups = new Map<string, { count: number; fullPath: string }>();
for (const row of allFiles) {
  const basename = row.file.split('/').pop() || row.file;
  const existing = basenameGroups.get(basename);
  if (existing) {
    existing.count += row.count;
  } else {
    basenameGroups.set(basename, { count: row.count, fullPath: row.file });
  }
}

// Sort and limit
const topFiles = Array.from(basenameGroups.entries())
  .map(([file, data]) => ({ file, count: data.count, fullPath: data.fullPath }))
  .sort((a, b) => b.count - a.count)
  .slice(0, limit);
```

## Files Modified

- `ψ/lab/data-aware-rag/src/db/sqlite.ts` - `getTopSourceFiles()` function
- `ψ/lab/data-aware-rag/src/cli/rag.ts` - inline stats query

## Before vs After

**Before:**
```
   1. 361-370-energy-rhythm.md                42
   2. 361-370-energy-rhythm.md                42
```

**After:**
```
   1. README.md                              557
   2. INDEX.md                               532
   3. tasks.md                               476
```

## Key Statement

> When displaying aggregated data, **aggregate at the display level** (basename), not the storage level (full path). Keep the full path as metadata for reference.

## Related

- Spec: `specs/003-generic-markdown-rag/spec-v3.md`
- Issue: Duplicate entries in topFiles (from v2 testing)
