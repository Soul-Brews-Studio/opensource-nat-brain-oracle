---
date: 2026-01-01
tags: [react, modal, ux, accessibility, frontend]
context: Data-Aware RAG - Adding click-to-preview for Explorer
---

# Click-to-Preview Modal Pattern

## Problem

Users browsing 42,000+ documents in the Explorer table needed a way to view full content without navigating away. The table only showed truncated content (80 chars).

## Solution

Added a click-to-preview modal with three key features:

1. **Click anywhere on row** - Opens modal with full content
2. **ESC to close** - Keyboard accessibility
3. **Click overlay to close** - Standard modal behavior

## Implementation

### 1. State & Type

```typescript
interface PreviewDoc {
  id: string
  content: string
  source_file: string
  source_type: string
  created_at: string
  section_count?: number
}

const [preview, setPreview] = useState<PreviewDoc | null>(null)
```

### 2. ESC Key Handler (Document Level)

```typescript
const handleKeyDown = useCallback((e: KeyboardEvent) => {
  if (e.key === 'Escape' && preview) {
    setPreview(null)
    onDebugLog?.('[EXPLORER] Preview closed (ESC)')
  }
}, [preview, onDebugLog])

useEffect(() => {
  document.addEventListener('keydown', handleKeyDown)
  return () => document.removeEventListener('keydown', handleKeyDown)
}, [handleKeyDown])
```

### 3. Clickable Table Row

```tsx
<tr
  onClick={() => openPreview(doc as PreviewDoc)}
  style={{ cursor: 'pointer' }}
  title="Click to preview"
>
```

### 4. Modal Structure

```tsx
{preview && (
  <div className="modal-overlay" onClick={() => setPreview(null)}>
    <div className="modal-content" onClick={e => e.stopPropagation()}>
      {/* Header, meta, body, footer */}
    </div>
  </div>
)}
```

## Key CSS

```css
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.8);
  z-index: 1000;
}

.modal-content {
  max-width: 900px;
  max-height: 80vh;
  overflow-y: auto;
}

.data-table tbody tr:hover {
  background: var(--border);
  cursor: pointer;
}
```

## Key Learning

> "Use `stopPropagation()` on modal content to prevent clicks from bubbling to overlay. Add document-level keyboard listeners with proper cleanup."

The pattern of `onClick={e => e.stopPropagation()}` on modal content is essential - otherwise clicking inside the modal closes it.

## Accessibility Wins

| Feature | Benefit |
|---------|---------|
| ESC key closes | Keyboard navigation |
| Click overlay closes | Expected behavior |
| Pointer cursor on rows | Visual affordance |
| "Press ESC to close" hint | User guidance |
