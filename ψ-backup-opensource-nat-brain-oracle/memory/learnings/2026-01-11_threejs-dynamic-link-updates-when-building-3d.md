---
title: ## Three.js Dynamic Link Updates
tags: [threejs, visualization, graph, animation, links]
created: 2026-01-11
source: Oracle Graph 3D Session 2026-01-11
---

# ## Three.js Dynamic Link Updates

## Three.js Dynamic Link Updates

When building 3D graph visualizations with nodes that can move between layouts (e.g., sphere mode vs cluster mode), links must update dynamically:

**Problem**: Static link geometry created at init time doesn't follow moving nodes
**Solution**: Store node indices in linkData, update line geometry positions every frame

```typescript
// Store indices, not positions
linkDataArray.push({
  sourceIdx: srcIdx,
  targetIdx: tgtIdx,
  line
});

// In animation loop - update from live node positions
const srcPos = meshes[linkData.sourceIdx].position;
const tgtPos = meshes[linkData.targetIdx].position;
const linePositions = linkData.line.geometry.attributes.position.array;
linePositions[0] = srcPos.x; linePositions[1] = srcPos.y; linePositions[2] = srcPos.z;
linePositions[3] = tgtPos.x; linePositions[4] = tgtPos.y; linePositions[5] = tgtPos.z;
linkData.line.geometry.attributes.position.needsUpdate = true;
```

**Key insight**: Links are relationships between nodes, not between positions. Reference the nodes, not coordinates.

---
*Added via Oracle Learn*
