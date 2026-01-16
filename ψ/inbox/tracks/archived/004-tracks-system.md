# Track: tracks-system

**Created**: 2025-12-28 11:03
**Last touched**: 2025-12-28 11:18
**Status**: Completed

---

## Goal

Replace single WIP.md with multi-track parallel system

## What Was Built

- Issue #58: Multi-track WIP replacement with time-decay
- `ψ/inbox/tracks/` folder with `NNN-title.md` format
- `/jump` creates/switches tracks + TRACK field in focus.md
- `/tracks` shows all with decay status
- Time-decay from mtime: Hot | Warm | Cooling | Cold | Dormant

## Debates

1. **Critic (Haiku)**: Validated design, regenerate_index() exists
2. **Marie Kondo (5 rounds)**: Confirmed location, added TRACK field

## Key Commits

- `8c9a181` - /jump with multi-track
- `c1ff71e` - /tracks command
- `42c5398` - NNN-title.md format

## Next

Track complete. Use `/jump` for new tracks.
