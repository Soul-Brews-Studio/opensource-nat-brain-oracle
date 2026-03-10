# URL Persistence and Chart Drilldown Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG Dashboard frontend enhancements
**Impact**: User experience and data exploration

## What We Fixed

### 1. URL Persistence for View State
**Problem**: Page refresh reset view to Dashboard, losing user's navigation state.

**Solution**: Use URL hash for view state synchronization:
```typescript
// Get initial view from URL hash
function getInitialView(): View {
  const hash = window.location.hash.slice(1)
  const validViews: View[] = ['dashboard', 'explorer', 'charts', 'about']
  if (validViews.includes(hash as View)) {
    return hash as View
  }
  return 'dashboard'
}

// Initialize with hash
const [view, setView] = useState<View>(getInitialView)

// Sync view changes to URL
useEffect(() => {
  window.location.hash = view
}, [view])

// Listen for browser back/forward
useEffect(() => {
  function handleHashChange() {
    setView(getInitialView())
  }
  window.addEventListener('hashchange', handleHashChange)
  return () => window.removeEventListener('hashchange', handleHashChange)
}, [])
```

**Key insight**: URL hash is perfect for client-side routing state - no server required, survives refresh, supports browser history.

### 2. Clickable File Paths for Validation
**Problem**: Users couldn't easily validate indexed files - had to manually navigate to paths.

**Solution**: Use `file://` URLs for local file access:
```tsx
<a
  href={`file://${sourceFile}`}
  target="_blank"
  rel="noopener noreferrer"
  className="file-path-link"
  title="Open file in system (works for local files)"
>
  {sourceFile}
</a>
```

**Caveat**: `file://` URLs work in Electron apps and some browsers when running locally. Security restrictions may apply in production web contexts.

### 3. Chart.js Click-to-Drilldown
**Problem**: Charts showed aggregated data but users wanted to understand what's in each category.

**Solution**: Chart.js onClick handler with drilldown modal:
```typescript
options: {
  onClick: (_event, elements) => {
    if (elements.length > 0) {
      const index = elements[0].index
      const range = data.contentLength[index].range
      const count = data.contentLength[index].count
      setDrilldown({ range, count })
    }
  }
}
```

**Pattern**: Drilldown modals should explain what the data means, not just show raw numbers. Context makes data actionable.

## Chart.js v4 Controller Registration

**Problem**: "bar is not a registered controller" error with tree-shaking.

**Solution**: Explicitly import and register controllers:
```typescript
import {
  Chart,
  BarController,
  LineController,
  DoughnutController,
  // ... other components
} from 'chart.js'

Chart.register(
  BarController,
  LineController,
  DoughnutController,
  // ... other components
)
```

## Design Principles Applied

1. **Explainability over raw data**: Every chart has a description explaining what it shows
2. **Direct manipulation**: Click charts to drill down, click paths to validate
3. **State preservation**: URL hash survives refresh, browser history works
4. **Progressive disclosure**: Show summary first, details on demand

## Files Modified

| File | Changes |
|------|---------|
| `App.tsx` | URL hash persistence |
| `Explorer.tsx` | Clickable file paths |
| `SearchResults.tsx` | Clickable file paths |
| `Charts.tsx` | Controllers, descriptions, drilldown |
| `index.css` | Drilldown modal styles, path link styles |
