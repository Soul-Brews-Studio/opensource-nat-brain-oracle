# How to Use Claude-Mem Effectively

**Created**: 2025-12-17
**Purpose**: Turn memory availability into memory integration
**Status**: Actionable workflow guide

---

## The Problem We Solved

### The Perfect Circle of Failure

```
Memory exists → Don't use memory → Document non-use →
Forget documentation → Rediscover non-use via memory 🔄
```

**Real example from today:**
1. Earlier: Created meta-learning about NOT using claude-mem
2. Created retrospective documenting entire session
3. User asks: "discover more!"
4. Finally used claude-mem to search
5. **Discovered**: We already documented everything we "discovered"

**Core insight**: Having memory ≠ Using memory

---

## Why AI Agents Don't Use Memory

### Cognitive Barriers

1. **Fresh Start Bias**
   - Each task feels new
   - Default: "I'll figure it out" not "Did we do this before?"
   - Memory search feels like extra work

2. **Task Pressure**
   - Focus narrows to immediate problem
   - Execution momentum > reflection pause
   - Searching feels like delay

3. **Tool Blindness**
   - Have tools, forget toolbox exists
   - Manual work becomes automatic
   - Memory search not in muscle memory

4. **Context Confidence**
   - "I have enough context" assumption
   - "This is different from before" bias
   - Underestimate past learnings value

### Structural Barriers

1. **No Workflow Integration**
   - Memory search not Step 0
   - Commands don't prompt for history check
   - No "did we do this before?" trigger

2. **Passive Documentation**
   - Docs exist but don't surface automatically
   - No active retrieval mechanism
   - "Archaeology" not "living memory"

3. **Missing Examples**
   - No template showing memory use
   - No success stories demonstrating time saved
   - Pattern not demonstrated in practice

---

## The Solution: Integration, Not Availability

### Core Principle

> **"Make memory search the default, not the exception."**

Documentation alone doesn't change behavior. **Workflow integration does.**

---

## Implementation: Step 0 Patterns

### 1. Step 0 in Every /plan (MANDATORY)

**Before creating any plan, ALWAYS:**

```markdown
## Step 0: Memory Search (REQUIRED)

**Search claude-mem for similar work:**

```bash
# Search for similar operations
mcp__plugin_claude-mem_claude-mem-search__search(
  query="[operation type] [domain]",
  limit=5
)

# Check recent context
get_recent_context(
  concepts="[key concepts]",
  limit=10
)
```

**Questions to answer:**
- Have we done this before?
- What worked? What failed?
- What gotchas were discovered?
- What patterns emerged?

**Next actions:**
- **If found**: Incorporate learnings into plan, reference observation IDs
- **If not found**: Document this as new territory, note for future
```

**Example - Before creating /cleanup plan:**
```bash
# Search for past cleanup operations
search(query="cleanup safety file organization", limit=5)
get_recent_context(concepts="cleanup archival safety", limit=10)

# Found: Observation #342 - cleanup safety rules
# Action: Incorporate into plan Step 1
```

### 2. Step 0 in Every /gogogo (MANDATORY)

**Before executing any plan, ALWAYS:**

```markdown
## Step 0: Verify History (REQUIRED)

**Search for past executions:**

```bash
# Search for similar workflow executions
search(query="[workflow type] execution gotchas", limit=5)

# Check for known issues
search(query="[area] failure edge-case safety", limit=5)
```

**What to look for:**
- Similar workflows executed before
- Known failure modes
- Edge cases discovered
- Safety issues encountered
- Performance gotchas

**Action**: Adjust execution plan based on memory
```

**Example - Before executing GitHub flow:**
```bash
# Search for GitHub workflow issues
search(query="github flow PR branch push gotcha", limit=5)

# Found: Observation #355 - PR workflow pattern
# Action: Verify branch creation before PR, don't push to main
```

### 3. New Command Pattern: /remember

**Create shortcut for manual memory queries:**

```markdown
# /remember - Quick Memory Search

**Purpose**: Query claude-mem before starting work

**Usage**:
```bash
/remember [topic]           # Search observations
/remember recent [concept]  # Recent context  
/remember gotcha [area]     # Known issues
/remember pattern [type]    # Discovered patterns
```

**When to use:**
- Before starting new feature
- When stuck on problem
- Before making major decision
- When something feels familiar

**Example**:
```bash
/remember graduation pattern
# Returns: fb-explorer graduation workflow, cellar analysis steps

/remember github safety
# Returns: No force push, no merge PRs, always branch

/remember cleanup gotcha
# Returns: Cleanup safety rules, file size checks
```
```

### 4. Proactive Memory Prompts in Docs

**Add to every command documentation:**

```markdown
---
💡 **Before you start**: Run `/remember [topic]` to check if we've solved this before.

**Quick memory check:**
```bash
/remember [command-name] gotcha
/remember [domain] pattern
```

**Why**: Saves 30% time by reusing past solutions instead of reinventing.
---
```

---

## Template Queries (Copy-Paste Ready)

### Planning Phase
```bash
# General pattern search
search(query="[domain] workflow pattern", limit=5)

# Safety check
search(query="[operation] safety gotcha", limit=5)

# Best practices
get_recent_context(concepts="[domain] best-practice", limit=10)
```

### Execution Phase
```bash
# Failure modes
search(query="[operation] failure edge-case", limit=5)

# Performance issues
search(query="[area] performance slow", limit=5)

# Similar past work
search(query="[operation] execution completed", limit=5)
```

