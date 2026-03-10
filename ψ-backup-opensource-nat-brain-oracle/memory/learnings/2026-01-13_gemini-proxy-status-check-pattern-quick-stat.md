---
title: ## Gemini Proxy Status Check Pattern
tags: [mqtt, gemini-proxy, status-check, liveness]
created: 2026-01-13
source: User feedback on /watch skill 2026-01-13
---

# ## Gemini Proxy Status Check Pattern

## Gemini Proxy Status Check Pattern

**Quick Status** (from retained message - shows last activity):
```bash
STATUS=$(mosquitto_sub -t "claude/browser/status" -C 1 -W 2)
TS=$(echo "$STATUS" | jq -r '.timestamp')
VERSION=$(echo "$STATUS" | jq -r '.version')
HUMAN=$(date -r $((TS / 1000)) '+%H:%M:%S')
AGE=$(($(date +%s) - TS / 1000))

echo "🟢 v$VERSION | Last: $HUMAN (${AGE}s ago)"
[ $AGE -lt 30 ] && echo "✅ LIVE" || echo "⚠️ Stale - ping to verify"
```

**Ping for Live Check** (confirms extension responds now):
```bash
mosquitto_pub -t "claude/browser/command" -m '{"action":"get_state"}'
RESP=$(mosquitto_sub -t "claude/browser/response" -C 1 -W 3)
TS=$(echo "$RESP" | jq -r '.timestamp')
echo "✅ LIVE @ $(date -r $((TS / 1000)) '+%H:%M:%S')"
```

**Key Insight**: Status timestamp = when extension last broadcast. If >30s old, ping to confirm liveness before sending commands.

---
*Added via Oracle Learn*
