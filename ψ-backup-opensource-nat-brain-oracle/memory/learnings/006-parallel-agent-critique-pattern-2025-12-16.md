# Parallel Agent Critique Pattern — 10 Perspectives Validation

**Date**: 2025-12-16
**Context**: After creating ARCHITECTURE.md, spawned 10 Haiku agents in parallel to critique from different perspectives
**Outcome**: Comprehensive validation (6.6/10 average), identified critical gaps

---

## The Pattern

### Problem
After writing system documentation, you need validation but:
- Single perspective = blind spots
- Sequential review = slow
- Self-review = confirmation bias

### Solution: Multi-Agent Critique
```
Spawn 10 agents simultaneously, each with different role:
1. New Developer (accessibility)
2. Technical Architect (design quality)
3. Documentation Expert (doc quality)
4. Product Manager (business case)
5. Security Engineer (security/privacy)
6. UX Designer (user experience)
7. Systems Thinker (emergence/resilience)
8. AI Ethics Researcher (ethical implications)
9. DevOps Engineer (operations)
10. Cost Optimizer (economics)

Each agent: Scores 1-10 + specific improvements + strengths
```

### Implementation
```bash
# Single message with 10 Task calls
Task(subagent_type="general-purpose",
     model="haiku",
     run_in_background=true,
     prompt="You are [ROLE]. Critique [DOCUMENT]...")

# Collect all results in parallel
# Synthesize findings
```

---

## Key Learnings

### 1. Different Roles Catch Different Gaps
**Discovery**: Technical quality (8.5/10) masked UX problems (6/10) and ops gaps (4.5/10)

**Example**:
- Architect: "Sound design" (7.5/10)
- DevOps: "No deployment guide" (4.5/10)
- Both correct — architecture ≠ operations

**Lesson**: Single-perspective review misses category gaps.

---

### 2. Consensus Themes Reveal True Problems
**Pattern**: When 4+ agents flag same issue = critical

**Examples**:
- 6 agents: "No hands-on tutorial" → Created QUICKSTART.md
- 5 agents: "Missing operational docs" → Identified as real gap
- 4 agents: "Cognitive overload" → Progressive disclosure needed

**Lesson**: Count repetitions, not individual scores.

---

### 3. Scoring Reveals Blind Spots
**Discovery**: What YOU think is good vs what AGENTS score can differ drastically

**Example**:
- Expected: "Architecture is great" → High scores across board
- Reality: Architecture 7.5/10, UX 6/10, DevOps 4.5/10, Cost 5.5/10

**Lesson**: You optimize for what you measure. Missing categories = missing quality.

---

### 4. Role-Specific Language Surfaces Hidden Assumptions
**Pattern**: Each agent speaks in their domain's vocabulary

**Examples**:
- DevOps: "No runbook" (not "no docs")
- UX: "Progressive disclosure" (not "too many commands")
- Cost: "Token budget" (not "API usage")

**Lesson**: Domain experts articulate problems you can't even name.

---

### 5. Lowest Score = Highest Priority Fix
**Discovery**: DevOps (4.5/10) and Cost (5.5/10) were blind spots

**Why**: Solo developer = no ops/cost pressure → ignored these dimensions

**Action taken**:
- Priority 1: QUICKSTART.md (accessibility gap)
- Priority 2: Cost tracking (economics gap)
- Priority 3: FAILURE_MODES.md (ops gap)

**Lesson**: Fix your weakest area first, not your strongest.

---

## Anti-Patterns (What NOT to Do)

### ❌ Don't Ask for "Overall Quality"
**Why**: Too vague. Agents give generic feedback.

**Better**: Ask for specific dimensions (clarity, completeness, accessibility)

---

### ❌ Don't Average Scores Without Context
**Why**: 6.6/10 average hides that DevOps is 4.5/10

**Better**: Look at distribution. Fix outliers first.

---

### ❌ Don't Ignore Low-Confidence Agents
**Why**: "I'm not sure but..." often contains breakthrough insights

**Example**: Ethics agent flagged "wife as key enabler" dependency → Real systemic risk

---

### ❌ Don't Skip Synthesis
**Why**: 10 separate reports = cognitive overload

**Better**: Extract consensus themes + top 10 priorities + quotes

---

## When to Use This Pattern

### ✅ Good For:
- Major documentation (architecture, design docs)
- System designs (technical specs)
- Product launches (multi-stakeholder review)
- Strategic plans (business + tech + ops)

### ❌ Not Good For:
- Daily retrospectives (overkill)
- Code reviews (use 1-2 agents max)
- Quick fixes (just do it)

---

## Cost/Benefit Analysis

### Input
- 10 Haiku agents × ~5,000 tokens each = 50,000 tokens
- Cost: ~$0.05 (input) + ~$0.25 (output) = **$0.30 total**
- Time: 5-7 minutes parallel execution

### Output
- 10 comprehensive critiques
- Consensus themes identified
- Top 10 actionable priorities
- Blind spots revealed

### ROI
**Without this**: Would have shipped ARCHITECTURE.md thinking it was great
**With this**: Identified critical UX/ops/cost gaps before wider use
**Value**: Saved weeks of confused users + support burden

**Verdict**: $0.30 and 10 minutes = incredibly cheap validation

---

## Implementation Template

```markdown
You are a [ROLE]. Read [FILE_PATH]

Your job: Critique from [PERSPECTIVE] perspective.

Questions to answer:
1. [Domain-specific question 1]
2. [Domain-specific question 2]
3. [Domain-specific question 3]
4. [Domain-specific question 4]

Score the document 1-10 on:
- [Dimension 1] (explanation)
- [Dimension 2] (explanation)
- [Dimension 3] (explanation)

Provide: Score + 3-5 specific improvements + what you liked most
```

---

## Variations

### Fast Version (5 agents)
- Technical (architecture)
- User (accessibility)
- Operations (deployment)
- Security (privacy)
- Cost (economics)

### Deep Version (15+ agents)
Add:
- Legal (compliance)
- Accessibility (disabilities)
- Internationalization (i18n)
- Performance (speed)
- Scalability (growth)

---

## Related Patterns

- **002-subagent-delegation-pattern.md** — When to use Haiku vs Opus
- **005-parallel-agent-orchestration.md** — 96-minute build pattern
- **CLAUDE_workflows.md** — `/gogogo` pattern (parallel execution)

---

## Meta-Learning

**Observation**: This pattern validated itself through use.

**How**: 10 agents criticized the documentation → Revealed the pattern itself was valuable → Now documented as learning.

**Recursive**: The critique pattern creates knowledge about the critique pattern.

---

## Next Evolution

**Idea**: Automate this as pre-commit hook for major docs?

```bash
# .claude/hooks/pre-doc-commit.sh
if [ -f "ARCHITECTURE.md" ]; then
  echo "Running 10-agent validation..."
  claude-task parallel-critique ARCHITECTURE.md
  echo "Review synthesis before commit"
fi
```

**Question**: Is $0.30 per commit worth it for quality assurance?
**Answer**: For major docs, yes. For daily commits, no.

---

**Status**: Validated pattern, ready for reuse
**Confidence**: High (real-world tested)
**Reusability**: Very high (template provided)
