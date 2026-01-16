#!/bin/bash
# maw-peek.sh - Check all agent worktree status

ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

echo "🕐 $(date '+%H:%M:%S') MAW Status"
echo ""
echo "| Agent | Branch | Hash | Last Commit |"
echo "|-------|--------|------|-------------|"

for i in 1 2 3 4 5; do
  WORKTREE="$ROOT/agents/$i"
  if [ -d "$WORKTREE" ]; then
    BRANCH=$(git -C "$WORKTREE" branch --show-current 2>/dev/null)
    HASH=$(git -C "$WORKTREE" log -1 --format="%h" 2>/dev/null)
    MSG=$(git -C "$WORKTREE" log -1 --format="%ar: %s" 2>/dev/null | cut -c1-40)
    echo "| $i | $BRANCH | $HASH | $MSG |"
  fi
done

echo ""
echo "**Main**: $(git -C $ROOT log -1 --format='%h (%ar)' 2>/dev/null)"
