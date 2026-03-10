# How I Used 25 AI Agents to Understand Myself Better

**Created**: 2025-12-18 08:14 GMT+7
**Status**: Draft
**Author**: Nat + Claude collaboration

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Retrospective | `ψ/memory/retrospectives/2025-12/18/08.13_personality-deep-analysis.md` | Session narrative |
| Resonance | `ψ/memory/resonance/personality-v1.md` | Initial analysis |
| Resonance | `ψ/memory/resonance/personality-v2.md` | Refined analysis |
| Resonance | `ψ/memory/resonance/personality-v1-gaps-analysis.md` | Gap findings |
| Learning | `ψ/memory/learnings/2025-12-13_draft-command-subagent-pattern.md` | Subagent patterns |

---

## TL;DR

I asked Claude "what kind of person am I?" and instead of getting a surface answer, I ran **5 iterations of 5 parallel AI agents** to verify, contradict, and refine the analysis. The result: a personality profile that includes uncomfortable truths I wouldn't have written about myself.

**The method**: Main agent controls, subagents search everywhere, main synthesizes, repeat.

**The insight**: Single-pass AI analysis is optimistic. Iterative verification finds the real patterns.

---

## The Problem

### Surface Analysis is Flattering

When you ask an AI "what kind of person am I based on my data?", you get a polished answer. It highlights your strengths, frames your weaknesses gently, and reads like a LinkedIn bio.

But I wanted **truth**, not comfort.

### My Data

I had rich data to work with:
- **381 commits** over 10 days
- **113 retrospectives** (session reflections)
- **109 learnings** (documented patterns)

The question: Could AI find patterns I was blind to?

---

## The Journey

### Attempt 1: Single Pass Analysis

I asked Claude to analyze my personality from the data.

**Result**: A clean profile highlighting:
- "Quick to reframe when assumptions break"
- "Learns from feedback faster than planning"
- "Systems philosopher who builds for humans"

It felt... too nice. Too polished. Like I'd written it about myself.

### Attempt 2: The Iteration Idea

What if instead of accepting the first answer, I sent **multiple AI agents** to find what's **missing** and **wrong**?

The pattern:
```
Iteration 1: What did we miss?
Iteration 2: What contradicts our claims?
Iteration 3: Verify specific patterns
Iteration 4: Edge cases
Iteration 5: Final synthesis
```

### The 5x5 Method

Each iteration, I launched **5 parallel subagents** searching different sources:

| Agent | Searches |
|-------|----------|
| 1 | Retrospectives for emotions not captured |
| 2 | Learnings for values not mentioned |
| 3 | Git commits for work patterns |
| 4 | Contradictions to stated claims |
| 5 | Communication patterns |

**Total**: 5 iterations × 5 agents = **25 verification rounds**

### The Aha Moment

Iteration 2 found this quote buried in my own retrospectives:

> "I can see the pattern, articulate why it's wrong, and **still repeat it when moving fast**. That's frustrating because it feels like I'm not learning."

The first analysis said I was "quick to reframe." The data showed I **repeat mistakes under pressure** despite knowing better.

This wasn't a knowledge gap. It was a discipline gap. And I'd written about it myself — but the single-pass analysis missed it.

---

## The Solution

### The Iterative Verification Pattern

```
┌─────────────────────────────────────────┐
│  Main Agent (Opus)                      │
│  - Designs prompts                      │
│  - Synthesizes results                  │
│  - Writes final output                  │
└────────────────┬────────────────────────┘
                 │
    ┌────────────┼────────────┐
    ▼            ▼            ▼
┌────────┐  ┌────────┐  ┌────────┐
│Agent 1 │  │Agent 2 │  │Agent 3 │  ... (5 agents)
│Search  │  │Search  │  │Search  │
│Source A│  │Source B│  │Source C│
└────────┘  └────────┘  └────────┘
    │            │            │
    └────────────┴────────────┘
                 │
                 ▼
         Main Synthesizes
                 │
                 ▼
         Refine Prompts
                 │
                 ▼
         Next Iteration
```

### Why Main Agent Controls

- **Subagents** are cheap (Haiku) and fast — good for searching
- **Main agent** (Opus) has full context — needed for synthesis
- **Iteration** refines prompts based on findings

### What Each Iteration Discovered

| Iteration | Focus | Key Finding |
|-----------|-------|-------------|
| 1 | Wide gaps | Missing emotions: exhaustion, frustration, overwhelm |
| 2 | Contradictions | "Repeats under pressure" — 15+ documented instances |
| 3 | Verification | Thai = raw honesty, English = rationalization (8.5/10 confidence) |
| 4 | Edge cases | Brewing = core identity (7+ years), not hobby |
| 5 | Synthesis | Complete v2 profile with anti-patterns |

