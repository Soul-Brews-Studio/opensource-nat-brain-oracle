---
title: HTML5 Particle Physics MVP Pattern
tags: [html5, canvas, physics, game, particles]
created: 2026-01-16
source: Pluto game iteration 1
---

# HTML5 Particle Physics MVP Pattern

## Core Components

| Component | Implementation |
|-----------|----------------|
| Particle class | x, y, vx, vy, radius, color |
| Physics loop | gravity → velocity → position → bounds |
| Collision | O(n²) simple overlap resolution |
| Interaction | Mouse position + radius check |

## Key Formulas

```javascript
// Gravity
vy += gravity;

// Distance check
const dist = Math.sqrt(dx*dx + dy*dy);

// Push force (inverse distance)
force = (radius - dist) / radius * strength;

// Overlap resolution
overlap = (minDist - dist) / 2;
a.x -= nx * overlap;
b.x += nx * overlap;
```

## Performance Notes

- 300 particles with O(n²) collision runs smooth
- Beyond 500 needs spatial partitioning (grid/quadtree)
- requestAnimationFrame for consistent timing

## What Worked

1. **Single file** — all in index.html, zero deps
2. **HSL colors** — easy earth tones with random variation
3. **Touch support** — same logic, different event names

## What's Missing (for next iteration)

- Treasures/items to find
- Score system
- Better physics (spring joints, LowLevelDigger patterns)
- Sound effects

---

*First iteration of Pluto game — pure HTML5 Canvas*
