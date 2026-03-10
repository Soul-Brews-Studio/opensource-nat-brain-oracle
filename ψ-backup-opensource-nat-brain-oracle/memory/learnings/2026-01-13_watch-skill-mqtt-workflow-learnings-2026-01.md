---
title: ## /watch Skill - MQTT Workflow Learnings (2026-01-13)
tags: [watch-skill, mqtt, gemini-proxy, workflow, debugging, selector, chrome-extension, lesson-learned]
created: 2026-01-13
source: /watch skill session 2026-01-13
---

# ## /watch Skill - MQTT Workflow Learnings (2026-01-13)

## /watch Skill - MQTT Workflow Learnings (2026-01-13)

**Problem**: Session was SLOW due to wrong approach and debugging

### What Went Wrong
1. **Started with claude-in-chrome MCP** - WRONG! Should use MQTT
2. **Skill file was outdated** - still had browser automation instructions
3. **Selector issues** - `p[data-placeholder]` didn't work, needed `div[contenteditable=true]`
4. **Enter key vs click** - `key Enter` works better than clicking send button
5. **Retained messages** - Must clear `claude/browser/answer` before new query

### Correct MQTT Workflow (FAST)

```bash
# 1. Check extension online
mosquitto_sub -t "claude/browser/status" -C 1 -W 3

# 2. Clear retained answer (CRITICAL for fresh response)
mosquitto_pub -t "claude/browser/answer" -r -n

# 3. Type prompt (use contenteditable selector!)
mosquitto_pub -t "claude/browser/command" -m '{"action":"type","selector":"div[contenteditable=true]","text":"YOUR PROMPT"}'

# 4. Press Enter (more reliable than click)
mosquitto_pub -t "claude/browser/command" -m '{"action":"key","key":"Enter"}'

# 5. Check state for responseCount
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_state","id":"s1"}'
mosquitto_sub -t "claude/browser/response" -C 1 -W 5

# 6. Get response when responseCount > 0
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_response","id":"get1"}'
mosquitto_sub -t "claude/browser/answer" -C 1 -W 60
```

### Key Selectors (Gemini 2026-01)
- Input: `div[contenteditable=true]` or `p[data-placeholder]`
- Send: `button[aria-label="Send message"]` (but Enter key is better)

### Timing
- Video analysis: 30-90 seconds depending on length
- Check `get_state` for `responseCount` before fetching answer
- `loading: true` means Gemini is still processing

### DO NOT USE
- ❌ `mcp__claude-in-chrome__*` tools - SLOW, unreliable
- ❌ Browser automation with refs - refs change constantly
- ✅ MQTT via mosquitto_pub/sub - FAST, stable

---
*Added via Oracle Learn*
