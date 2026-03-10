---
date: 2026-01-01
tags: [data-aware-rag, search, ux, sql, grouping]
context: Data-Aware RAG - Fixing duplicate search results
---

# Search Result Grouping by File

## The Problem

When indexing markdown files, each `## section` becomes a separate document for granular search. But this causes duplicates in results:

```
1. 2025-12-27_global-safety-hooks.md    ## What Happened
2. 2025-12-27_global-safety-hooks.md    ## What We Built
3. 2025-12-27_global-safety-hooks.md    ## Key Learning
4. 2025-12-27_global-safety-hooks.md    ## Outcome
```

Users see the same file 4+ times, which is confusing.

## The Solution

### 1. CLI Search: Group by File (Default)

```typescript
// Keep only the best match per file
const byFile = new Map<string, Result>();
for (const r of results) {
  const existing = byFile.get(r.source_file);
  if (!existing || r.score < existing.score) {
    byFile.set(r.source_file, r);
  }
}
finalResults = Array.from(byFile.values());
```

Add `--all` flag to show all sections when needed.

### 2. Backend API: SQL Grouping

```sql
SELECT d.*, agg.section_count
FROM documents d
INNER JOIN (
  SELECT
    source_file,
    MIN(id) as first_id,
    MAX(created_at) as latest_created,
    COUNT(*) as section_count
  FROM documents
  GROUP BY source_file
) agg ON d.id = agg.first_id
ORDER BY agg.latest_created DESC
```

This shows one entry per file with section count.

## Results

| Before | After |
|--------|-------|
| 42,145 entries | 4,994 unique files |
| Same file 7x | Each file once |
| Confusing UX | Clean list |

## Key Learning

> "Index at section level for search precision, but display at file level for UX clarity. The backend should handle grouping, not the frontend."

## Debug Output

CLI with `--debug` now shows:
```
│ 3. [2ms]    FTS5 search  7 raw hits         │
│ 4. [0ms]    Group files  4 files → top 4    │
```
