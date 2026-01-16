---
date: 2026-01-01
tags: [chartjs, npm, cdn, react, migration]
context: Data-Aware RAG - Migrating Chart.js from CDN to npm
---

# Chart.js NPM Migration Pattern

## The Problem

CDN-loaded libraries in React/Vite apps:
1. Block rendering until external script loads
2. No TypeScript types
3. Harder to test offline
4. Version mismatches possible

Before:
```html
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

```typescript
// Have to lie to TypeScript
declare const Chart: any
```

## The Fix

### 1. Install via npm/bun

```bash
bun add chart.js
```

### 2. Remove CDN from index.html

```html
<!-- Remove this line -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

### 3. Import and Register Components

Chart.js 4.x uses tree-shaking, so you must register what you use:

```typescript
import {
  Chart,
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
  Filler,
} from 'chart.js'

// Register components
Chart.register(
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
  Filler
)
```

## Component Mapping

| Chart Type | Required Imports |
|------------|------------------|
| Bar chart | `BarElement`, `CategoryScale`, `LinearScale` |
| Line chart | `LineElement`, `PointElement`, `Filler` |
| Doughnut/Pie | `ArcElement` |
| All charts | `Tooltip`, `Legend` (optional) |

## Benefits

| Before (CDN) | After (npm) |
|--------------|-------------|
| `declare const Chart: any` | Full TypeScript support |
| External dependency | Bundled with app |
| Network required | Works offline |
| Version drift | Locked version |

## Key Learning

> "Always prefer npm over CDN for frontend dependencies. The extra 5 minutes of setup saves hours of debugging type issues and network failures."
