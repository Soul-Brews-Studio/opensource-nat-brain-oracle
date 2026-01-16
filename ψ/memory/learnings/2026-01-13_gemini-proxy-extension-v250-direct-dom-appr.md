---
title: ## Gemini Proxy Extension v2.5.0 - Direct DOM Approach
tags: [chrome-extension, gemini-proxy, mqtt, dom-scraping, simplification]
created: 2026-01-13
source: Session 2026-01-13
---

# ## Gemini Proxy Extension v2.5.0 - Direct DOM Approach

## Gemini Proxy Extension v2.5.0 - Direct DOM Approach

**Problem**: Complex storage/MQTT chain for getting Gemini responses was unreliable.

**Solution**: Read directly from DOM - simple and fast!

### Key Learnings:
1. **Case sensitivity matters**: `MESSAGE-CONTENT` (uppercase) not `message-content`
2. **Skip storage complexity**: Direct `chrome.scripting.executeScript` is faster and more reliable
3. **Auto-load on open**: `autoLoadResponses()` runs on sidebar init
4. **Show all responses**: Number them `[1]`, `[2]` with `---` separators

### Evolution (one session):
- v2.3.3 → v2.3.4: Friendly icons
- v2.3.5: Uppercase selector fix
- v2.4.0: Auto-fetch when loading done
- v2.4.2: Simplified - button reads DOM directly
- v2.5.0: Auto-load on sidebar open

### Pattern:
```javascript
// Simple DOM read - no storage/MQTT needed
const result = await chrome.scripting.executeScript({
  target: { tabId: tab.id },
  func: () => {
    const all = document.querySelectorAll('MESSAGE-CONTENT');
    return Array.from(all).map(el => el.innerText);
  }
});
```

**Lesson**: When something is complex and unreliable, simplify by going direct to the source (DOM).

---
*Added via Oracle Learn*
