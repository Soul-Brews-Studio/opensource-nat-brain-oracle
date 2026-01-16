---
title: ## React Animation State: Use Refs for Closure Escape
tags: [react, animation, useRef, useEffect, closure, state, three.js]
created: 2026-01-11
source: Oracle Learn
---

# ## React Animation State: Use Refs for Closure Escape

## React Animation State: Use Refs for Closure Escape

When React state needs to be accessed inside animation loops (requestAnimationFrame, setInterval):

**Problem**: Local variables in useEffect don't update when React state changes
```typescript
// WRONG - currentSelectedId never updates
let currentSelectedId = null;
const handleClick = () => { currentSelectedId = node.id; }
function animate() { if (currentSelectedId) ... } // stale
```

**Solution**: Use ref that syncs via useEffect
```typescript
// CORRECT - ref always current
const selectedIdRef = useRef<string | null>(null);
useEffect(() => { selectedIdRef.current = selectedNode?.id || null; }, [selectedNode]);
function animate() { if (selectedIdRef.current) ... } // fresh
```

This is the "closure trap" - animation callbacks capture initial values, not reactive state.

---
*Added via Oracle Learn*
