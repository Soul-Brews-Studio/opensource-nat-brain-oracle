# Long Run CLI Building Pattern

**Date**: 2025-12-31
**Session**: Long run practice - built 13 CLIs (065-077)

## The Pattern

Built 13 CLIs in one session using consistent pattern:

### Structure
```
ψ/lab/{app}/
├── src/
│   └── index.ts      # CLI entry (Commander.js)
├── package.json      # bin + scripts
└── data/             # SQLite db (if needed)
```

### Commands (Template)
```bash
# 1. Create directories
mkdir -p specs/{id}-{name} ψ/lab/{name}/src

# 2. Init with bun
cd ψ/lab/{name} && bun init -y && bun add commander

# 3. Write spec.md (minimal)
# 4. Write src/index.ts
# 5. Update package.json (add bin + scripts)
# 6. Test
# 7. Commit + push
```

### package.json Template
```json
{
  "bin": { "cmd": "./src/index.ts" },
  "scripts": { "start": "bun run src/index.ts" }
}
```

## Timing

| Type | Time |
|------|------|
| Simple utility (no db) | ~1-2 min |
| Database CLI | ~5 min |

## CLIs Built

1. **065-link-saver** - Save/tag URLs (SQLite+FTS5)
2. **066-daily-log** - Journal entries (SQLite)
3. **067-time-tracker** - Track time (SQLite)
4. **068-password-gen** - Generate passwords
5. **069-uuid-gen** - Generate UUIDs
6. **070-hash-gen** - MD5/SHA hashes
7. **071-base64** - Encode/decode
8. **072-json-fmt** - Format JSON
9. **073-timestamp** - Convert timestamps
10. **074-word-count** - Count words
11. **075-ip-info** - IP lookup
12. **076-file-size** - File sizes
13. **077-lorem** - Lorem ipsum

## Key Learnings

### 1. Commander.js Negation
```typescript
// --no-symbols sets options.symbols = false
.option('--no-symbols', 'Exclude symbols')

// Check with !== false
if (options.symbols !== false) { ... }
```

### 2. Drizzle Field Names
Drizzle returns camelCase, raw SQL returns snake_case:
```typescript
// Drizzle: active.startedAt
// Raw SQL: row.started_at
const session = { started_at: active.startedAt, ended_at: active.endedAt };
```

### 3. Clipboard (macOS)
```typescript
import { spawn } from 'child_process';
function copyToClipboard(text: string) {
  const proc = spawn('pbcopy', [], { stdio: ['pipe', 'inherit', 'inherit'] });
  proc.stdin?.write(text);
  proc.stdin?.end();
}
```

### 4. Bun Path Resolution
```typescript
const DATA_DIR = `${import.meta.dir}/../../data`;
```

### 5. FTS5 Pattern
```sql
CREATE VIRTUAL TABLE items_fts USING fts5(
  title, content,
  content='items',
  content_rowid='id'
);

-- Triggers to sync
CREATE TRIGGER items_ai AFTER INSERT ON items BEGIN
  INSERT INTO items_fts(rowid, title, content)
  VALUES (new.id, new.title, new.content);
END;
```

## Efficiency Tips

1. **Copy-paste pattern** - Same structure every time
2. **Minimal specs** - Just list commands, no detail
3. **Test immediately** - Catch issues early
4. **Commit after each** - Stay synced
5. **No overthinking** - Build fast, iterate if needed

---

**Pattern proven**: 13 CLIs in ~30 minutes = efficient.
