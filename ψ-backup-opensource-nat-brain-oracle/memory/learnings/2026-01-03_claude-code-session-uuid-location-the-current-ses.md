---
title: Claude Code Session UUID Location
tags: [claude-code, session, uuid, debug, discovery]
created: 2026-01-03
source: Oracle Learn
---

# Claude Code Session UUID Location

Claude Code Session UUID Location

The current session UUID is stored in ~/.claude/debug/:
- Each session creates a `{uuid}.txt` debug log file
- `latest` symlink points to current active session

To get current session UUID:
```bash
readlink ~/.claude/debug/latest | xargs basename | sed 's/.txt//'
```

Discovery: Found through exploration of ~/.claude/ directory structure. No documentation - pattern recognition from file naming convention.

---
*Added via Oracle Learn*
