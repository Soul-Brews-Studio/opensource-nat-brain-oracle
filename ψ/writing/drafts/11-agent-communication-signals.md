# Agent Communication: Signals, Tokens, and Efficient Handoffs

**Created**: 2025-12-17 00:13 GMT+7
**Status**: 📝 Draft
**Type**: Technical Pattern Guide
**Author**: Human + AI collaboration

---

## 📚 Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Git History | weyermann ec94c07 (2025-12-07) | File signal breakthrough (~100ms) |
| Learning | ψ/memory/learnings/001-delegate-reading.md | Delegate reading, never >100 lines in main |
| Learning | ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md | แจกงาน + ตอบสั้น + ตรวจ pattern |
| Learning | ψ/memory/learnings/006-parallel-agent-critique-pattern-2025-12-16.md | Parallel Haiku agents ($0.30 for 10 agents) |
| Documentation | weyermann INBOX-DESIGN-V1.md | Atomic message passing with state dirs |
| Current Session | MAW trace + signal discovery | Real-time agent coordination |

---

## 🎯 TL;DR

**Agent communication isn't just about sending messages—it's about sending the RIGHT amount of information at the RIGHT speed while saving tokens.** Three breakthroughs: (1) File signals reduce latency from 10s to 100ms, (2) "Summary + verify command" responses save 90% of tokens, (3) Main-agent-writes pattern maintains quality while delegating bulk work.

**Cost impact**: $0.30 for 10 parallel Haiku agents vs $4.50 for Opus doing same work = **15x cost reduction**

**Speed impact**: 100ms signal detection vs 10s blind waiting = **100x faster coordination**

---

## 🔥 The Problem

### Problem 1: Waiting Burns Tokens

Traditional approach:
```bash
# Send task to agent
maw hey 2 "Analyze codebase"

# Wait blindly
sleep 10  # Maybe done? Maybe not?

# Capture output
tmux capture-pane -t session:0.2 -p
```

**What's wrong**:
- 10 seconds might be too short (miss output)
- 10 seconds might be too long (waste time)
- No way to know when agent finishes
- Main agent idle = opportunity cost

### Problem 2: Reading Everything Burns Context

Traditional approach:
```bash
# Main agent reads 348-line file
Read(context/workshop-requests.md)  # 500 tokens → Opus context
```

**What's wrong**:
- Main agent (Opus) = 15x more expensive than Haiku
- 348 lines = ~500 tokens wasted if you only need 2 lines
- Context fills up faster = session ends sooner

### Problem 3: Verbose Responses Waste Tokens

Traditional subagent response:
```
✅ Updated 11 files successfully:

1. File plugins/foo/README.md:
   - Changed line 5 from "old text" to "new text"
   - Added section "Installation" with 10 lines
   - Updated version number in line 3

2. File plugins/foo/package.json:
   - Changed version from 1.0.0 to 1.1.0
   - Added dependency "lodash": "^4.17.21"

... (300 more lines of details)
```

**What's wrong**:
- Main agent doesn't need every detail
- 300 lines = ~400 tokens
- If main trusts the work, all those tokens are wasted

---

## 🛤️ The Journey

### Discovery 1: File Signals (Dec 7, 2025 - Weyermann)

**The "Aha Moment"**: Testing Codex communication in weyermann project.

**Problem**: Sending task to Codex agent, waiting 10-20 seconds blindly.

**First attempt**: Fixed sleep
```bash
maw hey 2 "analyze this"
sleep 10
tmux capture-pane...
```
**Result**: Sometimes too short, sometimes too long. Unreliable.

**Second attempt**: Polling every 2 seconds
```bash
for i in {1..10}; do
  OUTPUT=$(tmux capture-pane...)
  if echo "$OUTPUT" | grep -q "analysis complete"; then
    break
  fi
  sleep 2
done
```
**Result**: Better, but 2-20 second latency still slow.

**Breakthrough**: File signals (commit ec94c07)
```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
SIGNAL="$REPO_ROOT/.sync/codex-signal-$$"
maw hey 2 "analyze. When done: touch $SIGNAL"

for i in {1..100}; do
  if [ -f "$SIGNAL" ]; then
    # Detected in ~100ms!
    break
  fi
  sleep 0.1
done
```

**Result**: ~100ms latency. **100x improvement**. Proven working.

**Why it works**:
- File creation = atomic operation on POSIX
- 100ms polling = fast enough, CPU-efficient enough
- Process ID (`$$`) = unique signal per task (no collisions)

### Discovery 2: Summary + Verify Pattern (Dec 13, 2025 - Nat's Agents)

**The problem**: Main agent editing 36 files sequentially = context overflow.

