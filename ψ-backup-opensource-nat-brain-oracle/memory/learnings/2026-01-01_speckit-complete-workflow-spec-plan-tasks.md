---
date: 2026-01-01
tags: [speckit, spec, plan, tasks, workflow]
context: Data-Aware RAG v2 planning session
---

# Speckit Complete Workflow: spec.md → plan.md → tasks.md

## The Pattern

When planning a feature, create all three artifacts in sequence:

```
spec.md  →  plan.md  →  tasks.md
(what)      (how)       (checklist)
```

## What Each File Contains

### spec.md (What)
- Vision statement
- User stories with acceptance criteria
- Functional requirements (FR-001, FR-002...)
- Non-functional requirements (NFR-001...)
- Success criteria (SC-001...)
- Architecture diagram
- Dependencies

### plan.md (How)
- Tech stack decisions with rationale
- Phases (1, 2, 3...) with goals
- Tasks grouped by phase
- Deliverables per phase
- Risk assessment
- Dependencies graph
- Testing strategy

### tasks.md (Checklist)
- Task IDs (T001, T002...)
- File paths affected
- Dependencies between tasks
- `[P]` marker for parallel tasks
- Progress summary table
- Definition of done

## Key Insights

### 1. Status Tracking
Keep implementation status table in spec.md:
```markdown
| Component | Status | Tech |
|-----------|--------|------|
| SQLite | ✅ Done | bun:sqlite |
| CLI | ⏳ TODO | Commander.js |
```

### 2. Priority Levels
Use P0/P1/P2/P3 consistently:
- P0 = Must have (MVP)
- P1 = Should have (complete)
- P2 = Nice to have
- P3 = Future/optional

### 3. Parallel Task Markers
Mark tasks that can run concurrently:
```markdown
- [ ] **T003**: Create progress utility
- [P] **T004**: Create output utility  ← Can run parallel
```

### 4. Carry Forward UX Issues
Include critic feedback in spec:
```markdown
## UX Fixes from Critic (Carry Forward)
| Priority | Issue | Fix |
|----------|-------|-----|
| P0 | Pagination unusable | Jump-to-page |
```

## File Locations

```
specs/[number]-[name]/
├── spec.md       # What to build
├── plan.md       # How to build
└── tasks.md      # Checklist
```

## Commands Reference

| Command | Purpose |
|---------|---------|
| `/speckit.specify` | Create/update spec.md |
| `/speckit.plan` | Create plan.md |
| `/speckit.tasks` | Create tasks.md |
| `/speckit.analyze` | Check alignment |
| `/speckit.implement` | Start coding |

## Anti-Pattern Avoided

**Bad**: Start coding without spec
**Good**: spec → plan → tasks → code

## Key Quote

> "A spec that matches reality is more valuable than a spec that describes a dream."
