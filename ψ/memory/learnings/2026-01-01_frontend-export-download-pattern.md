# Frontend Export Download Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v4 - Export Buttons

## The Pattern

### 1. Download File Function (No Server Needed)
```typescript
function downloadFile(content: string, filename: string, mimeType: string) {
  // Create blob from content
  const blob = new Blob([content], { type: mimeType })

  // Create temporary URL
  const url = URL.createObjectURL(blob)

  // Create hidden anchor and trigger download
  const a = document.createElement('a')
  a.href = url
  a.download = filename
  a.click()

  // Cleanup
  URL.revokeObjectURL(url)
}
```

### 2. Export as JSON
```typescript
function exportAsJSON() {
  const data = {
    query,
    timestamp: new Date().toISOString(),
    count: results.length,
    results: results.map((r, i) => ({
      rank: i + 1,
      score: normalizedScore(r),
      content: r.content,
      metadata: r.metadata,
    })),
  }
  downloadFile(
    JSON.stringify(data, null, 2),
    `search-${query}.json`,
    'application/json'
  )
}
```

### 3. Export as CSV
```typescript
function exportAsCSV() {
  const headers = ['Rank', 'Score', 'Content']
  const rows = results.map((r, i) => [
    i + 1,
    r.score.toFixed(4),
    `"${r.content.substring(0, 100).replace(/"/g, '""')}"`, // Escape quotes
  ])
  const csv = [
    headers.join(','),
    ...rows.map(r => r.join(','))
  ].join('\n')

  downloadFile(csv, `search-${query}.csv`, 'text/csv')
}
```

## Key Learnings

1. **No server needed** - Blob + URL.createObjectURL handles everything client-side
2. **Escape CSV quotes** - Replace `"` with `""` for proper CSV escaping
3. **Cleanup URLs** - Call `URL.revokeObjectURL()` to prevent memory leaks
4. **Filename sanitization** - Replace spaces with dashes in filenames

## CSS for Export Bar
```css
.export-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid var(--border);
}

.export-btn {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 4px;
  padding: 4px 12px;
  cursor: pointer;
}
```

---

*Client-side export: No backend needed, instant downloads.*
