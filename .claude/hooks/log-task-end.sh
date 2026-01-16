#!/bin/bash
# PostToolUse hook - log subagent completion with description

input=$(cat)
description=$(echo "$input" | jq -r '.tool_input.description // "unknown"')
timestamp=$(date '+%Y-%m-%d %H:%M')

echo "$timestamp | done | $description" >> "$CLAUDE_PROJECT_DIR/ψ/memory/logs/activity.log"

exit 0
