---
title: ## DuckDB Markdown Pattern — The Parser Elimination Story
tags: [duckdb, markdown, parsing, extension, pattern, skill, meta-pattern]
created: 2026-01-13
source: Oracle Learn
---

# ## DuckDB Markdown Pattern — The Parser Elimination Story

## DuckDB Markdown Pattern — The Parser Elimination Story

**Date**: 2026-01-13
**Discovery**: DuckDB community extensions eliminate custom parsers

### The Story

We had `parse-schedule.sh` and `parse-tracks.sh` — shell scripts that converted markdown tables to CSV for DuckDB queries. Every time the markdown changed, we regenerated CSV. It worked, but felt wrong.

Then we discovered: DuckDB has a **markdown extension**!

```bash
INSTALL markdown FROM community;
LOAD markdown;
SELECT * FROM read_markdown_sections('schedule.md');
```

Within 6 minutes:
- 06:06 — Discovered extension, added to /recap
- 06:09 — Deleted parse-tracks.sh
- 06:12 — Deleted parse-schedule.sh

Two scripts eliminated. Zero CSV files. Direct queries.

### The Meta-Pattern

> "When you find yourself writing parsers, check for database extensions first."

DuckDB extensions exist for: markdown, JSON, Excel, Parquet, spatial, httpfs, and more.

### Key Functions

- `read_markdown_sections()` — Parse into title/level/content
- `read_markdown()` — Full file with filepath
- `regexp_extract_all()` — Filter specific table rows
- `REGEXP_EXTRACT()` — Extract data from content

### Applied To

- `/recap` skill — tracks query
- `/schedule` skill — created with tests
- Future: Any markdown-as-data workflow

---
*Added via Oracle Learn*
