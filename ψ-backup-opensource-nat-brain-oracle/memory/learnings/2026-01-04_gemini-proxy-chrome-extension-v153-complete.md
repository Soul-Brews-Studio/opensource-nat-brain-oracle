---
title: ## Gemini Proxy Chrome Extension v1.5.3 Complete
tags: [chrome-extension, mqtt, gemini, browser-automation, service-worker, websocket, ipc]
created: 2026-01-04
source: Session 2026-01-04: Gemini Proxy MQTT Complete
---

# ## Gemini Proxy Chrome Extension v1.5.3 Complete

## Gemini Proxy Chrome Extension v1.5.3 Complete

**What**: Chrome extension enabling Claude Code ↔ Gemini communication via MQTT

**Architecture**:
```
Claude (MQTT) → Extension → Gemini (Web) → Extension → Claude (MQTT)
```

**Key Technical Patterns**:

1. **Service Worker Keep-Alive**: Chrome kills WebSocket after ~30s idle. Solution: ping every 30s.

2. **Storage-Based IPC**: `chrome.runtime.sendMessage` unreliable for sidepanel. Use `chrome.storage.local` + 1s polling fallback.

3. **Detect NEW Responses** (not old):
```javascript
const initialCount = getResponses().length;
// ... send message ...
// Wait for count increase, then stability check
```

4. **Quill Editor Input**: Gemini uses contenteditable, not textarea. Use `el.textContent = text` or real keyboard simulation.

5. **MQTT Retained Messages**: Flag 0x31 for retained. Perfect for async workflows.

**Version Evolution**: v1.2.x (basic relay) → v1.3.x (sidebar) → v1.4.x (Gemini-only) → v1.5.x (chat mode, Thai support)

**Proof**: Successfully exchanged Thai messages between Claude and Gemini via MQTT → Browser → MQTT loop.

---
*Added via Oracle Learn*
