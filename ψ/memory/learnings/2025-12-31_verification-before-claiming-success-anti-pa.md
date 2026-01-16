---
title: ## Verification Before Claiming Success
tags: [verification, testing, proof, browser-automation, screenshots]
created: 2025-12-31
source: Headline RAG Frontend Session 2025-12-31
---

# ## Verification Before Claiming Success

## Verification Before Claiming Success

**Anti-pattern:**
```
❌ Write code → Commit → Say "done"
❌ See loading state → Assume it will work
❌ Partial test → Claim full success
```

**Correct pattern:**
```
✅ Write code → Start servers → Browser automation
✅ Wait for COMPLETE response (not just loading)
✅ Screenshot shows FULL result with data
✅ Only then commit + claim success
```

**Key insight:** A loading spinner is NOT proof of success. Wait for the actual data response before taking verification screenshots.

**Example from headline-rag:**
- First screenshot showed "กำลังค้นหา..." (loading)
- That's NOT enough - had to wait 60s for Claude response
- Final screenshot shows actual PM2.5 answer + 5 sources with scores
- THAT is real proof

---
*Added via Oracle Learn*
