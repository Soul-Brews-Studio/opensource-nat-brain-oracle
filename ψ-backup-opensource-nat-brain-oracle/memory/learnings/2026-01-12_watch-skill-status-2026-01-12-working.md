---
title: /watch skill status (2026-01-12):
tags: [watch-skill, status, working, not-working, mqtt, model-selection]
created: 2026-01-12
source: /watch skill testing - 2026-01-12
---

# /watch skill status (2026-01-12):

/watch skill status (2026-01-12):

**WORKING**:
- yt-dlp metadata extraction (title, duration, channel)
- yt-dlp CC/subtitle download
- claude-in-chrome browser control (screenshot, click, type)
- read_page + ref clicks for Gemini input
- get_page_text for response extraction
- Save to ψ/memory/learnings/

**NOT WORKING YET**:
- MQTT select_model command (extension v1.6 added but not responding)
- Extension needs sidepanel open to receive MQTT commands

**WORKAROUND**: Use claude-in-chrome directly for model selection (click Pro dropdown via ref)

---
*Added via Oracle Learn*
