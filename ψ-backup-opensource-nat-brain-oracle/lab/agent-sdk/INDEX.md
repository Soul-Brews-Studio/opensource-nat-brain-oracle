---
title: "Claude Agent SDK Reference"
tags: [lab, sdk, reference, typescript]
created: 2025-12-11
status: active
parent: "[[lab|Lab]]"
---

# Claude Agent SDK Reference

> **Source**: https://platform.claude.com/docs/en/agent-sdk/
> **Package**: `@anthropic-ai/claude-agent-sdk`
> **Fetched**: 2025-12-11

---

## Quick Links

| File | Content |
|------|---------|
| [typescript-api.md](typescript-api.md) | Full TypeScript API reference |
| [v2-interface.md](v2-interface.md) | New V2 send/receive pattern (preview) |
| [sandboxing.md](sandboxing.md) | Filesystem & network isolation |
| [TIMELINE.md](TIMELINE.md) | Version history & feature timeline |

---

## Learning Labs

| # | Lab | Description | Status |
|---|-----|-------------|--------|
| [001](001-basic-sdk-learning/) | Basic SDK Learning | query(), V2 APIs, tools config | ✅ Complete |

> Labs are hands-on experiments for learning SDK features by writing real code.

---

## Key Features (2025-12)

- **1M Context Window**: Beta support for Claude Sonnet 4/4.5
- **Sandboxing**: OS-level filesystem & network isolation
- **V2 Interface**: Simplified `send()` → `receive()` pattern
- **Multi-turn**: Session-based conversations

---

## Installation

```bash
npm install @anthropic-ai/claude-agent-sdk
```

Requires Node.js 18+

---

## Quick Example (V2)

```typescript
import { unstable_v2_createSession } from '@anthropic-ai/claude-agent-sdk'

await using session = unstable_v2_createSession({
  model: 'claude-sonnet-4-5-20250929'
})

await session.send('Hello!')
for await (const msg of session.receive()) {
  console.log(msg)
}
```

---

## External Links

- [Official Docs](https://platform.claude.com/docs/en/agent-sdk/typescript)
- [GitHub Repo](https://github.com/anthropics/claude-agent-sdk-typescript)
- [Sandboxing Blog](https://www.anthropic.com/engineering/claude-code-sandboxing)

---

*Maintained as part of Nat's Agents project*

---

## See Also

- [[HOME|Home]] - Brain navigation
- [[lab/claude-code-features/experiment|Claude Code Features]] - Related experiments
- [[memory/retrospectives/2025-12/11/05.30-agent-sdk-learning-lab|Session: SDK Learning Lab]] - Session that created this
- [[memory/retrospectives/2025-12/11/07.30-sdk-to-pitch-pivot|Session: SDK to Pitch Pivot]] - Follow-up session
