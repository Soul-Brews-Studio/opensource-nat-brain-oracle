---
title: "DuckDB + Markdown: Query Your Notes Like a Database"
date: 2026-01-13
status: draft
tags: [duckdb, markdown, bun, testing, claude-code, skills]
---

# DuckDB + Markdown: Query Your Notes Like a Database

**TL;DR**: Use DuckDB's markdown extension to query `.md` files directly. No parsing scripts needed. Add Bun tests for confidence. Package as a Claude Code skill for reuse.

---

## The Problem

You have a `schedule.md` with a nice markdown table:

```markdown
## January 2026

| Date | Time | Event | Status |
|------|------|-------|--------|
| Jan 13 (Mon) | 20:50 | ✈️ CNX→BKK | YE5PXD |
| Jan 14 (Tue) | 14:00 | Bitkub Talk | T2-Solana |
| Jan 15 (Wed) | 14:00 | Follow-up Meeting | Bitkub Office |
```

You want to query it: "What's happening today?" or "Find all Bitkub events"

**Old way**: Write a parser script → export CSV → query with DuckDB
**New way**: Query markdown directly!

---

## The Solution: DuckDB Markdown Extension

```bash
# Install once
duckdb -c "INSTALL markdown FROM community; LOAD markdown;"

# Query markdown sections
duckdb -markdown -c "
LOAD markdown;
SELECT title, content
FROM read_markdown_sections('schedule.md')
WHERE title = 'January 2026';
"
```

### Key Functions

| Function | Purpose |
|----------|---------|
| `read_markdown('*.md')` | Read file content |
| `read_markdown_sections('*.md')` | Parse into sections (title, level, content) |
| `regexp_extract_all(content, pattern)` | Extract matching rows |

### Filtering Table Rows

The magic: `regexp_extract_all()` extracts specific rows from a markdown table:

```sql
-- Get only today's rows
SELECT regexp_extract_all(content, '\|[^\n]*Jan 13[^\n]*\|') as today
FROM read_markdown_sections('schedule.md')
WHERE title = 'January 2026';
```

Output:
```
['| Jan 13 (Mon) | 20:50 | ✈️ CNX→BKK | YE5PXD |']
```

---

## Packaging as a Skill

Following the **progressive disclosure** pattern from Anthropic's skill-creator:

```
.claude/skills/schedule/
├── skill.md           # Lean docs (<100 lines)
└── scripts/
    ├── query.sh       # DuckDB queries
    ├── test.sh        # Bash tests
    └── schedule.test.ts  # Bun tests
```

### skill.md (Lean)

```markdown
# /schedule - Query Schedule with DuckDB

- `/schedule` → Show upcoming events
- `/schedule today` → Today only
- `/schedule bitkub` → Search keyword

## Implementation
Run: `.claude/skills/schedule/scripts/query.sh [filter]`
```

### scripts/query.sh

```bash
#!/bin/bash
FILTER="${1:-upcoming}"
TODAY_DAY=$(date '+%d' | sed 's/^0//')

case "$FILTER" in
  today)
    duckdb -markdown -c "
    LOAD markdown;
    SELECT regexp_extract_all(content, '\|[^\n]*Jan $TODAY_DAY[^\n]*\|') as today
    FROM read_markdown_sections('ψ/inbox/schedule.md')
    WHERE title = 'January 2026';
    "
    ;;
  *)
    # Keyword search with (?i) for case-insensitive
    duckdb -markdown -c "
    LOAD markdown;
    SELECT regexp_extract_all(content, '(?i)\|[^\n]*$FILTER[^\n]*\|') as matches
    FROM read_markdown_sections('ψ/inbox/schedule.md')
    WHERE LOWER(content) LIKE LOWER('%$FILTER%');
    "
    ;;
esac
```

---

## Testing: Bash + Bun

### Bash Tests (Quick)

```bash
#!/bin/bash
# test.sh
test_case() {
  local name="$1" cmd="$2" expect="$3"
  if $cmd 2>&1 | grep -q "$expect"; then
    echo "✅ $name"
  else
    echo "❌ $name"
  fi
}

test_case "today returns date" "./query.sh today" "Jan 13"
test_case "keyword finds bitkub" "./query.sh bitkub" "Bitkub"
```

### Bun Tests (Type-safe)

```typescript
// schedule.test.ts
import { describe, test, expect } from "bun:test";
import { $ } from "bun";

describe("/schedule skill", () => {
  test("today returns current date rows", async () => {
    const result = await $`./query.sh today`.text();
    expect(result).toContain("Jan 13");
  });

  test("keyword search finds bitkub", async () => {
    const result = await $`./query.sh bitkub`.text();
    expect(result).toContain("Bitkub");
  });
});
```

Run: `bun test ./.claude/skills/schedule/scripts/schedule.test.ts`

---

## The Three Patterns

This session produced three complementary DuckDB query patterns:

| Skill | Pattern | Data Source |
|-------|---------|-------------|
| `/physical` | `gh api \| duckdb` | GitHub-hosted CSV |
| `/recap` | `read_markdown_sections()` | Local .md files |
| `/schedule` | `regexp_extract_all()` | Markdown table rows |

### `/physical` — GitHub API + DuckDB

```bash
gh api repos/OWNER/REPO/contents/data.csv --jq '.content' | base64 -d | duckdb -c "
SELECT * FROM read_csv('/dev/stdin', header=false, ignore_errors=true)
"
```

Fresh data, no local files, works with private repos.

## The Skill Pattern

1. **DuckDB queries** → Direct data access (no parsers)
2. **Shell script** → Wrap with CLI interface
3. **Dual testing** → Bash for quick, Bun for CI
4. **Skill structure** → `skill.md` + `scripts/` folder

---

## Key Insight

> When you find yourself writing parsers, check if there's a database extension first.

DuckDB has extensions for: markdown, JSON, CSV, Parquet, Excel, spatial data, and more.

---

## References

- [DuckDB Markdown Extension](https://duckdb.org/community_extensions/extensions/markdown)
- [Bun Shell API](https://bun.sh/docs/runtime/shell)
- [Claude Code Skills](https://docs.anthropic.com/claude-code/skills)

---

*Written after building `/schedule` skill for querying my personal schedule.md*
