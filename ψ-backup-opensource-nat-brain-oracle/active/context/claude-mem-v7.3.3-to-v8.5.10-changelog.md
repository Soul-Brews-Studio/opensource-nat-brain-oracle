# claude-mem Changelog: v7.3.3 → v8.5.10

Generated: 2026-01-06

---

## Major Releases

### v8.5.0 - Cursor Support (2025-12-30)
- **Full Cursor IDE support** with persistent AI memory
- Works without Claude Code subscription
- Free AI providers: Gemini (1,500 req/day), OpenRouter
- Cross-platform: macOS, Linux, Windows (native PowerShell)
- Interactive setup wizard: `bun run cursor:setup`

### v8.2.0 - Gemini API Provider (2025-12-26)
- **Google Gemini API** as alternative to Claude SDK
- Provider selection in Settings UI
- Supported models: gemini-2.5-flash-preview, gemini-2.5-pro-preview, gemini-2.0-flash
- Built-in rate limiting (15 RPM free, 1000 RPM paid)
- Hot-swap providers without restart
- Contributor: [@AlexanderKnigge](https://x.com/AlexanderKnigge)

### v8.0.0 - Mode System (2025-12-23)
- **Context-aware observation capture** (Code Dev, Email Investigation modes)
- **28 language support** including Thai
  - Arabic, Bengali, Chinese, Czech, Danish, Dutch, Finnish, French, German, Greek
  - Hebrew, Hindi, Hungarian, Indonesian, Italian, Japanese, Korean, Norwegian, Polish
  - Portuguese (BR), Romanian, Russian, Spanish, Swedish, Thai, Turkish, Ukrainian, Vietnamese
- All observations/summaries in chosen language
- ModeManager for centralized config
- Dynamic SDK prompts based on mode
- Fail-fast error handling (no silent failures)
- **Fully backward compatible**

---

## Notable Features

### v8.2.1 - Worker Lifecycle Hardening (2025-12-27)
- Improved worker reliability

### v8.0.2 - Chill Mode (2025-12-23)
- Performance mode for reduced resource usage

### v8.0.1 - UI Improvements (2025-12-23)
- Enhanced user interface

---

## v7.4.x Series

### v7.4.5 - Bug Fix (2025-12-21)
- Fixed missing `formatDateTime` import breaking `get_context_timeline`

### v7.4.4 - Code Quality (2025-12-21)
- Comprehensive cleanup (20 issues resolved)

### v7.4.3 - Discord Integration (2025-12-20)
- Discord release notification script
- `npm run discord:notify <version>`

### v7.4.2 - Windows Reliability (2025-12-20)
- Fixed Windows worker stop/restart (#395)
- Refactored worker commands to CLI

### v7.4.1 - MCP Protocol Fix (2025-12-19)
- Redirect logs to stderr (preserves JSON-RPC protocol) (#396)

### v7.4.0 - Token Optimization (2025-12-18)
- MCP tool token reduction through progressive parameter disclosure
- Added `get_schema()` tool for on-demand docs

---

## v8.5.x Bug Fixes

### v8.5.10 (2026-01-06) ⭐ LATEST
- **#545**: Fixed crash parsing non-JSON tool inputs (raw Bash)
- **#544**: Terminology fix (mem-search skill → MCP tools)
- **#557**: Settings auto-create with defaults (no "module loader" errors)
- **#543**: Runtime switch node → bun (fixes bun:sqlite issues)
- Circular dependency fix (Logger/SettingsDefaultsManager)
- 72 new integration tests

### v8.5.9 (2026-01-04)
- Minor bug fixes

### v8.5.8 (2026-01-04)
- Minor bug fixes

### v8.5.7 (2026-01-04)
- Minor bug fixes

### v8.5.6 (2026-01-04)
- Minor bug fixes

### v8.5.5 (2026-01-03)
- Minor bug fixes

### v8.5.4 (2026-01-02)
- Minor bug fixes

### v8.5.3 (2026-01-02)
- Minor bug fixes

### v8.5.2 - SDK Agent Memory Leak Fix (2025-12-31)
- Critical memory leak patch

### v8.5.1 - Migration 17 Idempotency (2025-12-30)
- Database migration reliability fix

---

## Summary

**Total releases**: 40+ between v7.3.3 and v8.5.10

**Key improvements**:
- ✅ 28 language support (including Thai)
- ✅ Gemini API provider (free tier available)
- ✅ Cursor IDE support (no Claude Code needed)
- ✅ Mode system (code, email investigation)
- ✅ Memory leak fixes
- ✅ Better error handling (fail-fast)
- ✅ Windows reliability improvements
- ✅ Token optimization
- ✅ 72 new tests

**Breaking changes**: None (fully backward compatible)

**Recommended**: Update to v8.5.10 for latest bug fixes and features.
