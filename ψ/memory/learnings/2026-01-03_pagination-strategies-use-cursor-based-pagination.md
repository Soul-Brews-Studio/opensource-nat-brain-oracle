---
title: Pagination strategies: Use cursor-based pagination for real-time data (prevents 
tags: [pagination, cursor, api, infinite-scroll, performance]
created: 2026-01-03
source: Knowledge gap fill
---

# Pagination strategies: Use cursor-based pagination for real-time data (prevents 

Pagination strategies: Use cursor-based pagination for real-time data (prevents skipping/duplicates). Use offset pagination only for static sorted data. Return nextCursor and hasMore in response. For infinite scroll, prefetch next page. Set reasonable page size limits (10-100). Include total count only if needed - it's expensive on large tables.

---
*Added via Oracle Learn*
