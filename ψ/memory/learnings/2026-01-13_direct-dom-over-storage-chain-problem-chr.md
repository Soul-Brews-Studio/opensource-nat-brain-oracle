---
title: ## Direct DOM Over Storage Chain
tags: [chrome-extension, simplification, architecture, mqtt, dom-scraping, rapid-iteration]
created: 2026-01-13
source: Session 2026-01-13 Gemini Proxy
---

# ## Direct DOM Over Storage Chain

## Direct DOM Over Storage Chain

**Problem**: Chrome extension sidebar data display was unreliable via MQTT → storage → sync chain.

**Solution**: Direct DOM access via `chrome.scripting.executeScript` from sidebar.

**Key Insight**: "When something is complex and unreliable, simplify by going direct to the source."

**Architecture Pattern**:
- MQTT path: External control (Claude Code → Gemini)
- Direct DOM path: UI display (sidebar → instant)

**Result**: 12 releases in 2 hours (v2.3.3 → v2.6.4), ending with clean dual-path architecture.

---
*Added via Oracle Learn*
