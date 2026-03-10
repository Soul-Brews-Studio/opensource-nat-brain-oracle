---
title: ## DustBoy PhD Data Pipeline
tags: [dustboy, phd, white-server, data-pipeline, parquet, duckdb]
created: 2026-01-01
source: Session 2026-01-02 - Data Export Complete
---

# ## DustBoy PhD Data Pipeline

## DustBoy PhD Data Pipeline

**Owner**: Nat (PhD candidate, Climate Change @ CMU)

### Data Architecture
- **WHITE server** (88GB DuckDB): `white.local` or `floodboy-white4.alchemycat.org`
- **Local MacBook** (7.6GB Parquet): `parquet-exports-by-model/`
- **Records**: 2.6B raw → 1.29B deduplicated
- **Sensors**: 1,355 across 10 models
- **Period**: 2019-2024

### Access Patterns
| Location | Use Case | Connection |
|----------|----------|------------|
| white.local | Heavy queries, tmux | LAN only |
| floodboy-white4.alchemycat.org | Remote access | SSH tunnel |
| Local Parquet | Dashboard, exploration | Direct |

### Key Learnings
1. **Divide & conquer** for large DISTINCT exports (split by year/half-year)
2. **Pre-calculate aggregations** for static historical data
3. **Streamlit** for interactive sensor exploration
4. **>1000 PM2.5** mostly sensor errors, not real burning

---
*Added via Oracle Learn*
