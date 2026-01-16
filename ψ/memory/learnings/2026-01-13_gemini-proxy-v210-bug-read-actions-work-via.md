---
title: **Gemini Proxy v2.1.0 Bug**: Read actions work via MQTT (get_url, get_text) but 
tags: [gemini-proxy, mqtt, bug, contenteditable, quill]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy v2.1.0 Bug**: Read actions work via MQTT (get_url, get_text) but 

**Gemini Proxy v2.1.0 Bug**: Read actions work via MQTT (get_url, get_text) but write actions (type, key) fail silently. Content script receives commands but doesn't execute on Gemini's contenteditable input.

**Workaround**: Use Chrome MCP (claude-in-chrome) for typing, MQTT for status/reading.

**Root cause hypothesis**: Gemini's Quill editor needs special handling - `el.textContent` or real keyboard simulation, not just dispatching events.

---
*Added via Oracle Learn*
