# nat-agents-core v1.10.0 Released

**Date**: 2026-01-02
**Type**: Plugin Update

## New Commands (+4)

| Command | Purpose | Dependencies |
|---------|---------|--------------|
| `/now` | Session awareness | None (AI memory) |
| `/hours` | Work hours summary | ψ/memory/retrospectives/ |
| `/jump` | Multi-track topic switching | .claude/scripts/jump.sh |
| `/pending` | Show pending tasks | ψ/inbox/tracks/ |

## New Scripts (+2)

| Script | Used by |
|--------|---------|
| `jump.sh` | /jump |
| `tracks.sh` | /pending |

## New Skills (+2)

| Skill | Purpose | Triggers |
|-------|---------|----------|
| `handoff` | Session continuity | "wrap up", "end session", context >80% |
| `context-finder` | Auto-search | "find", "search", "where is" |

## Updated /awaken

Now installs:
- 11 commands
- 3 agents
- 2 scripts
- 2 skills

## Note

Commands `hours`, `jump`, `pending` work best after `/soul-init` or `/soul-lite` which creates the ψ/ structure.

## GitHub

https://github.com/laris-co/nat-agents-core
