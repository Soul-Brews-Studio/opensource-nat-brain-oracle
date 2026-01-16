#!/bin/bash
# oracle - Mother Oracle communicates with child Oracles
# Usage: oracle hey <session> <message>   - send message to child
#        oracle see <session> [lines]     - view child's terminal
#        oracle list                      - list all children (tmux sessions)

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

show_usage() {
    cat <<'USAGE'
🌙 Oracle - Mother communicates with children

Usage:
  oracle hey <child> <message>    Send message to child Oracle
  oracle see <child> [lines]      View child's terminal (default: 20 lines)
  oracle list                     List all child Oracles (tmux sessions)

Examples:
  oracle hey arthur "analyze the codebase"
  oracle see arthur 50
  oracle list

Philosophy: Arthur doesn't LEAVE Oracle. Arthur EXTENDS Oracle.
USAGE
}

list_children() {
    echo "🌙 Oracle Children (tmux sessions):"
    echo ""
    if tmux list-sessions -F "  🔮 #{session_name} (#{session_windows} windows, created #{session_created_string})" 2>/dev/null; then
        echo ""
    else
        echo "  (no children running)"
    fi
}

oracle_hey() {
    local session="$1"
    shift
    local message="$*"

    if [[ -z "$message" ]]; then
        echo "❌ No message provided"
        echo "Usage: oracle hey <child> <message>"
        exit 1
    fi

    # Check session exists
    if ! tmux has-session -t "$session" 2>/dev/null; then
        echo "❌ Child '$session' not found"
        echo ""
        list_children
        exit 1
    fi

    local pane="${session}:0.0"

    # Send using proven pattern
    if [[ "$message" == *$'\n'* ]] || [[ ${#message} -gt 500 ]]; then
        echo "$message" | tmux load-buffer -
        tmux paste-buffer -t "$pane"
        sleep 0.3
        tmux send-keys -t "$pane" Enter
    else
        tmux send-keys -t "$pane" "$message"
        sleep 0.05
        tmux send-keys -t "$pane" Enter
    fi

    echo "🌙→🔮 Oracle → $session: sent"
}

oracle_see() {
    local session="$1"
    local lines="${2:-20}"

    # Check session exists
    if ! tmux has-session -t "$session" 2>/dev/null; then
        echo "❌ Child '$session' not found"
        echo ""
        list_children
        exit 1
    fi

    local pane="${session}:0.0"

    echo "👁️  Oracle sees '$session' (last $lines lines)"
    echo "─────────────────────────────────────────"
    tmux capture-pane -t "$pane" -p -S "-${lines}" 2>/dev/null || {
        echo "❌ Could not see child '$session'"
        exit 1
    }
    echo "─────────────────────────────────────────"
}

# Main dispatch
if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
fi

case "$1" in
    hey|send)
        shift
        if [[ $# -lt 1 ]]; then
            echo "❌ No child specified"
            echo "Usage: oracle hey <child> <message>"
            exit 1
        fi
        oracle_hey "$@"
        ;;
    see|view|peek)
        shift
        if [[ $# -lt 1 ]]; then
            echo "❌ No child specified"
            echo "Usage: oracle see <child> [lines]"
            exit 1
        fi
        oracle_see "$@"
        ;;
    list|ls|children)
        list_children
        ;;
    help|-h|--help)
        show_usage
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac
