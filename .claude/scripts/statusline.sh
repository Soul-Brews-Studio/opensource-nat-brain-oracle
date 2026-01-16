#!/bin/bash
# Combined status line: time + date + project + agent + context
# Outputs: 📊 Opus 4.5 56% | 🕐 08:24 | 13 Jan 2026 | Nat-s-Agents | agent-6

ROOT="${CLAUDE_PROJECT_DIR:-/Users/nat/Code/github.com/laris-co/Nat-s-Agents}"
FILE="$ROOT/ψ/active/statusline.json"

# Time + Date + Project + Agent
TIME=$(date '+%H:%M')
DATE=$(date '+%d %b %Y')
PROJECT=$(basename "$CLAUDE_PROJECT_DIR")
AGENT=$(bash "$CLAUDE_PROJECT_DIR/.claude/scripts/agent-id.sh" 2>/dev/null || echo "?")

# Context (from statusline.json)
CONTEXT=""
if [ -f "$FILE" ]; then
  model=$(jq -r '.model.display_name' "$FILE" 2>/dev/null)
  used=$(jq -r '.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens' "$FILE" 2>/dev/null)
  total=$(jq -r '.context_window.context_window_size' "$FILE" 2>/dev/null)

  if [ -n "$total" ] && [ "$total" != "null" ]; then
    usable=$((total * 80 / 100))  # 160k usable of 200k
    pct=$((used * 100 / usable))
    used_k=$((used / 1000))
    usable_k=$((usable / 1000))

    if [ "$pct" -ge 97 ]; then
      CONTEXT="🚨 ${model} ${pct}%"
    elif [ "$pct" -ge 95 ]; then
      CONTEXT="⚠️ ${model} ${pct}%"
    else
      CONTEXT="📊 ${model} ${pct}%"
    fi
  fi
fi

# Output single line
if [ -n "$CONTEXT" ]; then
  echo "${CONTEXT} | 🕐 ${TIME} | ${DATE} | ${PROJECT} | ${AGENT}"
else
  echo "🕐 ${TIME} | ${DATE} | ${PROJECT} | ${AGENT}"
fi
