---
title: ## Drag-to-Rotate vs Move-to-Rotate UX
tags: [ux, threejs, camera, interaction, drag]
created: 2026-01-11
source: Oracle Graph 3D Session 2026-01-11
---

# ## Drag-to-Rotate vs Move-to-Rotate UX

## Drag-to-Rotate vs Move-to-Rotate UX

For 3D visualizations with clickable elements, move-to-rotate makes clicking nearly impossible.

**Problem**: Camera follows mouse position → nodes constantly moving → can't click
**Solution**: Drag-to-rotate (hold + move)

```typescript
let isDragging = false;
let dragStart = { x: 0, y: 0 };

function onMouseDown(e) {
  isDragging = true;
  dragStart = { x: e.clientX, y: e.clientY };
}

function onMouseMove(e) {
  if (isDragging) {
    const dx = (e.clientX - dragStart.x) * 0.005;
    targetAngle.x += dx;
    dragStart = { x: e.clientX, y: e.clientY };
  }
  // Hover detection still works when not dragging
}
```

**Bonus**: Add scroll-to-zoom for intuitive camera distance control.

---
*Added via Oracle Learn*
