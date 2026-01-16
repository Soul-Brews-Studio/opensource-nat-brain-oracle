---
title: ## DuckDB Markdown Extension — Query Markdown Directly
tags: [duckdb, markdown, parsing, sql, efficiency, tools]
created: 2026-01-12
source: Session 2026-01-13 - DuckDB markdown discovery
---

# ## DuckDB Markdown Extension — Query Markdown Directly

## DuckDB Markdown Extension — Query Markdown Directly

**Discovery**: 2026-01-13
**Commit**: 54646c7f (added), next commit (removed parse scripts)

### The Pattern

Instead of: `parse-*.sh → CSV → DuckDB query`
Now: `DuckDB markdown extension → query .md files directly`

### Install & Use

```bash
# Install once
duckdb -c "INSTALL markdown FROM community; LOAD markdown;"

# Query markdown with glob patterns
duckdb -markdown -c "
LOAD markdown;
SELECT title, content FROM read_markdown_sections('ψ/inbox/tracks/*.md')
WHERE level = 1;
"
```

### Key Functions

- `read_markdown('*.md')` — Full content
- `read_markdown_sections('**/*.md')` — Parsed sections (title, level, content)
- `read_markdown_blocks()` — Block-level elements
- `md_extract_code_blocks()` — Extract code
- `REGEXP_EXTRACT(content, pattern, group)` — Regex extraction
- `-markdown` flag — Output as markdown table

### Applied To

- `/recap` skill — tracks query uses markdown extension
- Replaced parse-tracks.sh (deleted)
- Future: Can replace all parse-*.sh scripts

### Key Insight

> "When you find yourself writing parsers, check if there's a database extension first."

**Source**: https://duckdb.org/community_extensions/extensions/markdown

---
*Added via Oracle Learn*
