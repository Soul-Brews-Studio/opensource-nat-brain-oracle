# Incremental Indexing with File Hash Detection

**Date**: 2026-01-01
**Context**: Data-Aware RAG v3 - avoiding redundant re-indexing
**Impact**: 10 files in 727ms → 0 records when unchanged

## The Problem

Without incremental indexing:
- Every `index` command re-parses and stores ALL files
- Wastes time on unchanged files
- Duplicates work already done

## The Solution

Store SHA256 hash of file content alongside documents:

```typescript
// Check before parsing
const content = await readFile(file, 'utf-8');
const hash = hashContent(content);
const existingHash = getFileHash(file);

if (existingHash === hash) {
  console.log(`[SKIP] ${basename(file)} (unchanged)`);
  continue;
}

// After indexing, store hash
updateFileHash(file, hash);
```

## Database Schema Addition

```sql
ALTER TABLE documents ADD COLUMN file_hash TEXT;
ALTER TABLE documents ADD COLUMN file_mtime INTEGER;
ALTER TABLE documents ADD COLUMN indexed_at INTEGER;
CREATE INDEX idx_documents_hash ON documents(file_hash);
```

## CLI Usage

```bash
# Without incremental - re-index everything
bun run cli index ./docs --limit 1000

# With incremental - skip unchanged
bun run cli index ./docs --limit 1000 --incremental

# Output:
# [SKIP] README.md (unchanged)
# [SKIP] API.md (unchanged)
# .....
# Skipped (unchanged): 998
# Records indexed: 2
```

## Why Hash Instead of mtime?

| Method | Pros | Cons |
|--------|------|------|
| **mtime** | Fast (stat only) | Can change without content change |
| **Hash** | Accurate (content-based) | Slower (read + hash) |

We use **hash** because:
1. Files can be touched without changing (git operations, backup restore)
2. Content is the source of truth
3. Reading file is already needed for indexing

## Key Insight

> The check happens **before** parsing. If hash matches, we skip the entire parsing pipeline - not just the database insert.

## Files Modified

- `ψ/lab/data-aware-rag/src/db/sqlite.ts` - getFileHash, updateFileHash
- `ψ/lab/data-aware-rag/scripts/index-data.ts` - --incremental flag
- `ψ/lab/data-aware-rag/src/cli/rag.ts` - CLI option
- `ψ/lab/data-aware-rag/src/core/indexer.ts` - hash calculation

## Key Statement

> Hash-based incremental indexing trades O(n) file reads for O(1) database lookups on unchanged files. Worth it when most files don't change.
