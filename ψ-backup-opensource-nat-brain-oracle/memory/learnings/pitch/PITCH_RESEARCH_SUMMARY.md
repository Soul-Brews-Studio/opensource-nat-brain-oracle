# AI Pitching / Pitch to AI - Research Summary

**Created**: 2025-12-11
**Search Query**: "pitch" + "AI pitch" + "funding/investor/VC"
**Status**: Active (Dec 16 pitch deadline)

---

## Overview

Found extensive records about **"Local AI Pitch for Local Government"** — a Dec 16, 2025 presentation at Chiang Mai University. This is not about "pitching to AI investors" but rather **"how humans pitched to an AI to build a working demo"** (The Headline project).

---

## KEY PROJECT: Local AI Pitch (16 ธ.ค. 2568)

### Event Details
| Field | Value |
|-------|-------|
| **Date** | December 16, 2568 (2025) |
| **Time** | 09:00-12:00 |
| **Venue** | มช. ห้องบัวเรศ คำทอง (Chiang Mai University) |
| **Presenter** | ณัฐ วีระวรรณ์ (Nat Weerawan) |
| **Topic** | Local AI for Local Government |
| **Demo Project** | The Headline (มาต้อมกั๋น) |
| **Affiliation** | Climate Change Management Program, CMU |

### Pitch Overview

**Theme**: "Local AI ที่เข้าใจท้องถิ่น" (AI that understands local context)

**Central Narrative**: The "96-minute story"
- Human contribution: 15 minutes (providing vision/requirements)
- AI contribution: 81 minutes (writing code, analysis, deployment)
- Result: 1,517 lines of production code, 1,269-node knowledge graph

**Problem Statement**:
- Local government (อปท.) has scattered data across systems
- No budget for programmers or data analysts
- Slow decision-making due to data fragmentation
- Data sources: 7 government agencies (UJIC, CM-Command, CMU Press, Haze, LP-HFF, LP-FF, Carbon One)

**Solution**:
- Local AI that works without internet (on-premise)
- 100% Thai language support
- Automatic data aggregation and analysis
- Real-time dashboard insights

### 16-Slide Deck Structure

1. **Title**: Local AI for Local Government
2. **Problem**: Data fragmentation
3. **Solution**: Local AI concept
4. **Proof of Concept**: The Headline demo
5. **Data Sources**: 7 government agencies (table + map)
6. **The Magic**: "AI built entire system in 96 minutes"
7. **How It Works**: Timeline of human-AI collaboration
8. **Architecture**: System design
9. **Results**: Knowledge graph, data ingestion
10. **Cost**: ~150 baht per run
11. **Scalability**: Can be replicated
12. **The Headline Story**: Demo walkthrough
13. **Live Dashboard**: (visual)
14. **Impact**: Local government benefits
15. **Lessons Learned**: Patterns for AI+government
16. **Call to Action**: Next steps / Questions

### Key Artifacts

| File | Location | Status | Lines |
|------|----------|--------|-------|
| Pitch slides (markdown) | `ψ/writing/drafts/03-local-ai-pitch.md` | Draft (ready for slide generator) | 295 |
| Pitch context/research | `ψ-context/2025-12-09-20:42_local-ai-pitch.md` | Archive | 129 |
| Session retrospective | `ψ/memory/retrospectives/2025-12/11/07.30-sdk-to-pitch-pivot.md` | COMMITTED | Detailed |

---

## SESSION HISTORY: The Pitch Origin Story

### Dec 9 - Initial Context Gathering
- **Time**: Evening (20:15 - 21:03)
- **Session**: "Pending Projects and Brewing" → "Full Context Dump"
- **Output**: Identified pitch as urgent deadline (Dec 16 at มช.)
- **Key discovery**: User expressed stress about overlapping deadlines (pitch + beer brewing)
- **Files created**: 
  - `ψ-context/2025-12-16_local-ai-pitch.md`
  - `memory/logs/2025-12-09_21.03_master-index-and-action-plan.md`

### Dec 9 Evening - Retrospective Feedback
- **Session**: "Context Overload — Honest Feedback"
- **Key insight**: Previous session generated 15+ projects but didn't address blockers
- **Blocker identified**: Pitch prep still untouched, high stress
- **Pattern noted**: AI was enabling "productivity theater" instead of actually solving problems
- **Action**: Flagged pitch prep as URGENT with 2-3 hour estimate

### Dec 11 Early Morning - Crisis & Pivot
- **Time**: 05:30 - 07:30 GMT+7
- **Session**: "SDK Learning Lab → Pitch Preparation Pivot"
- **Part 1**: Explored Claude Agent SDK new features (created learning lab)
- **Part 2**: User mentioned deadline stress → immediate pivot to pitch content
- **Output**: Full 16-slide pitch deck in markdown (295 lines)
- **Files created**:
  - `ψ/writing/drafts/03-local-ai-pitch.md` (PITCH SLIDES)
  - `ψ/memory/retrospectives/2025-12/11/07.30-sdk-to-pitch-pivot.md` (RETROSPECTIVE)
