#!/bin/bash

# Ralph Loop Setup Script (Local Version)
# Creates state file for in-session Ralph loop

set -euo pipefail

PROMPT_PARTS=()
MAX_ITERATIONS=0
COMPLETION_PROMISE="null"

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      cat << 'EOF'
Ralph Loop - Self-referential development loop

USAGE:
  /ralph-loop [PROMPT...] [OPTIONS]

OPTIONS:
  --max-iterations <n>           Max iterations (default: unlimited)
  --completion-promise '<text>'  Promise phrase to exit (USE QUOTES)
  -h, --help                     Show help

EXAMPLES:
  /ralph-loop Build a todo API --completion-promise 'DONE' --max-iterations 20
  /ralph-loop Fix the auth bug --max-iterations 10

STOPPING:
  Output: <promise>YOUR_PHRASE</promise>
  Or reach --max-iterations limit
EOF
      exit 0
      ;;
    --max-iterations)
      [[ -z "${2:-}" ]] && echo "❌ --max-iterations needs a number" >&2 && exit 1
      [[ ! "$2" =~ ^[0-9]+$ ]] && echo "❌ --max-iterations must be integer: $2" >&2 && exit 1
      MAX_ITERATIONS="$2"
      shift 2
      ;;
    --completion-promise)
      [[ -z "${2:-}" ]] && echo "❌ --completion-promise needs text" >&2 && exit 1
      COMPLETION_PROMISE="$2"
      shift 2
      ;;
    *)
      PROMPT_PARTS+=("$1")
      shift
      ;;
  esac
done

PROMPT="${PROMPT_PARTS[*]}"

[[ -z "$PROMPT" ]] && echo "❌ No prompt provided" >&2 && exit 1

mkdir -p .claude

if [[ -n "$COMPLETION_PROMISE" ]] && [[ "$COMPLETION_PROMISE" != "null" ]]; then
  COMPLETION_PROMISE_YAML="\"$COMPLETION_PROMISE\""
else
  COMPLETION_PROMISE_YAML="null"
fi

cat > .claude/ralph-loop.local.md <<EOF
---
active: true
iteration: 1
max_iterations: $MAX_ITERATIONS
completion_promise: $COMPLETION_PROMISE_YAML
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---

$PROMPT
EOF

cat <<EOF
🔄 Ralph loop activated!

Iteration: 1
Max: $(if [[ $MAX_ITERATIONS -gt 0 ]]; then echo $MAX_ITERATIONS; else echo "unlimited"; fi)
Promise: $(if [[ "$COMPLETION_PROMISE" != "null" ]]; then echo "${COMPLETION_PROMISE//\"/}"; else echo "none"; fi)

⚠️  Loop runs until promise or max-iterations reached.
EOF

echo ""
echo "$PROMPT"
