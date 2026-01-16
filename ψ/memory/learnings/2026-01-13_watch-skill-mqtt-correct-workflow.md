---
title: "/watch Skill - Correct MQTT Workflow"
tags: [watch-skill, mqtt, gemini-proxy, chrome-extension, workflow, critical]
created: 2026-01-13
source: Session debugging 2026-01-13
---

# /watch Skill - Correct MQTT Workflow

## TL;DR

**USE MQTT, NOT claude-in-chrome MCP!**

```bash
# The correct flow (30 seconds total)
mosquitto_pub -t "claude/browser/answer" -r -n                    # Clear retained
mosquitto_pub -t "claude/browser/command" -m '{"action":"type","selector":"div[contenteditable=true]","text":"PROMPT"}'
mosquitto_pub -t "claude/browser/command" -m '{"action":"key","key":"Enter"}'
mosquitto_sub -t "claude/browser/answer" -C 1 -W 120              # Wait for response
```

## Why This Session Was Slow

| Problem | Time Wasted | Fix |
|---------|-------------|-----|
| Started with claude-in-chrome MCP | 10 min | Use MQTT from start |
| Skill file had wrong instructions | 5 min | Updated skill.md |
| Wrong selector `p[data-placeholder]` | 5 min | Use `div[contenteditable=true]` |
| Clicking send button failed | 3 min | Use `key Enter` instead |
| Retained message confusion | 5 min | Clear before new query |

**Total wasted**: ~28 minutes on a task that should take 2 minutes

## Correct Selectors (Gemini Jan 2026)

```javascript
// Input field - BOTH work but contenteditable is more reliable
"div[contenteditable=true]"     // Recommended
"p[data-placeholder]"           // Sometimes works

// Send button - but Enter key is better
"button[aria-label=\"Send message\"]"
```

## Complete Working Script

```bash
#!/bin/bash
# /watch via MQTT - correct workflow

URL="$1"
PROMPT="$2"

# 1. Check extension online
STATUS=$(mosquitto_sub -t "claude/browser/status" -C 1 -W 3 2>/dev/null)
if [ -z "$STATUS" ]; then
  echo "❌ Extension offline - open Gemini with sidepanel"
  exit 1
fi
echo "✅ Extension: $(echo "$STATUS" | jq -r '.version')"

# 2. Clear retained answer (CRITICAL!)
mosquitto_pub -t "claude/browser/answer" -r -n

# 3. Type prompt
mosquitto_pub -t "claude/browser/command" \
  -m "{\"action\":\"type\",\"selector\":\"div[contenteditable=true]\",\"text\":$(echo "$PROMPT" | jq -Rs .)}"

# 4. Press Enter (more reliable than click)
sleep 1
mosquitto_pub -t "claude/browser/command" -m '{"action":"key","key":"Enter"}'

# 5. Wait and get response
echo "⏳ Waiting for Gemini..."
ANSWER=$(mosquitto_sub -t "claude/browser/answer" -C 1 -W 120)

if [ -z "$ANSWER" ]; then
  echo "❌ Timeout"
  exit 1
fi

echo "$ANSWER" | jq -r '.answer'
```

## State Checking (Optional but Useful)

```bash
# Check if Gemini is still processing
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_state","id":"check"}'
mosquitto_sub -t "claude/browser/response" -C 1 -W 5 | jq .

# Response shows:
# - loading: true/false (is Gemini thinking?)
# - responseCount: N (how many responses received)
# - tool: null or "youtube" (what tool Gemini is using)
```

## MQTT Topics Reference

| Topic | Direction | Purpose |
|-------|-----------|---------|
| `claude/browser/command` | Claude → Extension | Send commands |
| `claude/browser/response` | Extension → Claude | Command results |
| `claude/browser/answer` | Extension → Claude | Gemini text (retained) |
| `claude/browser/status` | Extension → Claude | Online/offline (LWT) |
| `claude/browser/state` | Extension → Claude | Loading/tool state |

