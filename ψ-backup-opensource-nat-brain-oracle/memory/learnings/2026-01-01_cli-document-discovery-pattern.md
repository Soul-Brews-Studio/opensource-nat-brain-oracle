# CLI Document Discovery Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v4 - CLI Commands

## The Pattern

### 1. Info Command - Document Details
```typescript
// Get document by path or ID (flexible lookup)
function getDocumentInfo(pathOrId: string) {
  // Try exact ID match first
  let doc = db.query('SELECT * FROM documents WHERE id = ?').get(pathOrId);

  // Fallback to source_file LIKE match
  if (!doc) {
    doc = db.query('SELECT * FROM documents WHERE source_file LIKE ?')
      .get(`%${pathOrId}`);
  }

  // Return enriched info
  return {
    document: doc,
    sections: countSections(doc.source_file),
    wordCount: countWords(doc.content),
  };
}
```

### 2. Similar Command - FTS5-based Similarity
```typescript
// Find similar documents using term overlap
function findSimilarDocuments(pathOrId: string, limit = 5) {
  const source = getDocumentInfo(pathOrId);

  // Extract top terms (frequency-based)
  const topTerms = extractTopTerms(source.content, 10);

  // Search FTS5 with OR query
  const searchQuery = topTerms.join(' OR ');
  const results = db.query(`
    SELECT id, source_file, rank as score
    FROM documents_fts
    WHERE documents_fts MATCH ?
    AND id != ?
    ORDER BY rank
  `).all(searchQuery, source.id);

  // Deduplicate by source_file
  return deduplicateByFile(results);
}
```

### 3. Clean Command - Index Hygiene
```typescript
// Remove orphaned entries
function cleanIndex(dryRun = false) {
  const files = db.query('SELECT DISTINCT source_file FROM documents').all();

  for (const { source_file } of files) {
    if (!fs.existsSync(source_file)) {
      if (!dryRun) {
        db.run('DELETE FROM documents WHERE source_file = ?', [source_file]);
      }
    }
  }
}
```

## Key Learnings

1. **Flexible path matching** - Allow partial paths, not just exact IDs
2. **Term extraction** - Filter stopwords, use frequency for relevance
3. **Deduplicate results** - Group by source_file, not section ID
4. **Dry-run support** - Always offer preview before destructive ops
5. **JSON output** - Support `--json` for scripting integration

## CLI Commands Added

| Command | Purpose | Options |
|---------|---------|---------|
| `info <path>` | Show document details | `--json` |
| `similar <path>` | Find related docs | `-l`, `--json` |
| `clean` | Remove deleted files | `--dry-run` |
| `vacuum` | Optimize database | - |

## FTS5 Similarity Approach

Instead of vector embeddings, use FTS5 for similarity:
1. Extract top N terms from source document
2. Build `term1 OR term2 OR ...` query
3. Search FTS5, rank by BM25 score
4. Show shared terms for explainability

**Trade-off**: Less semantic, but fully explainable and fast.

---

*FTS5-based similarity: Explainable, fast, no external deps.*
