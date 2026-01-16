# URL State Preservation Pattern

**Context**: Oracle v2 UI polish - users expected refresh to preserve their browsing position

## The Pattern

```javascript
// Save state to URL (no history pollution)
function updateURL() {
  const params = new URLSearchParams();
  params.set('mode', currentMode);
  params.set('type', currentType);
  params.set('offset', currentOffset.toString());
  const query = document.getElementById('query').value;
  if (query) params.set('q', query);
  window.history.replaceState({}, '', '?' + params.toString());
}

// Restore state from URL on load
function loadFromURL() {
  const params = new URLSearchParams(window.location.search);
  if (params.has('mode')) currentMode = params.get('mode');
  if (params.has('type')) currentType = params.get('type');
  if (params.has('offset')) currentOffset = parseInt(params.get('offset')) || 0;
  // ... apply state to UI elements
}

// Call on page load
window.addEventListener('DOMContentLoaded', loadFromURL);

// Call after any state change
updateURL();
```

## Key Decisions

| Choice | Alternative | Why This |
|--------|-------------|----------|
| `replaceState` | `pushState` | No back button pollution |
| Query params | Hash fragment | Standard, shareable |
| On every change | Debounced | Instant sync, no state drift |

## When to Use

- Paginated lists (offset)
- Filter selections (type, status)
- Search queries
- Tab/mode switches

## Anti-patterns

- Storing sensitive data in URL
- Storing large objects (use sessionStorage)
- Using pushState for minor changes (clutters history)

---

*Source: Oracle v2 UI polish session 2025-12-30*
