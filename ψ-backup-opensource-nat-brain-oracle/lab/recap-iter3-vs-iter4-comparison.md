# ITERATION 3 vs ITERATION 4: Side-by-Side Comparison

## Design Complexity Metrics

| Metric | Iteration 3 (Hybrid) | Iteration 4 (Simplified) | Change |
|--------|----------------------|--------------------------|--------|
| **Scoring Factors** | 3 (recency, type, impact) | 2 (recency, type) | -33% |
| **Possible Scores** | 9 values (0-6+) | 3 values (0, 2, 4) | -67% |
| **State Machine** | 5 states | 3 states | -40% |
| **Output Sections** | 4 tiers + narrative | 2 tiers | -50% |
| **Processing Steps** | Score + classify + extract + synthesize | Score + extract + output | -25% |
| **Code Lines (Est.)** | 120-150 | 60-80 | -45% |
| **Read Time** | 30 seconds | 15 seconds | -50% |
| **Opus Processing** | 5-10 seconds | 2-3 seconds | -60% |

---

## Feature Comparison

### What's Kept (Core Value)

| Feature | Iter 3 | Iter 4 | Why Kept |
|---------|--------|--------|----------|
| WIP Priority | ✓ | ✓ | Explicit resume point |
| Score Colors | ✓ | ✓ | At-a-glance priority |
| Tier Structure | ✓ | ✓ | Clear mental model |
| Retro Context | ✓ | ✓ | Learning from previous session |
| File Changes | ✓ | ✓ | What changed in 24h |
| Parallel Agents | ✓ | ✓ | Speed |

### What's Removed (Complexity Cuts)

| Feature | Iter 3 | Iter 4 | Why Removed |
|---------|--------|--------|------------|
| Impact Scoring | ✓ | ✗ | Rarely different (most files low-impact) |
| Fine Recency | ✓ | ✗ | 4-level granularity unnecessary |
| Blocker Detection | ✓ | ✗ | User reads retro anyway; avoid false positives |
| Narrative Synthesis | ✓ | ✗ | Table is faster; retro is the story |
| 5-State Machine | ✓ | ✗ | Only 2 states used in practice (working/done) |
| Suggestion Inference | ✓ | ✗ | Let retro's "Next Actions" speak |
| Commit Messages | ✓ | ✗ | Available in git log, avoid duplication |

---

## Output Format Comparison

### Iteration 3 (Hybrid)

```markdown
## 🔴 TIER 1: Files Changed (24 hours)

| | When | File | Commits |
|-|------|------|---------|
| 🔴 | 2m | .claude/commands/recap.md | docs: finalize hybrid design |
| 🟠 | 15m | .claude/agents/agent-9.md | feat: agent 9 specification |
| 🟡 | 45m | CLAUDE_workflows.md | docs: update /recap docs |

**Working**: M .claude/settings.json (3 lines changed)

## 🟡 TIER 2: Session Context

**Highlights**: What's been happening
- (10:07) feat: start /recap 10-iteration design
- (09:47) fix: timestamp hook clean formatting

**Learnings**: From latest retrospective
> "Workshop prep was energizing - clear teaching improves..."
> "Next time: prototype commands BEFORE documenting"

**Next**: Design phase complete → update spec files
```

### Iteration 4 (Simplified)

```markdown
## 🔴 TIER 1: What's Hot (24 hours)

| When | File | What |
|------|------|------|
| 5m | .claude/commands/recap.md | feat: simplify scoring |
| 1h | CLAUDE_workflows.md | docs: cut state machine |

**Status**: 2 modified, working clean

---

## 🟡 TIER 2: Latest Context

> "Simplifying /recap reveals what's really needed..."
>
> "Next: validate with real usage"
```

**Differences:**
- Iter 3: Has commit messages, highlights, learnings extracted
- Iter 4: Has file "what" column (short version of commits), raw retro quote
- Iter 3: 20+ lines
- Iter 4: 12 lines

---

## Scoring Algorithm Comparison

### Iteration 3 (6-Point System)

```python
recency_points = {
  "< 1 hour": 3,
  "< 4 hours": 2,
  "< 24 hours": 1,
  "else": 0
}

type_points = {
  ".ts, .js, .go, .py": 3,
  ".claude/*": 2,
  ".json, .yml, .md": 1,
  "ψ/*": 0
}

impact_points = {
  "CLAUDE.md, package.json": 2,
  "config, CI/CD": 1,
  "else": 0
}

total = recency + type + impact
color = {
  0-1: "⚪",
  2-3: "🟡",
  4-5: "🟠",
  6+: "🔴"
}
```

