# Direct DOM Over Storage Chain Pattern

**Date**: 2026-01-13
**Context**: Gemini Proxy Extension v2.3.3 → v2.6.4

## The Problem

Chrome extension sidebar needed to display data from the page. Initial approach:

```
Button → MQTT → background.js → execute → storage → sync interval → display
```

**Issues**:
- Storage sync unreliable (timing, race conditions)
- Too many moving parts
- Data appeared on reload but not real-time

## The Solution

Direct DOM access from sidebar:

```javascript
$('button').onclick = async () => {
  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  const result = await chrome.scripting.executeScript({
    target: { tabId: tab.id },
    func: () => document.querySelector('SELECTOR').innerText
  });
  log('res', result[0]?.result);
};
```

**Result**: Instant, reliable, simple.

## Key Insight

> "When something is complex and unreliable, simplify by going direct to the source."

Don't add more layers to fix a broken chain. Question if the chain is needed at all.

## Dual Path Architecture

For the best of both worlds:

| Path | Use Case |
|------|----------|
| MQTT | External control (Claude Code → Gemini) |
| Direct DOM | UI display (sidebar buttons → instant) |

## Code Pattern

```javascript
// Sidebar can use chrome.scripting.executeScript directly
// No need to go through MQTT for UI-only operations
const result = await chrome.scripting.executeScript({
  target: { tabId: tab.id },
  func: () => ({ /* query DOM here */ })
});
```

## Tags

#chrome-extension #simplification #architecture #mqtt #dom-scraping
