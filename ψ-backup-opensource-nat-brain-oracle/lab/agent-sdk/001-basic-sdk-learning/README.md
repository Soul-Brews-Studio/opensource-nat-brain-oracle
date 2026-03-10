# Lab 001: Basic SDK Learning

> **Type**: Learning Lab
> **Method**: Learn by doing with AI assistance
> **Status**: ✅ Complete
> **Date**: 2025-12-11

---

## What is This?

This is a **learning lab** - a hands-on approach to learning new technology by writing and running real code, guided by AI.

### Learning Method

```
1. AI explains concepts
2. Write experiment code
3. Run and observe
4. Fix errors together
5. Understand through iteration
```

---

## Lab Contents

| # | Experiment | What You Learn |
|---|------------|----------------|
| 01 | basic-query.ts | `query()` function, async iteration |
| 02 | v2-session.ts | V2 APIs, sessions, multi-turn |
| 03 | tools-sandbox.ts | Tool configurations |

---

## Quick Start

```bash
# Install dependencies
npm install

# Run all experiments
npm start

# Or run individually
npm run exp:basic    # Basic query
npm run exp:v2       # V2 session APIs
npm run exp:tools    # Tool configurations
```

---

## Key Learnings

### 1. SDK API Pattern
```typescript
import { query } from '@anthropic-ai/claude-agent-sdk'

// Correct signature
const generator = query({
  prompt: 'Your prompt here',
  options: { maxTurns: 1 }
})

// Iterate through responses
for await (const message of generator) {
  if (message.type === 'result') {
    console.log(message.result)
  }
}
```

### 2. V2 Session APIs
```typescript
import { unstable_v2_prompt } from '@anthropic-ai/claude-agent-sdk'

// One-shot (simplest)
const result = await unstable_v2_prompt('Hello', {
  model: 'claude-sonnet-4-5-20250929'
})
console.log(result.result)
```

### 3. Tool Configurations
```typescript
// All tools
options: { tools: { type: 'preset', preset: 'claude_code' } }

// Restricted
options: { tools: ['Read', 'Glob', 'Grep'] }

// No tools
options: { tools: [] }
```

---

## Process Documentation

### Iteration History

| Round | What Happened |
|-------|---------------|
| 1 | Initial code from Haiku agents - API mismatches |
| 2 | Main agent (Opus) reviewed and fixed signatures |
| 3 | All experiments pass |

### Costs
- Total API cost: ~$0.16
- Time: ~30 minutes

---

## References

- [SDK TIMELINE](../TIMELINE.md) - Version history
- [TypeScript API](../typescript-api.md) - Full API reference
- [V2 Interface](../v2-interface.md) - New session APIs
- [Sandboxing](../sandboxing.md) - Security features

---

## Philosophy

> "Learning by doing" with AI assistance
>
> - AI provides context and guidance
> - Human runs experiments and observes
> - Errors are learning opportunities
> - Iteration leads to understanding

This lab demonstrates that **AI + Human collaboration** accelerates learning through:
1. Instant feedback loops
2. Real code, not just theory
3. Fixing errors together
4. Building understanding incrementally

---

*Lab 001 - Created 2025-12-11*
