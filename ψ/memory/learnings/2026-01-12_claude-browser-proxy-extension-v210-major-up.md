---
title: ## Claude Browser Proxy Extension v2.1.0
tags: [mqtt, chrome-extension, gemini, lwt, mqtt-js, browser-automation, websocket]
created: 2026-01-12
source: Extension Development Session 2026-01-12
---

# ## Claude Browser Proxy Extension v2.1.0

## Claude Browser Proxy Extension v2.1.0

Major upgrade to Gemini Proxy Chrome extension with MQTT.js library integration.

### Key Features
- **MQTT.js Library**: Replaced raw WebSocket MQTT implementation with mqtt.js for cleaner code
- **LWT (Last Will & Testament)**: Online/offline detection via `claude/browser/status` topic
  - Keep-alive: 15 seconds
  - LWT triggers: ~22 seconds after disconnect
- **"Get Gemini Response" Button**: Captures latest Gemini answer to sidepanel
- **Model Selector UI**: Fast/Pro/Think buttons for Gemini model switching
- **Smart Badge**: Shows version (2.1.0), green on Gemini+connected, red otherwise
- **Collapsible JSON Logs**: `📦 action ✅/❌ id` summary, click to expand full JSON

### MQTT Topics
| Topic | Purpose |
|-------|---------|
| `claude/browser/command` | Commands from Claude Code |
| `claude/browser/response` | Results back to Claude Code |
| `claude/browser/status` | Online/offline with LWT |
| `claude/browser/answer` | Gemini responses (retained) |

### Files
- `mqtt.min.js` - MQTT.js v5.14.1 browser bundle (368KB)
- `background.js` - Service worker with MQTT.js
- `sidepanel.js` - Collapsible JSON formatting
- `sidepanel.html` - UI with answer box, model selector

### LWT Configuration (MQTT.js)
```javascript
client = mqtt.connect('ws://localhost:9001', {
  keepalive: 15,
  will: {
    topic: 'claude/browser/status',
    payload: JSON.stringify({ status: 'offline', version: VERSION }),
    retain: true
  }
});
```

Location: `/Users/nat/Code/github.com/laris-co/claude-browser-proxy/`

---
*Added via Oracle Learn*
