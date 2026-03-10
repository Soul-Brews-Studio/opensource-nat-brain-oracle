# Multi-Format Indexing Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v3 - adding YAML parser and verifying multi-format support
**Impact**: System now indexes markdown, JSON, and YAML files correctly

## The Pattern

Each file format needs a parser that returns `RawRecord[]`:

```typescript
interface RawRecord {
  id: string;
  content: string;
  contentType: 'text' | 'image' | 'link' | 'unknown';
  metadata: Record<string, unknown>;
  sourceFile: string;
  sourceType: 'markdown' | 'json' | 'yaml' | 'csv' | 'text';
}
```

## Format-Specific Parsers

### Markdown
```typescript
// Simple - whole file as one record
return [{
  id: basename(filePath, ext),
  content,
  contentType: 'text',
  metadata: { path: filePath },
  sourceFile: filePath,
  sourceType: 'markdown',
}];
```

### JSON
```typescript
// Handle arrays and objects with common field names
const data = JSON.parse(content);
const items = Array.isArray(data)
  ? data
  : data.data || data.messages || data.items || [data];

return items.map((item, i) => ({
  id: `${sourceName}_${item.id || i}`,
  content: item.text || item.content || item.message || '',
  // ...
}));
```

### YAML
```typescript
// Handle multi-document YAML files (separated by ---)
const { parse } = await import('yaml');
const docs = content.split(/^---$/m).filter(d => d.trim());

return docs.map((doc, i) => {
  const parsed = parse(doc);
  const text = typeof parsed === 'string'
    ? parsed
    : parsed?.content || parsed?.text || JSON.stringify(parsed);
  // ...
});
```

### CSV
```typescript
// Already in loaders/csv.ts
// Auto-detects content column by name or length
```

## Key Decisions

1. **Dynamic imports** - Use `await import()` for format-specific packages to avoid loading everything upfront

2. **Graceful fallback** - If parsing fails, store raw content:
   ```typescript
   } catch {
     return { content: doc, metadata: { raw: true } };
   }
   ```

3. **Content detection** - Look for common field names:
   - `content`, `text`, `message`, `description`, `body`

4. **ID generation** - `${filename}_${index}` for array items

## Results

```
Before: 100% markdown (42,145 docs)
After:  97.1% markdown + 2.8% json + 0.0% yaml (43,383 docs)
```

## Files Modified

- `ψ/lab/data-aware-rag/src/core/indexer.ts` - Added YAML parser
- `ψ/lab/data-aware-rag/package.json` - Added yaml dependency

## Key Statement

> Each format parser transforms source-specific structure into uniform `RawRecord[]`. The indexer doesn't care about format - it just stores records.
