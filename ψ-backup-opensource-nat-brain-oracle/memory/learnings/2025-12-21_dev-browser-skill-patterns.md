# Lesson: dev-browser Skill Patterns — Speed Through State Persistence

**Date**: 2025-12-21
**Context**: Study of SawyerHood/dev-browser skill

## Core Insight

> **Speed comes from eliminating round-trips, not faster execution.**

dev-browser is 2x faster than `claude --chrome` not because it runs faster, but because it **reduces LLM turns** from 80 to 29.

## Key Patterns

### 1. Stateful Server Pattern

```
┌─────────┐          ┌─────────┐          ┌─────────┐
│ Script 1│ ──────── │ Server  │ ──────── │ Browser │
└─────────┘          │ (owns   │          │ (pages  │
     ↓               │  pages) │          │  persist)│
┌─────────┐          │         │          │         │
│ Script 2│ ──────── │         │          │         │
└─────────┘          └─────────┘          └─────────┘
```

**Anti-pattern**: Each script launches fresh browser
**Pattern**: Server owns browser, scripts are ephemeral clients

### 2. LLM-Friendly Representation

**Before (raw HTML)**:
```html
<a href="/news" class="hnlink" id="nav-1"
   style="color: #828282; text-decoration: none;">
  Hacker News
</a>
```

**After (ARIA Snapshot)**:
```yaml
- link "Hacker News" [ref=e16] [cursor=pointer]:
  - /url: news
```

**Insight**: Strip CSS, IDs, styles → keep only semantic structure + refs

### 3. Ref System for Stable Interaction

```javascript
// Store refs in browser's window object
window.__devBrowserRefs = {
  "e1": <HTMLElement>,
  "e2": <HTMLElement>,
  // ... survives across script executions
}
```

**Why it works**:
- Refs stored in browser memory (not script memory)
- CDP targetId ensures correct page lookup
- Scripts can disconnect and reconnect

### 4. Script Batching

**MCP style (80 turns)**:
```
LLM: click button
Browser: done
LLM: fill input
Browser: done
LLM: click submit
Browser: done
```

**dev-browser style (29 turns)**:
```javascript
// One script, multiple actions
await button.click();
await input.fill("text");
await submit.click();
```

## Application to Other Skills

### When to Use This Pattern

- Browser automation
- Any stateful external service
- Long-running connections (databases, APIs)
- Multi-step workflows

### Implementation Checklist

1. **Server owns state** — clients are ephemeral
2. **Stable identifiers** — refs that survive disconnection
3. **LLM-friendly output** — YAML/structured > raw data
4. **Batch operations** — script multiple actions together

## Benchmark Reference

| Method | Time | Cost | Turns |
|--------|------|------|-------|
| dev-browser | 3m 53s | $0.88 | 29 |
| Playwright MCP | 4m 31s | $1.45 | 51 |
| claude --chrome | 12m 54s | $2.81 | 80 |

## Tags

#skill #browser-automation #performance #state-persistence #aria
