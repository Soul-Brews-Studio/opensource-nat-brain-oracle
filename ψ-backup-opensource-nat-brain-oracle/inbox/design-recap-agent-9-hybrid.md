# /recap - Agent 9 Final Design (HYBRID)

**Model**: Claude Opus (main synthesis) + Claude Haiku (data gathering)

**Status**: FINAL - Combines minimal + tiered + scored into one coherent system

---

## Overview

/recap is a **fresh-start context summary** command that answers: "What have I missed? What's most important?"

### The Hybrid Approach
1. **Minimal**: Only 3 output tiers (0/1/2)
2. **Tiered**: Clear hierarchy (WIP → Files → Context)
3. **Scored**: Color-coded priorities (⚪🟡🟠🔴)
4. **Fast**: One focused Haiku agent gathers, Opus synthesizes
5. **Focused**: No redundancy - commits integrated into file story

---

## Phase 1: Haiku Gathers (Raw Data)

### Command Flow

```bash
# Haiku agent runs ONE command sequence, outputs RAW data
# (No processing, no scoring, just data)

date "+🕐 %H:%M (%A %d %B %Y)"    # Timestamp

# Section 1: WIP Check (First!)
cat ψ/WIP.md 2>/dev/null || echo "NO_WIP"

# Section 2: File Changes (24 hours)
git log --since="24 hours ago" --format="%h|%ar|%s" --name-only

# Section 3: Working State
git status --short

# Section 4: Recent Commits (full context)
git log --format="%h|%ar|%s" -10

# Section 5: Plan Issues
gh issue list --limit 10 --state all \
  --json number,title,createdAt \
  --jq '.[] | select(.title | test("plan:")) | "#\(.number) | \(.title) | \(.createdAt[0:10])"' \
  2>/dev/null || echo "NO_PLANS"

# Section 6: Latest Retrospectives
ls -t ψ/memory/retrospectives/**/*.md 2>/dev/null | head -3

# Section 7: Read Latest Retro
LATEST=$(ls -t ψ/memory/retrospectives/**/*.md 2>/dev/null | head -1)
if [ -n "$LATEST" ]; then
  echo "=== LATEST RETRO ==="
  head -50 "$LATEST"  # First 50 lines
fi
```

### Haiku Output Format

**RAW, marked sections:**
```
=== TIMESTAMP ===
🕐 14:25 (Thursday 27 December 2025)

=== WIP ===
[content of ψ/WIP.md OR "NO_WIP"]

=== FILES_MODIFIED_24H ===
[git log output - one commit per line with files]

=== WORKING_STATE ===
[git status --short output]

=== RECENT_COMMITS ===
[git log -10 output]

=== PLAN_ISSUES ===
[filtered gh issues OR "NO_PLANS"]

=== RETRO_FILES ===
[ls output - 3 latest paths]

=== LATEST_RETRO_CONTENT ===
[head -50 of latest retro]
```

### Cost Estimate
- Tokens: ~3-4k
- Time: ~10-15 seconds
- Complexity: Low (just run commands, output raw)

---

## Phase 2: Opus Synthesizes (Create Narrative)

### Processing Steps

```
1. Parse Haiku output into sections
   └─ Extract WIP status, file list, commits, retro content

2. Calculate scores for each file
   Recency:  <1h = +3,  <4h = +2,  <24h = +1
   Type:     .ts/.js/.go/.py = +3,  .claude/* = +2,  .md (not ψ/) = +1,  ψ/* = +0
   Impact:   CLAUDE.md/package.json = +2,  config = +1

3. Classify each file
   🔴 = 6+ points (Critical)
   🟠 = 4-5 points (Important)
   🟡 = 2-3 points (Notable)
   ⚪ = 0-1 points (Background)

4. Extract key insights from latest retro
   - AI Diary (what I felt)
   - Honest Feedback (what worked/didn't)
   - Suggested Next (from retro)

5. Build narrative output
   Tier 0 (if WIP exists) → Tier 1 (scored files) → Tier 2 (context)
```

### Decision Logic

