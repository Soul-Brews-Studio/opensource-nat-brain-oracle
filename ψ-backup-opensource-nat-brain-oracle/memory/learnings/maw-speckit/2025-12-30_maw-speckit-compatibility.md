# MAW + speckit Compatibility Analysis

**Date**: 2025-12-30
**Status**: Research Complete, Implementation Pending
**Tags**: `maw` `speckit` `worktree` `branching` `integration`

## Summary

MAW (Multi-Agent Workflow) and speckit are **compatible** but require awareness of branching behavior. This document captures the analysis and recommended patterns.

---

## Architecture Comparison

| Aspect | MAW | speckit |
|--------|-----|---------|
| **Purpose** | Parallel agent execution | Specification-driven planning |
| **Branches** | `agents/1`, `agents/2`... | `agentN/NNN-feature-name` (prefixed) |
| **Identity** | PWD-based (directory path) | Branch-based |
| **Workflow** | worktree isolation | feature branch + PR |

---

## Key Compatibility Findings

### What IS Compatible

1. **Complementary Workflows**
   - speckit: Planning phase (spec → plan → tasks → issues)
   - MAW: Execution phase (distribute → work → merge → sync)

2. **Agent Can Checkout Feature Branches**
   - Agent identity = directory path, NOT git branch
   - Agent 1 in `/agents/1/` can checkout to `046-feature` freely
   - Still identified as "agent 1" by MAW commands

3. **No Structural Conflicts**
   - speckit creates `.specify/specs/NNN-feature/`
   - MAW uses `.agents/` for tooling
   - No file overlap

### What Needs Care

1. **Branch Number Namespace**
   - speckit: auto-increments `NNN-` (001, 002, 045...)
   - No collision yet, but scaling risk exists

2. **Sync Before Return**
   - If agent on feature branch, `maw sync` affects feature, not `agents/N`
   - Always return to identity branch before sync

3. **Single Branch Checkout Rule**
   - Git worktrees: only ONE worktree per branch
   - Two agents cannot checkout same feature branch

---

## Recommended Workflow

```
PLANNING (on main or agent):
  /speckit.specify "feature description"
  /speckit.plan
  /speckit.tasks
  /speckit.taskstoissues → GitHub Issues

EXECUTION (distribute to agents):
  maw hey 1 "implement issue #XX"
  Agent 1: checkout feature, work, push, PR
  Agent 1: return to agents/1
  maw merge 1
  maw sync (all agents updated)
```

---

## The Identity Rule

**Critical Understanding**:

```bash
# Agent 1 location
PWD=/agents/1/

# Agent 1 can be on ANY branch
git branch --show-current
# → agents/1 (default)
# → 046-feature (after speckit)
# → main (if manually checked out)

# MAW ALWAYS detects from PWD
detect_agent_id() {
  if [[ "$PWD" =~ /agents/([0-9]+) ]]; then
    echo "${BASH_REMATCH[1]}"  # From path, not branch
  fi
}
```

---

## Risk Matrix

| Scenario | Risk | Mitigation |
|----------|------|------------|
| Agent forgets to return to `agents/N` | Medium | `maw peek` shows current branches |
| Two agents create same feature number | Low | speckit scans all sources |
| Sync while on feature branch | Medium | Document "return first" rule |
| Feature branch collision in worktrees | None | Git prevents automatically |

---

## Branch Naming Convention (DECIDED)

**Pattern**: `agentN/NNN-feature-name`

| Agent | Feature | Branch |
|-------|---------|--------|
| Agent 1 | 046 maw-speckit | `agent1/046-maw-speckit` |
| Agent 2 | 047 auth | `agent2/047-auth` |
| Main | 048 dashboard | `048-dashboard` (no prefix) |

**Benefits**:
- Namespace isolation - agents can't collide
- Clear ownership - who created what
- Git-friendly - appears as folders in GUIs
- Sortable - numbers still work for ordering

**Implementation**: Modify `create-new-feature.sh` to detect agent context and add prefix.

---

## Future Improvements

1. **Pre-sync Warning** (P1 - UX polish)
   - `maw sync` could show visibility when skipping non-identity branch
   - Note: `smart-sync.sh` already filters non-agents/N branches (safety exists)

2. **speckit Agent Awareness**
   - speckit could detect worktree context
   - Auto-add agent prefix to branch names
   - Auto-suggest return to identity branch

---

## References

- `ψ/memory/learnings/maw/2025-12-28_worktree-is-identity.md`
- `ψ/memory/learnings/maw/maw.md`
- `ψ/learn/spec-kit/2025-12-30_ARCHITECTURE.md`
- `.specify/scripts/bash/create-new-feature.sh`
- `CLAUDE.md` (Multi-Agent Sync section)

---

## Related Sessions

- 2025-12-27: speckit initialization + MAW merge command
- 2025-12-30: This analysis session
