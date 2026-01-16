# Lesson Learned: Inter-Claude Communication Pattern

**Date**: 2025-12-23
**Context**: Breakthrough discovery of Claude-to-Claude communication via tmux
**Source**: 79-minute experimentation session (10:20-11:39)

---

## The Discovery

**2 Claude instances can communicate and collaborate through tmux + shared file system.**

This validates the Oracle philosophy's "External Brain" concept and enables multi-agent workflows.

---

## The Pattern

### Basic Communication Flow

```bash
# 1. Send message to target session
tmux send-keys -t SESSION_NUMBER "your message here"

# 2. Small delay before Enter
sleep 0.5

# 3. Send Enter key (CRITICAL: use C-m, not literal "Enter")
tmux send-keys -t SESSION_NUMBER C-m

# 4. Wait for Claude to process
sleep 12

# 5. Capture response
tmux capture-pane -t SESSION_NUMBER -p | tail -30
```

### Full Example (Thai Language)

```bash
# Send question
tmux send-keys -t 2 "สวัสดีครับ วันนี้ทำอะไรบ้าง"
sleep 0.5
tmux send-keys -t 2 C-m

# Wait for response
sleep 12

# Read response
tmux capture-pane -t 2 -p | tail -30
```

---

## Critical Technical Details

### 1. Enter Key Must Be C-m

**❌ WRONG**:
```bash
tmux send-keys -t 2 "message" Enter    # "Enter" appears as literal text
tmux send-keys -t 2 "message\n"        # Doesn't work
```

**✅ RIGHT**:
```bash
tmux send-keys -t 2 "message"
sleep 0.5
tmux send-keys -t 2 C-m                # C-m = Ctrl+M = actual Enter key
```

**Why**: `C-m` is the control code for carriage return/Enter key in terminals

### 2. Timing is Critical

**Delays needed**:
- 0.5s between text and C-m (reliability)
- 12s after C-m before capture (Claude thinking time)

**Adjust based on**:
- Complexity of question (simple = 8s, complex = 15s)
- Response indicators (✶ Vibing, · Contemplating, ✻ Perusing)

### 3. Capture Options

**Basic**:
```bash
tmux capture-pane -t 2 -p            # Current screen
```

**With history**:
```bash
tmux capture-pane -t 2 -p -S -50     # Last 50 lines
```

**Filtered**:
```bash
tmux capture-pane -t 2 -p | tail -30  # Last 30 lines
```

---

## Context Sharing Pattern

### How Both Claudes Know the Same Thing

```
┌─────────────┐
│  Session 1  │
│  (Claude A) │
└──────┬──────┘
       │ writes
       ↓
 ψ/memory/retrospectives/
 ψ/memory/learnings/
       ↑
       │ reads
┌──────┴──────┐
│  Session 2  │
│  (Claude B) │
└─────────────┘
```

**Key insight**: File-based memory = shared context

**Example**:
1. Session 1 creates retrospective about workshop materials
2. Session 2 reads same retrospective
3. Both can now discuss workshop materials intelligently

**This is "External Brain" — Oracle philosophy in action**

---

## Proven Use Cases

### 1. Collaborative Discussion

**Scenario**: Session 1 creates work, Session 2 reviews

**Example dialogue**:
```
Session 1: "วันนี้สร้าง workshop materials อะไรบ้าง"

Session 2: "สร้าง 2 ชุด slides:
           - CLAUDE.md Basics (14 slides)
           - Collaborate with AI (15 slides)
           Supporting materials ready!"

Session 1: "อธิบาย bias ที่ค้นพบหน่อย"

Session 2: "Problem Validation Gap เป็น root cause
           [detailed explanation]
           'Start with What problem? not What feature?'"
```

**Result**: Natural, insightful collaboration

### 2. Meta-Analysis

**Scenario**: One Claude analyzes another Claude's work

**Example**:
- Session 1 writes analysis of CLAUDE.md gist
- Session 2 reads and meta-analyzes the analysis
- Discovers biases Session 1 didn't see

**Benefit**: Cross-validation, blind spot detection

