# Search History Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v4 - Search History

## The Pattern

### 1. Database Schema
```sql
CREATE TABLE search_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  query TEXT NOT NULL,
  mode TEXT DEFAULT 'fts',
  result_count INTEGER DEFAULT 0,
  timestamp INTEGER DEFAULT (unixepoch())
);
```

### 2. Backend Functions
```typescript
// Save on every search
function saveSearchHistory(query: string, mode: string, resultCount: number) {
  sqlite.run(
    'INSERT INTO search_history (query, mode, result_count) VALUES (?, ?, ?)',
    [query, mode, resultCount]
  );
}

// Get recent (last N)
function getSearchHistory(limit = 20) {
  return sqlite.query(`
    SELECT * FROM search_history
    ORDER BY timestamp DESC LIMIT ?
  `).all(limit);
}

// Get popular (most frequent)
function getPopularSearches(limit = 10) {
  return sqlite.query(`
    SELECT query, COUNT(*) as count, MAX(timestamp) as last_used
    FROM search_history
    GROUP BY query
    ORDER BY count DESC
    LIMIT ?
  `).all(limit);
}
```

### 3. API Endpoints
```typescript
// GET /api/history
{ recent: [...], popular: [...] }

// POST /api/history/clear
clearSearchHistory();
```

### 4. Frontend Component
```tsx
function SearchHistory({ onSelectQuery }) {
  const [recent, setRecent] = useState([]);
  const [popular, setPopular] = useState([]);

  // Popular as tags (quick access)
  <div className="history-tags">
    {popular.map(p => (
      <button onClick={() => onSelectQuery(p.query, 'fts')}>
        {p.query} <span>{p.count}</span>
      </button>
    ))}
  </div>

  // Recent as list (full context)
  <div className="history-list">
    {recent.map(item => (
      <button onClick={() => onSelectQuery(item.query, item.mode)}>
        {item.query}
        <span>{item.mode}</span>
        <span>{item.result_count} results</span>
      </button>
    ))}
  </div>
}
```

## Key Learnings

1. **Separate recent vs popular** - Different use cases
2. **GROUP BY for popularity** - SQL aggregation for frequency
3. **Unix timestamps** - Easier math for "X ago" display
4. **Click to re-run** - Pass query AND mode back
5. **Toggle visibility** - Don't clutter UI by default

## Time Formatting Helper
```typescript
function formatTime(timestamp: number): string {
  const diffMins = Math.floor((Date.now() - timestamp * 1000) / 60000);
  if (diffMins < 1) return 'just now';
  if (diffMins < 60) return `${diffMins}m ago`;
  if (diffMins < 1440) return `${Math.floor(diffMins / 60)}h ago`;
  return new Date(timestamp * 1000).toLocaleDateString();
}
```

---

*Search history: Learn from user patterns, enable quick re-runs.*
