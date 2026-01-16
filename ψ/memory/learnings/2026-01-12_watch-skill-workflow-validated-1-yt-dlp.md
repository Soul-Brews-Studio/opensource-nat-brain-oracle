---
title: /watch skill workflow validated:
tags: [watch-skill, gemini, youtube, claude-in-chrome, workflow, validated]
created: 2026-01-12
source: /watch skill first successful test - 2026-01-12
---

# /watch skill workflow validated:

/watch skill workflow validated:

1. **yt-dlp** → Get title + metadata (JSON)
2. **yt-dlp** → Get CC/subtitles if available  
3. **claude-in-chrome** → Navigate to Gemini
4. **read_page filter=interactive** → Find elements by ref (not coordinates!)
5. **click ref_xxx** → Click send button reliably
6. **get_page_text** → Extract full response
7. **Save to ψ/memory/learnings/** → With frontmatter

Key lesson: Use `read_page` + `ref` clicks, NOT coordinate clicks. Gemini UI elements shift positions.

---
*Added via Oracle Learn*
