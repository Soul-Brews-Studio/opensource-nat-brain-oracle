#!/bin/bash
# incubate.sh - Clone repos to ψ/incubate/repo using ghq pattern

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
INCUBATE_ROOT="$BASE_DIR/ψ/incubate/repo"

usage() {
    echo "Usage: incubate.sh <github-url>"
    echo ""
    echo "Examples:"
    echo "  incubate.sh https://github.com/laris-co/the-headline"
    echo "  incubate.sh git@github.com:user/repo.git"
}

if [[ -z "$1" ]]; then
    usage
    exit 1
fi

URL="$1"

# Use ghq with custom root
GHQ_ROOT="$INCUBATE_ROOT" ghq get "$URL"

# Show result
echo ""
echo "✅ Incubated to: $INCUBATE_ROOT"
ls -d "$INCUBATE_ROOT"/*/*/*/ 2>/dev/null | tail -5
