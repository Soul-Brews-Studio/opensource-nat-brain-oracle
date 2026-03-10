---
title: ## /watch Full Transcript Pattern for AI-to-AI Transfer
tags: [watch-skill, transcript, ai-to-ai, gemini, full-text]
created: 2026-01-13
source: User insight 2026-01-13
---

# ## /watch Full Transcript Pattern for AI-to-AI Transfer

## /watch Full Transcript Pattern for AI-to-AI Transfer

When transcribing YouTube for another AI (like Claude), request **full verbatim transcript** instead of summary:

**Better Prompt for Full Transcript**:
```
Please provide the FULL verbatim transcript of this video with timestamps.
Do NOT summarize - I need the complete text for another AI to analyze.

Video: [URL]

Format:
[00:00] exact words spoken
[00:15] next section exact words
...
```

**Why Full > Summary**:
- Another AI can do its own analysis
- No information loss from double-summarization
- Claude can extract different insights than Gemini
- Preserves nuance, examples, exact phrasing

**When to Use**:
| Goal | Prompt Style |
|------|--------------|
| Quick learning | Summary + key points |
| AI-to-AI transfer | Full verbatim transcript |
| Reference doc | Full + timestamps |

**Pattern**: Ask for raw data, let receiving AI do analysis.

---
*Added via Oracle Learn*
