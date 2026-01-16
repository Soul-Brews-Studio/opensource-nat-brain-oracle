---
title: MQTT Retained Messages for Instant Data Retrieval
tags: [mqtt, retained, pattern, architecture, messaging]
created: 2026-01-12
source: Gemini Proxy v2.1.0 Session
---

# MQTT Retained Messages for Instant Data Retrieval

## The Pattern

When you need to retrieve data without waiting for the next publish:

```
Publisher → Broker (stores with retain=true) → Subscriber gets it instantly
```

## How It Works

1. **Publisher** sends message with `retain: true`
2. **Broker** stores the last message on that topic
3. **New subscriber** gets the stored message immediately upon subscribing
4. No need to wait for next publish!

## Code Example

**Publisher (Extension):**
```javascript
client.publish('claude/browser/answer', JSON.stringify({
  answer: geminiResponse,
  timestamp: Date.now()
}), { retain: true });  // ← Key flag!
```

**Subscriber (Claude Code):**
```bash
# Get last answer instantly - no waiting
mosquitto_sub -t "claude/browser/answer" -C 1
```

## Why This Is Powerful

| Without Retain | With Retain |
|---------------|-------------|
| Must subscribe BEFORE publish | Subscribe anytime |
| Wait for next message | Get last message instantly |
| Polling or long-running sub | One-shot retrieval |
| Complex synchronization | Simple request-response feel |

## Use Cases

- **Status topics**: `claude/browser/status` - always know if online/offline
- **Last value topics**: Sensor readings, responses, state
- **Configuration**: Publish once, all future clients get it

## LWT + Retain = Reliable Status

```javascript
mqtt.connect(url, {
  will: {
    topic: 'status',
    payload: 'offline',
    retain: true  // Broker stores "offline" if client crashes
  }
});

// On connect, publish "online" (retained) - overwrites "offline"
client.publish('status', 'online', { retain: true });
```

Now any subscriber always knows the current status!

## Key Insight

> "The broker holds the answer, ready for whoever asks."

No polling. No waiting. No complex pub/sub synchronization.
Just `retain: true` and instant data retrieval.
