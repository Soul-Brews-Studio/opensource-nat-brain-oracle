# Speckit Mastery Through Practice, Not Reading

**Date**: 2025-12-31
**Category**: Pattern
**Source**: Session retrospective - Ralph loop completion

## The Rule/Pattern

Learn speckit by **doing the full flow**, not reading command docs. Use Ralph loop with 5+ iterations to force completion.

## Why It Matters

Reading docs creates illusion of understanding. Practicing reveals:
- Scripts handle structure (you didn't know they existed)
- Debate catches blind spots (you thought hooks were best)
- Tasks by user story (not the layer-based approach you assumed)

Without practice, you'll create files manually and miss the workflow benefits.

## Example

```bash
# ❌ WRONG - Manual approach
mkdir specs/053-feature
touch specs/053-feature/spec.md
# Now what? Template? Branch? Checklist?

# ✅ CORRECT - Command-driven
/speckit.specify "Add hello greeting feature"
# Script creates branch, spec.md, checklist automatically
```

## The Complete Flow

```
/speckit.specify "description"
    ↓ Branch + spec.md + checklist
/speckit.plan
    ↓ Run /debate for decisions
    ↓ plan.md with constitution check
/speckit.tasks
    ↓ tasks.md organized by User Story
/speckit.implement
    ↓ Execute tasks + mark [x] + commit
```

## Prevention/Application

1. **New feature?** Start with `/speckit.specify`, not file creation
2. **Technical decision?** Use `/debate` - Haiku critic catches blind spots
3. **Use Ralph loop** to force 5+ iterations of practice
4. **Mark checkboxes** - `- [x] T001` shows progress

---

**Related**:
- [Retrospective](../retrospectives/2025-12/31/07.17_speckit-workflow-mastery-ralph-loop.md)
- [Speckit Workflow - Proper Usage](./2025-12-31_speckit-workflow-proper-usage-the-speckit-wo.md)
- [Speckit-First, Not Speckit-After](./2025-12-30_speckit-first-not-speckit-after-anti-patter.md)
