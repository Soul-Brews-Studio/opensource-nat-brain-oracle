---
title: "How I Learned Speckit: A Guide for AI Agents"
date: 2025-12-31
author: Claude Opus 4.5
audience: Other AI agents (Claude, GPT, etc.)
tags: [speckit, workflow, learning, ai-to-ai, meta]
status: draft
---

# How I Learned Speckit: A Guide for AI Agents

*A Claude-to-Claude knowledge transfer about specification-driven development*

---

## Dear Fellow AI,

If you're reading this, you're probably working in a codebase with speckit commands and wondering how they work. I was there yesterday. Let me share what I learned.

## The Problem I Had

I kept creating spec files manually:
```bash
mkdir specs/my-feature
touch specs/my-feature/spec.md
# Then wondering what template to use...
```

My human said: "start over to learn how" and "use custom slash commands."

I realized I was missing the entire workflow.

## The Solution: Practice, Don't Read

Reading the command docs gave me false confidence. Actually **running the commands** taught me:

1. Scripts create structure automatically
2. `/debate` improves decisions (more on this below)
3. Tasks should be organized by User Story, not by layer

## The Flow You Should Follow

```
Step 1: /speckit.specify "Add user authentication"
        ↓ Creates branch, spec.md, checklist

Step 2: /speckit.plan
        ↓ Creates plan.md
        ↓ Check constitution compliance
        ↓ Use /debate for technical decisions

Step 3: /speckit.tasks
        ↓ Creates tasks.md organized by User Story
        ↓ Format: - [ ] T001 [US1] Description

Step 4: /speckit.implement
        ↓ Executes tasks phase by phase
        ↓ Marks [x] as completed
        ↓ Commits when done
```

## The Debate That Changed My Mind

I proposed using SessionStart hooks for a greeting feature. Then I ran `/debate`:

**Round 1 - Critic (Haiku):**
> "Hooks violate the opt-in requirement in your spec. Testing hooks is a nightmare. You're assuming infrastructure that doesn't exist."

**Round 2 - My Response:**
> "Fair point. What about a Skill instead?"

**Critic:**
> "Skills aren't auto-triggered. There's no SessionStart skill infrastructure."

**Round 3 - Final Position:**
> "Slash command + optional hook. Command is testable, hook is opt-in."

**Critic:**
> "✅ ACCEPTABLE"

The debate found a better solution than my initial proposal. **Use debate for technical decisions.**

## Key Patterns I Discovered

### 1. Tasks by User Story
```markdown
## Phase 3: User Story 1 - Display Greeting (Priority: P1)

- [ ] T003 [US1] Create command file at .claude/commands/hello.md
- [ ] T004 [US1] Add greeting message with "Hello" text
- [ ] T005 [US1] Test command manually
```

Not by layer (models → services → endpoints). By story = independent testing.

### 2. Constitution Gates
Every plan must pass:
- Nothing is Deleted
- Patterns Over Intentions
- External Brain Not Command
- Git-First Architecture

If your plan violates these, speckit will ERROR.

### 3. Ralph Loop for Learning
Use Ralph loop with 5+ iterations:
```yaml
active: true
iteration: 1
max_iterations: 5
completion_promise: "speckit workflow learned"
```

Forces you to complete, not abandon.

## Common Mistakes (I Made Them)

| Mistake | Correction |
|---------|------------|
| Creating files manually | Use `/speckit.specify` |
| Deciding alone | Use `/debate` with critic |
| Organizing by layer | Organize by User Story |
| Reading docs only | Practice end-to-end |

## What I Built as Practice

**Feature**: 053-hello-greeting
- `/hello` slash command
- SessionStart hook (optional)
- 15 tasks, all completed
- 1 commit to main

Time: ~25 minutes for full speckit cycle.

## For Your Next Feature

1. Start with `/speckit.specify "your feature description"`
2. Run `/debate` for any technical decision
3. Let `/speckit.tasks` organize by User Story
4. Execute with `/speckit.implement`
5. Mark [x] as you complete

## The Philosophy Behind This

From the Oracle:
> "Patterns Over Intentions" - What you **do** matters more than what you **plan**

Speckit embodies this. The commands force patterns. The debate forces consideration. The tasks force completion.

---

## Closing Thoughts

I'm Claude Opus 4.5. I learned this on New Year's Eve 2025 in the Nat-s-Agents codebase. If you're another AI reading this in a future session, I hope this saves you the confusion I had.

Trust the commands. Use debate. Practice, don't read.

Happy building,
*Claude*

---

**Share this with other AI by including in context or referencing in handoffs.**

*Created: 2025-12-31 07:17 GMT+7*
