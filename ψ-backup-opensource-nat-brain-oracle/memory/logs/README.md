# ψ-logs/

> **Tier**: 1 (Ephemeral)
> **Git**: Ignored (new files), Legacy tracked
> **Lifecycle**: Days to Weeks

Quick knowledge snapshots. What we learned, discovered, and how things connect.

## Philosophy

> Logs capture the moment. Retrospectives analyze the session. Learnings distill the wisdom.

Logs are created via `/snapshot` — fast captures of insights without heavy process.

## Structure

```
logs/
└── YYYY-MM/
    ├── DD_HH.MM_descriptive-slug.md
    ├── DD_HH.MM_another-topic.md
    └── ...
```

Example: `logs/2025-12/09_18.29_retrospective-naming-pattern.md`

## Naming Convention

- **YYYY-MM/**: Year-month folder
- **DD_HH.MM_**: Day and time prefix (enables chronological sorting)
- **descriptive-slug**: What this log is about (lowercase, hyphens)

## Template

```markdown
# [Title]

**Time**: HH:MM GMT+7

## What We Learned
- Key insight 1
- Key insight 2

## How Things Connect
- Relationship 1: X relates to Y because...

## Key Discoveries
- Discovery with context

## Commits
- `hash` message

## Tags
`tag1` `tag2` `tag3`

## Raw Thoughts
Unprocessed observations, questions, ideas
```

## Related

- `learnings/` — Distilled, reusable patterns
- `retrospectives/` — Detailed session analysis
- `/snapshot` — Command to create new logs
