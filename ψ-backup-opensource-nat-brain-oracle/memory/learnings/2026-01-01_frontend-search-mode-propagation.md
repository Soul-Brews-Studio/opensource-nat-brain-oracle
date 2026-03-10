---
date: 2026-01-01
tags: [frontend, react, api, search, mode, typescript]
context: Data-Aware RAG - Adding search mode selector to frontend
---

# Frontend Search Mode Propagation Pattern

## The Challenge

Adding a new parameter (search mode) that flows through:
1. UI component (SearchBox)
2. Parent component (App)
3. API client
4. Server endpoint

## The Solution

### 1. Define Type Once, Export Everywhere

```typescript
// api/client.ts - Single source of truth
export type SearchMode = 'fts' | 'vector' | 'hybrid';

export async function search(
  query: string,
  limit = 10,
  debug = false,
  mode: SearchMode = 'fts',  // Add parameter with default
  signal?: AbortSignal
): Promise<SearchResponse> {
  // ...
}
```

### 2. Update Component Interface

```typescript
// SearchBox.tsx
import type { SearchMode } from '../api/client'

interface Props {
  onSearch: (query: string, mode: SearchMode) => void  // Add to callback
  // ...
}

export default function SearchBox({ onSearch, ...props }) {
  const [mode, setMode] = useState<SearchMode>('fts')

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    onSearch(query, mode)  // Pass mode up
  }

  return (
    <form onSubmit={handleSubmit}>
      <input ... />
      <select value={mode} onChange={(e) => setMode(e.target.value as SearchMode)}>
        <option value="fts">FTS5</option>
        <option value="vector">Vector</option>
        <option value="hybrid">Hybrid</option>
      </select>
      <button type="submit">Search</button>
    </form>
  )
}
```

### 3. Parent Passes to API

```typescript
// App.tsx
async function handleSearch(query: string, mode: SearchMode = 'fts') {
  const data = await search(query, 10, debugMode, mode, controller.signal)
  // ...
}
```

### 4. Server Accepts Mode

```typescript
// server.ts
type SearchMode = 'fts' | 'vector' | 'hybrid';

if (path === '/api/search') {
  const body = await req.json();
  const mode = (body.mode as SearchMode) || 'fts';
  const data = await search(query, limit, debug, mode);
  // ...
}
```

## Key Principles

| Principle | Why |
|-----------|-----|
| Type once, import everywhere | Consistency, no drift |
| Default at each level | Backward compatible |
| Cast at boundary | Type safety at API edge |
| Component owns state | Mode lives in SearchBox |

## The Flow

```
User selects "Hybrid" → SearchBox.mode state → onSearch(query, mode)
→ App.handleSearch → API.search(mode) → Server.search(mode) → Results
```

## Key Learning

> "When adding a new parameter that flows through multiple layers, define the type once and export it. Each layer imports the type and adds a sensible default. This makes the change backward-compatible and type-safe."
