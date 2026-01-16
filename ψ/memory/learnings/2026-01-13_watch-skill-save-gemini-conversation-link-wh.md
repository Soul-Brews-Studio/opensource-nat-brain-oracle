---
title: ## /watch Skill: Save Gemini Conversation Link
tags: [watch-skill, gemini, youtube, transcript, conversation-link]
created: 2026-01-13
source: User feedback 2026-01-13
---

# ## /watch Skill: Save Gemini Conversation Link

## /watch Skill: Save Gemini Conversation Link

When using /watch to transcribe YouTube videos via Gemini, always save the Gemini conversation URL for future reference.

**Pattern**:
```yaml
# In learning file frontmatter
source: YouTube - [Creator] (youtube_url)
gemini_conversation: https://gemini.google.com/app/[conversation_id]
```

**Why**:
- Gemini conversations persist and are revisitable
- Can continue asking follow-up questions later
- Provides audit trail of how transcript was generated
- URL format: `gemini.google.com/app/[unique_id]`

**Example**:
```yaml
source: YouTube - Alex Finn (https://www.youtube.com/watch?v=uJUVUL8U7b4)
gemini_conversation: https://gemini.google.com/app/a502bcd02b9ef0ee
```

---
*Added via Oracle Learn*
