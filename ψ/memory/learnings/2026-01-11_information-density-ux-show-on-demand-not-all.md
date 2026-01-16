---
title: ## Information Density UX: Show on Demand, Not All at Once
tags: [ux, information-density, progressive-disclosure, graph, visualization, interaction]
created: 2026-01-11
source: Oracle Learn
---

# ## Information Density UX: Show on Demand, Not All at Once

## Information Density UX: Show on Demand, Not All at Once

When displaying dense interconnected data (graphs, networks, relationships):

**Anti-pattern**: Show everything → spider web → overwhelming
- Oracle Graph had 27k links visible = unreadable mess

**Pattern**: Progressive disclosure via interaction
1. Default: Clean view with ambient hints (few random connections cycling)
2. Hover: Show that node's connections only
3. Click: Lock selection, freeze animation, persist view

Formula: `activeId = hoveredId || selectedId || ambientId`

Benefits:
- Clean default state
- User controls complexity
- Ambient animation shows "there's more" without showing all

---
*Added via Oracle Learn*
