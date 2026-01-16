#!/bin/bash
# Remind Antigravity to continue MASTER-AUTO.md every 5 minutes
# Usage: ./scripts/antigravity-remind.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INTERVAL=300  # 5 minutes

echo "🔄 Antigravity Reminder - Every 5 minutes"
echo "   Press Ctrl+C to stop"
echo ""

while true; do
    echo "$(date '+%H:%M:%S') - Sending reminder..."
    osascript "$SCRIPT_DIR/send-to-antigravity.scpt" "Continue @ψ/outbox/MASTER-AUTO.md - generate next image. Check results/ folder, skip existing, generate missing ones from 086-210. Don't ask, just do it."
    echo "✓ Sent. Waiting 5 minutes..."
    sleep $INTERVAL
done
