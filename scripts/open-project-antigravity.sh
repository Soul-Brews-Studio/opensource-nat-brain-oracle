#!/bin/bash
# Open Nat's Agents project using Antigravity AI assistant
# Usage: ./scripts/open-project-antigravity.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/open-nats-agents.txt"

# Read the prompt
PROMPT=$(cat "$PROMPT_FILE")

# Send to Antigravity
osascript "$SCRIPT_DIR/send-to-antigravity.scpt" "$PROMPT"

echo "✅ Sent project open request to Antigravity"
