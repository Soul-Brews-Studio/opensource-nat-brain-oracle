---
title: Browser caching strategies: Use content hashing in filenames for aggressive cach
tags: [caching, service-worker, http-headers, performance, frontend]
created: 2026-01-03
source: Knowledge gap fill
---

# Browser caching strategies: Use content hashing in filenames for aggressive cach

Browser caching strategies: Use content hashing in filenames for aggressive caching (immutable). Set Cache-Control: max-age=31536000, immutable for hashed assets. Use stale-while-revalidate for API responses. Implement service worker for offline support. Set short TTL for HTML, long for JS/CSS. Use ETag for conditional requests on dynamic content.

---
*Added via Oracle Learn*
