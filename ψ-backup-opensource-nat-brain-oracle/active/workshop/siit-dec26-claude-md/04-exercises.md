# CLAUDE.md Workshop Exercises

## Exercise 1: Golden Rules (Part 2)

**Time:** 10 minutes

### Task
Write 5 Golden Rules for a project you're working on.

### Template
```markdown
## Golden Rules

1. NEVER ___________________________________
   Why: ___________________________________

2. NEVER ___________________________________
   Why: ___________________________________

3. Always _________________________________
   Why: ___________________________________

4. Ask before _____________________________
   Why: ___________________________________

5. ________________________________________
   Why: ___________________________________
```

### Examples to Consider
- What could break production?
- What data is sensitive?
- What operations are irreversible?
- What needs human approval?

### Share
Share your top rule with the group!

---

## Exercise 2: Navigation Table (Part 3)

**Time:** 15 minutes

### Task
Plan a modular CLAUDE.md structure for your project.

### Template
```markdown
## Navigation

| File | Content | Priority |
|------|---------|----------|
| CLAUDE.md | Main hub | Required |
| CLAUDE___________.md | _____________ | ________ |
| CLAUDE___________.md | _____________ | ________ |
| CLAUDE___________.md | _____________ | ________ |

### When to Read

| File | When to Read |
|------|--------------|
| CLAUDE.md | Every session |
| CLAUDE___.md | When _______ |
| CLAUDE___.md | When _______ |
```

### Questions to Answer
1. What topics deserve their own file?
2. When would AI need to read each file?
3. What's the priority order?

---

## Exercise 3: ψ/ Structure (Part 4)

**Time:** 15 minutes

### Task
Create a minimal ψ/ structure for your project.

### Step 1: Create directories
```bash
mkdir -p ψ/memory/{retrospectives,learnings}
```

### Step 2: Create .gitkeep files
```bash
touch ψ/memory/retrospectives/.gitkeep
touch ψ/memory/learnings/.gitkeep
```

### Step 3: Create WIP.md
```markdown
# WIP - Work in Progress

## Current Focus
- [ ]

## Today
- [ ]

## Pending
- [ ]

---
*Last updated: [date]*
```

### Step 4: Update .gitignore
```gitignore
# ψ/ - AI Brain
ψ/active/*
!ψ/active/.gitkeep
ψ/memory/logs/*
!ψ/memory/logs/.gitkeep
```

### Verify
```bash
ls -la ψ/
ls -la ψ/memory/
```

---

## Exercise 4: First Retrospective (Part 5)

**Time:** 15 minutes

### Task
Create your first retrospective for today's workshop.

### Template
```markdown
# Workshop Retrospective

**Date:** 2025-12-26
**Duration:** ~2 hours
**Focus:** CLAUDE.md Workshop at SIIT

## Summary
- Learned about CLAUDE.md structure
- Created Golden Rules for my project
- Set up ψ/ folder structure
- [Your additions]

## AI Diary
[Write 3-5 sentences about what you learned.
Use first person: "I discovered that...", "I realized..."]

## Honest Feedback

### What Worked
- [Something that clicked]
- [Something useful]

### What Was Challenging
- [Something difficult]
- [Something unclear]

## Lessons Learned
- Pattern: [Something reusable]
- Discovery: [Something new]

## Next Steps
- [ ] Apply CLAUDE.md to real project
- [ ] Create more Golden Rules
- [ ] [Your next step]

---
*Created: 2025-12-26*
```

### Save to
```
ψ/memory/retrospectives/2025-12/26/workshop-claude-md.md
```

---

## Exercise 5: Build Your CLAUDE.md (Part 6)

**Time:** 20 minutes

### Task
Create a complete CLAUDE.md for your project.

### Checklist
- [ ] Project name and description
- [ ] 3-5 Golden Rules
- [ ] Project structure overview
- [ ] Tech stack
- [ ] Naming conventions
- [ ] Git workflow
- [ ] Key commands
- [ ] Link to ψ/ (if created)

### Minimum Viable CLAUDE.md
```markdown
# [Project] - AI Guide

## Golden Rules
1. [Rule 1]
2. [Rule 2]
3. [Rule 3]

## Stack
- [Technology 1]
- [Technology 2]

## Structure
- src/ - [Purpose]
- tests/ - [Purpose]

## Commands
- `[command]` - [Description]
- `[command]` - [Description]
```

### Test It!
1. Save your CLAUDE.md
2. Start a new Claude Code session
3. Ask: "What are the rules for this project?"
4. Does AI understand correctly?

---

## Bonus Exercise: Install nat-agents-core

**Time:** 5 minutes

### Task
Install the Oracle plugin and awaken your project.

### Steps
```bash
# 1. Add marketplace
/plugin marketplace add laris-co/nat-plugins

# 2. Install plugin
/plugin install nat-agents-core@nat-plugins

# 3. Initialize (choose one)
/soul-lite     # Minimal ψ/
/soul-init     # Full ψ/ + Obsidian

# 4. Install commands
/awaken

# 5. Test
/recap
```

### What You Get
- `/recap` - Fresh start context
- `/trace` - Search history
- `rrr` - Session retrospective
- `/snapshot` - Quick capture
- `/forward` - Forward context
- `/wip` - Show work in progress
- `/standup` - Daily standup

---

## Group Exercise: Review Each Other's CLAUDE.md

**Time:** 10 minutes

### Task
Pair up and review each other's CLAUDE.md.

### Review Checklist
- [ ] Are the Golden Rules specific enough?
- [ ] Is the structure clear?
- [ ] Would a new AI understand the project?
- [ ] What's missing?
- [ ] What's unnecessary?

### Feedback Template
```
Good:
- [Something well done]

Suggestion:
- [Something to improve]

Question:
- [Something unclear]
```

---

## Take-Home Exercise

### Task
Over the next week:

1. **Day 1-2:** Apply CLAUDE.md to your real project
2. **Day 3-4:** Add ψ/ structure, create first retrospective
3. **Day 5-6:** Iterate based on usage
4. **Day 7:** Review and improve

### Report Back
Share your experience:
- What worked?
- What did you change?
- What patterns emerged?

---

*End of Exercises*
