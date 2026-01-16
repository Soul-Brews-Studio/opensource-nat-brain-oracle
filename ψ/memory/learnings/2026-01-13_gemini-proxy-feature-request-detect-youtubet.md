---
title: **Gemini Proxy Feature Request**: Detect YouTube/tool loading state
tags: [gemini-proxy, mqtt, feature-request, loading-state, youtube]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy Feature Request**: Detect YouTube/tool loading state

**Gemini Proxy Feature Request**: Detect YouTube/tool loading state

When Gemini is processing a YouTube video or using tools, it shows a spinning loader. The extension should:
1. Detect loading state via DOM (look for spinner element)
2. Publish to `claude/browser/state/loading` topic
3. Include what's loading (youtube, search, etc.)

```json
{"state": "loading", "tool": "youtube", "timestamp": ...}
{"state": "ready", "tool": "youtube", "timestamp": ...}
```

This helps Claude wait appropriately instead of polling blindly.

---
*Added via Oracle Learn*
