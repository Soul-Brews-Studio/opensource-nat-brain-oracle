---
title: **Gemini Proxy v2.3.3 Bug**: State shows 0 responses when response exists
tags: [gemini-proxy, bug, v2.3.3, selector, to-fix]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy v2.3.3 Bug**: State shows 0 responses when response exists

**Gemini Proxy v2.3.3 Bug**: State shows 0 responses when response exists

The `MESSAGE-CONTENT` selector may not match Gemini's current DOM. Need to investigate:
1. What element holds the response now?
2. Is it `model-response`, `message-content`, or something else?

Sidebar shows ⚪ 0 responses while page clearly has a full response visible.

**To fix**: Inspect Gemini DOM for correct response container selector.

---
*Added via Oracle Learn*
