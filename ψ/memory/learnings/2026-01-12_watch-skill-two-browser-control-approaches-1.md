---
title: /watch skill: Two browser control approaches
tags: [watch-skill, browser-automation, gemini, mqtt, claude-in-chrome, lesson-learned]
created: 2026-01-12
source: /watch skill development - 2026-01-12
---

# /watch skill: Two browser control approaches

/watch skill: Two browser control approaches

1. **MQTT (claude-browser-proxy)**: Requires extension loaded + sidepanel open + MQTT connected. Topics: claude/browser/command, claude/browser/response. More setup but async-capable.

2. **claude-in-chrome (MCP)**: Direct browser control, always works if Chrome open. Simpler but synchronous.

**Lesson**: Default to claude-in-chrome for /watch skill. MQTT is overkill for simple transcription workflow. Only use MQTT when need async/multi-tab orchestration.

---
*Added via Oracle Learn*
