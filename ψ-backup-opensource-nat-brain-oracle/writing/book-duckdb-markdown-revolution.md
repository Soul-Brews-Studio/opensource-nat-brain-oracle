---
title: "The DuckDB Markdown Revolution"
subtitle: "How Database Extensions Eliminated My Parser Scripts"
author: Nat
date: 2026-01-13
type: book
status: draft
chapters: 5
---

# The DuckDB Markdown Revolution

> "When you find yourself writing parsers, check for database extensions first."

---

## Preface

This book documents a discovery that changed how I manage data in my AI-assisted workflow. In 6 minutes, I eliminated two shell scripts and an entire CSV pipeline—replaced by a single SQL query.

This isn't just about DuckDB. It's about a **meta-pattern**: the tools we build reveal the tools we're missing.

---

# Chapter 1: The Parser Problem

## The Setup

I maintain my schedule in `schedule.md`—a simple markdown file with tables:

```markdown
## January 2026

| Date | Time | Event | Status |
|------|------|-------|--------|
| Jan 13 (Mon) | 20:50 | ✈️ CNX→BKK | YE5PXD |
| Jan 14 (Tue) | 14:00 | Bitkub Talk | T2-Solana |
```

I wanted to query it: "What's happening today?"

## The Old Solution

Like any good engineer, I wrote scripts:

```bash
# parse-schedule.sh (53 lines)
# Extracts markdown table → CSV
grep "^|" schedule.md | \
  sed 's/|/,/g' | \
  tail -n +3 > schedule.csv
```

Then query:

```bash
duckdb -c "SELECT * FROM read_csv_auto('schedule.csv') WHERE date LIKE '%Jan 13%'"
```

It worked. But something felt wrong.

## The Friction Points

1. **Two-step process** — Parse, then query
2. **Stale data** — CSV diverges from markdown
3. **Maintenance burden** — Every format change breaks the parser
4. **Duplicated effort** — Same pattern for tracks.md, logs.md...

I had 2 parse scripts. I was about to write a third.

---

# Chapter 2: The Discovery

## 06:06 — The Moment

While improving my `/recap` skill, I wondered: "Does DuckDB have a markdown extension?"

```bash
duckdb -c "INSTALL markdown FROM community;"
```

It did.

```sql
LOAD markdown;
SELECT title, content
FROM read_markdown_sections('schedule.md');
```

I stared at the output. My schedule, parsed into sections. No script needed.

## The Functions

| Function | Purpose |
|----------|---------|
| `read_markdown('*.md')` | Full file content |
| `read_markdown_sections('*.md')` | Sections with title, level, content |
| `read_markdown('*.md', include_filepath=true)` | Multiple files with paths |
| `regexp_extract_all(content, pattern)` | Extract matching parts |

## The Killer Feature

`regexp_extract_all()` extracts specific rows from markdown tables:

```sql
SELECT regexp_extract_all(content, '\|[^\n]*Jan 13[^\n]*\|') as today
FROM read_markdown_sections('schedule.md')
WHERE title = 'January 2026';
```

Output: `['| Jan 13 (Mon) | 20:50 | ✈️ CNX→BKK | YE5PXD |']`

One query. No parsing. Direct from markdown.

---

# Chapter 3: The Elimination

## 06:08 — Applied to /recap

My `/recap` skill needed tracks data. Old way:

```bash
./parse-tracks.sh > tracks.csv
duckdb -c "SELECT * FROM read_csv_auto('tracks.csv')"
```

New way:

```sql
SELECT
    REGEXP_EXTRACT(title, '^Track ([0-9]+)', 1) as id,
    REGEXP_EXTRACT(content, '\\*\\*Status\\*\\*: ([^\\n]+)', 1) as status
FROM read_markdown_sections('ψ/inbox/tracks/*.md')
WHERE level = 1;
```

Glob patterns work. I can query all tracks at once.

## 06:09 — Deleted parse-tracks.sh

```bash
git rm .claude/skills/recap/scripts/parse-tracks.sh
git rm ψ/data/tracks.csv
git commit -m "refactor: remove deprecated parse-tracks.sh"
```

49 lines deleted. One CSV file gone.

## 06:12 — Deleted parse-schedule.sh

```bash
git rm .claude/skills/schedule/scripts/parse-schedule.sh
git commit -m "refactor: remove unused parse-schedule.sh"
```

53 lines deleted.

**Total: 102 lines eliminated in 6 minutes.**

---

# Chapter 4: The New Skill

## Building /schedule

With the pattern proven, I built a proper skill:

```
.claude/skills/schedule/
├── skill.md              # Documentation
└── scripts/
    ├── query.sh          # DuckDB queries
    ├── test.sh           # Bash tests
    └── schedule.test.ts  # Bun tests
```

