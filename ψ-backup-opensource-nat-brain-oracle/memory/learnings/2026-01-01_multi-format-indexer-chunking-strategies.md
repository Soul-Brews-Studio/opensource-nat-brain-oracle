---
title: "Multi-Format Indexer Chunking Strategies"
date: 2026-01-01
concepts: [indexer, chunking, json, csv, yaml, markdown, text]
---

# Multi-Format Indexer Chunking Strategies

## The Problem

Different file types need different chunking strategies for optimal RAG retrieval.

## Chunking by File Type

| File Type | Chunking Strategy | Record Per |
|-----------|-------------------|------------|
| Markdown | Split by `## ` headers | Section |
| JSON (array) | Each array item | Item |
| JSON (object) | Top-level keys | Key-value pair |
| CSV | Each row | Row with headers |
| YAML | Split by `---` | Document |
| Text | Split by blank lines | Paragraph |

## Implementation Pattern

```typescript
async function parseFile(filePath: string): Promise<ParsedRecord[]> {
  const ext = extname(filePath).toLowerCase();

  switch (ext) {
    case '.md':
      return parseMarkdown(filePath);  // ## sections
    case '.json':
      return parseJSON(filePath);       // array items or keys
    case '.csv':
      return parseCSV(filePath);        // rows with headers
    case '.yaml':
    case '.yml':
      return parseYAML(filePath);       // --- documents
    case '.txt':
      return parseText(filePath);       // paragraphs
    default:
      return [];
  }
}
```

## Key Insights

1. **CSV produces most records** - Each row is a record, so even small CSV files produce many records (51k from 38 files = ~1,300 rows per file average)

2. **JSON chunking depends on structure**:
   - Array: each item is a record
   - Object with few keys: each key is a record
   - Object with many keys: whole object is one record

3. **Markdown section-based** works well for documentation - each `## ` section is a coherent unit

4. **Skip non-content directories** - node_modules, dist, build, .venv, target, .next, .nuxt

## Results

From 7,496 files -> 117,625 records:
- CSV dominates (44%) despite only 38 files
- Markdown next (51%) from 7,011 files
- Good diversity for testing search

---

*Learned during: Data-Aware RAG Multi-Format Indexer Session 2026-01-01*
