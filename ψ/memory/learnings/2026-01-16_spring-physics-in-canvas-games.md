---
title: Spring Physics in Canvas Games
tags: [html5, canvas, physics, spring, game-dev]
created: 2026-01-16
source: Pluto game iteration 2
---

# Spring Physics in Canvas Games

## Core Spring Formula

```javascript
// Spring toward target
const dx = targetX - this.x;
const dy = targetY - this.y;

this.vx += dx * springStrength;  // 0.05-0.15 typical
this.vy += dy * springStrength;

this.vx *= damping;  // 0.8-0.95 typical
this.vy *= damping;

this.x += this.vx;
this.y += this.vy;
```

## Key Parameters

| Parameter | Range | Effect |
|-----------|-------|--------|
| Spring | 0.05-0.15 | Lower = slower follow, bouncier |
| Damping | 0.80-0.95 | Lower = more oscillation |

## LowLevelDigger Patterns Applied

1. **Kinematic body** → Mouse position directly sets target
2. **Distance joint** → Spring pulls scoop toward target
3. **Zero distance** → Scoop tries to reach mouse exactly
4. **Spring frequency** → Our `springStrength` parameter
5. **Damping ratio** → Our `damping` parameter

## What Feels Good

- **Spring 0.08 + Damping 0.85** — responsive but not jerky
- **Angle interpolation** — scoop rotates smoothly toward movement
- **Velocity transfer** — particles move with scoop

## Arc Collision (Scoop Bowl)

```javascript
// Check if particle is in scoop arc (not open part)
const angle = Math.atan2(dy, dx);
const relAngle = normalizeAngle(angle - scoopAngle);
if (Math.abs(relAngle) > halfOpenAngle) {
    // Particle hits scoop wall
}
```

---

*Learned from translating Unity Box2D patterns to Canvas 2D*
