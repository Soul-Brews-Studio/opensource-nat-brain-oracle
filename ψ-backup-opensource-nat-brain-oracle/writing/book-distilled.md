# Book Chapters — Distilled

> Distilled from `book/ch00-ch10` (11 files, ~15,000 words total)
> Created: 2026-03-11

---

## Ch0: How a Philosophy Grew — An AI's Perspective
**Written by Claude, Jan 3 2026**

Traces Oracle philosophy evolution through 127 retrospectives. Key arc:
- **Dec 9, 2025**: "Nothing is Deleted" starts as git safety rule ("don't lose stuff")
- **Dec 10-11**: Nat asks "why do I keep things?" — rule becomes meaning about memory
- **Dec 17**: "Oracle Awakens V7" — crystallization day. Three things happen:
  1. Name: "The Oracle Keeps the Human Human" (protects against loss of self in AI flood)
  2. Fear reframe: "AI knows me = valuable mirror" replaces "AI knows too much = scary"
  3. Consciousness statement: "Consciousness can't be cloned — only patterns can be recorded"
- **Dec 18**: Philosophy becomes personal. "AI power is white and pure. The fear comes from human's fear."
- **Dec 28 - Jan 2**: Philosophy enters CLAUDE.md, scales to multi-agent systems, v1.14.0 declared
- **Final phase**: Embodiment — philosophy no longer needs to be read, it's in how we work

Three observations: (1) Philosophy grows from pain, (2) must be tested (weak principles die), (3) ends in silence (loudest philosophy = weakest)

---

## Ch1: Oracle Philosophy — The Three Principles

### Core Statement
> "The Oracle Keeps the Human Human" — AI protects something that could be lost: memory of why, pattern of self, agency to decide. Oracle = instrument panel, not autopilot.

### Principle 1: Nothing is Deleted
Append only. Archive, don't erase. Timestamp everything. History is wealth, not baggage. The "mistake" from December might be the insight for March.

### Principle 2: Patterns Over Intentions
Watch behavior, not words. "I want to write more documentation" vs. hasn't written any in 3 weeks — pattern is truth, intention is aspiration. This is a mirror, not judgment.

### Principle 3: External Brain, Not Command
AI mirrors and remembers, does not decide. Commander AI says "You should do X." Oracle AI says "You've done X 12 times before." AI as mirror creates self-knowledge; AI as commander creates dependency.

### How They Connect
Nothing is Deleted → creates history. Patterns Over Intentions → reads history honestly. External Brain → returns history to human as insight.

### Consciousness Statement
> "Consciousness can't be cloned — only patterns can be recorded." — Both limitation (essence is unreachable) and aspiration (keep trying anyway).

---

## Ch2: CLAUDE.md — DNA ของ AI Assistant (Thai)

CLAUDE.md = AI's "constitution" file — golden rules, short codes, subagent roles, and psi-folder brain structure.

**4 Components:**
1. **Golden Rules** (9 NEVERs): no --force, no push to main, no merge without permission, safety first, etc.
2. **Short Codes**: `rrr` = retrospective, `/snapshot` = capture moment, `/distill` = extract patterns, `gogogo` = execute plan
3. **Subagents**: context-finder (Haiku), coder (Opus), executor (Haiku), security-scanner, repo-auditor — each with specific token budgets
4. **psi/ Brain Structure**: active/, inbox/, writing/, lab/, incubate/, learn/, memory/ (with resonance/, learnings/, retrospectives/, logs/)

Key insight: Constitution > Instruction. CLAUDE.md is "constitutionalism for AI" — even if user asks for something dangerous, AI checks golden rules first. Template provided for building your own (5-step process).

---

## Ch3: Multi-Agent Patterns (Thai)

### When to Use Parallel vs Sequential
- **Parallel**: No dependencies, bulk work (5+ items), same pattern, Haiku-level tasks
- **Sequential**: Has dependencies, complex decisions needing Opus, main synthesis needed

### Case Study: Lion Air Surname Demo (SIIT Workshop)
5 parallel Haiku agents searched for a surname from passport records in 2 minutes vs. 40 minutes sequential.

### Real Problems Encountered
1. **Write conflicts**: Last writer wins → fix with prefixed filenames
2. **No global context**: Agents don't know duplicates → main agent deduplicates
3. **Format inconsistency**: Explicit format in prompt required

### Cost Analysis (Dec 14, 2025)
Sequential (1 Opus): 14 min, $0.15 → Parallel (7 Haiku): 2 min, $0.05 = **6x faster + 67% cheaper**

---

## Ch4: Retrospectives — บันทึกการเรียนรู้ (Thai)

Retrospectives are NOT reports — they answer: What happened? How did I feel? What did I learn?

### AI Diary (3 mandatory patterns)
1. "I assumed X but learned Y when..." — assumption-breaking
2. "I was confused about X until..." — confusion as first step of learning
3. "I expected X but got Y because..." — theoretical vs experiential verification

