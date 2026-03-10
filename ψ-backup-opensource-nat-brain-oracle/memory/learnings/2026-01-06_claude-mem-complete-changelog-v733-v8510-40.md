---
title: claude-mem Complete Changelog v7.3.3 → v8.5.10 (40+ releases)
tags: [claude-mem, changelog, v7-to-v8, gemini, cursor, multilingual, mode-system]
created: 2026-01-06
source: claude-mem GitHub releases full audit (2026-01-06)
---

# claude-mem Complete Changelog v7.3.3 → v8.5.10 (40+ releases)

claude-mem Complete Changelog v7.3.3 → v8.5.10 (40+ releases)

**Major Features**
- v8.0.0: Mode System (28 languages including Thai, code/email modes, backward compatible)
- v8.2.0: Gemini API Provider (free 1,500 req/day, hot-swap providers, by @AlexanderKnigge)
- v8.5.0: Cursor IDE Support (works without Claude Code, cross-platform setup wizard)

**v7.4.x Series**
- v7.4.0: MCP tool token reduction via progressive parameter disclosure
- v7.4.1: MCP protocol fix (logs to stderr) #396
- v7.4.2: Windows worker reliability #395
- v7.4.3: Discord release notifications
- v7.4.4: Code quality audit (20 issues)
- v7.4.5: formatDateTime import fix

**v8.5.x Bug Fixes**
- v8.5.1: Migration 17 idempotency
- v8.5.2: SDK agent memory leak (critical)
- v8.5.3-9: Minor bug fixes
- v8.5.10: #545 non-JSON crash, #557 settings auto-create, #543 node→bun runtime, 72 tests

**New Settings**
- CLAUDE_MEM_MODE: code|email
- CLAUDE_MEM_PROVIDER: claude|gemini
- CLAUDE_MEM_GEMINI_API_KEY, gemini_has_billing

**Impact**: Multilingual, free alternatives (Gemini), Cursor support, no breaking changes. Safe to update.

---
*Added via Oracle Learn*
