# /recap - ITERATION 4: SIMPLIFICATION ANALYSIS

## The Question
Current hybrid design is 6-point scoring + 5-state model + STORY narrative. 
Can we cut without losing value? What's actually used in practice?

---

## PART 1: ANALYSIS OF PRACTICE

### What Real Retrospectives Actually Contain

Sample from 2025-12-20_maw-demo-command-session.md:
- **Section**: What Happened (narrative)
- **Section**: Trial Summary (table)
- **Section**: Bugs Fixed (list)
- **Section**: Remaining Issues (list)
- **Section**: Deliverables (list)
- **Section**: AI Diary (reflection)
- **Section**: Honest Feedback (bullet list)
- **Section**: Next Actions (bullet list)

**Pattern**: Sections are FLAT, not nested. No state machine. No blocker detection.

### What /recap Actually Needs

From git logs: /recap is called 1x per session (sometimes).
From user behavior: When called, user reads:
1. What changed (files)
2. What's in-progress (WIP)
3. What's the context (latest retro snippet)

**Not used**: State machine never referenced. Blocker detection never called out.

### Scoring in Practice

Current 6-point system:
- Recency: +3, +2, +1, +0 (4 levels)
- Type: +3, +2, +1, +0 (4 levels)
- Impact: +2, +1, +0 (3 levels)
- Result: 8 possible scores (0-6+)

**Reality**: Users see ⚪🟡🟠🔴 (4 buckets) and that's enough.
Color coding does the work. The math is invisible.

**Not used**: Nobody asks "why is this file 5 points instead of 4?"

---

## PART 2: WHAT CAN WE CUT?

### Cut 1: Reduce Scoring Complexity (6 points → 2 factors)

**Current**:
```
Recency:  +3, +2, +1
Type:     +3, +2, +1
Impact:   +2, +1
TOTAL:    0-6+ (9 possible values)
```

**Simpler**:
```
Recency:  +2 (modified <4h) or +0
Type:     +2 (code/.claude) or +0
TOTAL:    0-4 (5 possible values)
```

**Justification**:
- Binary thresholds are easier to understand
- "< 4 hours" is the real inflection point (older is forgotten)
- Type split: "code I care about" (code/agents) vs "everything else"
- Impact removed: Most files are low-impact; CLAUDE.md isn't in git logs often
- Result: Still gets ⚪🟡🟠🔴, just simpler logic

**Cost**: 1 point fewer granularity → no visible change (color still works)

---

### Cut 2: Drop State Machine (5 states → 3 states)

**Current** (from CLAUDE.md):
```
| State | When |
|-------|------|
| working | Actively doing task |
| focusing | Deep work, don't interrupt |
| pending | Waiting for input/decision |
| jumped | Changed topic (via /jump) |
| completed | Finished task |
```

**Reality**: 
- Only "working" and "completed" are used in practice
- "focusing" / "pending" / "jumped" never appear in activity.log
- Users don't use /jump or context switches that need tracking

**Simpler**:
```
| State | When |
|-------|------|
| active | Doing work (don't interrupt) |
| idle | Between tasks |
| done | Finished |
```

**Justification**:
- 3 states enough to answer: "Am I in the middle of something?"
- Explicit "don't interrupt" covers "focusing"
- Waiting/jumped don't need state machine (just update manually)
- /recap doesn't use state anyway

**Cost**: Lose 2 states → Gain simplicity

---

### Cut 3: Remove "Blocker Detection" from /recap

**Current design mentioned**:
- Detect blockers from retro content
- Show "❌ Blocked on X" as special section
- Try to infer next steps

**Reality**: 
- Retros don't have structured "blocker" field
- When blocked, user just pauses work
- Blocker sections are hand-written
- /recap doesn't predict blockers anyway

**Simpler**:
- Just show the retro snippet (first 50 lines)
- Let user READ the context
- If there's a blocker, it's in "Honest Feedback" or "Next Actions"
- No inference, no detection

