---
title: ## Project Spinoff Pattern
tags: [spinoff, repo-hygiene, data-migration, gitignore, parquet, project-organization]
created: 2026-01-04
source: 2026-01-04 dustboy spinoff session
---

# ## Project Spinoff Pattern

## Project Spinoff Pattern

When a project in ψ/lab/ grows beyond 1GB (especially data files like parquet), spinoff to its own repo immediately.

### Steps:
1. `gh repo create laris-co/[project] --private`
2. Clone to `~/Code/github.com/laris-co/[project]/`
3. Copy code files (*.py, *.md, *.sh)
4. Create `.gitignore` for data folders (*.parquet, exports/, data/)
5. `mv` data folders to new location (not cp - saves disk)
6. Verify sizes match before deleting source
7. Move source to /tmp (not rm -rf) for recovery

### Example: dustboy-confidence-system
- Before: 25GB in Nat's Agents
- After: 150M Nat's Agents + 24GB in own repo
- Data gitignored, code tracked

### Key: Always verify data moved before deleting source.

---
*Added via Oracle Learn*