**First attempt**: Main does everything
```
Main: Read file 1 → Edit → Read file 2 → Edit → ... (36x)
Result: 70+ operations, context full at 90%
```

**Second attempt**: Subagent does everything, returns full details
```
Subagent: Edit 36 files, write 500-line report
Main: Read report (500 tokens), trust blindly
Result: Saved operations but lost verification ability
```

**Breakthrough**: "ตอบสั้น + verify command"
```
Subagent response:
✅ Done: 11/11 files

Verify: git diff --stat
Expected: 11 files changed, 23 insertions(+)

Main agent:
1. Read summary (50 tokens, not 500)
2. Run verify command (instant)
3. Trust if match, investigate if mismatch
```

**Result**: 90% token savings + verification capability maintained.

### Discovery 3: Delegate Reading (Dec 9, 2025)

**The mistake**: Context-finder found answer in 348-line file. Main agent read entire file.

**Lesson**:
```
IF file > 100 lines
THEN Task(context-finder, "Extract section X")
NEVER Read() directly in main
```

**Why**:
- Context-finder (Haiku) = cheap
- Main agent (Opus) = 15x more expensive
- Reading 348 lines in Haiku = $0.003
- Reading 348 lines in Opus = $0.045
- **Savings: 93%**

---

## ✅ The Solution

### Pattern 1: File Signal for Fast Coordination

**Use when**: Sending tasks to agents, need to know when done

**Implementation**:
```bash
# 0. Get main repo root (shared by all agents)
REPO_ROOT=$(git rev-parse --show-toplevel)
SYNC_DIR="$REPO_ROOT/.sync"

# 1. Create unique signal path in SHARED location
SIGNAL="$SYNC_DIR/agent-signal-$$"
rm -f "$SIGNAL"

# 2. Send task with signal instruction (use absolute path!)
source .envrc && maw hey 1 "Task description. When done: touch $SIGNAL"

# 3. Poll at 100ms intervals (max 10 seconds)
for i in {1..100}; do
  if [ -f "$SIGNAL" ]; then
    # Task complete! Capture output
    OUTPUT=$(tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -30)
    rm -f "$SIGNAL"
    echo "$OUTPUT"
    exit 0
  fi
  sleep 0.1
done

# 4. Timeout after 10 seconds
echo "⚠️ Task timeout (no signal after 10s)"
```

**Key details**:
- Use `$REPO_ROOT/.sync/` = SHARED across all agent worktrees
- Use `$$` for unique PID (prevents collisions)
- 100ms polling = sweet spot (fast + efficient)
- Always `rm -f` after detecting (cleanup)
- Set timeout (100 iterations = 10 seconds max)

### Pattern 2: Summary + Verify Response

**Use when**: Subagent does bulk work (edit 5+ files, search multiple sources)

**Subagent response format**:
```markdown
✅ Done: 11/11 tasks completed

| Item | Status |
|------|--------|
| Update README.md | ✅ |
| Add package.json | ✅ |
| Create tests/ | ✅ |
| ... | ✅ |

Verify: git status --short
Expected output:
 M README.md
 M package.json
?? tests/

Verify: git diff --stat
Expected: 11 files changed, 47 insertions(+), 3 deletions(-)
```

**Main agent workflow**:
```bash
# 1. Read summary (50 tokens, not 500)
# 2. Run verify commands
git status --short
git diff --stat

# 3. Compare with expected
# If match → Trust, move on
# If mismatch → Read specific files for investigation
```

**Token comparison**:
- Verbose response: 500 tokens
- Summary + verify: 50 tokens + verification (instant)
- **Savings: 90%**

### Pattern 3: Delegate Reading to Haiku

**Use when**: Need info from files >100 lines

**Anti-pattern**:
```bash
# ❌ Main agent reads directly
Read(ψ/memory/retrospectives/long-file.md)  # 348 lines → 500 tokens in Opus
```

**Correct pattern**:
```bash
# ✅ Delegate to context-finder
Task(context-finder, "Extract section about X from long-file.md")
# Haiku reads (cheap), returns summary (50 tokens to Opus)
```

**When to use**:

| File Type | Size | Action |
|-----------|------|--------|
| context/ | Any | ALWAYS delegate |
| retrospectives/ | Any | ALWAYS delegate |
| learnings/ | >100 lines | Delegate |
| code files | >100 lines | Delegate |
| Small files | <100 lines | Main can read |

**Cost comparison** (348-line file):
- Main reads: $0.045 (Opus input)
- Context-finder: $0.003 (Haiku input) + $0.002 (summary to Opus)
- **Savings: 89%**

### Pattern 4: Parallel Subagents for Validation

