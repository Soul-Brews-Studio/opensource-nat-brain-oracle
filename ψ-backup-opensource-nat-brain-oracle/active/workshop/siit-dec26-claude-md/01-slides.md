# CLAUDE.md Workshop Slides

## Part 1: Why CLAUDE.md? (10 min)

---

### Slide 1: The Problem

```
Developer: "Add a login feature"

AI without context:
- Which framework?
- What auth method?
- Where to put files?
- What coding style?
- What's the project structure?

Result: Generic code that doesn't fit
```

---

### Slide 2: The Solution

```
CLAUDE.md = Project Instructions for AI

Like onboarding docs for a new team member
But for your AI assistant
```

---

### Slide 3: Demo - Without vs With

**Without CLAUDE.md:**
```
> Add user authentication

"I'll create a basic auth system using JWT..."
[Generic solution, wrong structure, different style]
```

**With CLAUDE.md:**
```
> Add user authentication

"Based on your project using Next.js + Supabase,
I'll add auth following your existing patterns in /lib/auth..."
[Project-specific solution]
```

---

### Slide 4: What Goes in CLAUDE.md?

| Category | Examples |
|----------|----------|
| **Project Context** | Stack, structure, conventions |
| **Rules** | Safety, git workflow, file access |
| **Patterns** | Naming, folder structure, code style |
| **Commands** | Short codes, workflows |
| **Knowledge** | Where to find docs, history |

---

## Part 2: Golden Rules (15 min)

---

### Slide 5: Safety First

```markdown
## Golden Rules

1. NEVER use `--force` flags
2. NEVER push to main
3. NEVER merge PRs without approval
4. NEVER create temp files outside repo
5. Safety first - Ask before destructive actions
```

**Why?** AI is powerful but needs guardrails

---

### Slide 6: Git Safety

```markdown
## Git Operations

- Always create feature branch
- Always create PR (never direct push)
- Wait for human approval before merge
- No force push, no hard reset
```

**Pattern:**
```
feature-branch → PR → Review → Merge
```

---

### Slide 7: File Access Rules

```markdown
## File Access Rules

Any file operation outside project root:
1. Inform user first, OR
2. Ask for confirmation

Not banned, but MUST notify.
```

**Why?** Transparency = Trust

---

### Slide 8: Hands-on #1

```
Write 3 Golden Rules for YOUR project:

1. ________________________________
2. ________________________________
3. ________________________________

Consider:
- What operations are dangerous?
- What should AI never do alone?
- What needs human approval?
```

---

## Part 3: Modular Structure (20 min)

---

### Slide 9: The Evolution

```
Day 1: Small CLAUDE.md (50 lines)
        ↓
Day 7: Growing... (200 lines)
        ↓
Day 14: Too long! Hard to find things
        ↓
Solution: SPLIT into focused files
```

---

### Slide 10: The 6-File System

```
CLAUDE.md (hub)
├── CLAUDE_safety.md      (62 lines)
├── CLAUDE_workflows.md   (187 lines)
├── CLAUDE_subagents.md   (165 lines)
├── CLAUDE_lessons.md     (77 lines)
└── CLAUDE_templates.md   (335 lines)

Total: 1,118 lines → Organized!
```

---

### Slide 11: When to Read

| File | When | Priority |
|------|------|----------|
| CLAUDE.md | Every session start | Required |
| CLAUDE_safety.md | Before git operations | Required |
| CLAUDE_workflows.md | When using commands | As needed |
| CLAUDE_subagents.md | Before spawning agents | As needed |
| CLAUDE_lessons.md | When stuck | Reference |
| CLAUDE_templates.md | When creating docs | Reference |

---

### Slide 12: Navigation Table

```markdown
## Navigation

| File | Content |
|------|---------|
| [CLAUDE_safety.md](CLAUDE_safety.md) | Git rules |
| [CLAUDE_workflows.md](CLAUDE_workflows.md) | Commands |
| ...

### When to Read

| File | When to Read | Priority |
|------|--------------|----------|
| CLAUDE.md | Every session | Required |
| ...
```

**Key:** Tell AI exactly when to read each file

---

### Slide 13: Hands-on #2

```
Plan your modular structure:

Main file: CLAUDE.md
├── _______________.md (what content?)
├── _______________.md (what content?)
└── _______________.md (what content?)

Start with 2-3 files, add more as needed.
```

---

## Part 4: ψ/ Brain Structure (20 min)

---

### Slide 14: The Problem

```
Where do I put...
- Research notes?
- Session logs?
- Lessons learned?
- Draft articles?
- Experiments?

Without structure → Chaos
```

