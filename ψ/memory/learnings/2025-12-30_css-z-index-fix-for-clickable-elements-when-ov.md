---
title: ## CSS Z-Index Fix for Clickable Elements
tags: [css, z-index, playwright, debugging, ui-fix]
created: 2025-12-30
source: Oracle Learn
---

# ## CSS Z-Index Fix for Clickable Elements

## CSS Z-Index Fix for Clickable Elements

When overlay elements (like animated rings, backgrounds, or decorative elements) block clicks on interactive elements, add `z-index` to bring the clickable element above.

### The Error Pattern (from Playwright)
```
<div class="core-ring"></div> from <div class="container">…</div> 
subtree intercepts pointer events
```

### The Solution
```css
.nav-link {
    position: fixed;
    /* ... other styles ... */
    z-index: 100;  /* Ensure above decorative elements */
}
```

### Key Points
1. Fixed/absolute positioned elements need explicit z-index
2. Animated background elements can intercept clicks even if visually behind
3. Use dev-browser's Playwright errors to diagnose pointer interception
4. z-index only works on positioned elements (relative, absolute, fixed, sticky)

---
*Added via Oracle Learn*
