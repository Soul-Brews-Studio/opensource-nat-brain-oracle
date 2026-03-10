---
title: Workshop Teaching Content - Learnings Extraction
created: 2025-12-12
tags: [workshop, teaching, patterns, advanced-agentic-ai]
source: Extracted from ψ/memory/learnings/
---

# Workshop Teaching Content - Advanced Agentic AI

> Distilled patterns from 10+ learnings files, organized for teaching "Advanced Agentic AI Workshop"

---

## TIER 1: Foundation Patterns (Teach First)

### 001. Delegate Reading to Sub-agents
**File**: `001-delegate-reading.md`
**Key Insight**: Use cheap agents (Haiku) for data gathering, expensive agents (Opus) for decision-making
**Workshop Hook**: "Token efficiency is design philosophy"

**Teachable Pattern**:
- IF file > 100 lines → delegate to subagent
- IF you need metadata → use subagent to extract before main agent reads
- Cost example: 348 lines in main context = 500 tokens wasted vs Haiku summarize = 50 tokens

**Real Example**: DustBoy chat (1443 lines) - would cost 2000+ Opus tokens if read directly

---

### 002. Context-Finder FIRST - Always
**File**: `002-context-finder-first.md`
**Key Insight**: Make search/summarization a default reflex before any large file operation
**Workshop Hook**: "The 10x rule - delegation saves context, time, and money"

**Teachable Pattern**:
```
BEFORE: "I need to find X in file Y"
CHECK: "Can context-finder (Haiku) do this?"
ANSWER: Almost always YES
ACTION: Task(context-finder, "search X in Y, return summary")
NOT: Read(file_Y)
```

**Checklist Before Every Search**:
- Is this in context/, raw/, retrospectives/, journal/?
- Is file likely > 100 lines?
- Could I ask context-finder to find/summarize this?
- Am I about to Read() when I should Task()?

---

### 003. File Size Check Before Reading
**File**: `005-file-size-check-before-read.md`
**Key Insight**: One command decides your entire flow (token efficiency)
**Workshop Hook**: "Make decisions programmatically, not by guessing"

**Teachable Pattern**:
```bash
wc -l "filename.txt"
# Decision Tree:
# < 500 lines    → Read directly
# 500-2000 lines → Read head + tail, decide
# > 2000 lines   → Use subagent (Haiku)
```

**Cost-Benefit Trade**:
- Small overhead: 5 seconds to check size
- Big payoff: Save 500-2000 tokens per file

---

### 004. Human Confirmation Loop
**File**: `004-human-confirmation-loop.md`
**Key Insight**: Create first, confirm before commit - AI writes, human approves
**Workshop Hook**: "The hidden 5-second rule that prevents silent failures"

**Teachable Pattern**:
```
Create [artifact] → Show summary → Ask 3 questions → ONLY commit if human says yes
```

**Questions to Ask Before Commit**:
1. "Is this what you wanted?"
2. "What's missing?"
3. "What should I add/fix?"

**Anti-Pattern**: Create and commit silently → user has no control → knowledge quality drifts

---

### 005. Speech-to-Text Uncertainty Handling
**File**: `003-speech-to-text-uncertainty.md`
**Key Insight**: Balance between confirming every message and wasting time
**Workshop Hook**: "Uncertainty management - when to ask vs. when to assume"

**Teachable Pattern**:
- **Confirm When**: High uncertainty, destructive actions, after negative feedback
- **Don't Confirm**: Clear intent, low risk, continuation of established pattern
- **Detection**: Human says "ไม่ใช่", "ทำเกิน", looks frustrated

---

## TIER 2: Architecture Patterns (Teach Second)

### 006. Naming Philosophy
**File**: `000-naming-philosophy.md`
**Key Insight**: Good names transform technical decisions into memorable structures
**Workshop Hook**: "Architecture is communication"

**Teachable Pattern**:
```
retrospectives/2025-12/09/18.19_cellar-flutter-scaffold.md
       domain      Y-M   D    HH.MM + descriptive-slug
```

**Principles**:
- Numbered (000-) = critical learnings
- Unnumbered = general patterns
- Date folders = "what happened on day X?"
- Descriptive > Cryptic

