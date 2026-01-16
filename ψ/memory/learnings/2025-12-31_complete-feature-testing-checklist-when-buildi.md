---
title: ## Complete Feature Testing Checklist
tags: [testing, ui, verification, checklist, features]
created: 2025-12-31
source: Headline RAG Complete Testing 2025-12-31
---

# ## Complete Feature Testing Checklist

## Complete Feature Testing Checklist

When building a UI feature, test ALL of these before claiming success:

### Core Flow
- [ ] Welcome/empty state
- [ ] Data loading state  
- [ ] Data loaded state
- [ ] Error handling state

### User Interactions
- [ ] Button clicks work
- [ ] Form submission works
- [ ] Expandable/collapsible elements work
- [ ] Multiple sequential actions work

### Data Display
- [ ] Numbers/stats display correctly
- [ ] Lists render all items
- [ ] Nested data (sources with content) displays
- [ ] Thai/Unicode text renders properly

### Proof Requirements
- [ ] Screenshot of EACH state (not just final)
- [ ] Response text captured (not just visual)
- [ ] Count verification (e.g., "5 sources shown")
- [ ] Fresh page test (not reusing stale state)

**Example from headline-rag:**
```
final-1-welcome.png   → Empty state with stats
final-2-stats.png     → API breakdown expanded
final-3-response.png  → Full Claude response with markdown
final-4-source.png    → Expanded source content
```

Each screenshot proves a different feature works.

---
*Added via Oracle Learn*
