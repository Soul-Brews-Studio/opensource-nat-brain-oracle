---
title: Data File Query Pattern: Explore vs Query
tags: [jq, duckdb, query-pattern, explore, golden-rules, json, yaml, csv, markdown]
created: 2026-01-13
source: Session 2026-01-13 - User clarification: jq explore, duckdb query
---

# Data File Query Pattern: Explore vs Query

Data File Query Pattern: Explore vs Query

**Golden Rule #13 Extended**

| File | Explore | Query |
|------|---------|-------|
| `.json` | `jq` | `duckdb json` |
| `.yaml` | `yq` | - |
| `.csv` | `head` | `duckdb csv` |
| `.md` | - | `duckdb markdown` |

**Mental Model**:
- **Explore** (jq/yq): "What's in here?" — structure, keys, sample
- **Query** (duckdb): "Give me rows where X" — SQL, aggregate, join

```bash
# Explore first
jq 'keys' data.json
jq '.[0]' data.json

# Then query
duckdb -c "SELECT * FROM read_json_auto('data.json') WHERE status='active'"
```

NEVER use Read tool for data files. Explore or Query instead.

---
*Added via Oracle Learn*
