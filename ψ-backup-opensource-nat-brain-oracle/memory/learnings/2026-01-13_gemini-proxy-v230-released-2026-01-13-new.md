---
title: **Gemini Proxy v2.3.0 Released** (2026-01-13)
tags: [gemini-proxy, chrome-extension, release, v2.3.0]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy v2.3.0 Released** (2026-01-13)

**Gemini Proxy v2.3.0 Released** (2026-01-13)

New features:
- `get_state` action - returns `{loading, tool, responseCount}`
- Sidebar state display with live polling
- Tool detection: youtube, search, maps
- Loading detection via `mat-mdc-progress-spinner`

Usage:
```bash
mosquitto_pub -t 'claude/browser/command' -m '{"action":"get_state","id":"x"}'
```

Response:
```json
{"loading": true, "tool": "youtube", "responseCount": 1}
```

Repo: github.com/laris-co/claude-browser-proxy

---
*Added via Oracle Learn*
