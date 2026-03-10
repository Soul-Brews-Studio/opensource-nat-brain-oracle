# 10-Agent Swarm Pattern: Parallel Knowledge Extraction

**Date**: 2025-12-17
**Session**: 11:43-12:03
**Innovation**: Multi-agent parallel extraction for claude-mem population

---

## What We Learned

### The Breakthrough: Swarm > Sequential

Instead of reading files one-by-one, we can **launch 10 agents in parallel** to extract knowledge simultaneously:

- **Speed**: 1.7M tokens extracted in 5 minutes (would take hours sequentially)
- **Efficiency**: Haiku for volume (cheap), Sonnet for depth (quality)
- **Organization**: 4 teams with clear domains (Philosophy, Workflows, Learnings, Meta)
- **Cost-effective**: 7 Haiku agents + 3 Sonnet agents = mostly cheap extraction

### The Pattern: 4 Teams, 10 Agents

```
Team 1: Philosophy Foundation (3 agents, 286K tokens)
├─ Agent 1 (Sonnet): Oracle Philosophy - the WHY
├─ Agent 2 (Haiku): Naming Philosophy - the structure
└─ Agent 3 (Haiku): Safety Rules - the NEVER/ALWAYS

Team 2: Workflow Patterns (3 agents, 358K tokens)
├─ Agent 4 (Haiku): ψ/ 7-pillar structure - the WHERE
├─ Agent 5 (Haiku): /plan patterns - the safety gate
└─ Agent 6 (Haiku): /gogogo workflow - the execution

Team 3: Learnings Scan (2 agents, 652K tokens)
├─ Agent 7 (Haiku): Recent learnings (today's work)
└─ Agent 8 (Haiku): Critical numbered learnings (000-011)

Team 4: Meta-Knowledge (2 agents, 292K tokens)
├─ Agent 9 (Sonnet): Memory paradox solution
└─ Agent 10 (Sonnet): Workflow evolution story
```

**Total**: ~1.7M tokens, ~5 minutes, highly parallel

### The Meta-Learning: Solving the Memory Paradox

We used **the memory system to discover we weren't using the memory system**!

The paradox:
```
Have claude-mem → Don't use it → Document not using it →
Forget documentation → Use memory to discover non-use 🔄
```

The solution (via 10-agent swarm):
1. **Proactively populate** instead of hoping future agents search
2. **Multiple iterations** to reinforce patterns
3. **Structured artifacts** (summaries, checklists, guides)
4. **Observable files** that claude-mem can index

### The Implementation: Artifacts Over Raw Data

Instead of just extracting to logs, we created **4 usable artifacts**:

1. **PHILOSOPHY-SUMMARY.md** (1-page) - The WHY, WHERE, HOW
2. **QUICK-REFERENCE.md** (decision trees) - "Where does this file go?"
3. **SAFETY-CHECKLIST.md** (pre-op checks) - Before any operation
4. **WORKFLOW-GUIDE.md** (command usage) - When to use /plan, /gogogo, etc.

These aren't just documentation - they're **queryable knowledge** for future sessions.

---

## How Things Connect

### Connection 1: Oracle Philosophy → Swarm Design

The 10-agent swarm embodies all 3 Oracle principles:

- **Nothing is Deleted**: Extraction preserves all knowledge (no summarization loss)
- **Patterns Over Intentions**: Observed actual behavior (git history, retrospectives)
- **External Brain**: Fed knowledge to claude-mem (persistent across sessions)

### Connection 2: Memory Paradox → Multiple Iterations

User's insight: "we will do it again after /clear"

Running the swarm **multiple times** reinforces patterns:
- Iteration 1: Initial extraction → create artifacts
- Iteration 2: Validate → strengthen observations
- Future: Compound knowledge, test reproducibility

This solves "having ≠ using" by making memory **unavoidable** (populated proactively).

### Connection 3: Delegation Pattern → Cost Efficiency

