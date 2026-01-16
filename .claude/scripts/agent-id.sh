#!/bin/bash
# Short agent ID for hooks (no colors, just ID)
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

if [[ "$PWD" =~ $ROOT/agents/([0-9]+) ]]; then
  echo "agent/${BASH_REMATCH[1]}"
elif [[ "$PWD" == "$ROOT" ]]; then
  echo "main"
else
  echo "?"
fi