## Prompting Gemini for Video Analysis

### Effective Prompts

**For Recipes/Instructions:**
```
Extract the COMPLETE RECIPE from this video:
[URL]

I need ALL details:
1. Ingredients with exact amounts
2. Step-by-step process
3. Temperatures and times
4. Any tips mentioned

Format as a complete recipe card.
```

**For Transcripts:**
```
Provide the FULL verbatim transcript with timestamps.
Do NOT summarize - I need complete text.

Video: [URL]

Format:
[00:00] exact words
[00:15] next section
```

**For Summaries:**
```
Analyze this video and extract:
1. Key takeaways (3-5 points)
2. Main topics covered
3. Any data/stats mentioned

Video: [URL]
```

### Prompt Tips

| Do | Don't |
|----|-------|
| Be specific about format wanted | Ask vague "tell me about" |
| Request timestamps | Assume Gemini remembers context |
| Ask for "ALL details" | Say "brief summary" for recipes |
| Include video URL in prompt | Assume URL is already known |

### Follow-up Questions

When first response lacks detail:
```bash
# Clear retained first!
mosquitto_pub -t "claude/browser/answer" -r -n

# Then ask specific follow-up
"What are the EXACT measurements for the grain bill?"
"Give me the step-by-step mash schedule with temperatures"
```

## Prevention & Troubleshooting

### Before Starting Checklist

