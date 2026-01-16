# Corpus Visualization Patterns

**Date**: 2026-01-01
**Context**: Data-Aware RAG v5 - Word Cloud + Relationship Graph

## Pattern 1: Word Cloud from FTS5 Vocabulary

### Backend Function

```typescript
export function getWordCloudData(limit = 100): { text: string; value: number }[] {
  // FTS5 creates a vocab table automatically
  try {
    const rows = sqlite.query(`
      SELECT term, cnt FROM documents_fts_vocab
      WHERE term NOT IN ('the', 'and', 'for', ...)
      AND length(term) > 3
      ORDER BY cnt DESC
      LIMIT ?
    `).all(limit);
    return rows.map(r => ({ text: r.term, value: r.cnt }));
  } catch {
    // Fallback: Manual extraction from documents
    const docs = sqlite.query('SELECT content FROM documents LIMIT 1000').all();
    const wordFreq = new Map<string, number>();
    // ... count words manually
    return Array.from(wordFreq.entries()).sort(...).slice(0, limit);
  }
}
```

### Frontend Rendering (CSS-based)

```tsx
function WordCloud({ terms, onSearch }) {
  const maxValue = Math.max(...terms.map(t => t.value));

  function getFontSize(value: number): number {
    const normalized = value / maxValue;
    return 12 + normalized * 36; // 12px to 48px
  }

  return (
    <div className="word-cloud">
      {terms.map((term, i) => (
        <span
          style={{ fontSize: `${getFontSize(term.value)}px` }}
          onClick={() => onSearch(term.text)}
        >
          {term.text}
        </span>
      ))}
    </div>
  );
}
```

### Key CSS

```css
.word-cloud {
  display: flex;
  flex-wrap: wrap;
  gap: 8px 12px;
  justify-content: center;
}

.word-cloud-term:hover {
  background: rgba(88, 166, 255, 0.2);
  transform: scale(1.1);
}
```

## Pattern 2: Relationship Graph with Canvas

### Backend: Building Graph Data

```typescript
export function getRelationshipGraph(limit = 30): { nodes: Node[]; edges: Edge[] } {
  const docs = sqlite.query(`
    SELECT id, source_file, content FROM documents
    ORDER BY indexed_at DESC LIMIT ?
  `).all(limit);

  // Extract top terms per document
  const docTerms = new Map<string, Set<string>>();
  for (const doc of docs) {
    const freq = new Map<string, number>();
    // ... count word frequency
    const topTerms = Array.from(freq.entries())
      .sort((a, b) => b[1] - a[1])
      .slice(0, 20);
    docTerms.set(doc.id, new Set(topTerms.map(t => t[0])));
  }

  // Build edges from shared terms
  const edges = [];
  for (let i = 0; i < docIds.length; i++) {
    for (let j = i + 1; j < docIds.length; j++) {
      const terms1 = docTerms.get(docIds[i])!;
      const terms2 = docTerms.get(docIds[j])!;

      let shared = 0;
      for (const term of terms1) {
        if (terms2.has(term)) shared++;
      }

      if (shared >= 3) {
        edges.push({
          source: docIds[i],
          target: docIds[j],
          weight: shared / Math.max(terms1.size, terms2.size),
        });
      }
    }
  }

  return { nodes, edges };
}
```

### Frontend: Simple Force Simulation

```typescript
// Initialize random positions
const positions = new Map<string, { x, y, vx, vy }>();

function simulate() {
  nodes.forEach(node => {
    // Repulsion from other nodes
    nodes.forEach(other => {
      const dist = distance(pos, otherPos);
      const force = 500 / (dist * dist);
      pos.vx += dx / dist * force;
    });

    // Attraction from connected edges
    edges.forEach(edge => {
      if (edge involves node) {
        pos.vx += dx * 0.01 * edge.weight;
      }
    });

    // Center gravity
    pos.vx += (centerX - pos.x) * 0.001;

    // Apply with damping
    pos.x += pos.vx * 0.1;
    pos.vx *= 0.9;
  });
}

// Animation loop
useEffect(() => {
  for (let i = 0; i < 200; i++) {
    simulate();
    requestAnimationFrame(() => draw());
  }
}, [nodes]);
```

### Canvas Drawing

```typescript
function draw() {
  // Draw edges
  edges.forEach(edge => {
    ctx.beginPath();
    ctx.moveTo(from.x, from.y);
    ctx.lineTo(to.x, to.y);
    ctx.globalAlpha = edge.weight * 2;
    ctx.stroke();
  });

  // Draw nodes
  nodes.forEach(node => {
    ctx.beginPath();
    ctx.arc(pos.x, pos.y, radius, 0, Math.PI * 2);
    ctx.fill();
    if (hovered) {
      ctx.fillText(node.label, pos.x, pos.y - radius - 5);
    }
  });
}
```

## Key Learnings

1. **FTS5 vocab table** - Free word frequency data if available
2. **CSS word cloud** - Simple, no library needed for basic cloud
3. **Canvas for graphs** - Better performance than SVG for many nodes
4. **Force simulation** - Simple physics works well for small graphs
5. **Shared term threshold** - 3+ shared terms = meaningful connection
6. **Damping factor** - 0.9 prevents oscillation
7. **Animation frames** - Limit iterations (200) for stable layout

## Anti-Patterns Avoided

```typescript
// BAD: Library overkill for simple visualization
import * as d3 from 'd3';
import { ForceGraph2D } from 'react-force-graph';

// GOOD: Simple canvas + requestAnimationFrame
const canvas = useRef<HTMLCanvasElement>(null);
useEffect(() => { animate(); }, []);
```

---

*Visualization: Keep it simple. CSS for word clouds, Canvas for graphs, no heavy libraries needed.*
