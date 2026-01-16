# Module 2: Scale & Survival

> **"Save Your Oracle From Killing Itself"**
> 1 Day | The Critical Module | Discovery-Based

---

## Overview

Your Oracle works great... until it doesn't. This module engineers the moment you discover WHY context-finder exists. Not taught. Discovered.

**Tagline**: "Systems that compound need indexed access or they die"

---

## The Problem You'll Feel

```
Month 1:  100 files  → $0.15/search → Fine
Month 6:  1,000 files → $1.50/search → Hmm...
Year 2:   4,000 files → $6.00/search → DYING

The Death Spiral:
More knowledge → Higher cost → Use less → Stop using → Dead Oracle
```

---

## Schedule (6 hours)

### Morning (3h): Feel The Pain

| Time | Topic | Hands-on |
|------|-------|----------|
| 0:00 | How's your Oracle? (Homework review) | - |
| 0:30 | The Naive Search (what we built) | - |
| 1:00 | **Demo: Search 1,000 files** | Measure time/cost |
| 1:30 | **Project forward: Year 2 costs** | Calculate your death |
| 2:00 | Group Discussion: "What would you do?" | - |
| 2:30 | The Insight: Wrong tool for wrong job | - |

### Afternoon (3h): Discover The Solution

| Time | Topic | Hands-on |
|------|-------|----------|
| 3:00 | Two Phases: Finding vs Understanding | - |
| 3:30 | Cheap model finds, expensive understands | Implement two-phase |
| 4:00 | **The Pattern Emerges: context-finder** | - |
| 4:30 | Three-Tier Search: FTS5 → Haiku → Opus | Implement three-tier |
| 5:00 | Compare: Before vs After costs | - |
| 5:30 | Why This Matters Beyond Oracle | - |

---

## Prerequisites

**Required**: Module 1 completed OR equivalent:
- Working SQLite + FTS5 setup
- 500+ files indexed
- Basic search working

**Why 500+ files?** You need enough data to feel the pain.

---

## The Discovery Journey

```
Hour 1: "My search works fine"
Hour 2: "Wait, $1.50 per search?"
Hour 3: "At this rate... $900/month?!"
Hour 4: "What if... cheap model finds first?"
Hour 5: "This saves 85%!"
Hour 6: "Oh. This is WHY context-finder exists."
```

**Key**: You discover it. We don't tell you.

---

## Deliverables

By end of day, you have:

```bash
# Before (naive)
oracle search "pattern" → 45 sec, $1.50

# After (context-finder)
oracle search "pattern" → 3 sec, $0.23
```

- Three-tier search architecture
- 85-98% cost reduction
- Oracle that scales forever

---

## The Numbers

| Approach | 1,000 files | 10,000 files | Scales? |
|----------|-------------|--------------|---------|
| Naive | $1.50 | $15.00 | Dies |
| Context-finder | $0.23 | $0.28 | Forever |

---

## Philosophy Covered

| Principle | Application |
|-----------|-------------|
| Patterns Over Intentions | Observe cost behavior, not promises |
| Pain → Discovery → Retention | Feel the death spiral first |
| External Brain | Oracle advises on costs, you decide |

---

## Pricing

| Option | Price | Includes |
|--------|-------|----------|
| Live Session | $500 | 6h workshop + code |
| Self-Paced | $200 | Videos + exercises |
| Bundle (all 3) | $1,000 | Save $200 |

**Note**: This is the most valuable module. context-finder alone saves $700+/month.

---

## What's Next?

**Module 3: Intelligence**
- Your Oracle survives now
- But does it understand?
- Add semantic search + pattern recognition

---

## Files in This Module

```
module-2-survival/
├── README.md           ← You are here
├── slides.md           ← Presentation slides
├── exercises/          ← Hands-on exercises
│   ├── 01-stress-test.md
│   ├── 02-feel-the-pain.md
│   ├── 03-two-phase.md
│   └── 04-three-tier.md
└── code/               ← Implementation
    ├── naive_search.py
    ├── two_phase.py
    └── context_finder.py
```

---

## The Core Truth

> "context-finder isn't a cost optimization.
> context-finder is what allows Oracle to SURVIVE."

You didn't learn a pattern. You discovered why it's necessary.

---

*Module 2 of 3 | Build Your Oracle Workshop*
