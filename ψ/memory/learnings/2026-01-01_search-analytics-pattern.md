# Search Analytics Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v5 - Search Analytics

## The Pattern

### 1. Analytics Data Model

```typescript
interface SearchAnalytics {
  topQueries: { query: string; count: number; avgResults: number }[];
  searchVolume: { hour: number; count: number }[];
  zeroResults: { query: string; count: number; lastSearched: number }[];
  modeBreakdown: { mode: string; count: number }[];
  avgResults: number;
  totalSearches: number;
}
```

### 2. SQL Aggregation Queries

```sql
-- Top queries with average results
SELECT query, COUNT(*) as count, AVG(result_count) as avgResults
FROM search_history
GROUP BY query
ORDER BY count DESC
LIMIT 10;

-- Search volume by hour (last 24 hours)
SELECT
  CAST((timestamp % 86400) / 3600 AS INTEGER) as hour,
  COUNT(*) as count
FROM search_history
WHERE timestamp > unixepoch() - 86400
GROUP BY hour
ORDER BY hour;

-- Zero result queries (content gaps)
SELECT query, COUNT(*) as count, MAX(timestamp) as lastSearched
FROM search_history
WHERE result_count = 0
GROUP BY query
ORDER BY count DESC;

-- Mode breakdown
SELECT mode, COUNT(*) as count
FROM search_history
GROUP BY mode
ORDER BY count DESC;
```

### 3. Key Insight: Unix Timestamp Math

```sql
-- Extract hour from unix timestamp
CAST((timestamp % 86400) / 3600 AS INTEGER) as hour

-- 86400 = seconds in a day
-- Modulo gives seconds since midnight
-- Divide by 3600 gives hour (0-23)
```

### 4. Frontend: Fill Missing Hours

```typescript
// API may return sparse data (only hours with searches)
// Fill in zeros for complete 24-hour chart
const hourData = Array(24).fill(0);
data.searchVolume.forEach(v => {
  hourData[v.hour] = v.count;
});

// Now hourData[0..23] has counts for all hours
```

## Key Analytics Insights

| Metric | Why It Matters |
|--------|----------------|
| Top Queries | What users search most |
| Zero Results | Content gaps to fill |
| Mode Breakdown | FTS vs Vector usage |
| Search Volume | Peak usage hours |
| Avg Results | Search quality |

## Zero-Result Queries = Content Opportunities

```typescript
// These queries found nothing - users need this content!
const contentGaps = analytics.zeroResults;

// Display prominently
<h4>Zero-Result Queries</h4>
<p>Consider adding content for these topics</p>
{contentGaps.map(q => (
  <span>{q.query} ({q.count} times)</span>
))}
```

## Summary Stats Component

```tsx
<div className="analytics-summary">
  <div className="stat-card">
    <div className="stat-value">{data.totalSearches}</div>
    <div className="stat-label">Total Searches</div>
  </div>
  <div className="stat-card">
    <div className="stat-value">{data.avgResults}</div>
    <div className="stat-label">Avg Results</div>
  </div>
  <div className="stat-card">
    <div className="stat-value">{data.zeroResults.length}</div>
    <div className="stat-label">Zero-Result Queries</div>
  </div>
</div>
```

## Anti-Patterns

```typescript
// BAD: Fetch analytics on every keystroke
useEffect(() => {
  fetchAnalytics();
}, [searchQuery]); // Too frequent!

// GOOD: Fetch once on mount
useEffect(() => {
  fetchAnalytics();
}, []);

// BAD: Complex client-side aggregation
const topQueries = history
  .reduce((acc, h) => {...}, {})
  .sort(...)
  .slice(0, 10);

// GOOD: SQL aggregation is faster
const topQueries = sqlite.query(`
  SELECT query, COUNT(*) as count
  FROM search_history
  GROUP BY query
  ORDER BY count DESC LIMIT 10
`).all();
```

---

*Analytics: Let SQL do the heavy lifting. Focus on actionable insights like content gaps.*
