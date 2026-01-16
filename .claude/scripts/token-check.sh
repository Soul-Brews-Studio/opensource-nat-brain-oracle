#!/bin/bash
# token-check.sh - Monitor context usage and auto-handoff
#
# WHAT IT DOES:
#   - Reads context usage from ψ/active/statusline.json
#   - Shows usage % to LLM on every prompt
#   - At 95%: Warns to wrap up
#   - At 97%: Logs handoff to ψ/inbox/handoff.log (once per hour)
#
# HOW IT WORKS:
#   - Usable = 90% of total (auto-compact triggers at ~90%)
#   - Rate limit: Only 1 handoff entry per hour (prevents spam)
#   - Handoff includes: timestamp, %, focus, recent commits
#
# HOOK INTEGRATION:
#   - Runs on UserPromptSubmit hook
#   - Output appears in system-reminder to LLM
#   - LLM sees: "📊 Opus 4.5 74% | 🕐 10:56 | 14 Jan 2026"
#
# FILES:
#   - Input:  ψ/active/statusline.json (from Claude Code)
#   - Output: ψ/inbox/handoff.log (append-only)
#   - Focus:  ψ/inbox/focus-agent-main.md
#
# Updated: 2026-01-14

ROOT="${CLAUDE_PROJECT_DIR:-/Users/nat/Code/github.com/laris-co/Nat-s-Agents}"
FILE="$ROOT/ψ/active/statusline.json"

[ ! -f "$FILE" ] && exit 0

# Get values separately to handle spaces in model name
model=$(jq -r '.model.display_name' "$FILE" 2>/dev/null)
used=$(jq -r '.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens' "$FILE" 2>/dev/null)
total=$(jq -r '.context_window.context_window_size' "$FILE" 2>/dev/null)

[ -z "$total" ] || [ "$total" = "null" ] && exit 0

# Calculate based on 80% of total (160k usable of 200k, updated 2026-01-16)
usable=$((total * 80 / 100))
pct=$((used * 100 / usable))
used_k=$((used / 1000))
usable_k=$((usable / 1000))

# Format with urgency levels (based on usable, not total)
if [ "$pct" -ge 97 ]; then
  HANDOFF_LOG="$ROOT/ψ/inbox/handoff.log"

  # Check if we already logged this session (within last hour)
  if [ -f "$HANDOFF_LOG" ]; then
    LAST_ENTRY=$(grep -E "^## [0-9]{4}-[0-9]{2}-[0-9]{2}" "$HANDOFF_LOG" | tail -1 | cut -d'|' -f1 | sed 's/## //')
    if [ -n "$LAST_ENTRY" ]; then
      LAST_TS=$(date -j -f "%Y-%m-%d %H:%M " "$LAST_ENTRY " +%s 2>/dev/null || echo 0)
      NOW_TS=$(date +%s)
      DIFF=$((NOW_TS - LAST_TS))
      if [ "$DIFF" -lt 3600 ]; then
        # Already logged within last hour, just show status
        echo "🚨 CONTEXT ${pct}% - Wrap up soon! Run \`rrr\` to capture learnings. (logged $(($DIFF / 60))m ago)"
        exit 0
      fi
    fi
  fi

  echo "🚨 CONTEXT ${pct}% - Run \`rrr\` now! Handoff logged to ψ/inbox/handoff.log"

  # Get recent commits
  RECENT_COMMITS=$(cd "$ROOT" && git log --oneline -3 2>/dev/null | sed 's/^/  /')

  # Get current focus
  FOCUS=$(cat "$ROOT/ψ/inbox/focus-agent-main.md" 2>/dev/null | grep "TASK:" | head -1 || echo "  (no focus set)")

  # Append entry (only once per session)
  echo "" >> "$HANDOFF_LOG"
  echo "---" >> "$HANDOFF_LOG"
  echo "## $(date '+%Y-%m-%d %H:%M') | ${pct}%" >> "$HANDOFF_LOG"
  echo "" >> "$HANDOFF_LOG"
  echo "**Focus**: $FOCUS" >> "$HANDOFF_LOG"
  echo "" >> "$HANDOFF_LOG"
  echo "**Commits**:" >> "$HANDOFF_LOG"
  echo "$RECENT_COMMITS" >> "$HANDOFF_LOG"
  echo "" >> "$HANDOFF_LOG"
elif [ "$pct" -ge 95 ]; then
  echo "⚠️ ${model} ${pct}% (${used_k}k/${usable_k}k usable) - Wrap up, prepare handoff"
else
  echo "📊 ${model} ${pct}% (${used_k}k/${usable_k}k usable)"
fi