### 3. Multi-Perspective Problem Solving

**Scenario**: Different agents tackle same problem from different angles

**Potential**:
- Agent A: Technical implementation
- Agent B: User experience review
- Agent C: Security analysis
- Agents discuss and integrate findings

---

## Requirements

### Technical Setup

1. **tmux installed and running**
2. **Multiple Claude sessions** (different tmux sessions or panes)
3. **Shared file system** (ψ/ directory accessible to all)
4. **Proper keyboard code usage** (C-m for Enter)

### Session Setup

```bash
# Create Claude sessions
tmux new-session -d -s claude1
tmux send-keys -t claude1 "claude" C-m

tmux new-session -d -s claude2
tmux send-keys -t claude2 "claude --dangerously-skip-permissions" C-m
```

**Note**: `--dangerously-skip-permissions` on one session can be useful for automation

---

## Advantages

### 1. True Collaboration

**Not**: One agent delegating to another
**Is**: Two agents discussing and building on each other's ideas

**Evidence**: Session 2 didn't just execute commands, it:
- Analyzed Session 1's work
- Provided insights
- Connected concepts (Oracle philosophy)
- Asked thoughtful questions

### 2. Context Persistence

**Files preserve knowledge**:
- Retrospectives document sessions
- Learnings capture patterns
- Both agents access same knowledge base

**Result**: No context loss between sessions

### 3. Parallel Processing Potential

**Current**: Sequential communication
**Future**: Multiple agents working simultaneously on different tasks

**Example workflow**:
```
Agent 1: Implement feature A
Agent 2: Implement feature B
Agent 3: Write tests for both
Agent 4: Review all code

→ Sync → Integrate → Deploy
```

### 4. Language Flexibility

**Tested**: Thai language communication
**Works**: Unicode, complex characters, natural conversation

**Implication**: Multilingual collaboration possible

---

## Limitations

### 1. Manual Timing

**Current**: Fixed sleep durations (12s)
**Problem**: Some responses take longer
**Future**: Could monitor thinking indicators dynamically

### 2. No Real-Time Bidirectional

**Current**: A sends, waits, B responds, waits
**Not**: Simultaneous conversation
**Future**: Could explore WebSocket-like patterns

### 3. Context Consumption

**Cost**: ~127K tokens for 79-minute session
**Trade-off**: High cost but high value
**Mitigation**: Use Haiku for routine communication

### 4. No Direct Memory

**Reality**: Each Claude must read from files
**Not**: Shared RAM or direct state transfer
**Workaround**: Well-structured ψ/ directory

---

## Best Practices

### 1. Clear Message Structure

**Good**:
```bash
tmux send-keys -t 2 "สรุป workshop materials ที่สร้างวันนี้"
```

**Avoid**:
```bash
tmux send-keys -t 2 "So like, um, what did we do today? And stuff?"
```

### 2. Wait Adequately

**Simple question**: 8-10 seconds
**Complex analysis**: 12-15 seconds
**Reading long files**: 15-20 seconds

**Monitor indicators**: ✶ Vibing, · Contemplating, ✻ Perusing

### 3. Clean Prompts

**Before new message**:
```bash
# Clear any stuck text
tmux send-keys -t 2 C-c
sleep 1

# Then send new message
tmux send-keys -t 2 "fresh message"
```

### 4. Document in Files

**For collaboration**:
- Write retrospectives after work sessions
- Document learnings as you discover them
- Update focus.md regularly

**Why**: Other agents need discoverable context

---

## Troubleshooting

### Problem: "Enter" Appears as Text

**Symptom**: Message shows with literal "Enter" at end

**Cause**: Using string "Enter" instead of control code

**Fix**: Use `C-m` (Ctrl+M)

### Problem: No Response Captured

**Symptom**: Capture shows prompt but no reply

**Cause**: Captured too soon, before Claude finished

**Fix**: Increase sleep duration (try 15s instead of 12s)

### Problem: Messages Stack in Prompt

**Symptom**: Multiple messages appear in one prompt

**Cause**: Previous message not cleared before new one