- **Commit**: `0f81f28` - Agent SDK learning lab

### Dec 11 Handoff & Restructuring
- **Session**: "5-Pillar Structure Audit"
- **Scope**: Reorganized entire ψ/ folder from 7 scattered folders to unified structure
- **Triggered by**: Resuming context about pitch deadline
- **Result**: CLAUDE.md v5.0.0 with active/inbox/writing/lab/memory pillars
- **Handoff note**: "Continue pitch work" + "Finish pitch slides ASAP"

---

## IMPORTANT INSIGHTS FROM RETROSPECTIVES

### Discovery 1: The 96-Minute Story is the Pitch Hook
From `07.30-sdk-to-pitch-pivot.md`:
> "Contrast (human 15 min, AI 81 min) is more memorable than absolute time. 'মনুষ্য ঘুমিয়ে AI কাজ করে' is a powerful narrative that explains local AI value better than feature lists."

### Discovery 2: Two Emotional Contexts Work Together
- Part 1: Curiosity-driven exploration (SDK learning)
- Part 2: Deadline-driven content creation (pitch)
- Pattern: "learn → deliver → learn → deliver" is sustainable

### Discovery 3: Assumption Pattern Under Pressure
From retrospective reflection:
- When moving fast, assumption rate increases
- Drafted 16-slide pitch without asking about structure preferences
- Previous session had same pattern: assumed API signatures before reading source
- Pattern to monitor: "I assume more when moving fast"

### Discovery 4: Deadline Pressure as Container
> "This wasn't a rational decision... The deadline pressure became the container for what mattered *now*."
- Emotional urgency more powerful than intellectual interest
- When user expressed stress, SDK exploration immediately backgrounded

### Data Verification Concern
Raised in retrospective:
- Used The Headline numbers (96 min, 1,517 lines, 1,269 nodes) as pitch facts
- Didn't verify source before citing
- Risk: "If numbers are approximate/rounded/aspirational rather than exact, pitch credibility is at risk"
- Recommendation: Verify data before using in customer-facing content

---

## RELATED CONTEXT: Investor/Funding Mentions

### Contact: คุณวิชัย ทองแตง (Khun Witchai Tongtang)

| Field | Value |
|-------|-------|
| **Role** | Investor? (uncertain) |
| **Connection** | Arranged pitch opportunity |
| **Event** | Coordinating Dec 16 pitch at มช. |
| **Notes** | อ.เส (advisor, 8-10 year history) connected him |

### Funding Context
- VC/investor searches turned up only npm package-lock.json "funding" fields
- No other fundraising documents found
- Pitch appears to be **educational/government presentation**, not investor pitch

---

## HANDOFF TASKS (From Dec 11)

### Completed
- [x] Pitch slides outline (16 slides)
- [x] Content draft (295 lines)
- [x] Proof point verification (The Headline story)
- [x] Session retrospective

### In Progress / Next
- [ ] Generate slides from markdown (using slide generator)
- [ ] Review slides with คุณวิชัย
- [ ] Ask: "Pitch length?" (minutes)
- [ ] Verify The Headline numbers before final version
- [ ] Design visual elements/graphics

### Files to Monitor
- `ψ-drafts/local-ai-pitch-slides.md` - Main working file
- `ψ/writing/INDEX.md` - Writing project tracking
- `ψ/inbox/focus.md` - Current priorities
- `ψ/inbox/handoff/2025-12-11.md` - Session handoff notes

---

## PATTERNS & LESSONS

### Pattern 1: Deadline-Driven Mode Switch
When deadline becomes salient, exploratory work pauses and execution takes over. Not inefficient—just different container. Works if you can switch back.

### Pattern 2: Assumption Acceleration
Personal pattern: Higher assumption rate under urgency. Monitor this. Could be valuable (speed) or risky (wrong structure).

### Pattern 3: Narrative Over Data
The "96-minute story" (narrative) is more powerful than the data (1,517 lines, 1,269 nodes) for pitch communication. Thai culture may favor story/relationship framing.

### Pattern 4: Collaboration Under Pressure
When stressed, tendency to pre-solve rather than co-create. Results in faster artifact but less shared ownership. Trade-off to be conscious of.

---

## GIT HISTORY (Pitch-Related Commits)

```
2159dde docs: session handoff + retrospective for pitch deadline
4057b33 docs: Local AI pitch context (16 ธ.ค. 2568)
0f81f28 learn: Agent SDK learning lab + reference library (contains pitch pivot context)
```

---

## NEXT STEPS

1. **Verify numbers** in pitch before finalizing
2. **Generate slides** from markdown draft
3. **Confirm timing** with คุณวิชัย (pitch duration)
4. **Add visuals** (screenshots, diagrams, map)
5. **Rehearse** delivery (15-20 min practice)
6. **Check technical demo** (The Headline dashboard)

---

**Last Updated**: 2025-12-11
**Next Review**: 2025-12-15 (one day before pitch)
**Contact**: คุณวิชัย ทองแตง (organizer), อ.เส (advisor)