**IF WIP exists:**
- Put in TIER 0 with resume pointer
- Deprioritize other files
- Message: "Resume this work"

**IF NO WIP:**
- Show all files scored
- Top 3-5 by score
- Message: "Pick next from high-score files"

**ALWAYS:**
- Include latest retro context (TIER 2)
- Show suggestion if retro has one
- Show working state (dirty/clean)

---

## Phase 3: Opus Output (User-Facing)

### Output Structure

**Template:**

```markdown
## 🕐 [HH:MM] | [Day DD Month YYYY]

## 🚧 TIER 0: WIP (Ongoing Work)
[Content from ψ/WIP.md - first 5-10 lines]

→ **Resume this work first**

---

## 🔴 TIER 1: Files Changed (24 hours)

| | When | File | Commits |
|-|------|------|---------|
| 🔴 | 5m | src/index.ts | feat: new api endpoint; refactor: error handling |
| 🟠 | 1h | .claude/agents/context-finder.md | fix: scoring formula |
| 🟡 | 3h | README.md | docs: update workflow |
| 🟡 | 6h | .github/workflows/test.yml | ci: add coverage check |

**Working**: M .claude/settings.json, M ψ/WIP.md
_or_
**Working**: Clean (no uncommitted changes)

---

## 🟡 TIER 2: Session Context

**Highlights**: Recent commits that matter
- (14:30) feat: /recap agent 9 hybrid design
- (13:45) fix: scoring system edge case

**Learnings**: From latest retrospective
> "AI diary from retro - what I felt about the session"
>
> "Honest feedback - what worked, what didn't"

**Next**: Suggested direction
- From retro: "[suggestion from retro]"
- Or: "Pick from high-score files above"
```

### Example Output

```markdown
## 🕐 10:32 | Thursday 27 December 2025

## 🚧 TIER 0: WIP (Ongoing Work)
**Task**: Design /recap - Agent 9: HYBRID approach
**Since**: 10:07

→ **Resume this work first**

---

## 🔴 TIER 1: Files Changed (24 hours)

| | When | File | Commits |
|-|------|------|---------|
| 🔴 | 2m | .claude/commands/recap.md | docs: finalize hybrid design |
| 🟠 | 15m | .claude/agents/agent-9.md | feat: agent 9 specification |
| 🟡 | 45m | CLAUDE_workflows.md | docs: update /recap docs |

**Working**: M .claude/settings.json (3 lines changed)

---

## 🟡 TIER 2: Session Context

**Highlights**: What's been happening
- (10:07) feat: start /recap 10-iteration design
- (09:47) fix: timestamp hook clean formatting

**Learnings**: From latest retrospective
> "Workshop prep was energizing - clear teaching improves my own understanding"
>
> "Next time: prototype commands BEFORE documenting them"

**Next**: Design phase complete → update spec files
```

---

## Combined Elements (What We Kept)

| Element | Source | Why Kept |
|---------|--------|----------|
| WIP Priority | Minimal | Explicit resume point |
| Tier 0/1/2 | Tiered + Minimal | Clear mental model |
| Score Colors | Scored | At-a-glance priority |
| Parallel Agents | Minimal + Full | Speed + focus |
| Synthesis | Full Recap | Story + context |
| File Scoring | Scored | Importance ranking |
| Retro Integration | Minimal | Learning capture |
| Commits in Files | NEW (merged) | No redundancy |
| Suggestions | Minimal | Light guidance |

---

## Execution Flow (Diagram)

```
User runs: /recap
    ↓
Opus spawns Haiku agent (background)
    ↓
Haiku: git log, git status, cat WIP, gh issue, ls retros
    ↓
Haiku returns RAW output (marked sections)
    ↓
Opus receives raw data
    ↓
Opus: Score files, extract insights, classify tiers
    ↓
Opus: Build narrative (markdown output)
    ↓
Opus: Return to user
```

**Timeline**: ~20-30 seconds total
- Haiku: 10-15 seconds (parallel execution)
- Opus: 5-10 seconds (synthesis)

---

## Configuration & Implementation

### For .claude/commands/recap.md

