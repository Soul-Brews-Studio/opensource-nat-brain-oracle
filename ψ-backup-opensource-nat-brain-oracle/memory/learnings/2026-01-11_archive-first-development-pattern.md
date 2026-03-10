# Archive-First Development Pattern

**Date**: 2026-01-11
**Category**: Pattern
**Source**: Major cleanup session

## The Pattern

When accumulating too many commands/skills/specs:

1. **Analyze usage** - Which items actually get used?
2. **Archive ALL** to `_archive/` (git tracked)
3. **Keep only actively used** items (7 survived from 79)
4. **Restore on demand** → forced upgrade to skill format
5. **Consolidate similar** items (trace + trace-oracle → unified /trace)

## Why It Works

- Forces review before restoration
- Old commands become modern skills with triggers, hot reload
- Git preserves everything - nothing truly deleted
- Cleaner `/help` output
- Reduced cognitive load

## Key Insight

> Archive aggressively. Trust git. Restore = upgrade opportunity.

## Implementation

```bash
# Move to archive (stays in git)
mv .claude/commands/*.md .claude/_archive/

# Move _archive outside commands/ so Claude doesn't load them
mv .claude/commands/_archive .claude/_archive

# Restore as skill when needed
mkdir -p .claude/skills/[name]
# ... write skill.md with proper frontmatter
```

## Results

| Before | After |
|--------|-------|
| 79 commands | 0 |
| 35 skills | 7 active |
| 38 specs | 0 |
| Cluttered `/help` | Clean |

---

**Related**: `ψ/memory/retrospectives/2026-01/11/22.14_major-cleanup-archive-skills.md`
