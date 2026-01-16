# Tag Management Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v7 Phase 2 - Document tagging

## The Pattern

### 1. Simplified Schema

Instead of normalized foreign keys, store tags directly with source_file:

```sql
-- Tags table (for colors/metadata)
CREATE TABLE tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  color TEXT DEFAULT '#3b82f6',
  created_at INTEGER NOT NULL
);

-- Document-tag associations (simple, denormalized)
CREATE TABLE document_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_file TEXT NOT NULL,
  tag TEXT NOT NULL,
  created_at INTEGER DEFAULT (unixepoch()),
  UNIQUE(source_file, tag)
);
```

Advantages:
- No foreign key complexity
- Works with existing data immediately
- Easy to query with simple JOINs
- Self-documenting relationships

### 2. Idempotent Tag Operations

```typescript
// Get or create tag (idempotent)
export function getOrCreateTag(name: string, color = '#3b82f6') {
  const existing = db.query('SELECT * FROM tags WHERE name = ?').get(name.toLowerCase());
  if (existing) return existing;

  db.run('INSERT INTO tags (name, color, created_at) VALUES (?, ?, ?)',
    [name.toLowerCase(), color, Date.now()]);

  return db.query('SELECT * FROM tags WHERE name = ?').get(name.toLowerCase());
}

// Add tags (handles duplicates gracefully)
export function addTagsToDocument(path: string, tags: string[]) {
  const added = [];
  const existing = [];

  for (const tag of tags) {
    try {
      db.run('INSERT INTO document_tags (source_file, tag) VALUES (?, ?)',
        [path, tag.toLowerCase()]);
      added.push(tag);
    } catch {
      existing.push(tag); // UNIQUE constraint violation = already exists
    }
  }

  return { added, existing };
}
```

### 3. CLI Command Structure

```bash
# Subcommand group pattern
const tag = program.command('tag').description('Tag management');

# Each operation is a separate subcommand
tag.command('list')    # Show all tags
tag.command('add')     # Add to document
tag.command('remove')  # Remove from document
tag.command('show')    # Show document's tags
tag.command('search')  # Find by tag
tag.command('delete')  # Delete tag entirely
```

### 4. Merging Tag Sources

When tags exist in multiple tables, merge intelligently:

```typescript
export function listTags() {
  const tagMap = new Map();

  // From tags table (has colors)
  for (const t of db.query('SELECT * FROM tags').all()) {
    tagMap.set(t.name, { ...t, count: 0 });
  }

  // From document_tags (has counts)
  for (const dt of db.query('SELECT tag, COUNT(*) as count FROM document_tags GROUP BY tag').all()) {
    if (tagMap.has(dt.tag)) {
      tagMap.get(dt.tag).count = dt.count;
    } else {
      tagMap.set(dt.tag, { name: dt.tag, color: '#3b82f6', count: dt.count });
    }
  }

  return Array.from(tagMap.values());
}
```

## Anti-Patterns

```typescript
// BAD: Require document ID (documents use source_file as natural key)
function addTag(documentId: string, tag: string) { ... }

// GOOD: Match by path (partial match with LIKE)
function addTag(documentPath: string, tag: string) {
  const doc = db.query('SELECT source_file FROM documents WHERE source_file LIKE ?')
    .get(`%${documentPath}`);
  // ...
}

// BAD: Fail on duplicate tag
db.run('INSERT INTO document_tags ...');  // throws on UNIQUE violation

// GOOD: Try-catch for idempotency
try {
  db.run('INSERT INTO document_tags ...');
  added.push(tag);
} catch {
  existing.push(tag);
}
```

## CLI UX Decisions

| Decision | Rationale |
|----------|-----------|
| `--tags "a,b,c"` | Single flag, comma-separated |
| Case insensitive | Prevents duplicates like "Important" vs "important" |
| Partial path match | User doesn't need full absolute path |
| `--force` for delete | Destructive operations need confirmation |

---

*Tag management: Simple schema + idempotent operations + path matching*
