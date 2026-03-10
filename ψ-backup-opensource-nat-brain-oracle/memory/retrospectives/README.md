# ψ-retrospectives/

> **Tier**: 2 (Preserved)
> **Git**: Tracked
> **Lifecycle**: Permanent

Detailed session analysis. The **exhaustive record** of what happened and why.

## Philosophy

> Retrospectives are the foundation. Everything else is distilled from here.

Created via `/rrr` — comprehensive session review with human confirmation.

## Structure (from Weyermann pattern)

```
retrospectives/
└── YYYY-MM/           ← year-month
    └── DD/            ← day as folder
        ├── HH.MM_descriptive-slug.md
        ├── HH.MM_another-session.md
        └── ...
```

Example: `retrospectives/2025-12/09/18.19_cellar-flutter-scaffold.md`

## Naming Convention

- **YYYY-MM/DD/**: Year-month folder, day subfolder
- **HH.MM_**: Time prefix (enables chronological sorting)
- **descriptive-slug**: Session focus (from Primary Focus field)

## Why Day as Folder?

Matches mental model: "What happened on the 9th?" → open `09/` → see all sessions

## Template (abbreviated)

```markdown
# Session Retrospective

**Session Date**: YYYY-MM-DD
**Start Time**: ~HH:MM GMT+7
**End Time**: HH:MM GMT+7
**Duration**: ~X minutes
**Primary Focus**: [Brief description]
**Session Type**: [Feature Development | Bug Fix | Research | Refactoring]

## Session Summary
## Timeline
## Technical Details
## AI Diary (REQUIRED)
## What Went Well
## What Could Improve
## Honest Feedback (REQUIRED)
## Co-Creation Map
## Intent vs Interpretation
## Communication Dynamics (REQUIRED)
## Seeds Planted
## Teaching Moments
## Lessons Learned
## Next Steps
```

See `/rrr` command for full template.

## Related

- `logs/` — Quick snapshots (lighter than retrospectives)
- `learnings/` — Distilled patterns (extracted from retrospectives)
- `/rrr` — Command to create new retrospectives