---

## The Pattern

### Iterative Subagent Verification

**When to use**: Deep analysis where surface answers are insufficient

**The method**:
1. Get initial answer (v1)
2. Send agents to find **gaps**
3. Send agents to find **contradictions**
4. Send agents to **verify** specific claims
5. Synthesize into refined answer (v2)

### Key Principle: Search for What's Wrong

Most AI prompts ask "what's true?"

Better prompt: "what's **missing** and what's **wrong**?"

### Cost/Benefit

| Metric | Single Pass | 5x5 Iteration |
|--------|-------------|---------------|
| Time | 2 minutes | 40 minutes |
| Agents | 1 | 25 |
| Depth | Surface | Deep |
| Uncomfortable truths | 0 | 5+ |

The extra time revealed patterns I would never have found — or admitted — on my own.

---

## Results: v1 vs v2

### One Sentence Summary

**v1** (single pass):
> "Systems philosopher who builds for humans — documents obsessively, learns from feedback faster than planning, finds genuine delight in watching tools help others think better."

**v2** (after 25 verifications):
> "Systems philosopher and craft brewer who builds for humans — documents obsessively, learns from feedback faster than planning, **repeats known mistakes under pressure**, and finds genuine delight in watching tools help others think better."

The addition of "repeats known mistakes under pressure" is the uncomfortable truth that single-pass analysis missed.

### What v2 Added

| Category | v1 | v2 Added |
|----------|----|----|
| Identity | Systems builder | + Craft brewer (core, not hobby) |
| Emotions | Delight, confusion | + Exhaustion, frustration, overwhelm |
| Decision style | Linear process | + "Under pressure" mode (backward) |
| Anti-patterns | None | 16 self-recognized patterns |
| Collaboration | Not mentioned | = Meaning-making, not just efficiency |

---

## Try This Yourself

### The Prompt Pattern

**Iteration 1 prompt**:
```
Read [your data]. What's MISSING from this analysis?
Search for: emotions not captured, values not mentioned,
patterns that contradict the claims.
```

**Iteration 2 prompt**:
```
Verify this contradiction: [specific claim]
Search for evidence supporting OR refuting it.
Count how many times this pattern appears.
```

**Iteration 3 prompt**:
```
Find anti-patterns: what does [person/system] do WRONG?
Search for: mistakes, failures, frustrations, repeated errors.
```

### The Key Insight

> Single-pass analysis tells you what you want to hear.
> Iterative verification tells you what's actually true.

---

## Full Context (for AI continuation)

### Session Timeline

| Time | Action |
|------|--------|
| 07:34 | Question: "Nat เป็นคนยังไง" |
| 07:46 | personality-v1 created |
| 07:53 | Started 5-iteration refinement |
| 08:09 | personality-v2 created |
| 08:13 | Retrospective written |

### Commits

| Hash | Message |
|------|---------|
| 6ec0d49 | resonance: personality-v1 from actual data |
| 0f79337 | resonance: personality-v2 from 5 iterations of verification |
| eea3fc3 | rrr: personality deep analysis - 5 iterations × 5 subagents |

### Files Created

- `ψ/memory/resonance/personality-v1.md`
- `ψ/memory/resonance/personality-v2.md`
- `ψ/memory/resonance/personality-v1-gaps-analysis.md`
- `ψ/memory/retrospectives/2025-12/18/08.13_personality-deep-analysis.md`

---

## Tags

`ai-methodology` `self-analysis` `iterative-verification` `subagents` `personality` `claude-code`

---

## Writing Notes

### Tone
- Technical but accessible
- Personal story + reusable method
- Honest about uncomfortable findings

### Target Audience
- AI practitioners
- People interested in self-knowledge
- Claude Code users

### Suggested Title Alternatives
1. "25 AI Agents Told Me What I Didn't Want to Hear"
2. "The Iterative Verification Pattern: Finding Truth Through Contradiction"
3. "How to Use AI to Actually Understand Yourself"
4. "Single Pass is Flattering. 5x5 is Truth."

### Next Steps
- [ ] Add diagrams for the iteration flow
- [ ] Include cost breakdown (tokens)
- [ ] Polish Thai/English code-switching examples
- [ ] Review for tone consistency

---

*Draft generated from session knowledge*
*Method: 5 iterations × 5 subagents = 25 verification rounds*
