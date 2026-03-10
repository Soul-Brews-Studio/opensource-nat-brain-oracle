# Handoff: Pluto Game Iteration 2

**Date**: 2026-01-16 12:22
**Context**: ~50%
**Ralph Loop**: Iteration 2 complete

## What We Built

Full game mechanics for Pluto (HTML5 2D physics digging game):

| Feature | Status |
|---------|--------|
| Spring-based scoop | ✓ |
| Gems (+100) & bombs (-50) | ✓ |
| 5 rounds with score | ✓ |
| Gradual particle pouring | ✓ |
| Tray drop zone | ✓ |

**Repo**: https://github.com/Soul-Brews-Studio/pluto
**Symlink**: ψ/incubate/pluto

## Current State

- 614 lines single HTML file
- Playable game with complete loop
- 2 commits on main

## Known Issues

1. **Items don't interact with scoop** — gems/bombs fall through
2. **No sound** — feels flat
3. **O(n²) collision** — will lag at higher particle counts

## Next Iteration Options

| Priority | Task | Effort |
|----------|------|--------|
| High | Fix item-scoop collision | Small |
| High | Add Web Audio sounds | Medium |
| Medium | Spatial grid for collision | Medium |
| Low | Visual polish (trails, glow) | Small |

## Key Files

- `ψ/incubate/pluto/index.html` — the game
- `ψ/learn/LowLevelDigger/` — reference Unity project
- `ψ/memory/learnings/2026-01-16_spring-physics-in-canvas-games.md` — pattern doc

## Lessons Learned This Session

1. **Spring physics formula**: `vel += (target - pos) * spring; vel *= damping`
2. **Comparison-driven dev**: List what reference has, check off as you add
3. **Arc collision**: Use angle math, not just distance

## Git Status

Uncommitted in Nat-s-Agents:
- New learnings
- New retrospectives
- New handoff

---

*Ready for iteration 3: polish and sound*
