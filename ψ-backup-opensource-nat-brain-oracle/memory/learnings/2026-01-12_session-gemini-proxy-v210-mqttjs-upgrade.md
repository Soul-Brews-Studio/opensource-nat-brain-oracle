---
title: ## Session: Gemini Proxy v2.1.0 - MQTT.js Upgrade (2026-01-12)
tags: [mqtt, chrome-extension, gemini, lwt, retained-messages, session-summary, mqtt-js]
created: 2026-01-12
source: Session Retrospective 2026-01-12
---

# ## Session: Gemini Proxy v2.1.0 - MQTT.js Upgrade (2026-01-12)

## Session: Gemini Proxy v2.1.0 - MQTT.js Upgrade (2026-01-12)

### What We Built
Chrome extension upgrade from v1.7.0 to v2.1.0:
- **MQTT.js Library**: Replaced 600+ lines raw WebSocket with clean mqtt.js
- **LWT (Last Will & Testament)**: Online/offline detection, 15s keepalive, ~22s timeout
- **Collapsible JSON Logs**: `📦 action ✅/❌ id` summary, click to expand
- **Smart Badge**: Version always visible, green=Gemini+connected, red=otherwise

### Critical Pattern: Use MQTT, NOT claude-in-chrome
| claude-in-chrome | MQTT Extension |
|-----------------|----------------|
| Slow (API overhead) | Fast (WebSocket) |
| OK for debugging | Production use |

### Retained Messages Pattern
```javascript
// Publisher
client.publish(topic, data, { retain: true });

// Subscriber - gets last message INSTANTLY
mosquitto_sub -t "topic" -C 1
```

No polling. No waiting. Broker stores last message.

### Topics
- `claude/browser/command` - Send commands
- `claude/browser/response` - Get results  
- `claude/browser/status` - LWT online/offline
- `claude/browser/answer` - Gemini responses (retained)

### Version Progression
v1.8.0 → Get Response button
v1.9.0 → LWT support
v2.0.x → MQTT.js migration
v2.1.0 → Collapsible logs, polished UI

Retrospective: ψ/memory/retrospectives/2026-01/12/15.02_gemini-proxy-v2-mqtt-js-upgrade.md

---
*Added via Oracle Learn*
