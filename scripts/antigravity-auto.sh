#!/bin/bash
# Antigravity Auto-Generator
# Runs infinitely, sending prompts with interval
# Usage: ./scripts/antigravity-auto.sh [start_num] [interval_seconds]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"
RESULTS="$PROMPTS_DIR/results"
SCPT="$SCRIPT_DIR/send-to-antigravity.scpt"

# Config
START=${1:-301}
INTERVAL=${2:-90}  # seconds between sends (default 90s for rate limit)
END=400

echo "🚀 Antigravity Auto-Generator"
echo "   Start: $START"
echo "   End: $END"
echo "   Interval: ${INTERVAL}s"
echo "   Results: $RESULTS"
echo ""

# Ensure results dir exists
mkdir -p "$RESULTS"

# Function to extract prompt from markdown
extract_prompt() {
    local file="$1"
    # Extract raw section: from "Prompt" header until next header, "---", or "Expected Output"
    local raw_content=$(awk '
        /^#+ [Pp]rompt[[:space:]]*$/ { flag=1; next }
        /^#+ / { if(flag) exit }
        /^---/ { if(flag) exit }
        /\*\*Expected Output/ { if(flag) exit }
        flag { print }
    ' "$file")

    # If it contains backticks, extract strictly between them
    if echo "$raw_content" | grep -q "^\`\`\`"; then
        echo "$raw_content" | sed -n '/^```/,/^```/p' | sed '1d;$d'
    else
        # Trim leading/trailing whitespace/empty lines
        echo "$raw_content" | sed '/^[[:space:]]*$/d'
    fi
}

# Function to check if image exists
image_exists() {
    local num="$1"
    ls "$RESULTS"/${num}-*.png 2>/dev/null | head -1
}

# Main loop
current=$START
while [ $current -le $END ]; do
    num=$(printf "%03d" $current)

    # Find the prompt file
    prompt_file=$(ls "$PROMPTS_DIR"/antigravity-${num}-*.md 2>/dev/null | head -1)

    if [ -z "$prompt_file" ]; then
        echo "⚠️  No prompt file for $num, skipping..."
        ((current++))
        continue
    fi

    # Check if already generated
    existing=$(image_exists "$num")
    if [ -n "$existing" ]; then
        echo "✅ $num already exists: $(basename "$existing")"
        ((current++))
        continue
    fi

    # Extract prompt
    prompt=$(extract_prompt "$prompt_file")
    if [ -z "$prompt" ]; then
        echo "⚠️  No prompt found in $prompt_file, skipping..."
        ((current++))
        continue
    fi

    # Send to Antigravity
    echo "📤 Sending $num: $(basename "$prompt_file" .md)..."
    osascript "$SCPT" "$prompt" || {
        echo "❌ Failed to send $num, will retry next loop"
        sleep 10
        continue
    }

    echo "✓ Sent $num, waiting ${INTERVAL}s for generation..."

    # Wait for interval
    sleep "$INTERVAL"

    # Log progress
    echo "$(date '+%Y-%m-%d %H:%M:%S') | sent | antigravity-$num" >> "$REPO_ROOT/ψ/memory/logs/antigravity.log"

    ((current++))
done

echo ""
echo "🎉 All done! Generated $START to $END"
