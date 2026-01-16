---
title: **Gemini Proxy MQTT `type` action FIX**: Must include `selector` parameter!
tags: [gemini-proxy, mqtt, fix, selector, type-action]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy MQTT `type` action FIX**: Must include `selector` parameter!

**Gemini Proxy MQTT `type` action FIX**: Must include `selector` parameter!

❌ WRONG:
```json
{"action": "type", "text": "hello"}
```

✅ CORRECT:
```json
{"action": "type", "selector": ".ql-editor, [contenteditable=true]", "text": "hello"}
```

Default Gemini selectors that work:
- `.ql-editor` - Quill editor
- `[contenteditable=true]` - Generic contenteditable
- `[data-placeholder]` - Gemini's placeholder div

---
*Added via Oracle Learn*
