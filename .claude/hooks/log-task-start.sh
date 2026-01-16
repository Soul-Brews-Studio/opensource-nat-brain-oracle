#!/bin/bash
# PreToolUse hook - log subagent start with description

input=$(cat)
description=$(echo "$input" | jq -r '.tool_input.description // "unknown"')
timestamp=$(date '+%Y-%m-%d %H:%M')

echo "$timestamp | working | $description" >> "$CLAUDE_PROJECT_DIR/ψ/memory/logs/activity.log"

exit 0