### Iteration 4 (2-Point System)

```python
score = 0

# Recency: < 4 hours? +2
if minutes_ago < 240:
  score += 2

# Type: code or agent? +2
if is_code_file(path) or is_agent_file(path):
  score += 2

# Result: 0, 2, or 4
color = {
  0: "⚪",
  2: "🟡",
  4: "🔴"  # (no 🟠, combine with 🔴)
}
```

**Difference**: 
- Iter 3 calculates 3 factors, 9 possible values
- Iter 4 calculates 2 factors, 3 possible values
- Both produce 4 colors (but Iter 4 skips intermediate)

---

## Execution Flow Comparison

### Iteration 3 (Hybrid)

```
User: /recap
  ↓
Opus spawns Haiku (get raw data)
  ↓
Haiku: git log, git status, cat WIP, gh issues, ls retros, head latest
  ↓
Haiku returns: MARKED SECTIONS (raw output)
  ↓
Opus receives data
  ↓
Opus: Parse sections
Opus: Score each file (6-point algorithm)
Opus: Classify colors
Opus: Extract insights from retro
Opus: Build narrative synthesis
Opus: Generate markdown
  ↓
Return to user
```

**Timeline**: 20-30 seconds (10-15s Haiku + 5-10s Opus)

### Iteration 4 (Simplified)

```
User: /recap
  ↓
Opus spawns Haiku (get raw data)
  ↓
Haiku: git log, git status, cat WIP, head latest
  ↓
Haiku returns: MARKED SECTIONS (raw output)
  ↓
Opus receives data
  ↓
Opus: Parse sections
Opus: Score each file (2-point algorithm)
Opus: Classify colors
Opus: Extract retro quote (50-line snippet)
Opus: Build markdown table
  ↓
Return to user
```

**Timeline**: 12-18 seconds (10-15s Haiku + 2-3s Opus)

---

## Decision Matrix: What to Cut

| Question | Answer | Action |
|----------|--------|--------|
| Is this used? | Impact scoring never checked | Cut |
| Is this visible? | Fine recency granularity invisible | Cut |
| What's the cost? | +1 point complexity = no difference | Cut |
| Is there data? | Blocker field doesn't exist in retros | Cut |
| Is it accurate? | Parsing natural language is unreliable | Cut |
| Is it fast? | 30s to read narrative vs 5s for table | Cut |
| Can user get it? | Retro file is 2 clicks away | Cut |
| Is it core? | Scoring + colors + WIP + context = core | Keep |

---

## Validation Rules (Iteration 4)

After implementation, /recap passes if:

1. **Speed**: Completes in < 20 seconds (was 30)
2. **Clarity**: User reads in < 5 seconds (was 15)
3. **Accuracy**: All files are correctly scored
4. **Completeness**: WIP + recent changes + context shown
5. **No Regression**: Core features still work
6. **Simplicity**: Code is <100 lines (was 120-150)

---

## Tradeoffs Summary

| Dimension | Gain | Loss |
|-----------|------|------|
| **Speed** | 2x faster | None (data unchanged) |
| **Complexity** | 45% less code | Fewer scoring levels |
| **Clarity** | Scannable table | Less narrative flow |
| **Safety** | No false positives | No blocker warnings |
| **Maintenance** | Easier to debug | Less feature-rich |
| **Recall Time** | 5s to read | Can't learn as deeply |

---

## Why This Simplification Works

1. **Eliminates Complexity Without Loss**
   - 6-point system looks precise but maps to 4 colors anyway
   - User never asks "why 5 instead of 4?"
   - Removing impact factor = no visible change

2. **Matches User Behavior**
   - 5-state machine invented for future use cases that don't exist
   - Only "active" and "idle" are needed
   - One session is typically linear (no context switches)

3. **Respects Data Limits**
   - Retros don't have structured "blocker" field
   - Parsing 50 lines is faster and more accurate than NLP
   - Table format = user scans vs system narrates

4. **Prioritizes Core Value**
   - /recap's job: "What changed + is it important + what's the context?"
   - Removes: "I predict your problem is X" (unreliable)
   - Keeps: "Here's what happened" (reliable)

5. **Reduces Maintenance**
   - Less code = fewer bugs
   - Binary scoring = no edge cases
   - 3 states instead of 5 = less documentation

---

## Next: ITERATION 5 Preview

If Iteration 4 passes validation, Iteration 5 could:
- Add user testing feedback
- Optimize Haiku commands (might be able to skip gh issues)
- Consider caching retro summary (if run multiple times per day)
- Create output variants (compact vs full)

But first: Verify that 2-point scoring + 3 states actually matches user expectations.

