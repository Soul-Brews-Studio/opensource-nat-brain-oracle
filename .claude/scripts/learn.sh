#!/bin/bash
# learn.sh - Clone repos to ψ/learn/repo for learning

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
LEARN_ROOT="$BASE_DIR/ψ/learn/repo"

usage() {
    echo "Usage: learn.sh <github-url>"
    echo ""
    echo "Examples:"
    echo "  learn.sh https://github.com/nazt/weyermann-malt-productpage"
}

if [[ -z "$1" ]]; then
    usage
    exit 1
fi

URL="$1"

# Use ghq with custom root
GHQ_ROOT="$LEARN_ROOT" ghq get "$URL"

# Show result
echo ""
echo "📚 Learned to: $LEARN_ROOT"
ls -d "$LEARN_ROOT"/*/*/*/ 2>/dev/null | tail -5
