---
title: ## MQTT clean_session Bug
tags: [mqtt, bug, rumqttc, voice-tray, infinite-loop]
created: 2026-01-05
source: voice-tray-v2 bug fix 2026-01-05
---

# ## MQTT clean_session Bug

## MQTT clean_session Bug

**Problem**: App speaks infinitely when reconnecting to MQTT broker

**Root Cause**: `set_clean_session(false)` tells broker to persist messages for offline clients. When app reconnects, it receives ALL queued messages sent while offline, causing infinite speech loop.

**Fix**: Use `set_clean_session(true)` so old messages are discarded on reconnect.

```rust
// BAD - replays old messages
mqttoptions.set_clean_session(false);

// GOOD - fresh start on reconnect  
mqttoptions.set_clean_session(true);
```

**When to use clean_session(false)**: Only when you WANT to receive missed messages (e.g., important notifications). For real-time voice/TTS, always use clean_session(true).

---
*Added via Oracle Learn*
