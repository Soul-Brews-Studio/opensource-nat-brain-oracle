---
title: Golden Rule #13: Query markdown, don't Read
tags: [duckdb, markdown, golden-rules, query-pattern, discipline]
created: 2026-01-13
source: Session 2026-01-13 - User correction after breaking rule twice
---

# Golden Rule #13: Query markdown, don't Read

Golden Rule #13: Query markdown, don't Read

NEVER use Read tool for .md files. Always use DuckDB markdown extension:

```bash
# Use /md skill
/md file.md                      # All sections
/md file.md --section "Title"    # Specific section
/md file.md --filter "pattern"   # Table rows

# Or direct DuckDB
duckdb -c "LOAD markdown; SELECT * FROM read_markdown_sections('file.md')"
```

If query fails → Fix the query or write code. Never fall back to Read tool.

The cycle: Query → Error? → Fix → Learn → Remember → Growth → Query again

---
*Added via Oracle Learn*