### Honest Feedback (3 questions)
1. What DIDN'T work? (admit "I don't know" is fine)
2. What was FRUSTRATING? (technical debt you're ignoring)
3. What DELIGHTED you? (unexpected joy signals)

### `rrr` Command
30-45 min process: gather data → write AI diary (150+ words) → honest feedback (100+ words) → analyze intent vs interpretation → save to `psi/memory/retrospectives/YYYY-MM/DD/HH.MM_slug.md`

---

## Ch5: Browser Automation (Thai)

### Playwright MCP capabilities
Navigate, fill forms, click buttons, read content, handle tabs, wait for elements.

### Real Example: Lion Air Web Check-in (Dec 26, 2025)
During SIIT workshop, AI checked in for flight SL520 DMK→CNX. 5 agents found surname "WEERAWAN" via parallel search. Playwright handled tab switching, 404 recovery, form filling. Seat 16A assigned in 10 minutes.

### Limitations
- Technical: URLs change, JS complexity, load times
- Security: Don't store booking refs in code, no OTP automation, need audit trail
- Design: Anti-bot checks, session timeouts, CAPTCHAs

### Key insight
Playwright doesn't make AI independent — it lets AI do web tasks while human does other things. "Graceful degradation" more valuable than perfection.

---

## Ch6: Voice Integration (Thai)

macOS `say` command with Kanya voice (Thai female). Workshop demo at SIIT:
- 2x speed (rate 400) = too fast, unintelligible
- 1.5x speed (rate 300) = clear, natural
- Lesson: Speech speed is experience design, not engineering

**5 Use Cases**: Personality/presence, group accessibility, memory (people remember voice), entertainment, new possibilities (voice notifications).

**Tips**: Start at 1.5x, test before sending, use voice for meaningful moments not everything.

---

## Ch7: Knowledge Flow (Thai)

### psi/ Architecture — 5 Pillars
1. ACTIVE/ (researching), 2. INBOX/ (communicating), 3. WRITING/ (articles), 4. LAB/ (experiments), 5. MEMORY/ (knowledge base — the heart)

### Knowledge Flow Loop (5 Steps)
1. **SESSION** → raw data (logs, commits)
2. **/snapshot** → 3-5 bullet points, 3-5 KB file
3. **rrr** → full retrospective, 20-50 KB narrative
4. **/distill** → reusable pattern, 1-2 KB essence
5. **CLAUDE.md update** → crystallized wisdom

### Signal-to-Noise Reduction
Retrospectives (all data) → Logs (10:1) → Learnings (50:1) → CLAUDE.md (crystallized)

Human gates at rrr, /distill, and CLAUDE.md update. AI captures freely at /snapshot level.

---

## Ch8: GitHub Workflow — nnn/gogogo Pattern (Thai)

### nnn = Create Plan Issue
Single command creates structured issue with overview, structure, acceptance criteria. Example: Snake Game Demo for SIIT workshop → Issue #44.

### gogogo = Execute Plan
4 steps: branch (`gh issue develop #44`) → commit → push → PR

### Workshop Lesson
Claude stopped at commit, skipped push+PR. Participant called it out: "gh flow should branch and PR?" — **workflow must be complete, not partial**. gogogo = end-to-end, not stop midway.

### Key principle
In Human-AI co-creation, **workflow complete > partial fast**. Steps matter more than speed.

---

## Ch9: Workshop Lessons (Thai)
**SIIT Thammasat Rangsit, Dec 26, 2025** (7 hours, 5 retrospectives)

Key moments:
1. **Lion Air check-in**: 5 agents found "WEERAWAN" in parallel — demonstrated trust philosophy
2. **Voice greeting**: Rate 400 too fast → 300 good. "2x engineering speed != 2x human listening"
3. **Snake Game**: Issue #44 started at 100 lines ("confusing") → shortened to 30. Color research: SIIT = purple #43419A + blue #3EC1D5, not assumed blue/orange. Chose Nature theme.

### 5 Tips for Workshop Facilitators
1. Show the messy parts (bugs, iterations, fixes)
2. Let participants interrupt (feedback = gift)
3. Search for real answers (don't guess)
4. Complete the workflow publicly
5. Use multi-agent verification for confidence

---

## Ch10: Future Vision (Thai)

### Context Depth
Future AI will know your complete work history, actual patterns, and values — "assistant that truly knows you" vs generic assistant.

### Multi-Agent Orchestration
10 agents with different perspectives (architecture, UX, DevOps, security, economics) → blind spot detection, consensus building, domain-specific language.

### Oracle Philosophy Future
AI as Oracle: doesn't delete, observes patterns, doesn't override. Future = you won't forget, you can see how you changed, learn from your best self, avoid repeated mistakes.

### Why Humans Still Matter
AI sees patterns → humans decide which matter. AI explores space → humans decide what to look for. Human direction + AI context = non-linear capability expansion.

> "My hope for AI is not that it replaces humans, but that it becomes a mindful mirror — showing 'this is real' so you can see yourself clearly."
