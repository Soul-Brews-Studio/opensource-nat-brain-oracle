# V2 Interface (Preview)

> **Source**: https://platform.claude.com/docs/en/agent-sdk/typescript-v2-preview
> **Status**: Unstable preview - APIs may change
> **Fetched**: 2025-12-11

---

## Overview

V2 removes async generators and yield coordination. Multi-turn conversations become simpler:

| Concept | Description |
|---------|-------------|
| `createSession()` | Start new conversation |
| `resumeSession()` | Continue existing conversation |
| `session.send()` | Send a message |
| `session.receive()` | Get response (async generator) |

---

## Installation

Same package:

```bash
npm install @anthropic-ai/claude-agent-sdk
```

---

## Quick Examples

### One-shot Prompt

```typescript
import { unstable_v2_prompt } from '@anthropic-ai/claude-agent-sdk'

const result = await unstable_v2_prompt('What is 2 + 2?', {
  model: 'claude-sonnet-4-5-20250929'
})
console.log(result.result)
```

### Basic Session

```typescript
import { unstable_v2_createSession } from '@anthropic-ai/claude-agent-sdk'

await using session = unstable_v2_createSession({
  model: 'claude-sonnet-4-5-20250929'
})

await session.send('Hello!')
for await (const msg of session.receive()) {
  if (msg.type === 'assistant') {
    const text = msg.message.content
      .filter(block => block.type === 'text')
      .map(block => block.text)
      .join('')
    console.log(text)
  }
}
```

### Multi-turn Conversation

```typescript
import { unstable_v2_createSession } from '@anthropic-ai/claude-agent-sdk'

await using session = unstable_v2_createSession({
  model: 'claude-sonnet-4-5-20250929'
})

// Turn 1
await session.send('What is 5 + 3?')
for await (const msg of session.receive()) {
  console.log(msg)
}

// Turn 2 - Claude remembers context
await session.send('Multiply that by 2')
for await (const msg of session.receive()) {
  console.log(msg)
}
```

### Session Resume

```typescript
import { unstable_v2_resumeSession } from '@anthropic-ai/claude-agent-sdk'

await using session = unstable_v2_resumeSession(sessionId, {
  model: 'claude-sonnet-4-5-20250929'
})

await session.send('Continue from where we left off')
for await (const msg of session.receive()) {
  // Process response
}
```

---

## API Reference

### `unstable_v2_createSession()`

```typescript
function unstable_v2_createSession(options: {
  model: string;
  // Additional options supported
}): Session
```

### `unstable_v2_resumeSession()`

```typescript
function unstable_v2_resumeSession(
  sessionId: string,
  options: {
    model: string;
    // Additional options supported
  }
): Session
```

### `unstable_v2_prompt()`

```typescript
function unstable_v2_prompt(
  prompt: string,
  options: {
    model: string;
    // Additional options supported
  }
): Promise<Result>
```

### Session Interface

```typescript
interface Session {
  send(message: string): Promise<void>;
  receive(): AsyncGenerator<SDKMessage>;
  close(): void;
}
```

---

## Cleanup

Two options:

```typescript
// Automatic (TypeScript 5.2+)
await using session = unstable_v2_createSession({...})
// Session closes when block exits

// Manual (any TypeScript)
const session = unstable_v2_createSession({...})
// ...
session.close()
```

---

## V1 vs V2 Comparison

| Aspect | V1 | V2 |
|--------|----|----|
| Pattern | Async generator + yield | send() + receive() |
| Multi-turn | Input generator coordination | Just call send() again |
| Learning curve | Steeper | Simpler |
| Features | Full | Some missing (e.g., forkSession) |

---

## Not Yet Available in V2

- Session forking (`forkSession` option)
- Some advanced streaming input patterns

Use [V1 SDK](typescript-api.md) for these features.

---

## Feedback

Report issues: https://github.com/anthropics/claude-code/issues

---

*Preview API - subject to change*