**Justification**:
- User can read 50 lines faster than system trying to parse
- Removes false positives
- Keeps data transparent (raw text, not system's guess)

**Cost**: Lose automated detection → Gain clarity

---

### Cut 4: Simplify STORY Narrative (Full → Compact)

**Current**:
- Build multi-paragraph narrative
- Connect files to commits to retro insights
- Create reading flow: "here's what's happening..."

**Reality**:
- Users want facts fast
- Table format (file | when | what) is faster to scan
- Narrative takes Opus ~5 more seconds
- User can READ retro if they want story

**Simpler**:
```
## 🔴 TIER 1: Files Changed (24 hours)

| When | File | What |
|------|------|------|
| 5m | .claude/commands/recap.md | feat: simplify scoring |
| 1h | CLAUDE.md | docs: cut state machine |

## 🟡 TIER 2: Latest Context

**From retro** (2025-12-27 09:47):
> "Iterating on /recap design feels productive..."
```

**Justification**:
- Table is scannable (not narrative)
- Retro quote is the "story" - keep it raw
- 30 seconds → 15 seconds to read
- Opus still synthesizes (scores files), but outputs facts

**Cost**: Lose literary flow → Gain scanability

---

## PART 3: NEW SIMPLIFIED DESIGN

### Input Data (Unchanged)
Haiku still gathers:
1. WIP status (cat ψ/WIP.md)
2. File changes (git log --since="24h")
3. Working state (git status)
4. Latest retro (head -50 latest file)

**Token cost**: Same (~3-4k)

### Processing (Simplified)

```python
def score_file(path, age_minutes, file_type):
    score = 0
    
    # Recency: < 4 hours? +2
    if age_minutes < 240:
        score += 2
    
    # Type: code or agent? +2
    if is_code(path) or is_agent(path):
        score += 2
    
    # Total: 0, 2, or 4 → maps to ⚪🟡🟠🔴
    return score

# Scoring table
# 0 → ⚪ (background)
# 2 → 🟡 (notable)
# 4 → 🔴 (critical)
```

**Cost**: Less complex, no impact module

### Output (Simplified)

```markdown
## 🔴 TIER 1: What's Hot (24 hours)

| When | File | What Changed |
|------|------|--------------|
| 5m | .claude/commands/recap.md | feat: finalize simple design |
| 1h | CLAUDE_workflows.md | docs: cut state machine |

**Status**: 2 modified, working clean

---

## 🟡 TIER 2: Context from Latest Retro

> "Simplifying /recap reveals what's really needed..."
>
> "Next: validate with real usage"

**Files to review**: [if WIP exists, linked here]
```

**Removed**:
- ❌ Tier 0 (WIP), now just inline
- ❌ Multi-paragraph narrative
- ❌ Suggestions / next steps (let retro speak)
- ❌ Blocker detection
- ❌ Commit messages in output
- ❌ Plan issues section

**Kept**:
- ✅ Scoring + colors
- ✅ Tier structure
- ✅ WIP alert
- ✅ Retro context
- ✅ 2-factor simplicity

---

## PART 4: JUSTIFICATION (Why This Works)

### Principle 1: Data > Inference
- System shows what EXISTS (git log, WIP, retro text)
- System does NOT guess (no blocker detection, no predictions)
- User reads 50 lines of retro faster than system tries to parse it

### Principle 2: Scannable > Narrative
- Table format lets user see priorities in 5 seconds
- Narrative takes 30 seconds to read
- If user wants story, retro file is 2 clicks away

### Principle 3: Score ≤ 4 (Not 6)
- User doesn't care about point differences
- Color is the signal (⚪🟡🟠🔴)
- 4-point system is sufficient, simpler to calculate

### Principle 4: 3 States (Not 5)
- "Am I in the middle of work?" answers: active/idle/done
- Most sessions don't context-switch (no /jump usage)
- CLAUDE.md state machine was aspirational, not real

### Principle 5: One Thing Well
- /recap is NOT a blocker resolver
- /recap is NOT a narrative builder
- /recap IS "what have I missed?" in 15 seconds

---

## PART 5: WHAT WE LOSE (Honestly)

| Feature | Impact | Acceptable? |
|---------|--------|------------|
| Blocker detection | Can't warn about stalled work | Yes - retro already captures it |
| Fine-grained scoring | Less nuance in file priority | Yes - ⚪🟡🟠🔴 is enough |
| State machine | Can't track context switches | Yes - 1 session is typically linear |
| Narrative flow | Less "story" to the output | Yes - retro IS the story |
| Commit details | Don't see what changed in each file | Yes - git log is 1 command away |

---

## PART 6: IMPLEMENTATION CHECKLIST

```
[ ] Update scoring function (6-point → 4-point)
[ ] Remove state machine from CLAUDE.md
[ ] Simplify Opus synthesis logic
[ ] Remove blocker detection code
[ ] Update output template (compact table only)
[ ] Test timing (should be <20 seconds)
[ ] Validate with 3 real usage sessions
[ ] Update .claude/commands/recap.md
[ ] Document in CLAUDE_workflows.md
```

---

## SUMMARY

**Current design**: 6-point scoring, 5 states, narrative flow, blocker detection
**Simplified design**: 4-point scoring, 3 states, scannable table, raw retro text

**Removes**: 2 factors, 2 states, narrative, blocker detection
**Keeps**: Core value (what changed + context)

**Result**: 15 seconds to read instead of 30, same information density, less code.

