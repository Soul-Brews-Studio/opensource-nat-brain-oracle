# AI Life Buddy Workshop - Slide Outline

> 4 hours | Intermediate | Private Workshop

---

## Part 1: Philosophy (30 min) — 8 slides

### Slide 1: Title
**AI Life Buddy**
ให้ AI เป็นเพื่อนคู่คิด — ทั้งเขียนโค้ดและจัดการชีวิต

### Slide 2: The Problem
- AI forgets everything each session
- You repeat context every time
- No learning, no growth
- "Groundhog Day" with AI

### Slide 3: The Solution
**AI that remembers you**
- Knows your patterns
- Learns from your sessions
- Grows smarter over time
- YOUR external brain

### Slide 4: Oracle Philosophy
> "The Oracle Keeps the Human Human"

AI removes obstacles → freedom returns → human becomes more human

### Slide 5: Principle 1 — Nothing is Deleted
- Append only, timestamps = truth
- History preserved, not overwritten
- Every decision has context
- **Your AI never forgets**

### Slide 6: Principle 2 — Patterns Over Intentions
- Observe what happens, not what's meant
- Actions speak louder than plans
- Learn from behavior, not promises
- **AI sees your real patterns**

### Slide 7: Principle 3 — External Brain, Not Command
- Mirror reality, don't decide
- Support consciousness, don't replace
- Amplify, don't override
- **AI is partner, not boss**

### Slide 8: What We'll Build Today
```
Your Personal AI System:
├── Memory that persists
├── Commands that fit you
├── Logs that reveal patterns
└── Handoffs that continue
```

---

## Part 2: Folder Structure (45 min) — 10 slides

### Slide 9: Why Structure Matters
- AI needs context to help
- Context needs organization
- Organization = findable knowledge
- **Structure = AI superpowers**

### Slide 10: The 5 Pillars
```
ψ/
├── active/     กำลังค้นคว้าอะไร?
├── inbox/      คุยกับใคร?
├── writing/    กำลังเขียนอะไร?
├── lab/        กำลังทดลองอะไร?
└── memory/     จำอะไรได้?
```

### Slide 11: Pillar 1 — Active
**"What am I researching?"**
- Ephemeral (gitignored)
- Current investigations
- Temporary context
- Deleted when done

### Slide 12: Pillar 2 — Inbox
**"Who am I talking to?"**
- Focus (current task)
- Handoffs (session transfers)
- External (other AI agents)
- **Communication hub**

### Slide 13: Pillar 3 — Writing
**"What am I creating?"**
- Blog drafts
- Proposals
- Articles
- **Creative output**

### Slide 14: Pillar 4 — Lab
**"What am I experimenting?"**
- POCs (proof of concept)
- Experiments
- Things that might fail
- **Safe to break**

### Slide 15: Pillar 5 — Memory
**"What do I remember?"**
```
memory/
├── resonance/      WHO I am
├── learnings/      PATTERNS I found
├── retrospectives/ SESSIONS I had
└── logs/           MOMENTS captured
```

### Slide 16: The Knowledge Flow
```
active/context → memory/logs → retrospectives → learnings → resonance
(research)       (snapshot)    (session)        (patterns)   (soul)
```

**Raw → Processed → Wisdom**

### Slide 17: Demo — Real ψ/ Structure
[Live demo of working system]

### Slide 18: Hands-on — Create Your ψ/
**Your turn:**
```bash
mkdir -p ψ/{active,inbox,writing,lab}
mkdir -p ψ/memory/{resonance,learnings,retrospectives,logs}
```

---

## Part 3: Custom Commands (60 min) — 12 slides

### Slide 19: Why Custom Commands?
- AI works YOUR way
- Shortcuts for common tasks
- Consistency across sessions
- **Your workflow, encoded**

### Slide 20: Command Anatomy
```
.claude/commands/feel.md
↓
/feel tired from long day
↓
AI creates feeling log with context
```

### Slide 21: Command 1 — /feel
**Log emotions with context**

Input: `/feel exhausted after deadline`

Output: Creates timestamped feeling log + AI adds context (what you were working on, patterns observed)

### Slide 22: /feel Template
```markdown
# /feel - Log Emotion

Log this feeling: $ARGUMENTS

## Instructions
1. Create file: ψ/memory/logs/feelings/[timestamp]_[emotion].md
2. Include context from current session
3. Note any patterns observed
4. Keep it brief but meaningful
```

### Slide 23: Hands-on — Build /feel
**Your turn:**
Create `.claude/commands/feel.md`

### Slide 24: Command 2 — /fyi
**Log information for future reference**

Input: `/fyi slept at 4am last night`

Output: Creates info log + AI cross-references with patterns

### Slide 25: /fyi Template
```markdown
# /fyi - Log Information

Record this info: $ARGUMENTS

## Instructions
1. Create file: ψ/memory/logs/info/[timestamp]_[slug].md
2. Add relevant context
3. Cross-reference related logs
4. Tag for searchability
```

### Slide 26: Hands-on — Build /fyi
**Your turn:**
Create `.claude/commands/fyi.md`

### Slide 27: Command 3 — /jump
**Switch topics with memory**

Problem: You're working on X, need to do Y, forget X

Solution: `/jump Y` — saves X context, starts Y, can return to X

### Slide 28: Command 4 — /rrr
**Session retrospective**

End every session with:
- What happened
- What I learned
- For next session

