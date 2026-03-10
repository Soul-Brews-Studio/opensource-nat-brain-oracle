---
title: claude-browser-proxy v1.6.2 - select_model WORKING
tags: [claude-browser-proxy, v1.6.2, select_model, working, gemini]
created: 2026-01-12
source: Extension testing 2026-01-12
---

# claude-browser-proxy v1.6.2 - select_model WORKING

claude-browser-proxy v1.6.2 - select_model WORKING

**Command**: `{"action":"select_model","model":"fast"}`

**Models**: fast, thinking, pro

**Selector that works**: `button.input-area-switch` or text match `^(Pro|Fast|Thinking)$`

**Debug response includes**: totalButtons, candidates, foundBy, clickedButton, request

Full /watch workflow now possible:
1. select_model → fast (quick transcription)
2. type → prompt with YouTube URL
3. key → Enter
4. wait_response → get transcript

---
*Added via Oracle Learn*
