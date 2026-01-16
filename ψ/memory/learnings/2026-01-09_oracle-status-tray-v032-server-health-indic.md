---
title: ## Oracle Status Tray v0.3.2 - Server Health Indicators
tags: [tauri, cors, rust, health-check, oracle-status-tray]
created: 2026-01-09
source: Oracle Status Tray development
---

# ## Oracle Status Tray v0.3.2 - Server Health Indicators

## Oracle Status Tray v0.3.2 - Server Health Indicators

### Problem
Browser fetch() in Tauri webview blocked by CORS when checking localhost servers.

### Solution
Move health checks to Rust backend using ureq (same library used for Oracle API calls).

```rust
#[tauri::command]
fn check_servers_health() -> ServerHealth {
    let oracle = ureq::get("http://localhost:37778/stats")
        .timeout(Duration::from_secs(1))
        .call()
        .map(|r| r.status() == 200)
        .unwrap_or(false);
    // ... same for frontend:3000, chromadb:8000
}
```

### Pattern
**Tauri CORS Bypass**: When webview fetch fails due to CORS, move HTTP requests to Rust commands. Native code bypasses browser security restrictions.

### Result
Green/red status dots for each server in the Servers section:
- Oracle API :37778
- Frontend :3000
- ChromaDB :8000

---
*Added via Oracle Learn*
