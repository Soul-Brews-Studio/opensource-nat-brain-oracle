#!/bin/bash
# Create workshop slides using Antigravity
# Usage: ./scripts/create-slides-antigravity.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompts/create-workshop-slides.txt"

# Read the prompt
PROMPT=$(cat "$PROMPT_FILE")

# Send to Antigravity
osascript "$SCRIPT_DIR/send-to-antigravity.scpt" "$PROMPT"

echo "✅ Sent slide creation request to Antigravity"
