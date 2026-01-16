---
title: Animation performance: Use CSS transforms and opacity - they're GPU accelerated.
tags: [animation, performance, requestAnimationFrame, css, frontend]
created: 2026-01-03
source: Knowledge gap fill
---

# Animation performance: Use CSS transforms and opacity - they're GPU accelerated.

Animation performance: Use CSS transforms and opacity - they're GPU accelerated. Avoid animating layout properties (width, height, top, left). Use will-change sparingly as hint to browser. Prefer requestAnimationFrame over setTimeout. Use CSS animations for simple cases, JS for complex choreography. Profile with Chrome Performance tab to find jank.

---
*Added via Oracle Learn*
