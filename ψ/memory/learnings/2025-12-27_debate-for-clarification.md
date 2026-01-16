# Debate Agents for Specification Clarification

**Date**: 2025-12-27

## What We Learned

- **Clarification questions don't require human answers** — run advocate/critic/alternative agents instead
- **Structured opposition produces better specs** — 3 perspectives often synthesize into hybrid solutions
- **Pattern**: Question → 3 parallel agents → Opus synthesizes → Update spec

## The Pattern

```
Clarification needed:
  "Should buffer entries keep original or recovery timestamps?"

Instead of asking human:
  → Agent 1 (Advocate): "Keep original — timestamps = truth"
  → Agent 2 (Critic): "Recovery time matters for auditing"
  → Agent 3 (Alternative): "Dual timestamps — created_at + recovered_at"

Synthesis:
  → Dual timestamps wins — preserves both truths
```

## When to Use

- Design decisions with multiple valid approaches
- Trade-off questions (A vs B vs hybrid)
- Architecture choices needing devil's advocate

## When NOT to Use

- Factual questions (what's the user's preference?)
- Permission requests (should I proceed?)
- Context-specific decisions only human knows

## How Things Connect

- `/speckit.clarify` can run in "debate mode" instead of asking human
- Extends the 6-agent debate pattern from Oracle v2 planning
- Reduces human clarification burden while improving answer quality

## Implementation

```bash
# Run 3 agents in parallel per question
Task: advocate (haiku) - "ARGUE FOR option A"
Task: critic (haiku) - "ARGUE AGAINST or raise concerns"
Task: alternative (haiku) - "Propose BETTER alternative"

# Opus synthesizes
Main agent reads all 3 → picks best or creates hybrid
```

## Tags

`debate` `clarification` `specification` `multi-agent` `pattern`
