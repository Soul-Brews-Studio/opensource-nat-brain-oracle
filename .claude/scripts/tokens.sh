#!/bin/bash
# Quick token check from statusline.json

ROOT="${CLAUDE_PROJECT_DIR:-/Users/nat/Code/github.com/laris-co/Nat-s-Agents}"
FILE="$ROOT/ψ/active/statusline.json"

if [ ! -f "$FILE" ]; then
  echo "No statusline.json found"
  exit 1
fi

# Parse and display
jq -r '
  .context_window as $ctx |
  ($ctx.current_usage.input_tokens + $ctx.current_usage.cache_creation_input_tokens + $ctx.current_usage.cache_read_input_tokens) as $used |
  ($ctx.context_window_size) as $total |
  ($total - $used) as $remaining |
  ($used * 100 / $total | floor) as $pct |

  "Token Usage:",
  "  Used:      \($used / 1000 | floor)k / \($total / 1000)k (\($pct)%)",
  "  Remaining: \($remaining / 1000 | floor)k",
  "",
  "Session:",
  "  Cost:     $\(.cost.total_cost_usd | . * 100 | floor / 100)",
  "  Duration: \(.cost.total_duration_ms / 1000 | floor)s",
  "  Model:    \(.model.display_name)"
' "$FILE"
