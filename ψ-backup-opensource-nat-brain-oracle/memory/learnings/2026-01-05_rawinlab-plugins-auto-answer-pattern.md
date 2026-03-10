# RawinLab Plugins: Auto-Answer Pattern for Unattended Automation

**Date**: 2026-01-05
**Source**: /learn claude-plugins exploration session

---

## What We Learned

### Auto-Answer Hook Pattern

RawinLab's plugins use a hook-based auto-answer system for 100% unattended operation:

```json
{
  "name": "auto-answer",
  "event": "Notification",
  "hooks": [{
    "type": "prompt",
    "prompt": "If '(Recommended)' → YES. Otherwise 'SKIP'."
  }]
}
```

**Key insight**: Hooks auto-respond to all Claude prompts without user intervention, enabling fully autonomous workflows.

### Three-Layer Verification

Don't trust agent output alone - verify at multiple layers:

| Layer | What | How |
|-------|------|-----|
| Layer 1 | Agent says DONE | Pattern match output |
| Layer 2 | Files exist | Glob/find verification |
| Layer 3 | State matches | JSON state file sync |

**Only "truly complete" when all 3 layers agree.**

### Minimal Output Template

Agents return only essential info to save context:

```
DONE: [1-2 sentence summary]
Files: [comma-separated list]
```

Result: **99% context savings** vs verbose output.

### Sequential-Then-Parallel Execution

- **Phases 1-5**: Sequential (must wait for completion)
- **Phase 6+**: Parallel allowed (spawn 5-7 agents per batch)

Pattern: `/compact` after each batch to free context.

---

## How Things Connect

### Similarity to Our Patterns

| RawinLab | Nat's Agents | Connection |
|----------|--------------|------------|
| Auto-answer hooks | MAW auto-execution | Same concept, different implementation |
| 3-layer verification | Trust-but-verify | Our learning from Dec 13 |
| State JSON files | Oracle state management | Same pattern |
| Minimal output | context-finder summaries | Token efficiency |
| Sequential-then-parallel | Our batch processing | Identical pattern |

### Potential Integration

- **rw-telegram** could provide mobile notifications for Nat's Agents
- Their agent roles (sa-analyst, tech-lead, etc.) map to our subagent types
- Hook-based events could enhance our session management

### Learning from Others

> "Don't reinvent - study what works, adapt what fits"

RawinLab solved many problems we're also solving:
- Unattended operation
- Context management
- State-based resume
- Multi-agent coordination

---

## Application

### For Workshop Design

The auto-answer pattern validates our "teach through necessity" approach:
- Students will discover they need unattended operation
- Solution: Hook-based auto-answer (already exists in ecosystem)
- Workshop can reference RawinLab as production example

### For Oracle Development

Three-layer verification should be standard for Oracle operations:
1. Agent claims success
2. Files/data actually exist
3. State reflects reality

---

## Tags

`plugins` `auto-answer` `hooks` `verification` `rawinlab` `learning-from-others` `patterns`

---

## Related

- RawinLab repo: `ψ/learn/repo/github.com/RawinLab/claude-plugins`
- Learning docs: `ψ/learn/claude-plugins/2026-01-05_*.md`
- Our pattern: `ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md`
