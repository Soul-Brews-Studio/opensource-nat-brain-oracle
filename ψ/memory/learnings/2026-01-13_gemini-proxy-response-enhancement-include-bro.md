---
title: **Gemini Proxy Response Enhancement**: Include browser metadata in responses:
tags: [gemini-proxy, mqtt, debugging, metadata]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy Response Enhancement**: Include browser metadata in responses:

**Gemini Proxy Response Enhancement**: Include browser metadata in responses:
```json
{
  "id": "...",
  "action": "get_url",
  "result": {...},
  "meta": {
    "chromeVersion": "120.0.6099.109",
    "extensionVersion": "2.1.0",
    "timestamp": 1768278627483
  }
}
```
Helps debugging version-specific issues.

---
*Added via Oracle Learn*