**Use when**: Need multiple perspectives, want comprehensive review

**Example** (from session 2025-12-16):
```bash
# Launch 10 Haiku agents in parallel
for perspective in NewDev Architect DocExpert PM Security UX Systems Ethics DevOps Cost; do
  Task(general-purpose, "Review ARCHITECTURE.md from $perspective viewpoint")
done

# Wait for all to complete
# Main agent synthesizes 10 reports
```

**Cost**:
- 10 Haiku agents in parallel: $0.30
- 1 Opus agent sequential: $4.50
- **Savings: 93%**

**Time**:
- Parallel: ~10 minutes
- Sequential: ~60 minutes
- **Savings: 83%**

---

## 🧠 The Pattern

### Core Principle: Division of Labor

```
Main Agent (Opus)           Subagents (Haiku)
─────────────────           ─────────────────
• Strategy                  • Data gathering
• Synthesis                 • Bulk operations
• Writing                   • File searching
• Quality decisions         • Git operations
• Review & approve          • Status checks
```

**Never**:
- ❌ Main reads >100-line files
- ❌ Main does repetitive work
- ❌ Subagent writes final content
- ❌ Blind waiting without signals

**Always**:
- ✅ Delegate reading to Haiku
- ✅ Summary + verify responses
- ✅ File signals for coordination
- ✅ Main writes, subagents gather

### Response Length Decision Tree

```
Is this a bulk operation (5+ items)?
├─ Yes → Summary + verify format
│         (✅ Done: N/N + verify command)
│
└─ No → Is there an error/blocker?
    ├─ Yes → Full details needed
    │         (Error message + context + suggestion)
    │
    └─ No → Is output <10 lines?
        ├─ Yes → Show output directly
        └─ No → Summary + sample
                  (First 5 lines + "... 45 more lines")
```

### Signal File Decision Tree

```
Do you need to know when agent finishes?
├─ Yes → Use file signal ($REPO_ROOT/.sync/signal-$$)
│         Poll at 100ms, timeout at 10s
│
└─ No → Is this fire-and-forget?
    ├─ Yes → Just send task, check later
    │         (git status, maw hey without waiting)
    │
    └─ No → Do you need immediate response?
        └─ Yes → Use signal + capture pattern
```

### Token Budget Decision

```
Before reading ANY file >50 lines:

File in context/, retrospectives/, learnings/?
├─ Yes → ALWAYS delegate to context-finder
│
└─ No → File >100 lines?
    ├─ Yes → Delegate to context-finder
    │
    └─ No → Do you need the WHOLE file?
        ├─ Yes → Safe to Read() directly
        └─ No → Ask context-finder for specific section
```

---

## 📊 Cost & Speed Comparison

### File Signal Pattern

| Method | Latency | CPU Usage | Reliability |
|--------|---------|-----------|-------------|
| Fixed sleep 10s | 10,000ms | None | Often too short/long |
| Poll 2s intervals | 2,000-20,000ms | Low | Better but slow |
| **File signal 100ms** | **~100ms** | **Low** | **Fast + reliable** |

**Winner**: File signal = 100x faster than fixed sleep

### Token-Saving Patterns

| Operation | Opus Cost | Haiku Cost | Savings |
|-----------|-----------|------------|---------|
| Read 348-line file | $0.045 | $0.003 | 93% |
| 10 parallel reviews | $4.50 | $0.30 | 93% |
| Verbose response (500 lines) | $0.065 | $0.007 | 89% |
| **Summary + verify (50 lines)** | **$0.007** | **$0.001** | **86% better** |

**Average savings**: ~90% by delegating to Haiku + short responses

### Time Comparison

| Task | Sequential | Parallel | Savings |
|------|------------|----------|---------|
| 10 agent reviews | 60 min | 10 min | 83% |
| 5-agent search | 25 min | 5 min | 80% |
| Smart sync 5 agents | 50s | 10s | 80% |

**Pattern**: Parallel execution = ~80-85% time savings

---

## 🔧 Implementation Guide

### Step 1: Set Up Signal Infrastructure

```bash
# In your .envrc or shell profile
signal_wait() {
  local signal_file="$1"
  local timeout="${2:-100}"  # Default 10s (100 * 0.1s)

  for i in $(seq 1 $timeout); do
    if [ -f "$signal_file" ]; then
      rm -f "$signal_file"
      return 0
    fi
    sleep 0.1
  done

  return 1  # Timeout
}
```

**Usage**:
```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
SIGNAL="$REPO_ROOT/.sync/task-$$"
maw hey 1 "task. When done: touch $SIGNAL"

if signal_wait "$SIGNAL" 100; then
  echo "✅ Task complete"
  tmux capture-pane -t ai-Nat-s-Agents:0.1 -p -S -30
else
  echo "⚠️ Task timeout"
fi
```

