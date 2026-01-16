---
title: **Gemini Proxy Extension Improvement**: Should publish status on icon state chan
tags: [gemini-proxy, mqtt, chrome-extension, improvement]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy Extension Improvement**: Should publish status on icon state chan

**Gemini Proxy Extension Improvement**: Should publish status on icon state change (red↔green). Currently only publishes on connect/periodic. Would allow subscribers to know when content script injection succeeded/failed.

Suggested topics:
- `claude/browser/status` with `{state: "ready"|"error", reason: "..."}`
- Publish immediately on state transition, not just periodic

---
*Added via Oracle Learn*
