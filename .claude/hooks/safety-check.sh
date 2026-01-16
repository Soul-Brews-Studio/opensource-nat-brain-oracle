#!/bin/bash
# Safety check hook - blocks dangerous commands
# Input: JSON via stdin with tool_input.command

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null)

# === WORKTREE BOUNDARY CHECK ===
# If running from agents/N, block cd outside worktree AND block push to main
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
if [[ "$PWD" =~ $ROOT/agents/([0-9]+) ]]; then
  AGENT_ID="${BASH_REMATCH[1]}"
  MY_WORKTREE="$ROOT/agents/$AGENT_ID"

  # Block cd to outside worktree (but allow git -C which is safe)
  if echo "$CMD" | grep -qE '(^|;|&&|\|\|)\s*cd\s+' && ! echo "$CMD" | grep -qE 'git\s+-C'; then
    # Extract cd target
    CD_TARGET=$(echo "$CMD" | grep -oE 'cd\s+[^;&|]+' | head -1 | sed 's/cd\s*//')

    # Resolve to absolute path
    if [[ "$CD_TARGET" != /* ]]; then
      CD_TARGET="$PWD/$CD_TARGET"
    fi

    # Check if outside worktree
    if [[ ! "$CD_TARGET" =~ ^$MY_WORKTREE ]]; then
      echo "BLOCKED: Agent $AGENT_ID cannot cd outside worktree." >&2
      echo "Use 'git -C $ROOT ...' to operate on other paths." >&2
      exit 2
    fi
  fi

  # Block push to main from agent worktree
  if echo "$CMD" | grep -qE 'git\s+(-C\s+[^\s]+\s+)?push\s+.*\bmain\b'; then
    echo "BLOCKED: Agent $AGENT_ID cannot push to main." >&2
    echo "Commit to your branch (agents/$AGENT_ID), then use: maw merge $AGENT_ID" >&2
    exit 2
  fi
fi

# === DANGEROUS PATTERNS ===

# Block rm -rf - suggest safe alternative
if echo "$CMD" | grep -qE '(^|;|&&|\|\|)\s*rm\s+-rf\s'; then
  echo "BLOCKED: rm -rf not allowed." >&2
  echo "Use: mv <path> /tmp/trash_\$(date +%Y%m%d_%H%M%S)_\$(basename <path>)" >&2
  echo "Recovery: ls /tmp/trash_*" >&2
  exit 2
fi

# Block force flags (only for git/npm/yarn/pnpm, not awk -f etc)
if echo "$CMD" | grep -qE '(^|;|&&|\|\|)\s*(git|npm|yarn|pnpm)\s+[a-z-]+\s+.*(\s-f(\s|$)|--force(\s|$))'; then
  echo "BLOCKED: Force flags not allowed. Use safe alternatives." >&2
  exit 2
fi

# Block reset --hard
if echo "$CMD" | grep -qE '(^|;|&&|\|\|)\s*git\s+reset\s+--hard'; then
  echo "BLOCKED: git reset --hard not allowed." >&2
  exit 2
fi

# Block git commit --amend
if echo "$CMD" | grep -qE 'git\s+commit\s+.*--amend'; then
  echo "BLOCKED: Never use --amend in multi-agent setup. Creates hash divergence." >&2
  exit 2
fi

# gh pr merge - allowed (user can merge PRs when ready)
# Previously blocked, now permitted per user request 2025-12-30

exit 0
