---
title: Oracle v2 Graph Performance Fix: When building knowledge graphs from documents, 
tags: [performance, graph, o2-complexity, visualization, sampling]
created: 2025-12-29
source: Ralph Loop Session
---

# Oracle v2 Graph Performance Fix: When building knowledge graphs from documents, 

Oracle v2 Graph Performance Fix: When building knowledge graphs from documents, limit nodes to prevent O(n²) explosion.

**Problem**: 4,481 documents = ~20 million pairwise comparisons → browser freeze

**Solution**: Show only principles (always) + sample of learnings (100 random)
- 163 principles + 100 learnings = 263 nodes
- ~34k comparisons instead of 20 million
- Instant load instead of freeze

**Pattern**: For visualization, sample data. For search, use all data.

---
*Added via Oracle Learn*
