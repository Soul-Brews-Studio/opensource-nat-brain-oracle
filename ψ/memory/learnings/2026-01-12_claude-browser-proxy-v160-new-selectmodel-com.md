---
title: claude-browser-proxy v1.6.0 - New select_model command
tags: [claude-browser-proxy, extension, gemini, model-selection, mqtt, v1.6.0]
created: 2026-01-12
source: Extension update 2026-01-12
---

# claude-browser-proxy v1.6.0 - New select_model command

claude-browser-proxy v1.6.0 - New select_model command

**Usage**: `{"action": "select_model", "model": "fast"}`

**Models**: fast, thinking, pro

**How it works**:
1. Finds model dropdown button (Pro/Fast/Thinking)
2. Clicks to open dropdown
3. Waits 500ms for options
4. Clicks matching model option

**Use case**: /watch skill can select "fast" for quick transcriptions, "pro" for detailed analysis.

---
*Added via Oracle Learn*
