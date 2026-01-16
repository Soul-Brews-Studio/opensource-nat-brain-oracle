#!/bin/bash
# Show latest handoff - checks handoff.log for recent entries
# Only shows if there are entries from today/yesterday

ROOT="${CLAUDE_PROJECT_DIR:-/Users/nat/Code/github.com/laris-co/Nat-s-Agents}"
HANDOFF_LOG="$ROOT/ψ/inbox/handoff.log"

[ ! -f "$HANDOFF_LOG" ] && exit 0

# Check for entries from today or yesterday
TODAY=$(date '+%Y-%m-%d')
YESTERDAY=$(date -v-1d '+%Y-%m-%d' 2>/dev/null || date -d 'yesterday' '+%Y-%m-%d' 2>/dev/null)

if grep -q "$TODAY\|$YESTERDAY" "$HANDOFF_LOG" 2>/dev/null; then
  echo "📋 Previous session ended at high context. Last handoff:"
  echo ""
  # Show last entry
  awk '/^---$/{found=1; buffer=""} found{buffer=buffer $0 "\n"} END{print buffer}' "$HANDOFF_LOG" | head -8
  echo ""
  echo "💡 Run /recap to orient, check latest retrospective for context."
fi
