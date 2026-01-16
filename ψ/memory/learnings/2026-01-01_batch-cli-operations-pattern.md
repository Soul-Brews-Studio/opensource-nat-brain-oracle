# Batch CLI Operations Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v4 - Batch Operations

## The Pattern

### 1. Glob-Based File Matching

```typescript
import { glob } from 'glob';

const files = await glob(pattern, { absolute: true });
if (files.length === 0) {
  console.log('No files found matching pattern');
  return;
}
```

### 2. Dry-Run Preview

```typescript
.option('--dry-run', 'Show what would be done')

if (options.dryRun) {
  files.slice(0, 10).forEach(f =>
    console.log(`  Would reindex: ${path.basename(f)}`)
  );
  if (files.length > 10) {
    console.log(`  ... and ${files.length - 10} more`);
  }
  console.log(`\nDry run: ${files.length} files would be affected`);
  return;
}
```

### 3. SQL Pattern Matching

```sql
-- Match by path pattern
SELECT * FROM documents WHERE source_file LIKE '%pattern%'

-- Match by type
SELECT * FROM documents WHERE source_type = ?
```

### 4. Before/After Stats

```typescript
const beforeCount = getUniqueFileCount();
// ... perform operation ...
const afterCount = getUniqueFileCount();
console.log(`Files: ${beforeCount} -> ${afterCount}`);
```

## Complete CLI Examples

### Reindex Command

```typescript
program
  .command('reindex <pattern>')
  .description('Re-index files matching pattern')
  .option('--dry-run', 'Show what would be re-indexed')
  .option('--force', 'Force re-index even if unchanged')
  .action(async (pattern, options) => {
    const files = await glob(pattern, { absolute: true });

    if (options.dryRun) {
      // Preview only
      return;
    }

    for (const file of files) {
      sqlite.run('DELETE FROM documents WHERE source_file = ?', [file]);
    }
    console.log(`Removed ${files.length} files (run 'index' to re-add)`);
  });
```

### Delete Command

```typescript
program
  .command('delete <pattern>')
  .description('Delete documents matching pattern')
  .option('--dry-run', 'Show what would be deleted')
  .option('--by-type', 'Match by source_type instead of path')
  .action(async (pattern, options) => {
    let query: string;
    if (options.byType) {
      query = 'WHERE source_type = ?';
    } else {
      query = 'WHERE source_file LIKE ?';
      pattern = `%${pattern}%`;
    }

    const files = sqlite.query(`SELECT DISTINCT source_file FROM documents ${query}`).all(pattern);

    if (options.dryRun) {
      // Preview only
      return;
    }

    for (const { source_file } of files) {
      sqlite.run('DELETE FROM documents WHERE source_file = ?', [source_file]);
    }
  });
```

### Tag System

```typescript
program
  .command('tag <action> <tag>')
  .description('Manage tags (add/remove/list)')
  .option('--source <pattern>', 'Source file pattern')
  .option('--type <type>', 'Source type')
  .action(async (action, tag, options) => {
    // Ensure table exists
    sqlite.exec(`
      CREATE TABLE IF NOT EXISTS document_tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        source_file TEXT NOT NULL,
        tag TEXT NOT NULL,
        created_at INTEGER DEFAULT (unixepoch()),
        UNIQUE(source_file, tag)
      )
    `);

    if (action === 'list') {
      const tags = sqlite.query(`
        SELECT tag, COUNT(*) as count
        FROM document_tags GROUP BY tag ORDER BY count DESC
      `).all();
      tags.forEach(t => console.log(`  ${t.tag}: ${t.count} files`));
      return;
    }

    // Get matching files
    const files = getMatchingFiles(options);

    if (action === 'add') {
      for (const { source_file } of files) {
        sqlite.run(
          'INSERT OR IGNORE INTO document_tags (source_file, tag) VALUES (?, ?)',
          [source_file, tag]
        );
      }
    } else if (action === 'remove') {
      for (const { source_file } of files) {
        sqlite.run(
          'DELETE FROM document_tags WHERE source_file = ? AND tag = ?',
          [source_file, tag]
        );
      }
    }
  });
```

## Key Learnings

1. **Always support dry-run** - Users need to preview before destructive ops
2. **Show preview (first 10)** - Don't spam terminal with huge lists
3. **Before/after stats** - Quantify the impact
4. **Multiple filter modes** - Path pattern vs type filter
5. **INSERT OR IGNORE** - Gracefully handle duplicates
6. **UNIQUE constraint** - Prevent tag duplicates at DB level

## Anti-Patterns

```typescript
// BAD: No preview option
.action(async (pattern) => {
  sqlite.run('DELETE FROM documents WHERE source_file LIKE ?', [`%${pattern}%`]);
});

// GOOD: Dry-run first
.option('--dry-run', 'Preview what would be deleted')
.action(async (pattern, options) => {
  const files = findMatches(pattern);
  if (options.dryRun) {
    showPreview(files);
    return;
  }
  deleteFiles(files);
});
```

---

*Batch operations: Preview first, stats after, never surprise the user.*
