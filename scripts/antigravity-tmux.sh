#!/bin/bash
# Antigravity Auto-Generator in tmux
# Creates a detached tmux session that runs forever with 5-minute intervals
# Usage: ./scripts/antigravity-tmux.sh [start_num]

START=${1:-86}
INTERVAL=300  # 5 minutes = 300 seconds
SESSION="antigravity-gen"

# Kill existing session if any
tmux kill-session -t "$SESSION" 2>/dev/null

# Create new detached session
tmux new-session -d -s "$SESSION" -c "$(pwd)"

# Send the auto script command
tmux send-keys -t "$SESSION" "./scripts/antigravity-auto.sh $START $INTERVAL" C-m

echo "🚀 Started antigravity generator in tmux session: $SESSION"
echo "   Start: $START"
echo "   Interval: 5 minutes"
echo ""
echo "Commands:"
echo "   tmux attach -t $SESSION    # Watch progress"
echo "   tmux kill-session -t $SESSION  # Stop"
echo ""
echo "Check progress:"
echo "   ls ψ/outbox/results/*.png | wc -l"