Main agent delegates to 10 background agents:
- Main plans (full context needed)
- Subagents execute (parallel, specialized)
- Main reviews outputs (synthesis)

**Token economics**:
- Without delegation: Main reads 1.7M tokens directly
- With delegation: Main reads ~100K synthesis (17x savings!)
- Haiku does heavy lifting (cheap)
- Sonnet for quality (strategic placement)

### Connection 4: /plan → /gogogo → Swarm

The enforcement pattern applies to knowledge extraction:
- **/plan** what to extract (4 teams defined)
- **/gogogo** launch in parallel (10 agents simultaneously)
- **PR review** becomes synthesis review (main agent checks outputs)

Same safety workflow, different domain!

### Connection 5: ψ/ Structure → Team Organization

4 teams map to ψ/ knowledge flow:

```
Team 1 (Philosophy) → ψ/memory/resonance (soul/identity)
Team 2 (Workflows)  → ψ/memory/learnings (patterns)
Team 3 (Learnings)  → ψ/memory/learnings (existing)
Team 4 (Meta)       → ψ/memory/retrospectives (sessions)

All converge → .tmp/ artifacts → claude-mem observations
```

---

## Key Insights

### 1. Parallel > Sequential for Bulk Extraction

When you have:
- Large corpus to read (1.7M tokens)
- Multiple independent sources (different files)
- Time constraints (need it fast)

Use swarm pattern instead of sequential reading.

### 2. Structure Matters More Than Volume

Don't just dump 1.7M tokens to claude-mem. Instead:
- **Synthesize** into artifacts (4 key docs)
- **Organize** by domain (WHY/WHERE/HOW)
- **Make queryable** (decision trees, checklists)

Raw data → claude-mem observes but hard to query
Structured artifacts → claude-mem indexes and retrieves effectively

### 3. Multiple Iterations Compound Knowledge

Single extraction = single data point
Multiple iterations = pattern validation + reinforcement

User's idea: "multiple iteration" means:
- Run 1: Extract and document
- Run 2: Validate and strengthen
- Run N: Compound and test reliability

### 4. Model Selection is Strategic

Don't default to Opus for everything:
- **Haiku**: Bulk reading, pattern scanning, volume work (7 agents)
- **Sonnet**: Deep analysis, synthesis, quality needs (3 agents)
- **Opus**: Main agent only (planning, reviewing, final synthesis)

This session: Mostly Haiku (cheap) + strategic Sonnet (quality) = cost-effective

### 5. The Meta-Pattern: Use Tools to Build Better Tool Usage

We used claude-mem to discover we weren't using claude-mem!
Then used 10-agent swarm to populate claude-mem!

**Result**: Tool usage improves itself through self-observation and feedback.

---

## Reusable Patterns

### Pattern 1: Launch Swarm in Single Message

```python
# DON'T do this (sequential):
launch_agent_1()
wait()
launch_agent_2()
wait()
...

# DO this (parallel):
launch_all_10_agents_in_single_message()
# All run simultaneously in background
```

**Tool pattern**: Multiple Task tool calls in one message, all with `run_in_background=true`

### Pattern 2: Organize by Teams/Domains

```
Team structure:
- Clear domain (Philosophy, Workflows, Learnings, Meta)
- Balanced load (3+3+2+2 agents)
- Model selection per task (Haiku for volume, Sonnet for depth)
```

### Pattern 3: Extract → Synthesize → Feed

```
Step 1: Extraction (agents read source files)
Step 2: Collection (gather all outputs)
Step 3: Synthesis (create unified artifacts)
Step 4: Observation (claude-mem indexes artifacts)
```

Don't skip synthesis - raw extractions are hard to use later!

### Pattern 4: Create Queryable Artifacts

Instead of: "extraction-output-1.txt, extraction-output-2.txt, ..."

