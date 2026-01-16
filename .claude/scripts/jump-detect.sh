#!/bin/bash
# Auto-detect topic change from user message
# Called by PreUserMessage hook

MSG="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Patterns for topic change (Thai + English)
if echo "$MSG" | grep -qiE "กลับไปทำ|กลับไปเรื่อง|เปลี่ยนเรื่อง|ขอคุยเรื่อง|switch to|back to|let's work on"; then
    # Extract topic (word after pattern)
    TOPIC=$(echo "$MSG" | sed -E 's/.*(กลับไปทำ|กลับไปเรื่อง|เปลี่ยนเรื่อง|ขอคุยเรื่อง|switch to|back to|let'"'"'s work on)[[:space:]]*//' | cut -d' ' -f1-3)

    if [[ -n "$TOPIC" ]]; then
        bash "$SCRIPT_DIR/jump.sh" "$TOPIC"
        echo "🔄 Auto-jumped: $TOPIC"
    fi
fi
