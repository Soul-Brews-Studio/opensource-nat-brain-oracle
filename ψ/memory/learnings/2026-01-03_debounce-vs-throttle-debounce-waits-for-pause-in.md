---
title: Debounce vs throttle: Debounce waits for pause in events (search input, resize).
tags: [debounce, throttle, performance, events, frontend]
created: 2026-01-03
source: Knowledge gap fill
---

# Debounce vs throttle: Debounce waits for pause in events (search input, resize).

Debounce vs throttle: Debounce waits for pause in events (search input, resize). Throttle limits execution rate (scroll, mousemove). Use 150-300ms debounce for search-as-you-type. Use requestAnimationFrame for scroll handlers. Cancel pending debounced calls on unmount. Consider lodash/debounce or custom hook. Leading vs trailing edge matters for UX.

---
*Added via Oracle Learn*
