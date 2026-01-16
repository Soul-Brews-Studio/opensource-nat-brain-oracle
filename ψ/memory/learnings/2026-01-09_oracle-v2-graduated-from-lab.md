# Oracle v2 Graduated from Lab to Standalone Repo

**Date**: 2026-01-09
**Source**: oracle-v2 sync session

## What Happened

`ψ/lab/oracle-v2/` was the original prototype for Oracle v2 MCP. It has now **graduated** to a standalone GitHub repo: `laris-co/oracle-v2`.

## Migration Timeline

| Date | Event |
|------|-------|
| 2025-12-29 | Lab prototype started |
| 2025-12-30 | v0.1.0 - Basic FTS5 search |
| 2026-01-03 | ChromaDB integration via chroma-mcp |
| 2026-01-06 | Bun runtime migration |
| 2026-01-07 | Porter stemmer + hybrid search |
| 2026-01-09 | **Lab deleted, GitHub is canonical** |

## Canonical Location

**GitHub**: https://github.com/laris-co/oracle-v2
**Installed**: `~/.claude/plugins/marketplaces/oracle-v2/`
**Database**: `~/.oracle-v2/oracle.db` (machine-independent, like claude-mem)
**Version**: 0.4.0

## What Was Deleted

```
ψ/lab/oracle-v2/
├── src/           # Old TypeScript source (v0.1.0)
├── oracle.db      # 37MB SQLite database
├── chroma_data/   # ChromaDB vectors
├── node_modules/  # Dependencies
├── react-ui/      # Old React frontend
└── ...
Total: 1.7GB
```

## Why Delete

1. **Confusion** - Two locations with different versions
2. **Size** - 1.7GB in main repo (bloat)
3. **Out of sync** - Lab was v0.1.0, GitHub is v0.3.2
4. **Canonical source** - GitHub repo is the single source of truth

## Database Note

The `oracle.db` in lab was the working database. The canonical database is now at:
- **MCP server**: `~/.claude/plugins/marketplaces/oracle-v2/oracle.db`
- **Lab server**: Points to `ψ/lab/oracle-v2/oracle.db` (deleted)

After deletion, restart oracle-v2 server to use the correct DB path.

## Tags

`oracle` `graduation` `cleanup` `migration`
