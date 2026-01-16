---
title: ## Tauri Dev Mode - Hot Reload Development
tags: [tauri, development, hot-reload, oracle-status-tray]
created: 2026-01-09
source: Oracle Status Tray Development Session
---

# ## Tauri Dev Mode - Hot Reload Development

## Tauri Dev Mode - Hot Reload Development

When developing Tauri apps (like oracle-status-tray), use `cargo tauri dev` for fast iteration:

**Benefits:**
- Frontend (HTML/CSS/JS) hot reloads automatically on file save
- No need to rebuild for UI changes
- Rust changes trigger incremental compilation
- Much faster than `cargo tauri build` cycle

**Command:**
```bash
cd ψ/lab/oracle-status-tray
cargo tauri dev
```

**Pattern:** Always use dev mode during active development, only build for release/distribution.

---
*Added via Oracle Learn*