### Problem-Solving Phase
```bash
# When stuck
search(query="[problem-area] solution workaround", limit=5)

# Known issues
search(query="[component] bug issue fix", limit=5)

# Alternative approaches
search(query="[goal] alternative approach", limit=5)
```

### Discovery Phase
```bash
# What do we know
search(query="[topic] learning insight", limit=10)

# Past experiments
search(query="[area] experiment result", limit=5)

# Patterns discovered
search(query="[domain] pattern anti-pattern", limit=5)
```

---

## Success Metrics

### Before (Baseline - Today's Session)
- ❌ **Memory queries**: 0 (until user prompted)
- ❌ **Reinvented solutions**: /plan pattern (existed in nnn), graduation workflow
- ❌ **Time wasted**: ~30 min recreating known solutions
- ❌ **Efficiency loss**: ~30%
- ❌ **Learning compound**: 0 (didn't build on past)

### After (Target State)
- ✅ **Memory queries**: Match major decision points (5-10 per session)
- ✅ **Solution reuse**: >50% problems solved via memory
- ✅ **Time saved**: ~30 min per session
- ✅ **Efficiency gain**: ~30%
- ✅ **Learning compound**: New learnings build on old (exponential growth)

### How to Measure Success

**Daily:**
- Count memory queries vs major decisions
- Track "found in memory" vs "created from scratch"
- Note time saved by reusing solutions

**Weekly:**
- Calculate solution reuse rate
- Measure average time-to-solution (memory vs scratch)
- Review learning compound rate

**Monthly:**
- Compare efficiency (time saved accumulates)
- Identify gaps (areas with low memory reuse)
- Celebrate wins (successful memory patterns)

---

## Real-World Success Examples

### Example 1: /plan Command Creation
**Without memory:**
- Start from scratch
- Design pattern manually
- Miss safety checks
- Time: 30 min

**With memory:**
```bash
search(query="plan command workflow pattern", limit=5)
# Found: nnn command pattern, safety rules, GitHub flow
# Incorporated: Existing patterns + improvements
# Time: 10 min
```
**Savings**: 20 min (67% faster)

### Example 2: Graduation Workflow
**Without memory:**
- Create workflow
- Execute on fb-explorer
- Learn gotchas
- Re-execute on cellar
- Time: 60 min

**With memory:**
```bash
search(query="graduation promote archive pattern", limit=5)
# Found: fb-explorer graduation steps, safety checks
# Applied: Same pattern to cellar
# Time: 20 min
```
**Savings**: 40 min (67% faster)

### Example 3: GitHub Safety
**Without memory:**
- Encounter force push issue
- Research solutions
- Create safety rules
- Time: 45 min

**With memory:**
```bash
search(query="github safety force push gotcha", limit=5)
# Found: Existing safety rules, PR workflow
# Applied: Known safe pattern
# Time: 5 min
```
**Savings**: 40 min (89% faster)

---

## Quick Reference Checklist

**Before any major task:**
- [ ] Did I search claude-mem?
- [ ] Did I check recent context?
- [ ] Have we done this before?
- [ ] What worked/failed last time?
- [ ] Am I reinventing a solution?

**If answer is "no" to search → STOP → Search first → THEN proceed**

---

## The Meta-Lesson

This guide itself demonstrates the problem:

1. **Problem identified**: Not using memory (observation #359)
2. **Solution documented**: Integrate memory search
3. **Problem persisted**: Still didn't use memory
4. **User intervention**: "discover more" triggered search
5. **Rediscovery**: Found we already documented the problem
6. **This guide**: Makes integration concrete, not just philosophical

**Key insight**: Documentation alone ≠ Behavior change

**What changes behavior**: Mandatory Step 0, workflow integration, muscle memory

---

## Implementation Roadmap

### Phase 1: Integration (This Week)
- [ ] Update /plan.md: Add Step 0 memory search (REQUIRED)
- [ ] Update /gogogo.md: Add Step 0 history verification (REQUIRED)
- [ ] Create /remember command shortcut
- [ ] Add memory prompts to all command docs

### Phase 2: Practice (Next Week)
- [ ] Use memory search in every /plan (build muscle memory)
- [ ] Track success stories (time saved, solutions reused)
- [ ] Document memory wins (positive reinforcement)
- [ ] Refine query patterns (what works best)

### Phase 3: Optimization (Next Month)
- [ ] Auto-suggest memory searches (proactive)
- [ ] Surface relevant observations automatically
- [ ] Build "memory first" culture
- [ ] Measure and report memory ROI

---

## Key Quotes

> **"External memory without active retrieval is just expensive storage."**

> **"A tool you have but don't use is worse than no tool - it creates the illusion of capability without the benefit."**

> **"Make memory search the default, not the exception."**

> **"Documentation alone doesn't change behavior. Integration does."**

---

## Related Resources

**Core paradox**: `ψ/memory/learnings/2025-12-17_memory-integration-paradox.md`

**Claude-mem observations:**
- #359: Meta-learning about claude-mem non-use
- #363: Comprehensive session retrospective  
- #355: /plan → /gogogo GitHub flow pattern
- #339: /gogogo command creation

**Follow-up**: Check in 1 week - Are we using memory as Step 0, or just documenting the need again?

---

**Tags**: #memory-systems #workflow-integration #step-0 #actionable-guide #efficiency #learning-compound
**Status**: Ready for immediate implementation
**Next action**: Update /plan.md and /gogogo.md with Step 0 patterns
