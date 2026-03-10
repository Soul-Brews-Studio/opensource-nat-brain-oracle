---
title: **Gemini State Detector - Production Code**
tags: [gemini-proxy, chrome-extension, dom-detection, production-code, youtube]
created: 2026-01-13
source: /watch session 2026-01-13 - tested live
---

# **Gemini State Detector - Production Code**

**Gemini State Detector - Production Code**

```javascript
const GeminiStateDetector = {
  isLoading() {
    const spinner = document.querySelector('mat-mdc-progress-spinner.mdc-circular-progress--indeterminate');
    const avatarSpinner = document.querySelector('.avatar_spinner_animation');
    
    if (spinner) {
      const rect = spinner.getBoundingClientRect();
      if (rect.top < window.innerHeight && rect.bottom > 0) return true;
    }
    if (avatarSpinner && avatarSpinner.offsetParent !== null) return true;
    return false;
  },
  
  getActiveTool() {
    if (document.querySelector('img.youtube-icon')) return 'youtube';
    if (document.querySelector('img.tool-logo[src*="youtube"]')) return 'youtube';
    if (document.querySelector('img.tool-logo[src*="search"]')) return 'search';
    return null;
  },
  
  getResponseCount() {
    return document.querySelectorAll('MESSAGE-CONTENT').length;
  },
  
  getCurrentState() {
    return {
      loading: this.isLoading(),
      tool: this.getActiveTool(),
      responseCount: this.getResponseCount(),
      timestamp: Date.now()
    };
  }
};
```

**Key selectors** (tested 2026-01-13):
- Spinner: `mat-mdc-progress-spinner.mdc-circular-progress--indeterminate`
- Avatar: `.avatar_spinner_animation`
- YouTube: `img.youtube-icon`
- Response: `MESSAGE-CONTENT`

---
*Added via Oracle Learn*