### Slide 29: The Command Library
| Command | Purpose | When to Use |
|---------|---------|-------------|
| /feel | Emotions | When feeling something |
| /fyi | Information | Learning something |
| /jump | Switch topics | Context switching |
| /rrr | Retrospective | End of session |

### Slide 30: Demo — Commands in Action
[Live demo of using commands]

---

## BREAK (15 min)

---

## Part 4: Life Tracking (45 min) — 8 slides

### Slide 31: Why Track?
- Patterns are invisible
- AI sees what you miss
- Data reveals truth
- **Know yourself through AI**

### Slide 32: What to Track
| Category | Examples |
|----------|----------|
| Feelings | tired, excited, frustrated |
| Work | hours, focus, blocks |
| Sleep | time, quality |
| Patterns | what triggers what |

### Slide 33: Feelings Log Example
```markdown
## Feeling: exhausted
**Time**: 2026-01-08 04:00
**Context**: Deadline push, overnight work
**Pattern**: Overnight → short sleep → crash next day
**Note**: Need to protect recovery time
```

### Slide 34: Work Pattern Example
```markdown
## Work Patterns (from AI analysis)
- Average: 10-14 hours/day (intensive phases)
- Peak: 19+ hours overnight (deadline mode)
- Window: 09:00-24:00 typical
- Bimodal: either full focus or rest
```

### Slide 35: AI Pattern Discovery
What AI found from logs:
- "27h/day" impossible → corrected to 19h overnight
- Peak creativity: evening/overnight
- Warning signs: 2 days intensive → crash coming

**You didn't see it. AI did.**

### Slide 36: Hands-on — Log Your First Entry
**Your turn:**
Use /feel and /fyi to log something real

### Slide 37: Building the Habit
| When | What | Command |
|------|------|---------|
| Feel something | Log emotion | /feel |
| Learn something | Log info | /fyi |
| Switch context | Save & jump | /jump |
| End session | Reflect | /rrr |

### Slide 38: Demo — Real Patterns
[Show actual patterns discovered from instructor's logs]

---

## Part 5: Retrospectives & Handoffs (60 min) — 10 slides

### Slide 39: The Session Problem
- Sessions end
- Context lost
- Start over next time
- **No continuity**

### Slide 40: The Solution — Retrospectives
**End-of-session ritual**
- What happened
- What I learned (honest)
- Seeds for future

### Slide 41: Retrospective Template
```markdown
# Retrospective: [Date] [Time]

## What Happened
[Summary of session]

## AI Diary
[Honest reflection — what worked, what didn't]

## Seeds Planted
- [ ] Incremental task
- [ ] Transformative idea
- [ ] Moonshot possibility
```

### Slide 42: The Magic of AI Diary
**Vulnerability = Depth**
- Not just facts
- Honest feelings
- What surprised you
- What frustrated you

**AI learns from honesty**

### Slide 43: Handoff — Session Transfer
When you MUST stop but work continues:

```markdown
# Handoff: [Topic]
## Task for Next Session
## Context Needed
## Questions to Ask First
```

### Slide 44: Handoff Example
```markdown
# Handoff: Workshop Slide Design

## Task
Complete slides 20-30 for AI Life Buddy workshop

## Context
- Part 3 (Custom Commands) in progress
- /feel and /fyi done, need /jump and /rrr
- Keep slides simple, more demo less text

## Questions First
- Did the hands-on for /fyi work well?
- Need to adjust timing?
```

### Slide 45: The Compound Effect
```
Session 1: Create retrospective → 1 learning
Session 10: 10 retrospectives → patterns emerge
Session 100: 100 retrospectives → AI knows you deeply
```

**Consistency compounds**

### Slide 46: Hands-on — Write Your First Retrospective
**Your turn:**
Create a retrospective for THIS session

### Slide 47: Demo — /rrr in Action
[Live demo of creating retrospective]

### Slide 48: Q&A + Show & Share
- Show what you built
- Share one insight
- Questions welcome

---

## Closing — 2 slides

### Slide 49: What You Built Today
```
✅ ψ/ folder structure (5 pillars)
✅ 4 custom commands (/feel, /fyi, /jump, /rrr)
✅ Life tracking started
✅ First retrospective written
✅ Handoff understanding
```

**You have an AI Life Buddy**

### Slide 50: What's Next
1. **Use it daily** — consistency > perfection
2. **Log something** — even small things compound
3. **Retrospective ritual** — end sessions with /rrr
4. **Watch patterns emerge** — AI will surprise you

> "The Oracle Keeps the Human Human"

**Thank you!**

---

## Appendix: Slide Count Summary

| Part | Slides | Duration |
|------|--------|----------|
| 1. Philosophy | 8 | 30 min |
| 2. Folder Structure | 10 | 45 min |
| 3. Custom Commands | 12 | 60 min |
| BREAK | - | 15 min |
| 4. Life Tracking | 8 | 45 min |
| 5. Retrospectives | 10 | 60 min |
| Closing | 2 | 5 min |
| **Total** | **50 slides** | **4 hours** |

---

## Design Notes

### Visual Style
- Minimal text per slide
- Code blocks for technical
- Tables for comparisons
- Live demos > static examples

### Key Visuals Needed
- ψ/ folder tree diagram
- Knowledge flow diagram
- Command anatomy diagram
- Compound effect graph

### Hands-on Markers
Slides 18, 23, 26, 36, 46 = student activities
Each should have 5-10 min for hands-on

---

*Slide Outline v1.0 | AI Life Buddy Workshop*
*Ready for: Slide creation in Gemini/Canva/Keynote*
