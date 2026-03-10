---
title: WHITE Server tmux Pattern for Long Queries
tags: [white-server, tmux, duckdb, remote, long-query]
created: 2026-01-01
source: Session 2026-01-02 DustBoy
---

# WHITE Server tmux Pattern for Long Queries

WHITE Server tmux Pattern for Long Queries

For multi-minute DuckDB queries, use WHITE server with tmux:

```bash
# 1. SSH to WHITE
ssh nat@white.local

# 2. Start tmux
tmux new -s duckdb

# 3. Run query
duckdb -c "COPY (...) TO '/path/output.parquet'"

# 4. Detach: Ctrl+B, D
# 5. Reattach: tmux attach -t duckdb
```

Then rsync results back:
```bash
rsync -avP nat@white.local:/path/output.parquet ./
```

WHITE has more RAM (48GB) - good for DISTINCT on large datasets

---
*Added via Oracle Learn*
