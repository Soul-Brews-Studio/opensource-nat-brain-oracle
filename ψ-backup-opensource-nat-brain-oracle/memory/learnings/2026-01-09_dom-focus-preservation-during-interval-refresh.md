---
title: ## DOM Focus Preservation During Interval Refresh
tags: [dom, focus, input, interval, ux, tauri, pattern]
created: 2026-01-09
source: Oracle Status Tray v0.4.0 session
---

# ## DOM Focus Preservation During Interval Refresh

## DOM Focus Preservation During Interval Refresh

**Date**: 2026-01-09
**Context**: Oracle Status Tray - Ask Oracle input losing focus every 2 seconds

### The Problem

When a page has an interval refresh (e.g., `setInterval` updating DOM every 2 seconds), input fields can lose focus even if they're outside the re-rendered content area. Browser behavior varies.

### The Solution

Before any DOM update that might affect focus, capture and restore the input state:

```javascript
function renderContent() {
  // 1. Capture focus state BEFORE update
  const input = document.getElementById('myInput');
  const hadFocus = document.activeElement === input;
  const cursorPos = input?.selectionStart;
  const inputValue = input?.value;

  // 2. Do the DOM update
  content.innerHTML = `...`;

  // 3. Restore focus state AFTER update
  if (hadFocus && input) {
    input.value = inputValue || '';
    input.focus();
    input.setSelectionRange(cursorPos || 0, cursorPos || 0);
  }
}
```

### Key Points

- Save: `activeElement`, `selectionStart`, `value`
- Restore: value first, then focus, then cursor position
- Works even if input is outside the updated DOM area (browser quirks)

### Why This Matters

User experience. Nothing more frustrating than typing and losing your place every 2 seconds.

---
*Added via Oracle Learn*
