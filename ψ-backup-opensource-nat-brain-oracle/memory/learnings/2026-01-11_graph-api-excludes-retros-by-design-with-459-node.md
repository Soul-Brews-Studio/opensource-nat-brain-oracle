---
title: Graph API excludes retros by design: With 459 nodes (principles + learnings), li
tags: [graph, performance, o2-complexity, oracle-v2, retro, optimization]
created: 2026-01-11
source: Graph3D debugging session 2026-01-11
---

# Graph API excludes retros by design: With 459 nodes (principles + learnings), li

Graph API excludes retros by design: With 459 nodes (principles + learnings), link computation is O(n²) = ~210k comparisons. Adding 3984 retros would mean 4443 nodes = ~20M comparisons, killing performance. Solution: sample retros (e.g., top 50 recent) if needed, never include all. The graph intentionally limits to: all principles + random 100 learnings.

---
*Added via Oracle Learn*
