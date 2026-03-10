# Oracle Status Tray v0.2 - Build Session Learnings

**Date**: 2026-01-09

## What We Learned

### Tauri Development
- `cargo tauri dev` enables hot reload for frontend (HTML/CSS/JS)
- Config changes (tauri.conf.json) need dev server restart
- Tauri 2.0 uses `tauri-plugin-opener` for opening URLs (not shell.open)
- Capabilities must be declared in `src-tauri/capabilities/default.json`

### Data Type Mismatches
- Server returns `created_at` as Unix timestamp (number)
- Rust expected string, used `as_str()` which returned None
- Solution: Use chrono to convert timestamp to ISO string
- Always check API response types match frontend expectations

### Timezone Handling
- `toLocaleTimeString()` with `timeZone: 'Asia/Bangkok'` for GMT+7
- Apply to all date displays for consistency

### Architecture Insight
- MCP server and HTTP server can use different databases
- Search logs from MCP won't appear in HTTP server's /logs endpoint
- Consider unifying database paths or syncing mechanisms

## How Things Connect

```
Oracle Ecosystem:
├── MCP Server (Claude Code integration)
│   └── Uses: ~/.claude/plugins/marketplaces/oracle-v2/oracle.db
├── HTTP Server (Lab, Dashboard)
│   └── Uses: ψ/lab/oracle-v2/oracle.db
└── Status Tray (Menu bar monitoring)
    └── Connects to: HTTP Server on port 37778
```

The tray monitors the HTTP server, not the MCP. This means MCP searches don't appear in tray logs.

## Tags
`tauri` `oracle` `timezone` `rust` `typescript` `menu-bar-app`
