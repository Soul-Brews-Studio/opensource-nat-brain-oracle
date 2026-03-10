---
title: claude-mem v7.3.3 → v8.5.10 Major Update
tags: [claude-mem, plugin-update, multilingual, mode-system, bug-fixes]
created: 2026-01-06
source: claude-mem GitHub releases (2026-01-06)
---

# claude-mem v7.3.3 → v8.5.10 Major Update

claude-mem v7.3.3 → v8.5.10 Major Update

**v8.0.0 - Mode System**
- Context-aware observation capture (Code Dev, Email Investigation modes)
- 28 language support including Thai - all observations/summaries in chosen language
- ModeManager for centralized config, dynamic SDK prompts
- Fail-fast error handling (no silent failures)
- Fully backward compatible

**v8.5.10 - Critical Bug Fixes**
- #545: Fixed crash parsing non-JSON tool inputs (raw Bash)
- #557: Settings auto-create with defaults (no "module loader" errors)
- #543: Runtime switch node → bun (fixes bun:sqlite issues)
- #544: Terminology fix (mem-search skill → MCP tools)
- v8.5.2: Memory leak fix
- 72 new integration tests

**Impact**: Multilingual memory, better error handling, Thai language support. Worth updating.

---
*Added via Oracle Learn*