**Why Structure Matters**: Names should be scannable without opening files

---

### 007. Knowledge Distillation Loop
**File**: `007-knowledge-distillation-loop.md`
**Key Insight**: Knowledge flows through 3 layers, each removing noise and extracting signal
**Workshop Hook**: "The architecture of becoming smarter"

**Teachable Pattern**:
```
Retrospective (20-50KB, exhaustive)
       ↓ extract patterns
Log (3-5KB, snapshots)
       ↓ identify reusable
Learning (1-2KB, distilled)
       ↓ crystallize
CLAUDE.md (final wisdom)
```

**Key Concept**: Each layer serves a purpose - don't skip levels

**Layer Purposes**:
- **Retrospective**: Full narrative, answer "what happened?"
- **Log**: Quick capture, answer "what matters?"
- **Learning**: Distilled rule, answer "what to remember?"
- **CLAUDE.md**: Project wisdom, answer "how should I work?"

---

### 008. Plugin System Architecture
**File**: `006-plugin-system-architecture.md`
**Key Insight**: Auto-discovery requires understanding folder conventions, not explicit paths
**Workshop Hook**: "Let the system find things - don't tell it where to look"

**Teachable Pattern**:
```
plugins/my-plugin/
├── hooks/hooks.json    ← Must be here (auto-discovered)
├── commands/           ← Auto-discovered
├── agents/             ← Auto-discovered
└── knowledge/          ← Custom folder
```

**Critical Finding**: 
- SessionStart hooks from different plugins may NOT merge
- Hook format: root-level `{"SessionStart": [...]}` NOT wrapped in `{"hooks": {...}}`
- Claude Code auto-discovery = no explicit paths needed

---

### 009. Active Context Design
**File**: `008-active-context-design.md`
**Key Insight**: Active should be ephemeral, not accumulating
**Workshop Hook**: "Ephemeral spaces enable focus"

**Teachable Pattern**:
```
active/
├── INDEX.md          ← List current tasks
├── [task].md         ← Plan file per task
└── context/          ← EMPTY or temp only
```

**Workflow**:
1. Receive task → create `active/[task].md` (plan)
2. Work → context/ for temp files only
3. Finish → move to memory/reference/ or delete
4. context/ → delete when task completes

---

### 010. Subagent Context Limitation
**File**: `009-subagent-context-limitation.md`
**Key Insight**: Subagents are tools, not co-writers - use them for data, not output
**Workshop Hook**: "Use the right tool for the right job"

**Teachable Pattern**:
| Task | Who | Why |
|------|-----|-----|
| Gather data (git log, search) | Subagent (Haiku) | Cheap, focused |
| Write final output | Main agent (Opus) | Knows full context |

**Anti-Pattern**: Give subagent full writing task without context → wrong paths, wrong format

---

### 011. Hide Implementation Details
**File**: `010-hide-implementation-details.md`
**Key Insight**: Wrap ugly commands in clean scripts - presentation matters
**Workshop Hook**: "UX extends to the terminal"

**Teachable Pattern**:
```bash
# Instead of:
osascript scripts/xxx.scpt "..."

# Use:
./scripts/send-antigravity "..."
```

**Principle**: Once you hide something, don't talk about it - it doesn't exist

---

## TIER 3: Meta Patterns (Teach Third)

### 012. Thai Font Licensing Lesson
**File**: `011-thai-font-licensing.md`
**Key Insight**: Check licenses before shipping fonts/assets
**Workshop Hook**: "Compliance prevents lawsuits"

---

## Key Patterns That Cross-Cut All Learnings

### Pattern A: Delegation Hierarchy
```
Task complexity → choose agent → specify constraints → verify output
```

**Examples**:
- Simple search → Haiku context-finder
- Large file reading → Haiku context-finder
- Final output writing → Opus main agent
- Code review → Opus

### Pattern B: The Confirmation Loop
```
Create → Show → Ask → Approve → Commit
```
Used in: retrospectives, learnings, knowledge artifacts

