---
title: ## Complete Speckit Workflow - End-to-End Practice
tags: [speckit, workflow, complete-flow, practice, lesson-learned, debate]
created: 2025-12-31
source: Ralph Loop Completion - 2025-12-31
---

# ## Complete Speckit Workflow - End-to-End Practice

## Complete Speckit Workflow - End-to-End Practice

Successfully practiced the full speckit workflow from specification to implementation. Here's the detailed flow:

### The Complete Flow (Practiced with 053-hello-greeting)

```
/speckit.specify "feature description"
    ↓ Creates branch (053-hello-greeting)
    ↓ Creates spec.md with User Stories, Requirements, Success Criteria
    ↓ Creates checklists/requirements.md (quality validation)
    
/speckit.plan
    ↓ Runs setup-plan.sh script
    ↓ Loads constitution.md for compliance check
    ↓ Use /debate for technical decisions (3 rounds, Opus vs Critic)
    ↓ Creates plan.md with Constitution Check, Debate Reference
    
/speckit.tasks
    ↓ Runs check-prerequisites.sh script
    ↓ Reads spec.md for User Stories (P1, P2, P3)
    ↓ Reads plan.md for tech stack and structure
    ↓ Creates tasks.md organized by User Story
    ↓ Format: - [ ] T001 [P] [US1] Description with file path
    
/speckit.implement
    ↓ Checks checklists first (must all pass)
    ↓ Loads tasks.md and plan.md
    ↓ Executes phase-by-phase
    ↓ Marks tasks [x] as completed
    ↓ Commits changes
```

### Key Learnings

1. **Scripts do heavy lifting**: Each command has a bash script that sets up paths and structure
2. **Constitution is non-negotiable**: Every plan must pass constitution gates
3. **Debate is valuable**: 3 rounds of Opus vs Critic found better solution (slash command + hook vs hook-only)
4. **Tasks by User Story**: Not by layer - enables independent testing
5. **Checkboxes matter**: Mark [x] as you complete tasks

### Files Created for 053-hello-greeting

| Phase | Files |
|-------|-------|
| /speckit.specify | spec.md, checklists/requirements.md |
| /speckit.plan | plan.md (with debate reference) |
| /speckit.tasks | tasks.md (15 tasks) |
| /speckit.implement | .claude/commands/hello.md, .claude/hooks/hello-greeting.sh |

### Time Investment

- 5 Ralph loop iterations
- Full end-to-end practice
- 3 Oracle learnings created
- 1 working feature committed

**Completion Promise Fulfilled**: "speckit workflow learned"

---
*Added via Oracle Learn*
