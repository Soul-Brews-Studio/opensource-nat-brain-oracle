---
title: ## Gemini Proxy Extension v2.6.4 MQTT Commands
tags: [mqtt, gemini-proxy, chrome-extension, browser-automation, claude-code]
created: 2026-01-13
source: /watch skill session 2026-01-13
---

# ## Gemini Proxy Extension v2.6.4 MQTT Commands

## Gemini Proxy Extension v2.6.4 MQTT Commands

**Location**: `/Users/nat/Code/github.com/laris-co/claude-browser-proxy/`

**MQTT Topics**:
| Topic | Purpose |
|-------|---------|
| `claude/browser/command` | Send commands |
| `claude/browser/response` | Get command results |
| `claude/browser/answer` | Gemini's text response |
| `claude/browser/status` | Extension online status |
| `claude/browser/state` | Loading/tool state |

**Available Actions**:
- `get_state` - Check if Gemini is ready/loading
- `type` - Type text: `{action: "type", selector: "p[data-placeholder]", text: "..."}`
- `click` - Click element: `{action: "click", selector: "button[aria-label='Send']"}`
- `wait_response` - Wait for new Gemini response
- `get_response` - Get current response text
- `get_text` / `get_html` / `get_url` - Page content
- `screenshot` - Take screenshot

**Usage Pattern**:
```bash
# Check status (human-readable timestamp)
STATUS=$(mosquitto_sub -t "claude/browser/status" -C 1 -W 2)
TS=$(echo "$STATUS" | jq -r '.timestamp')
echo "Last seen: $(date -r $((TS/1000)) '+%H:%M:%S')"

# Send prompt to Gemini
mosquitto_pub -t "claude/browser/command" -m '{"action":"type","selector":"p[data-placeholder]","text":"Hello"}'
mosquitto_pub -t "claude/browser/command" -m '{"action":"click","selector":"button[aria-label=\"Send message\"]"}'

# Wait and get response
mosquitto_sub -t "claude/browser/answer" -C 1 -W 60
```

**Architecture**: MQTT for external control, Direct DOM for sidebar UI

---
*Added via Oracle Learn*