### Pattern C: Size-Based Decision Tree
```
IF small (< 100 lines) → handle directly
IF medium (100-2000 lines) → preview + decide
IF large (> 2000 lines) → delegate
```

### Pattern D: The Oracle Philosophy Implementation
```
Nothing is Deleted → Patterns Over Intentions → External Brain → Human Stays Human
```
Applied through: knowledge layers, active/ephemeral structure, distillation loop

---

## Recommended Workshop Curriculum

### Session 1: Foundations (2.5 hours)
1. Delegate Reading (001) - 20 min
2. File Size Check (005) - 20 min
3. Context-Finder First (002) - 20 min
4. Human Confirmation Loop (004) - 20 min
- **Exercise**: Build a subagent workflow using these 4 patterns
- **Output**: Write a simple context-finder task

### Session 2: Architecture (2.5 hours)
1. Naming Philosophy (000) - 20 min
2. Knowledge Distillation Loop (007) - 30 min
3. Plugin System Architecture (006) - 25 min
4. Active Context Design (008) - 20 min
- **Exercise**: Design a project structure using distillation loop
- **Output**: Create knowledge architecture for your project

### Session 3: Advanced Integration (2 hours)
1. Subagent Context Limitation (009) - 20 min
2. Hide Implementation Details (010) - 20 min
3. Speech-to-Text Uncertainty (003) - 15 min
4. All Patterns Combined - 40 min capstone project
- **Exercise**: Build complete agentic system with all patterns
- **Output**: Working multi-agent system

### Bonus: Oracle Philosophy
- 012 Thai Font Licensing - compliance example
- Deep dive into Oracle Keeper role (if time allows)

---

## Teaching Tips

### What Resonates Most
- Concrete examples with token costs/savings
- Real failures (what went wrong, how we fixed it)
- The "aha!" moment patterns (confirmation loop, distillation)
- Cost-benefit analysis (token efficiency)

### What Gets Pushed Back
- "Why can't I just read files directly?" → Answer: Show the math (2000 tokens saved)
- "Seems like too many steps" → Answer: Show time savings (5 sec check saves 2 min reading)
- "Can't the AI just figure it out?" → Answer: Show the failures (Oracle philosophy)

### Engagement Strategies
- Use actual learnings files as primary source (shows real work)
- Thai language in some examples (Nat's preference, builds connection)
- Cost/efficiency metrics (what engineers care about)
- Live exercises with immediate feedback

---

## Quick Reference for Instructors

| Learning | Best For | Teaching Time | Difficulty |
|----------|----------|----------------|------------|
| 001 Delegate | Kickoff, motivation | 20 min | Easy |
| 002 Context-First | Workflow, habits | 20 min | Easy |
| 003 S2T Uncertainty | UX, nuance | 15 min | Medium |
| 004 Confirmation | Quality gates | 20 min | Easy |
| 005 File Size Check | Token efficiency | 20 min | Easy |
| 006 Plugin System | Architecture | 25 min | Medium |
| 007 Distillation Loop | Knowledge strategy | 30 min | Hard |
| 008 Active Context | Project design | 20 min | Medium |
| 009 Subagent Limits | Tool selection | 20 min | Medium |
| 010 Hide Details | UX/Polish | 20 min | Easy |
| 011 Font License | Compliance | 15 min | Easy |

---

## Related Resources

**Foundation**:
- [CLAUDE.md](../../CLAUDE.md) - Project instructions
- [Oracle Philosophy](../resonance/oracle.md) - Core philosophy
- [Naming Convention](../learnings/000-naming-philosophy.md) - Structure

**Practice**:
- [CLAUDE_workflows.md](../../CLAUDE_workflows.md) - Short codes (ccc, rrr, /snapshot, /distill)
- [CLAUDE_lessons.md](../../CLAUDE_lessons.md) - Anti-patterns to avoid

**Sessions**:
- [Retrospectives Index](../retrospectives/INDEX.md) - Real session notes
- [Logs Archive](../logs/) - Snapshot examples

---

*Created: 2025-12-12*
*Source: 11 learnings files from ψ/memory/learnings/*
*Status: Ready for Advanced Agentic AI Workshop*