- [ ] Mosquitto running: `brew services list | grep mosquitto`
- [ ] Extension online: `mosquitto_sub -t "claude/browser/status" -C 1 -W 2`
- [ ] Gemini tab active (not chrome:// or other protected page)
- [ ] Sidepanel open with green "Connected to MQTT"

### Common Issues

| Symptom | Cause | Fix |
|---------|-------|-----|
| Timeout waiting for answer | Gemini not receiving prompt | Check selector, try `div[contenteditable=true]` |
| Same answer repeated | Retained message not cleared | `mosquitto_pub -t "claude/browser/answer" -r -n` |
| "Cannot be scripted" error | Wrong tab active | Switch to Gemini tab |
| Empty response | Video too long or blocked | Check Gemini UI manually, increase timeout |
| Connection refused | Mosquitto not running | `brew services start mosquitto` |

### Recovery Steps

```bash
# 1. Check everything is connected
mosquitto_sub -t "claude/browser/status" -C 1 -W 2

# 2. Clear all retained messages
mosquitto_pub -t "claude/browser/answer" -r -n
mosquitto_pub -t "claude/browser/response" -r -n

# 3. Test simple command
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_state","id":"test"}'
mosquitto_sub -t "claude/browser/response" -C 1 -W 5

# 4. If still failing, reload extension in Chrome
```

### Timeout Guidelines

| Video Length | Suggested Timeout |
|--------------|-------------------|
| < 5 min | 30 seconds |
| 5-15 min | 60 seconds |
| 15-30 min | 90 seconds |
| 30+ min | 120+ seconds |

## Architecture: Why MQTT Extension > claude-in-chrome MCP

### The Two Approaches

| Approach | Tool | How it Works |
|----------|------|--------------|
| **claude-in-chrome MCP** | `mcp__claude-in-chrome__*` | Claude → MCP Server → Chrome DevTools → Page |
| **MQTT Extension** | `mosquitto_pub/sub` | Claude → MQTT → Extension → Direct DOM |

### Why MQTT Extension is Better

```
claude-in-chrome MCP (SLOW):
┌────────┐    ┌───────────┐    ┌─────────────┐    ┌──────┐
│ Claude │ → │ MCP Server│ → │Chrome DevTools│ → │ Page │
└────────┘    └───────────┘    └─────────────┘    └──────┘
     ↑              ↑                 ↑
     │              │                 │
   Latency      Latency           Latency
   + refs change on every read_page call!

MQTT Extension (FAST):
┌────────┐    ┌──────┐    ┌───────────┐    ┌──────┐
│ Claude │ → │ MQTT │ → │ Extension │ → │ DOM  │
└────────┘    └──────┘    └───────────┘    └──────┘
     ↑           ↑              ↑
     │      Instant         Direct access
   Simple    pub/sub        No DevTools overhead
```

### Key Differences

| Aspect | claude-in-chrome | MQTT Extension |
|--------|------------------|----------------|
| **Speed** | Slow (3+ round trips) | Fast (1 pub, 1 sub) |
| **Reliability** | Flaky (refs change) | Stable (fixed selectors) |
| **State** | Stateless (must re-read) | Stateful (tracks responses) |
| **Retained data** | None | MQTT retained messages |
| **Async** | Blocking | Non-blocking |
| **DOM access** | Via DevTools protocol | Direct `document.querySelector` |

### The "ref" Problem with claude-in-chrome

```javascript
// claude-in-chrome: refs change every time!
read_page() → ref_188 is input
// ... do something else ...
read_page() → ref_203 is input now! ref_188 is gone!
// Click fails because ref_188 no longer exists

// MQTT Extension: selectors are stable
selector: "div[contenteditable=true]"  // Always works
selector: "button[aria-label='Send']"  // Always works
```

### Extension Reads DOM Directly

The claude-browser-proxy extension runs IN the browser context:

```javascript
// Extension code (runs in browser)
function handleCommand(cmd) {
  if (cmd.action === 'type') {
    // Direct DOM access - no DevTools!
    const el = document.querySelector(cmd.selector);
    el.textContent = cmd.text;
  }
  if (cmd.action === 'get_response') {
    // Direct read of Gemini's response
    const responses = document.querySelectorAll('.response-container');
    return responses[responses.length - 1].textContent;
  }
}
```

### When to Use Each

| Use Case | Tool |
|----------|------|
| Gemini interaction | MQTT Extension (preferred) |
| General web scraping | claude-in-chrome (if no extension) |
| Taking screenshots | Either works |
| Form filling on random sites | claude-in-chrome |
| Repeated automation | Build custom extension + MQTT |

### The Philosophy

> **"Build extensions for repeated tasks, use MCP for one-offs"**

- claude-in-chrome = generic, works everywhere, but slow
- Custom extension + MQTT = specific, fast, reliable
- For Gemini: we have claude-browser-proxy, so USE IT!

## Anti-Patterns (DO NOT DO)

```javascript
// ❌ WRONG - claude-in-chrome MCP (slow, flaky)
mcp__claude-in-chrome__navigate(...)
mcp__claude-in-chrome__computer(...)
mcp__claude-in-chrome__read_page(...)

// ✅ CORRECT - MQTT (fast, reliable)
mosquitto_pub -t "claude/browser/command" -m '...'
mosquitto_sub -t "claude/browser/answer" -C 1 -W 60
```

## Extension Repository

| Item | Value |
|------|-------|
| **Repo** | `/Users/nat/Code/github.com/laris-co/claude-browser-proxy` |
| **GitHub** | `github.com/laris-co/claude-browser-proxy` |
| **Version** | 2.6.4 (2026-01-13) |

### Recent Versions
- v2.6.4 - neutral color for youtube badge
- v2.6.3 - MQTT debug info in publish log
- v2.6.2 - collapsible publish details
- v2.6.1 - sidebar buttons publish to MQTT
- v2.6.0 - buttons use direct browser APIs

## Prerequisites

1. **Mosquitto broker** running: `brew services start mosquitto`
2. **claude-browser-proxy extension** loaded in Chrome (v2.6.4+)
3. **Gemini tab open** with sidepanel active
4. **Extension connected** (green dot in sidepanel)

---

*Learned the hard way on 2026-01-13. Don't repeat this mistake!*
