# Autocomplete Debounce Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v6 - Query Suggestions

## The Pattern

### 1. Backend: Prefix Search from History

```typescript
export function getQuerySuggestions(prefix: string, limit = 5) {
  if (!prefix || prefix.length < 2) return [];

  return sqlite.query(`
    SELECT query, COUNT(*) as count, AVG(result_count) as avgResults
    FROM search_history
    WHERE query LIKE ? || '%'
    GROUP BY query
    ORDER BY count DESC, avgResults DESC
    LIMIT ?
  `).all(prefix.toLowerCase(), limit);
}
```

Key decisions:
- Minimum 2 characters before searching
- Order by frequency (count) then quality (avgResults)
- Lowercase for case-insensitive matching

### 2. Frontend: Debounced Fetch

```typescript
useEffect(() => {
  if (debounceRef.current) {
    clearTimeout(debounceRef.current);
  }

  if (value.length >= 2) {
    debounceRef.current = setTimeout(async () => {
      const res = await fetchSuggestions(value);
      setSuggestions(res.suggestions);
      setShowSuggestions(res.suggestions.length > 0);
    }, 200);  // 200ms delay
  }

  return () => {
    if (debounceRef.current) {
      clearTimeout(debounceRef.current);
    }
  };
}, [value]);
```

Key decisions:
- 200ms debounce prevents API spam
- Cleanup on unmount
- Only show if results exist

### 3. Keyboard Navigation

```typescript
const handleKeyDown = (e: React.KeyboardEvent) => {
  switch (e.key) {
    case 'ArrowDown':
      e.preventDefault();
      setSelectedIndex(prev => Math.min(prev + 1, suggestions.length - 1));
      break;
    case 'ArrowUp':
      e.preventDefault();
      setSelectedIndex(prev => Math.max(prev - 1, -1));
      break;
    case 'Enter':
      if (selectedIndex >= 0) {
        selectSuggestion(suggestions[selectedIndex].query);
      } else {
        submitSearch();
      }
      break;
    case 'Escape':
      setShowSuggestions(false);
      break;
  }
};
```

### 4. CSS: Absolute Positioning

```css
.search-input-wrapper {
  position: relative;  /* Anchor for dropdown */
  flex: 1;
}

.suggestions-dropdown {
  position: absolute;
  top: 100%;           /* Below input */
  left: 0;
  right: 0;
  z-index: 100;        /* Above other elements */
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
}
```

## Anti-Patterns

```typescript
// BAD: No debounce - API call on every keystroke
useEffect(() => {
  fetchSuggestions(value);  // Called every character!
}, [value]);

// BAD: Not cleaning up timeout
useEffect(() => {
  setTimeout(() => fetchSuggestions(value), 200);
  // Memory leak if component unmounts!
}, [value]);

// BAD: Not preventing default on arrow keys
case 'ArrowDown':
  setSelectedIndex(prev => prev + 1);  // Cursor moves in input!
```

## UX Considerations

| Feature | Why |
|---------|-----|
| Min 2 chars | Avoid showing all history on first keystroke |
| 200ms delay | Fast enough to feel responsive |
| Show count | Users see which queries are popular |
| Escape closes | Standard keyboard pattern |
| Click outside | Natural dismissal behavior |

---

*Autocomplete: Debounce, navigate with keys, cleanup on unmount.*
