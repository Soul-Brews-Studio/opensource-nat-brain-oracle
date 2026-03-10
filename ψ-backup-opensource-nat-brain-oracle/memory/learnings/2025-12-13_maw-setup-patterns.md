# MAW Setup Patterns - Copy from 000-workshop

> Snapshot: 23:11 Saturday 13 December 2025

## Key Discovery

**000-workshop-product-page** has more complete MAW setup than Nat-s-Agents needed to copy.

## What We Copied

### Profiles (10-14)
- `profile14.sh` = 2 windows, 3 horizontal panes each (6 agents)
- `profile6.sh` = 3x2 grid layout
- `profile7.sh` = full 6-agent grid with monitoring

### Critical Scripts
| Script | Purpose |
|--------|---------|
| `maw` | Executable wrapper for subshell access |
| `maw-wrapper.sh` | Claude Code subshell support |
| `maw-safe.sh` | Fallback MAW loading |
| `wait-agents-fast.sh` | ms-level completion polling |
| `wait-for-agents.sh` | Fallback polling |
| `agent-status.sh` | Real-time agent status |
| `check-agent-status.sh` | Health check |

## Architecture Tiers (from 000)

| Tier | Role | Agents |
|------|------|--------|
| 1 Strategic | Orchestration | Agent 0 (You) |
| 2 Tactical | Shadow/Executor | Agent 1 |
| 3 Operational | Specialists | Agents 2-5 |

## Pattern

```
000-workshop = production MAW
Nat-s-Agents = needs to sync from 000

When 000 improves MAW → copy to Nat-s-Agents
```

## Next

- [ ] Update agents.yaml with tier structure
- [ ] Test profile14 with 6 agents
- [ ] Create more agent worktrees (currently only 3)

---

**Timeline**:
- 23:04 - Traced MAW files
- 23:08 - Found profile14 in 000
- 23:10 - Copied profiles + scripts
- 23:11 - Restarted MAW with profile14
