# Course Genealogy

> Track course inheritance, remixes, and evolution

---

## Family Tree

```
000-setup (root)
│
├── 001-imagination (inherits: 000)
│   │
│   ├── 002-control (inherits: 001)
│   │
│   └── skilllane/01-ai-builder (remix: 001 + pricing model)
│
└── siit-2025-12 (remix: 000 + 001, workshop format)
    │
    ├── ai-builder-2day (inherits: siit delivery style)
    │   │
    │   └── tingting-friends (inherits: ai-builder-2day, custom audience)
    │
    └── skilllane/02-masterclass (remix: siit depth + online format)
```

---

## Inheritance Log

| Date | Child | Parent(s) | Inherited | Modified |
|------|-------|-----------|-----------|----------|
| 2025-12 | 001-imagination | 000-setup | structure, flow | added imagination focus |
| 2025-12 | 002-control | 001-imagination | concepts | added advanced control |
| 2025-12-12 | siit-2025-12 | 000 + 001 | content | workshop format, 2 days |
| 2026-01-04 | ai-builder-2day | siit-2025-12 | delivery style | 2-day format |
| 2026-01-04 | tingting-friends | ai-builder-2day | structure | custom for friends group |

---

## DNA Registry

### 000-setup
```yaml
format: online
duration: 1h
level: everyone
style: demo-driven
pricing: free
```

### 001-imagination
```yaml
format: online
duration: 2h
level: intermediate
style: conceptual + hands-on
pricing: free
parent: 000-setup
```

### 002-control
```yaml
format: online
duration: 3h
level: advanced
style: hands-on
pricing: free
parent: 001-imagination
```

### siit-2025-12
```yaml
format: workshop
duration: 6h (2 days)
level: intermediate
style: 70% hands-on
pricing: institutional
remix: [000-setup, 001-imagination]
```

### ai-builder-2day
```yaml
format: workshop
duration: 2 days
level: intermediate
style: demo-driven + hands-on
pricing: custom
parent: siit-2025-12
```

### skilllane/01-ai-builder
```yaml
format: online (video)
duration: 8h 45m
level: beginner
style: structured lessons
pricing: ฿1,590
parent: 001-imagination
mixin: skilllane-format
```

### skilllane/02-masterclass
```yaml
format: online (video)
duration: 7h 20m
level: advanced
style: deep dive
pricing: ฿2,490
remix: [siit-2025-12, skilllane-format]
```

---

## Remix Patterns

### Pattern: Workshop → Online
**Sources**: siit-2025-12 + skilllane-format
**Result**: skilllane/02-masterclass
**What changed**:
- Live → recorded
- 6h intensive → 7h20m paced
- Institutional → individual pricing

### Pattern: Online → Workshop
**Sources**: 001-imagination + workshop-delivery
**Result**: siit-2025-12
**What changed**:
- Self-paced → instructor-led
- 2h → 6h (more exercises)
- Free → institutional

### Pattern: General → Audience-Specific
**Sources**: ai-builder-2day + audience-research
**Result**: tingting-friends
**What changed**:
- General examples → audience-specific
- Standard pace → adjusted for group
- Same structure, different context

---

## Evolution Insights

### Most Inherited
1. **000-setup** - Foundation for all courses
2. **siit-2025-12** - Workshop delivery pattern
3. **001-imagination** - Core concepts

### Most Remixed
1. **siit-2025-12 + skilllane** - Online video versions
2. **000 + 001** - Combined intro courses

### Genes That Spread
- "Demo → Try → Review" cycle (from siit)
- "45-min learning blocks" (from siit)
- "Build something real" philosophy (from 001)

---

## How to Update

When creating new course with `/course inherit` or `/course remix`:

1. Add to Family Tree (visual)
2. Add row to Inheritance Log
3. Add DNA entry with parent/remix references
4. Note any new patterns

---

*Genealogy tracks how courses evolve and learn from each other*
