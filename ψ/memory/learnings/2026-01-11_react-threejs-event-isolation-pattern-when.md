---
title: ## React + Three.js Event Isolation Pattern
tags: [react, threejs, events, hud, ux]
created: 2026-01-11
source: Oracle Graph 3D Session 2026-01-11
---

# ## React + Three.js Event Isolation Pattern

## React + Three.js Event Isolation Pattern

When embedding UI controls (HUD) over a Three.js canvas, mouse events can leak through and affect the 3D scene.

**Problem**: Dragging sliders in HUD panel also rotates camera
**Solution**: Use a ref to track HUD hover state, check before starting drag

```typescript
// Ref accessible from both React and vanilla event handlers
const hudHoveredRef = useRef(false);

// In Three.js event handler
function onMouseDown(e: MouseEvent) {
  if (hudHoveredRef.current) return;  // Don't start drag if over HUD
  isDragging = true;
}

// In React JSX
<div 
  className={styles.hud}
  onMouseEnter={() => { hudHoveredRef.current = true; }}
  onMouseLeave={() => { hudHoveredRef.current = false; }}
>
```

**Why not stopPropagation?** Canvas event listeners are added to container directly via addEventListener, not through React's synthetic event system. Refs bridge the gap.

---
*Added via Oracle Learn*
