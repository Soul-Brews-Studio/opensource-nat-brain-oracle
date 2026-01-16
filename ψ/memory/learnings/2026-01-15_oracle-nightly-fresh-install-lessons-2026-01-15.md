---
title: Oracle Nightly Fresh Install Lessons (2026-01-15):
tags: [oracle-nightly, fresh-install, mcp, testing, git]
created: 2026-01-15
source: Session 2026-01-15 14:20
---

# Oracle Nightly Fresh Install Lessons (2026-01-15):

Oracle Nightly Fresh Install Lessons (2026-01-15):

1. Check what git actually tracks (`git ls-files` not `ls`) - frontend/dist/assets wasn't committed
2. Test runners conflict - bunfig.toml to scope bun tests away from Playwright
3. Show all network URLs - remote users need IP/hostname, not just localhost
4. MCP auto-start exists - ensureServerRunning() in src/index.ts auto-starts HTTP server
5. Use Claude CLI for MCP - `claude mcp add/remove` instead of manual JSON editing

Fresh install command:
curl -sSL https://raw.githubusercontent.com/Soul-Brews-Studio/oracle-v2/main/scripts/fresh-install.sh | bash

MCP setup:
claude mcp add oracle-v2 -- bun run ~/.local/share/oracle-v2/src/index.ts

---
*Added via Oracle Learn*
