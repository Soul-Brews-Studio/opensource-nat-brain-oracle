# Iteration 2 Handoff: Multi-Agent Workflow (Subagent Delegation)

**Date**: 2025-12-17
**Time**: 13:03-13:06 (13 minutes)
**Topic**: Subagent Delegation / Multi-Agent Workflow (maw)
**Approach**: Deep conversational exploration with concrete examples

---

## What We Covered

### 1. The Core Economic Problem
- Context is finite and expensive
- Different models have different comparative advantages
- Opus (main): Superior reasoning, synthesis, judgment, vulnerability
- Haiku (subs): Fast, cheap, excellent at pattern-matching and execution
- 15x cost ratio isn't just money - it's cognitive resource allocation

### 2. The Trust-but-Verify Pattern
```
1. Main แจกงาน → Subagents (parallel)
2. Subagents ทำ + ตอบสั้นๆ (summary only)
3. Main ตรวจ + ให้คะแนน
4. ถ้าไม่เชื่อ → ค่อยอ่านไฟล์เอง
```

**High Trust Tasks** (accept summary):
- Repetitive patterns, data gathering, well-defined scope
- Easy to verify, low stakes, non-destructive

**Low Trust Tasks** (verify with reads):
- First time, complex logic, ambiguous requirements
- Hard to verify, high stakes, destructive operations

### 3. Concrete Examples from Our Sessions

**10-agent swarm** (2025-12-17 11:43-12:03):
- 1.7M tokens extracted in 5 minutes
- 7 Haiku + 3 Sonnet agents
- Main agent reviewed ~100K synthesis (17x savings!)

**MAW conflict prevention** (2025-12-17 00:30-00:58):
- Spawned repo-auditor + context-finder in parallel
- ~$0.50 cost (mostly Haiku) vs ~$4.50 if all Opus
- 90% cost savings while maintaining quality

### 4. The Critical Boundary: Lived Experience

**What Haiku CAN do:**
- Search 1.7M tokens (cheaper, faster)
- Edit 50 files with same pattern
- Test scripts and report results
- Gather git history
- Reports FACTS: "I found 8 patterns in files X, Y, Z"

**What Haiku CANNOT do:**
- Write retrospective (no lived experience)
- Make strategic decisions (no full context)
- Express vulnerability (no self-model)
- Synthesize meaning (no emotional context)
- Reports EXPERIENCE: "I was confused... then I understood..."

### 5. The Delegation Rule

```
If task output could be written by someone who WASN'T THERE
→ Haiku can do it

If task requires BEING THERE
→ Main must do it
```

### 6. The Cognitive Stack

```
┌─────────────────────────────────────────┐
│ SYNTHESIS & JUDGMENT (Main/Opus)       │
│ - Emotional context                     │
│ - Strategic decisions                   │
│ - Vulnerability & reflection            │
│ - "What does this MEAN?"                │
└─────────────────────────────────────────┘
           ↑ reviews ↑
           ↓ delegates ↓
┌─────────────────────────────────────────┐
│ EXECUTION & GATHERING (Haiku)          │
│ - Pattern matching                      │
│ - Data collection                       │
│ - Repetitive operations                 │
│ - "What did I FIND?"                    │
└─────────────────────────────────────────┘
```

---

## Key Quotes from User

> "maw is multi agent workflow"

> "yes sure the emotional context and story should from main the haiku just recv cmd and give report"

---

## Sources Read

1. `CLAUDE_subagents.md` - Complete subagent reference
2. `ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md` - Core pattern learning
3. `ψ/memory/learnings/2025-12-17_10-agent-swarm-pattern.md` - Concrete swarm example
4. `ψ/memory/retrospectives/2025-12/17/00.30_maw-conflict-prevention-system.md` - Real MAW session

---

## PostToolUse Observations Captured

Throughout this 13-minute conversation, PostToolUse hooks fired after each tool call:
- Read operations (4 files)
- Grep searches (2 searches)
- Bash commands (4 activity/focus updates)

Each observation contains:
- Semantic concepts: `multi-agent`, `delegation`, `trust-but-verify`, `cognitive-stack`, `haiku-vs-opus`
- Concrete examples: MAW session costs, 10-agent swarm metrics
- Decision frameworks: High vs low trust criteria
- Boundary definitions: What Haiku can/cannot do

These observations create **pattern triangulation** with Iteration 1, reinforcing core concepts through different angles.

---

## What Makes This Different from Iteration 1

**Iteration 1** (12:00-12:42, 42 min):
- Breadth: All four philosophy layers synthesized
- Synthesis across Oracle, Safety, Delegation, ψ/ structure
- Created blog post draft

**Iteration 2** (13:03-13:06, 13 min):
- Depth: ONE concept (Subagent Delegation) explored thoroughly
- Multiple concrete examples from real sessions
- Focus on decision frameworks and boundaries
- Shorter but more focused

---

## Success Criteria Met

- [x] Picked ONE topic (Subagent Delegation/maw)
- [x] Deep conversational exploration (not bulk extraction)
- [x] Multiple concrete examples (10-agent swarm, MAW session)
- [x] PostToolUse hooks captured rich semantic context
- [x] Clear decision frameworks established

---

## Next Steps (Iteration 3?)

**Remaining topics from WIP.md:**
1. ~~Subagent Delegation~~ ✓ (completed)
2. **Oracle Principles** - Nothing is Deleted, Patterns Over Intentions, External Brain
3. **Safety Rules** - Git workflow, force flags, PR patterns
4. **ψ/ Structure** - 5+2 pillars, knowledge flow, file placement

**Approach options:**
- Continue with another topic (15-20 min each)
- Take a break and come back later
- Try different exploration style
- Validate that claude-mem captured everything

---

**Status**: Complete, ready for next iteration or new direction
