---
title: "Chart.js Dark Theme Pattern"
date: 2026-01-01
concepts: [chart.js, dark-theme, visualization, styling]
---

# Chart.js Dark Theme Pattern

## The Pattern

When embedding Chart.js in a dark-themed dashboard:

```javascript
const colors = ['#238636', '#58a6ff', '#f78166', '#a371f7', '#3fb950', '#f0883e'];

new Chart(ctx, {
  type: 'bar',
  data: {
    labels: [...],
    datasets: [{
      data: [...],
      backgroundColor: colors[0],
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: {
        display: false,  // Or: labels: { color: '#c9d1d9' }
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: { color: '#8b949e' }  // Gray for dark theme
      },
      x: {
        ticks: { color: '#8b949e' }
      }
    }
  }
});
```

## Key Points

1. **Use GitHub dark theme colors**:
   - Background: `#0d1117`
   - Card: `#161b22`
   - Text: `#c9d1d9`
   - Dim text: `#8b949e`
   - Accent: `#58a6ff` (blue), `#238636` (green)

2. **Set tick colors** in scales for axis labels

3. **Set legend label colors** if legend is visible

4. **Use semi-transparent fills** for area charts:
   ```javascript
   backgroundColor: '#f78166' + '40',  // 40 = 25% opacity
   ```

5. **Responsive charts** adapt to container size:
   ```javascript
   options: { responsive: true }
   ```

## Chart Types for Dashboards

| Chart Type | Best For |
|------------|----------|
| Bar | Distribution, comparisons |
| Doughnut | Proportions, parts of whole |
| Horizontal Bar | Rankings, top-N lists |
| Line | Trends over time |

---

*Used in: Data-Aware RAG Charts Page 2026-01-01*
