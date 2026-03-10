---
title: ## Speckit Workflow - Proper Usage
tags: [speckit, workflow, specification, slash-commands, planning]
created: 2025-12-31
source: Ralph Loop Learning Session 2025-12-31
---

# ## Speckit Workflow - Proper Usage

## Speckit Workflow - Proper Usage

The speckit workflow is a specification-first development process that uses custom slash commands to guide feature development.

### The Complete Flow

1. `/speckit.specify [description]` → Creates feature branch + spec.md
   - Generates branch with sequential number (e.g., 053-feature-name)
   - Creates User Stories with priorities (P1, P2, P3)
   - Defines Functional Requirements (FR-001, FR-002)
   - Sets measurable Success Criteria
   - Maximum 3 [NEEDS CLARIFICATION] markers

2. `/speckit.clarify` → Resolves ambiguities (optional but recommended)
   - One question at a time, max 5 questions
   - Provides recommendations with reasoning
   - Updates spec.md directly with answers

3. `/speckit.plan` → Creates implementation plan
   - Phase 0: Research (resolves technical unknowns)
   - Phase 1: Design (data-model.md, contracts/)
   - Checks constitution compliance
   - Updates agent context file

4. `/speckit.tasks` → Generates actionable tasks.md
   - Organized by User Story (not by layer)
   - Each task: `- [ ] T001 [P] [US1] Description with file path`
   - Phases: Setup → Foundational → User Stories → Polish

5. `/speckit.analyze` → Quality check (READ-ONLY)
   - Cross-artifact consistency check
   - Coverage gaps detection
   - Constitution alignment verification
   - Run AFTER tasks, BEFORE implement

6. `/speckit.implement` → Execute the tasks
   - Checks checklists first
   - Phase-by-phase execution
   - Marks tasks as [X] when complete

### Key Principles

- **Speckit-First**: Define specs BEFORE coding
- **Slash Commands with Parameters**: Use `/speckit.specify Add user auth` not manual file creation
- **User Story Organization**: Tasks grouped by story, not by layer
- **Independent Testing**: Each story can be tested independently
- **Constitution Compliance**: Check at every stage

---
*Added via Oracle Learn*