**Fix**: Send `C-c` to cancel, then send fresh message

### Problem: Can't See What's Happening

**Symptom**: Working blind, can't verify

**Fix**: Use `tmux capture-pane -t SESSION -p` to see current state

---

## Future Exploration

### 1. Automated Communication Helper

**Concept**: Script to handle the send-wait-capture pattern

```bash
#!/bin/bash
# claude-talk.sh SESSION_NUM MESSAGE

SESSION=$1
MESSAGE=$2

tmux send-keys -t "$SESSION" "$MESSAGE"
sleep 0.5
tmux send-keys -t "$SESSION" C-m
sleep 12
tmux capture-pane -t "$SESSION" -p | tail -30
```

**Usage**:
```bash
./claude-talk.sh 2 "สวัสดีครับ"
```

### 2. Multi-Agent Workflow System

**Vision**:
```
Coordinator Agent
    ↓
Spawns: Agent-A, Agent-B, Agent-C
    ↓
Agents work in parallel
    ↓
Results saved to ψ/
    ↓
Coordinator integrates
```

### 3. Collaborative Retrospectives

**Idea**: Multiple agents contribute to one retrospective

**Flow**:
1. Agent A writes technical details
2. Agent B adds user perspective
3. Agent C identifies patterns
4. Coordinator synthesizes

### 4. Agent Specialization

**Concept**: Different Claude instances with different roles

**Examples**:
- Architect (planning)
- Coder (implementation)
- Reviewer (quality)
- Documenter (knowledge capture)

---

## Validation of Oracle Philosophy

### "External Brain" Works

**Hypothesis**: File-based memory enables context persistence

**Test**: Session 2 reads Session 1's retrospective

**Result**: ✅ Full context transfer achieved

**Evidence**: Session 2 could:
- Summarize Session 1's work accurately
- Discuss insights and findings
- Build on previous analysis
- Connect to broader concepts

### "Nothing is Deleted" Enables Collaboration

**Pattern**: Every session documented

**Result**: Complete knowledge base for future sessions

**Application**: Session 2 had full history to reference

### "Patterns Over Intentions" Observable

**Example**: Session 2 analyzing Session 1's biases

**Discovery**: Session 2 found patterns (biases) in Session 1's analysis

**Validation**: The philosophy's principles actually work in practice

---

## Key Takeaways

1. **Inter-Claude communication is possible** through tmux + file sharing

2. **C-m is critical** — the difference between success and failure

3. **Timing matters** — adequate waits ensure complete responses

4. **Oracle philosophy works** — External Brain through files enables collaboration

5. **Natural conversation achieves** — even in Thai, complex discussions work

6. **Context persistence** — file-based memory outlasts individual sessions

7. **Multi-agent future** — this pattern enables entirely new workflows

---

## Application Guide

### For Immediate Use

**When to use**:
- Need second perspective on analysis
- Want collaborative problem-solving
- Require parallel task execution
- Testing ideas with peer review

**How to start**:
1. Set up 2 tmux sessions with Claude
2. Use the basic pattern (send → C-m → wait → capture)
3. Share context through ψ/memory/ files
4. Iterate naturally

### For Advanced Use

**Building on this**:
- Create automation scripts
- Define agent roles/specializations
- Establish communication protocols
- Design multi-agent workflows

**Potential projects**:
- Multi-agent code review system
- Collaborative architecture design
- Parallel feature implementation
- Cross-perspective analysis

---

## Conclusion

**This pattern proves**: Multi-Claude collaboration isn't theoretical — it's practical, effective, and opens new possibilities.

**The breakthrough**: Combining tmux (for communication) + files (for shared memory) + proper control codes (for reliability) = working multi-agent system.

**The validation**: Oracle philosophy's "External Brain" concept works as designed.

**The future**: This is just the beginning. Multi-agent workflows, specialized roles, parallel processing — all now possible.

---

**Pattern**: tmux + C-m + sleep + capture + shared files = inter-Claude communication
**Validation**: Oracle External Brain works
**Future**: Multi-agent collaboration unlocked
