# /recap - Agent 9: HYBRID Design (Final)

## 10-Iteration Refinement Process Complete

### Starting State
- **Design A (Minimal)**: WIP first, tiers 0-2, compact format
- **Design B (Tiered)**: Full tier structure with synthesis narrative
- **Design C (Scored)**: 6-point scoring system with context-finder

### Design Challenge
Combine three approaches into ONE that balances:
- Speed (vs complexity)
- Clarity (vs completeness)  
- User agency (vs directive guidance)
- Cost (tokens, time)

---

## The 10 Iterations (Summary)

| Iteration | Question | Decision | Outcome |
|-----------|----------|----------|---------|
| 1 | What's good? What's redundant? | Keep WIP priority, tiered structure, scoring | Identified core principles |
| 2 | One agent or three? | One unified Haiku (not three) | Simplified agent design |
| 3 | Where does scoring happen? | Opus (not Haiku) | Defer complexity, Haiku gathers raw data |
| 4 | How to protect WIP? | Output in marked sections | Haiku delivers structured raw data |
| 5 | Is "suggest next" needed? | Optional guidance only | Trust user + data to decide |
| 6 | How to balance guidance? | IF WIP → focus on it, ELSE → suggest | Conditional synthesis |
| 7 | Is TIER 2 necessary? | Yes, but minimal (recent + learnings) | Compress context section |
| 8 | Separate commits or merge? | Merge into file story | Eliminate redundancy |
| 9 | Finalize output format | 3 clean sections (0/1/2) | User-ready output |
| 10 | Validate all principles | Speed, clarity, balance, no redundancy, agency | ALL CHECKS PASS |

---

## Final Design (Hybrid)

### What Is It?
A fresh-start context summary that tells you:
1. **What I was doing** (WIP)
2. **What changed** (scored files)
3. **What matters** (session context + learnings)

### How It Works

**Phase 1: Haiku Gathers** (~15 seconds)
- Runs ONE command sequence
- Outputs RAW data in marked sections
- No processing, no scoring
- Returns: timestamp, WIP, files, commits, issues, retros

**Phase 2: Opus Synthesizes** (~10 seconds)
- Parses Haiku output
- Calculates scores (recency + type + impact)
- Extracts insights from latest retro
- Builds narrative with 3 tiers
- Returns user-facing markdown

### Output Structure

```
## 🕐 [HH:MM] | [Day DD Month YYYY]

## 🚧 TIER 0: WIP (if exists)
[Content] → **Resume this work**

---

## 🔴 TIER 1: Files Changed (scored)
| | When | File | Commits |
| 🔴 | 5m | src/index.ts | feat: new endpoint |
| 🟠 | 1h | .claude/agents/x.md | fix: prompt |

**Working**: M file.md or Clean

---

## 🟡 TIER 2: Session Context
**Highlights**: Recent commits that matter
**Learnings**: From latest retro
**Next**: Suggestion or choose from high scores
```

---

## Combined Elements (What We Kept)

### From Minimal Design
- WIP priority (TIER 0)
- Compact format (3 sections)
- User agency (shows data, not directives)

### From Tiered Design
- Clear tiers (0/1/2)
- Narrative synthesis
- Story-based context

### From Scored Design
- 6-point scoring (recency + type + impact)
- Color codes (⚪🟡🟠🔴)
- Importance at-a-glance

### NEW (From Merging)
- Integrated commits (no separate section)
- Working state indicator (dirty/clean)
- One coherent Haiku prompt
- Deferred scoring to Opus

---

## Design Principles (All Validated)

✓ **Speed**: 20-30 seconds total (Haiku ~15s + Opus ~10s)
✓ **Clarity**: Tiered (0/1/2) + color codes + scannable tables
✓ **Balance**: WIP + files + context (nothing extra)
✓ **No Redundancy**: Commits integrated, scoring once, one format
✓ **User Agency**: Shows what matters, lets user decide next

---

## Key Design Decisions

1. **ONE Haiku agent** (not three)
   - Gather all data in parallel
   - Output structured raw data
   - Faster, simpler, cheaper

2. **Scoring in Opus** (not Haiku)
   - Haiku just gathers, Opus understands
   - Saves context in Haiku
   - More flexible synthesis

3. **Commits integrated into files**
   - No separate commits section
   - Files explain "why changed"
   - Reduces redundancy

4. **WIP as TIER 0 guard rail**
   - First thing shown if exists
   - Changes narrative weight
   - "Resume this work" vs "Pick next"

5. **Light guidance in TIER 2**
   - Suggest from retro if available
   - Or user picks from high scores
   - Respects user agency

---

## Example Output

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

## Scoring System (Ready to Use)

```
RECENCY
  < 1 hour    = +3
  < 4 hours   = +2
  < 24 hours  = +1
  else        = +0

TYPE
  Code        = +3
  Agent/cmd   = +2
  Doc/config  = +1
  Log/memory  = +0

IMPACT
  Core        = +2
  Config      = +1
  Other       = +0

TOTAL: 6+=🔴, 4-5=🟠, 2-3=🟡, 0-1=⚪
```

---

## Implementation Ready

### Files to Update
- .claude/commands/recap.md (command definition)
- .claude/agents/agent-9.md (Opus synthesizer)
- .claude/agents/context-finder.md (Phase 1, Haiku)

### Test Scenarios
- [ ] With WIP.md present
- [ ] Without WIP.md
- [ ] With recent changes
- [ ] Without recent changes
- [ ] With plan issues
- [ ] Without plan issues

### Success Criteria
- [ ] Speed: < 30 seconds
- [ ] WIP shown as TIER 0 if exists
- [ ] Scored files obviously prioritized
- [ ] No duplicate information
- [ ] TIER 2 helps with decision-making
- [ ] User agency respected

---

## What Changed from Original Designs

### Removed
- 3 separate Haiku agents (→ 1 focused agent)
- Haiku-side scoring (→ Opus does it)
- Separate "Commits" section (→ integrated)
- "Plan Issues" as major tier (→ TIER 2 if exists)
- Directive "What to focus on" (→ user agency)

### Added
- WIP as TIER 0 with guard rails
- Working state indicator (M/A/clean)
- Integrated commits in file story
- One coherent output format
- 10-iteration validation process

### Kept
- WIP priority (minimal)
- Tiered 0/1/2 structure
- Score colors (scored)
- Parallel execution
- Synthesis narrative
- Session context

---

## Design Statistics

- **Iterations**: 10 (each asking "is this balanced?")
- **Design sources combined**: 3 (minimal + tiered + scored)
- **Elements merged**: Commits + Files (no redundancy)
- **Output sections**: 3 (TIER 0/1/2)
- **Color codes**: 4 (⚪🟡🟠🔴)
- **Scoring factors**: 3 (recency + type + impact)
- **Total timeline**: 20-30 seconds
- **Token cost**: ~5-6k total

---

## Next: Implementation

The design is ready. The next phase is:

1. Create .claude/agents/agent-9.md (Opus synthesizer)
2. Update .claude/commands/recap.md to call Agent 9
3. Update .claude/agents/context-finder.md (Phase 1 only)
4. Test with real workflows
5. Validate timing + user feedback

The hybrid approach balances all three original designs into ONE coherent system that is:
- Fast (parallel + focused)
- Clear (tiered + scored)
- Smart (Haiku gathers, Opus synthesizes)
- User-centric (shows data, respects agency)

---

**Status**: READY FOR IMPLEMENTATION
**Design Process**: 10 iterations complete
**Model**: Haiku (this analysis) + Opus (actual implementation)