## The Query Script

```bash
#!/bin/bash
FILTER="${1:-upcoming}"

case "$FILTER" in
  today)
    duckdb -markdown -c "
    LOAD markdown;
    SELECT regexp_extract_all(content, '\|[^\n]*$(date +%b) $(date +%d)[^\n]*\|') as today
    FROM read_markdown_sections('ψ/inbox/schedule.md')
    WHERE title = 'January 2026';
    "
    ;;
  *)
    duckdb -markdown -c "
    LOAD markdown;
    SELECT regexp_extract_all(content, '(?i)\|[^\n]*$FILTER[^\n]*\|') as matches
    FROM read_markdown_sections('ψ/inbox/schedule.md')
    WHERE LOWER(content) LIKE LOWER('%$FILTER%');
    "
    ;;
esac
```

## Dual Testing

**Bash tests** for quick iteration:

```bash
test_case "today returns date" "./query.sh today" "Jan 13"
```

**Bun tests** for type safety and CI:

```typescript
test("today returns current date rows", async () => {
  const result = await $`./query.sh today`.text();
  expect(result).toContain("Jan 13");
});
```

All 6 tests pass.

---

# Chapter 5: The Meta-Pattern

## Parser Elimination Pattern

When you catch yourself writing a parser:

1. **Stop** — Don't write another line
2. **Search** — Check for database extensions
3. **Install** — `INSTALL [extension] FROM community`
4. **Query** — Use the native functions
5. **Delete** — Remove your old parsers

## The Three Data Query Patterns

This session birthed three complementary patterns:

| Skill | Pattern | Data Source |
|-------|---------|-------------|
| `/physical` | `gh api \| duckdb` | GitHub-hosted CSV |
| `/recap` | `read_markdown_sections()` | Local .md files |
| `/schedule` | `regexp_extract_all()` | Markdown table rows |

### Pattern 1: GitHub API + DuckDB (`/physical`)

Query CSV files hosted on GitHub without downloading:

```bash
gh api repos/laris-co/nat-location-data/contents/history.csv \
  --jq '.content' | base64 -d | duckdb -c "
SELECT MIN(updated), MAX(updated), COUNT(*) as records
FROM read_csv('/dev/stdin', header=false, ignore_errors=true)
WHERE device LIKE '%iPhone%'"
```

**Why**: Fresh data every query. No local storage. Works with private repos.

### Pattern 2: Markdown Extension (`/recap`)

Query markdown files directly:

```sql
LOAD markdown;
SELECT title, content FROM read_markdown_sections('tracks/*.md');
```

**Why**: No parse scripts. Glob patterns. Structured sections.

### Pattern 3: Row Extraction (`/schedule`)

Filter specific rows from markdown tables:

```sql
SELECT regexp_extract_all(content, '\|[^\n]*Jan 13[^\n]*\|')
FROM read_markdown_sections('schedule.md');
```

**Why**: Precise filtering. Case-insensitive with `(?i)`. Returns arrays.

## DuckDB's Extension Ecosystem

| Extension | Parses |
|-----------|--------|
| markdown | .md files |
| json | .json files |
| excel | .xlsx files |
| parquet | .parquet files |
| spatial | GeoJSON, shapefiles |
| httpfs | Remote files via HTTP |

## The Deeper Lesson

**The tools we build reveal the tools we're missing.**

I built `parse-schedule.sh` because I didn't know `read_markdown_sections()` existed. The parser was a symptom—the cure was discovery.

This applies beyond DuckDB:

- Writing a web scraper? Check if there's an API.
- Building a converter? Check if the format is already supported.
- Creating a wrapper? Check if someone abstracted it already.

---

## Epilogue: The 6-Minute Revolution

| Time | Action |
|------|--------|
| 06:06 | Discovered DuckDB markdown extension |
| 06:08 | Applied to /recap skill |
| 06:09 | Deleted parse-tracks.sh |
| 06:12 | Deleted parse-schedule.sh |
| 07:56 | Built /schedule skill with tests |
| 08:04 | Wrote this book |

**102 lines of parser code eliminated.**
**1 SQL query to rule them all.**

---

## Appendix: Quick Reference

### Install

```bash
duckdb -c "INSTALL markdown FROM community; LOAD markdown;"
```

### Query Sections

```sql
SELECT title, content FROM read_markdown_sections('file.md');
```

### Extract Table Rows

```sql
SELECT regexp_extract_all(content, '\|[^\n]*PATTERN[^\n]*\|') as rows
FROM read_markdown_sections('file.md')
WHERE title = 'Section Name';
```

### Query Multiple Files

```sql
SELECT file_path, title, content
FROM read_markdown('**/*.md', include_filepath=true);
```

---

*"Query your notes like a database. Because they are one."*