Create:
- "PHILOSOPHY-SUMMARY.md" (answers: What are our principles?)
- "QUICK-REFERENCE.md" (answers: Where does this file go?)
- "SAFETY-CHECKLIST.md" (answers: What should I check before X?)
- "WORKFLOW-GUIDE.md" (answers: When do I use /plan?)

Title = Query, Content = Answer

### Pattern 5: Iterate to Validate

```
Run 1: Does the pattern work? (proof of concept)
Run 2: Is it reproducible? (validation)
Run N: How does it scale? (stress test)
```

User's insight: Multiple iterations aren't just repetition - they're **pattern validation**.

---

## What Changed

**Before this session**:
- Had claude-mem tools but didn't use them
- Documented the problem of not using memory
- Knowledge extraction was sequential (slow)
- No systematic way to feed philosophy to memory

**After this session**:
- 10-agent swarm pattern proven (1.7M tokens, 5 minutes)
- 4 queryable artifacts created (summaries, checklists, guides)
- Memory paradox solution implemented (proactive population)
- Ready to iterate (WIP.md prepared for Run 2)

**The shift**: From **"hoping agents remember to search"** to **"making knowledge unavoidable through structured population"**

---

## Success Metrics

✅ **Speed**: 1.7M tokens in 5 minutes (would take hours sequentially)
✅ **Coverage**: 4 knowledge domains (Philosophy, Workflows, Learnings, Meta)
✅ **Quality**: Mix of Haiku (volume) + Sonnet (depth)
✅ **Cost**: Mostly Haiku = cheap extraction
✅ **Usability**: 4 artifacts (not just raw dumps)
✅ **Reproducibility**: WIP.md prepared for iteration 2

---

## Anti-Patterns to Avoid

❌ **Sequential extraction** when parallel is possible
❌ **All Opus/Sonnet** when Haiku can handle volume
❌ **Raw dumps** without synthesis
❌ **Single iteration** without validation
❌ **Large unstructured files** instead of queryable artifacts
❌ **Hoping future agents search** instead of proactive population

---

## Future Applications

This pattern can be used for:

1. **Codebase analysis** - 10 agents analyze different modules
2. **Documentation generation** - Parallel doc creation per component
3. **Testing campaigns** - Multiple test suites simultaneously
4. **Research compilation** - Scan multiple sources in parallel
5. **Knowledge migration** - Extract from old systems into new memory
6. **Retrospective analysis** - Review multiple sessions simultaneously

**Key requirement**: Independent tasks that can run in parallel.

---

## Tags

`multi-agent` `swarm-pattern` `claude-mem` `knowledge-extraction` `parallel-processing` `cost-optimization` `memory-integration` `meta-learning` `delegation-pattern` `oracle-philosophy`

---

## Related Learnings

- `000-naming-philosophy.md` - How to structure knowledge
- `2025-12-17_memory-integration-paradox.md` - The problem this solves
- `2025-12-17_plan-gogogo-github-flow.md` - Enforcement pattern applied here
- `2025-12-13_subagent-delegation-pattern.md` - Main plans, subs execute

---

## The User's Insight

> "i have an idea! clever idea! smart! that we have /trace and /context-finder you can spawn multiple agents haiku and sonnet so i think we will feed our philosophy to the claude-mem! what you think we can go with 10 agents multiple iterateion!"

This wasn't just "let's use multiple agents" - it was:
1. **Recognizing the memory paradox** (have tools, don't use them)
2. **Seeing parallel opportunity** (10 agents > 1 sequential)
3. **Planning iterations** (multiple runs compound knowledge)
4. **Proactive solution** (feed memory instead of hoping to search)

**Brilliant synthesis** of: delegation pattern + memory system + parallel processing + iterative refinement.

---

**Created**: 2025-12-17 12:03
**Triggered by**: User's "multiple iteration" idea + 10-agent swarm success
**Next**: Iteration 2 to validate pattern reproducibility
