# DuckDB Markdown Extension — Game Changer

**Date**: 2026-01-13 06:06
**Context**: Improving /recap skill performance
**Discovery**: DuckDB has a community markdown extension that eliminates need for parse scripts

---

## The Old Way (Before)

```bash
# 1. Create parse script (parse-schedule.sh, parse-tracks.sh)
# 2. Run script to generate CSV
# 3. Query CSV with DuckDB
duckdb -c "SELECT * FROM read_csv_auto('ψ/data/tracks.csv')"
```

**Problems**:
- Extra scripts to maintain
- CSV files to regenerate when source changes
- Two-step process

---

## The New Way (After)

```bash
# Install once
duckdb -c "INSTALL markdown FROM community; LOAD markdown;"

# Query markdown directly!
duckdb -markdown -c "
LOAD markdown;
SELECT title, content
FROM read_markdown_sections('ψ/inbox/tracks/*.md')
WHERE level = 1;
"
```

**Benefits**:
- No parse scripts needed
- No CSV intermediate files
- Query any markdown with glob patterns
- Extract sections, metadata, code blocks
- `-markdown` flag outputs markdown tables directly

---

## Key Functions

| Function | Purpose |
|----------|---------|
| `read_markdown('*.md')` | Full file content |
| `read_markdown_sections('*.md')` | Parsed sections with title, level, content |
| `read_markdown_blocks('*.md')` | Block-level elements |
| `md_extract_code_blocks()` | Extract code blocks |
| `md_extract_metadata()` | Extract frontmatter |
| `REGEXP_EXTRACT(content, pattern, group)` | Regex extraction |

---

## Example: Query Tracks

```sql
LOAD markdown;
SELECT
    REGEXP_EXTRACT(title, '^Track ([0-9]+)', 1) as id,
    REGEXP_REPLACE(title, '^Track [0-9]+: ', '') as name,
    REGEXP_EXTRACT(content, '\\*\\*Status\\*\\*: ([^\\n]+)', 1) as status
FROM read_markdown_sections('ψ/inbox/tracks/*.md')
WHERE level = 1 AND title NOT LIKE '%INDEX%'
ORDER BY id DESC;
```

---

## Example: Search AI Diary

```sql
LOAD markdown;
SELECT title, LEFT(content, 100) as preview
FROM read_markdown_sections('ψ/memory/retrospectives/**/*.md')
WHERE title = 'AI Diary'
ORDER BY start_line DESC
LIMIT 5;
```

---

## Performance

From extension docs:
> Processing 287 Markdown files (2,699 sections, 1,137 code blocks, 1,174 links) in 603ms.

Fast enough for real-time queries in `/recap`.

---

## Applied To

- `/recap` skill — tracks query now uses markdown extension
- Schedule queries can use it (with fallback to grep)
- Future: Replace all parse-*.sh scripts

---

**Key Insight**: When you find yourself writing parsers, check if there's a database extension first.

**Source**: https://duckdb.org/community_extensions/extensions/markdown
