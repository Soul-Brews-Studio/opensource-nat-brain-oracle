# React Keyboard Shortcuts Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v4 - Keyboard Navigation

## The Pattern

### 1. Custom Hook Architecture
```typescript
// useKeyboardShortcuts.ts
export function useKeyboardShortcuts(shortcuts: KeyboardShortcuts) {
  const handleKeyDown = useCallback((e: KeyboardEvent) => {
    // 1. Skip if user is typing in an input
    if (e.target instanceof HTMLInputElement) {
      // Allow Escape to blur
      if (e.key === 'Escape') {
        (e.target as HTMLElement).blur()
      }
      return
    }

    // 2. Handle global shortcuts
    switch (e.key) {
      case '/': e.preventDefault(); shortcuts.onFocusSearch?.(); break
      // ... more keys
    }
  }, [shortcuts])

  useEffect(() => {
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [handleKeyDown])
}
```

### 2. forwardRef for Focus Control
```typescript
// SearchBox.tsx - Allow parent to focus the input
const SearchBox = forwardRef<HTMLInputElement, Props>(function SearchBox(
  { onSearch, loading },
  ref
) {
  return <input ref={ref} type="text" />
})

// App.tsx - Store ref and pass to hook
const searchInputRef = useRef<HTMLInputElement | null>(null)
useKeyboardShortcuts({
  onFocusSearch: () => searchInputRef.current?.focus(),
})
```

### 3. Keyboard Help Modal
- Export shortcuts as array: `KEYBOARD_SHORTCUTS = [{key, description}]`
- Reuse in help modal AND in documentation
- Modal closes on overlay click + stopPropagation on content

## Key Learnings

1. **Always check input targets** - Ignore shortcuts when typing
2. **Use e.preventDefault()** - Prevent browser defaults (/ opens Firefox quick find)
3. **useCallback dependency** - Include shortcuts object to avoid stale closures
4. **forwardRef pattern** - Essential for parent components to control child focus
5. **Export shortcuts array** - Single source of truth for shortcuts + help display

## Files Created
- `hooks/useKeyboardShortcuts.ts` - The hook
- `components/KeyboardHelp.tsx` - Help modal
- Modified: `SearchBox.tsx` (forwardRef), `App.tsx` (integration), `index.css` (styling)

## Common Keyboard Conventions
| Key | Action |
|-----|--------|
| / | Focus search (GitHub, Slack) |
| Escape | Close modal, blur input |
| 1-9 | Quick navigation |
| ? | Show help (vim, GitHub) |
| d | Toggle debug (custom) |

---

*Use this pattern for any React app needing keyboard shortcuts.*