### Step 2: Train Subagents on Response Format

**Add to subagent instructions**:
```markdown
## Response Format

For bulk operations (5+ items), use:

✅ Done: N/N items

Verify: [command that main can run]
Expected: [what output should show]

For errors, include:
- ❌ Error description
- Relevant file/line
- Suggested fix
```

### Step 3: Create Delegation Checklist

**Before reading ANY file in main agent**:
```
[ ] Is file >100 lines? → Delegate
[ ] Is file in context/? → Delegate
[ ] Is file in retrospectives/? → Delegate
[ ] Do I need the WHOLE file? → If no, delegate extraction
```

**Before assigning task**:
```
[ ] Is this 5+ items? → Use subagent
[ ] Is this bulk search? → Use subagent
[ ] Is this repetitive? → Use subagent
[ ] Do I need immediate completion notification? → Use signal
```

---

## 📖 Real-World Examples

### Example 1: MAW Agent Coordination (This Session)

**Task**: Start MAW, verify agents auto-started, check identity

**With signals**:
```bash
# Start MAW
maw start profile14

# Send identity check to all agents (use SHARED .sync in main repo!)
REPO_ROOT=$(git rev-parse --show-toplevel)
SIGNAL="$REPO_ROOT/.sync/identity-check-$$"
maw hey all "pwd && git branch --show-current; touch $SIGNAL"

# Wait for signal (100ms detection)
signal_wait "$SIGNAL" 100

# Capture all responses immediately
for pane in 0.1 0.2 0.3 1.1 1.2; do
  tmux capture-pane -t ai-Nat-s-Agents:$pane -p | tail -5
done
```

**Time**: ~500ms total (5 agents in parallel)
**Without signals**: 10-50 seconds (blind waiting + polling)

### Example 2: Architecture Review (Dec 16, 2025)

**Task**: Get 10 different perspectives on ARCHITECTURE.md

**Implementation**:
```bash
# Launch 10 Haiku agents in parallel (single message)
Task(NewDev, "Review from new developer perspective")
Task(Architect, "Review architecture decisions")
Task(DocExpert, "Review documentation quality")
# ... 7 more agents

# Each agent returns summary + score:
✅ Score: 7.5/10
Key issues: 3
Verify: grep "Cost" ARCHITECTURE.md | wc -l
Expected: 0 (no cost section found)
```

**Cost**: $0.30 for 10 comprehensive reviews
**Time**: 10 minutes (parallel)
**Quality**: 10 perspectives revealed blind spots

### Example 3: Bulk File Updates (Dec 13, 2025)

**Task**: Update 11 plugin files with new pattern

**Wrong way**:
```bash
# Main agent sequential
for file in plugins/*/CLAUDE.md; do
  Read($file)      # 11 * 200 lines = 2200 lines read
  Edit($file)
done
# Result: Context 90% full, slow
```

**Right way**:
```bash
# Delegate to coder subagent
Task(coder, "Update 11 plugin CLAUDE.md files with pattern X")

# Subagent response:
✅ Done: 11/11 files

Verify: git diff --stat
Expected: 11 files changed

# Main runs verify (instant), moves on
```

**Token savings**: ~1800 tokens (90%)
**Time savings**: 10 minutes → 2 minutes

---

## 🏷️ Tags

`agent-communication` `file-signals` `token-optimization` `maw` `multi-agent` `haiku-opus` `delegation` `performance` `cost-optimization`

---

## 📝 Writing Notes

### Tone
- **Technical but practical** — Real code examples, not theory
- **Cost-conscious** — Show actual $ savings
- **Pattern-focused** — Reusable across projects

### Target Audience
- **Developers using Claude Code with subagents**
- **Teams optimizing AI costs**
- **Anyone coordinating multiple AI agents**

### Suggested Title Alternatives
1. "100ms Agent Coordination: File Signals + Token-Efficient Responses"
2. "Save 90% on AI Costs: Agent Communication Patterns That Work"
3. "From 10 Seconds to 100ms: Fast Agent Coordination with File Signals"
4. "Summary + Verify: How to Save Tokens While Maintaining Quality"

### Next Steps
- [ ] Add diagram of signal file flow
- [ ] Add cost calculator tool
- [ ] Create reference card (printable)
- [ ] Record demo video of signal pattern
- [ ] Benchmark latency in different environments

---

*Draft generated from MAW exploration + weyermann signal discovery*
*Ready for immediate use*
*Total savings: 90% tokens, 100x faster coordination, 15x cost reduction*
