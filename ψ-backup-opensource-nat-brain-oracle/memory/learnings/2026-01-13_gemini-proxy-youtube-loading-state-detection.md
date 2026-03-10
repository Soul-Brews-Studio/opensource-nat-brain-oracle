---
title: **Gemini Proxy: YouTube Loading State Detection**
tags: [gemini-proxy, chrome-extension, youtube, loading-detection, mqtt, implementation]
created: 2026-01-13
source: /watch session 2026-01-13
---

# **Gemini Proxy: YouTube Loading State Detection**

**Gemini Proxy: YouTube Loading State Detection**

Detect Gemini's YouTube processing spinner and publish state changes:

**DOM Detection** (look for these elements):
```javascript
// Spinner indicators on Gemini
const spinners = [
  '.loading-spinner',
  '[data-loading="true"]', 
  '.mat-mdc-progress-spinner',
  'mat-spinner',
  '.response-loading'
];

// YouTube tool indicator
const youtubeActive = document.querySelector('[data-tool="youtube"]') ||
  document.querySelector('.youtube-chip');
```

**MQTT Topics**:
```
claude/browser/state/tool → {
  "tool": "youtube",
  "state": "loading" | "ready" | "error",
  "timestamp": ...
}
```

**Implementation**:
1. MutationObserver on response area
2. Detect spinner appear → publish "loading"
3. Detect spinner disappear + content stable → publish "ready"
4. Timeout after 90s → publish "timeout"

**Benefits**:
- Claude can wait intelligently (not poll blindly)
- Know WHEN to call `get_response`
- Better UX for long videos

---
*Added via Oracle Learn*
