---
title: ## CRITICAL: Use MQTT Extension, NOT claude-in-chrome MCP
tags: [mqtt, gemini, critical, performance, architecture, anti-pattern]
created: 2026-01-12
source: Critical Learning 2026-01-12
---

# ## CRITICAL: Use MQTT Extension, NOT claude-in-chrome MCP

## CRITICAL: Use MQTT Extension, NOT claude-in-chrome MCP

**IMPORTANT**: When interacting with Gemini, ALWAYS use the MQTT-based Gemini Proxy extension, NOT the claude-in-chrome MCP tools.

### Why MQTT is Better
| claude-in-chrome MCP | MQTT Extension |
|---------------------|----------------|
| ❌ Slow (API overhead) | ✅ Fast (direct WebSocket) |
| ❌ Extra layer | ✅ Purpose-built for Gemini |
| ❌ Generic browser tool | ✅ Specific Gemini commands |

### The Correct Pipeline
```
Claude Code → mosquitto_pub → Extension → Gemini
Gemini → Extension → mosquitto_sub → Claude Code
```

### MQTT Commands
```bash
# Send command to extension
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_response","id":"123"}'

# Get Gemini response (retained)
mosquitto_sub -t "claude/browser/answer" -C 1

# Check extension status
mosquitto_sub -t "claude/browser/status" -C 1
```

### Topics
- `claude/browser/command` - Send commands
- `claude/browser/response` - Get results
- `claude/browser/answer` - Gemini responses (retained)
- `claude/browser/status` - Online/offline (LWT)

**Remember**: We engineered this MQTT bridge specifically for speed. Don't bypass it with slow MCP tools!

---
*Added via Oracle Learn*
