---
title: ## GitHub API + DuckDB Pattern (gh api | duckdb)
tags: [duckdb, github, api, csv, pattern, physical, location]
created: 2026-01-13
source: Oracle Learn
---

# ## GitHub API + DuckDB Pattern (gh api | duckdb)

## GitHub API + DuckDB Pattern (gh api | duckdb)

**Skill**: /physical
**Date**: 2026-01-13
**Purpose**: Query GitHub-hosted CSV data without downloading files

### The Pattern

```bash
gh api repos/OWNER/REPO/contents/FILE.csv --jq '.content' | base64 -d | duckdb -c "
SELECT * FROM read_csv('/dev/stdin', 
  header=false, 
  ignore_errors=true, 
  null_padding=true,
  columns={...})
"
```

### Key Components

1. `gh api` — Fetch file content from GitHub
2. `--jq '.content'` — Extract base64 content
3. `base64 -d` — Decode
4. `duckdb -c` — Query via stdin
5. `read_csv('/dev/stdin')` — DuckDB reads from pipe

### Why This Pattern?

- No local file storage needed
- Always queries fresh data
- Works with private repos (gh auth)
- Schema defined explicitly (handles inconsistent CSVs)

### Applied To

- `/physical` skill — location data from nat-location-data repo
- Potential: Any GitHub-hosted CSV/JSON data

### Compared to Markdown Pattern

| Pattern | Source | Method |
|---------|--------|--------|
| `gh api \| duckdb` | GitHub CSV | Pipe through stdin |
| DuckDB markdown | Local .md | read_markdown_sections() |

---
*Added via Oracle Learn*