---

### Slide 15: 5-Pillar Solution

```
ψ/
├── active/     ← "กำลังค้นคว้าอะไร?"
├── inbox/      ← "คุยกับใคร?"
├── writing/    ← "กำลังเขียนอะไร?"
├── lab/        ← "กำลังทดลองอะไร?"
└── memory/     ← "จำอะไรได้?"
```

Each pillar answers a question.

---

### Slide 16: Memory Structure

```
ψ/memory/
├── logs/           ← Moments (ephemeral)
├── retrospectives/ ← Sessions (tracked)
├── learnings/      ← Patterns (tracked)
└── resonance/      ← Soul/Identity (tracked)
```

**Hierarchy:** Raw → Processed → Distilled → Core

---

### Slide 17: Knowledge Flow

```
active/context → memory/logs → retrospectives → learnings → resonance
   (research)     (snapshot)     (session)      (patterns)    (soul)
```

**Commands:**
- `/snapshot` → Capture to logs
- `rrr` → Create retrospective
- `/distill` → Extract to learnings

---

### Slide 18: Git Status

| Folder | Tracked | Purpose |
|--------|---------|---------|
| ψ/active/* | No | Work in progress |
| ψ/inbox/* | Yes | Communication |
| ψ/writing/* | Yes | Drafts |
| ψ/lab/* | Yes | Experiments |
| ψ/memory/logs/* | No | Ephemeral |
| ψ/memory/retrospectives/* | Yes | History |
| ψ/memory/learnings/* | Yes | Knowledge |

---

### Slide 19: Hands-on #3

```
Create minimal ψ/ for your project:

mkdir -p ψ/memory/{retrospectives,learnings}
touch ψ/memory/retrospectives/.gitkeep
touch ψ/memory/learnings/.gitkeep

echo "# WIP" > ψ/WIP.md
```

Start small, grow as needed!

---

## Part 5: Commands & Workflows (15 min)

---

### Slide 20: Core Commands

| Command | Purpose | Output |
|---------|---------|--------|
| `/recap` | Fresh start context | Summary |
| `rrr` | Session retrospective | ψ/memory/retrospectives/ |
| `/snapshot` | Quick capture | ψ/memory/logs/ |
| `/trace` | Search history | Timeline |

---

### Slide 21: Retrospective Template

```markdown
# Session Retrospective

**Date**: 2025-12-24
**Duration**: ~90 minutes

## Summary
What we did...

## AI Diary (REQUIRED)
First-person reflection on the session...

## Honest Feedback (REQUIRED)
What worked, what didn't...

## Lessons Learned
- Pattern 1
- Pattern 2
```

---

### Slide 22: Workflow Example

```
Start session:
> /recap

Work on features...

End session:
> rrr

Extract patterns:
> /distill

Search history:
> /trace [topic]
```

---

### Slide 23: Demo

Live demo of full workflow:
1. `/recap` - Get context
2. Work on task
3. `rrr` - Create retrospective
4. Show resulting files

---

## Part 6: Build Your Own (20 min)

---

### Slide 24: Starter Template

```markdown
# [Project Name] - AI Assistant Guide

## Golden Rules
1. [Your rule]
2. [Your rule]
3. [Your rule]

## Project Structure
- src/ - Source code
- docs/ - Documentation
- ...

## Conventions
- [Naming convention]
- [Code style]
- [Git workflow]

## Quick Commands
- `/recap` - Get context
- `rrr` - Session retrospective
```

---

### Slide 25: Checklist

Your CLAUDE.md should have:
- [ ] Golden Rules (3-5 rules)
- [ ] Project structure overview
- [ ] Key conventions
- [ ] File/folder purposes
- [ ] Workflow commands
- [ ] Where to find docs

---

### Slide 26: Tips

1. **Start small** - Add rules as you discover needs
2. **Be specific** - "Use Tailwind" not "Use CSS framework"
3. **Update often** - CLAUDE.md grows with project
4. **Test it** - Start new session, does AI understand?

---

### Slide 27: Resources

- **nat-agents-core plugin**: `laris-co/nat-agents-core`
  - `/awaken` - Install commands
  - `/soul-lite` - Create minimal ψ/
  - `/oracle-init` - Add philosophy

- **Reference**: This workshop's CLAUDE.md
  - 27 commits of evolution
  - 1,118 lines of documentation
  - 16 days of refinement

---

### Slide 28: Q&A

```
Questions?

Contact:
- GitHub: laris-co
- Workshop materials: ψ/active/workshop/siit-dec26-claude-md/
```

---

*Total: ~100 minutes (adjust as needed)*
