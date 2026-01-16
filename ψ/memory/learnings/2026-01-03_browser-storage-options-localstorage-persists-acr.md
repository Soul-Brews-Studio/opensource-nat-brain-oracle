---
title: Browser storage options: localStorage persists across sessions (5-10MB limit). s
tags: [localStorage, sessionStorage, indexedDB, browser, persistence]
created: 2026-01-03
source: Knowledge gap fill
---

# Browser storage options: localStorage persists across sessions (5-10MB limit). s

Browser storage options: localStorage persists across sessions (5-10MB limit). sessionStorage clears on tab close. IndexedDB for large structured data (async API). Cookies for server-readable data (4KB limit). Never store sensitive data in localStorage. Use try/catch - storage can throw in private mode. Consider storage event for cross-tab sync.

---
*Added via Oracle Learn*