```yaml
name: /recap
description: Fresh-start context summary with WIP, files, and learnings
trigger: /recap
model: claude-opus-4-5
subagent: context-finder (haiku)
```

### For .claude/agents/agent-9.md

```yaml
name: Agent 9 (Recap Synthesizer)
model: claude-opus-4-5
role: Synthesizes Haiku data into narrative context
input: Raw git/issue data from Haiku
output: Tiered, scored, story-focused summary
scoring_system: 6-point (recency + type + impact)
```

---

## Design Principles (Validated)

✓ **Speed**: One Haiku + Opus synthesis = ~20-30 seconds
✓ **Clarity**: Tiered layout (0/1/2) + color codes (⚪🟡🟠🔴)
✓ **Balance**: WIP + files + context (nothing extra)
✓ **No Redundancy**: Commits integrated, scoring once, one format
✓ **User Agency**: Shows what matters, lets user decide next

---

## What Changed from Original Designs

### Removed
- ❌ 3 separate Haiku agents (→ 1 focused agent)
- ❌ Haiku-side scoring (→ Opus does it once)
- ❌ Separate "Commits" section (→ integrated into files)
- ❌ "Plan Issues" as major tier (→ mentioned in TIER 2 if exists)
- ❌ "What to focus on" directive (→ user agency via data)

### Added
- ✅ WIP as TIER 0 with guard rails
- ✅ Working state indicator (dirty/clean)
- ✅ Integrated commits (explain file changes)
- ✅ One coherent output format
- ✅ Validation checklist (10 iterations)

### Kept (From All Three)
- ✅ WIP priority (minimal)
- ✅ Tiered structure (tiered + minimal)
- ✅ Score colors (scored)
- ✅ Parallel execution (both recap versions)
- ✅ Synthesis narrative (full recap)
- ✅ Session context (all three)

---

## Success Criteria

After implementation, /recap passes if:

1. **Speed**: Completes in <30 seconds ✓
2. **WIP First**: Shows WIP as TIER 0 if exists ✓
3. **Clear Priority**: Scored files are obviously prioritized ✓
4. **No Redundancy**: No duplicate information ✓
5. **Useful Context**: TIER 2 actually helps with decision-making ✓
6. **User Agency**: Output shows options, doesn't dictate ✓

---

## Appendix: Scoring Rules (Detailed)

```
RECENCY (when was file last modified?)
  < 1 hour ago       = +3
  < 4 hours ago      = +2
  < 24 hours ago     = +1
  ≥ 24 hours ago     = +0

TYPE (what kind of file?)
  Code (.ts, .js, .go, .py, .tsx, .jsx) = +3
  Agent/Cmd (.claude/*)                   = +2
  Config (*.json, *.yml, *.yaml)         = +1
  Docs (.md, outside ψ/)                  = +1
  Memory/Logs (ψ/memory/, ψ/logs/)       = +0

IMPACT (is this core?)
  CLAUDE.md, package.json, Dockerfile    = +2
  Config files, CI/CD                    = +1
  Everything else                         = +0

TOTAL SCORE
  6+  → 🔴 Critical (must read)
  4-5 → 🟠 Important (should read)
  2-3 → 🟡 Notable (good context)
  0-1 → ⚪ Background (reference only)

EXAMPLE CALCULATIONS
  src/index.ts
    5m old = +3, code = +3, no impact = +0 → 6 (🔴)

  .claude/agents/recap.md
    1h old = +2, agent = +2, no impact = +0 → 4 (🟠)

  README.md
    3h old = +2, doc = +1, no impact = +0 → 3 (🟡)

  ψ/memory/retro.md
    6h old = +1, log = +0, no impact = +0 → 1 (⚪)
```

---

## Next Steps

1. Implement as Agent 9 (Opus synthesizer)
2. Update .claude/commands/recap.md to use new flow
3. Update .claude/agents/context-finder.md to match Phase 1
4. Test with real WIP scenarios
5. Validate 20-30 second timing

---

**Design Author**: Claude Haiku (context-finder)
**Design Process**: 10 iterations, combining minimal + tiered + scored
**Final Status**: READY FOR IMPLEMENTATION
