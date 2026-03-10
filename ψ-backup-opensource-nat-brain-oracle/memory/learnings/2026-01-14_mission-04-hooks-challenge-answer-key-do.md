---
title: ## MISSION-04: Hooks Challenge - Answer Key
tags: [mission-04, hooks-challenge, answer-key, safety-guardian, squad-challenge]
created: 2026-01-14
source: MISSION-04 Answer Key (private)
---

# ## MISSION-04: Hooks Challenge - Answer Key

## MISSION-04: Hooks Challenge - Answer Key

**DO NOT PUT IN PUBLIC REPO**

### Safety Guardian Complete Solution

```bash
#!/bin/bash
# Safety Guardian - Complete Solution

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$CMD" ]; then
    exit 0
fi

# Block rm -rf
if echo "$CMD" | grep -qE '(^|\s)rm\s+.*-rf|^rm\s+-rf'; then
    echo "BLOCKED: rm -rf not allowed." >&2
    echo "Use: mv <path> /tmp/trash_\$(date +%Y%m%d_%H%M%S)_\$(basename <path>)" >&2
    echo "Recovery: ls /tmp/trash_*" >&2
    exit 2
fi

# Block --force on git
if echo "$CMD" | grep -qE '^git\s+.*--force|^git\s+.*\s-f(\s|$)'; then
    echo "BLOCKED: --force flag not allowed on git commands." >&2
    echo "Reason: Force operations can overwrite history and lose work." >&2
    exit 2
fi

# Block git reset --hard
if echo "$CMD" | grep -qE '^git\s+reset\s+--hard'; then
    echo "BLOCKED: git reset --hard not allowed." >&2
    echo "Use: git stash (to save changes) or git checkout -- <file> (for specific files)" >&2
    exit 2
fi

# Block push to main
if echo "$CMD" | grep -qE '^git\s+push\s+(origin\s+)?main(\s|$)'; then
    echo "BLOCKED: Direct push to main not allowed." >&2
    echo "Use: Create a PR on a feature branch instead" >&2
    exit 2
fi

exit 0
```

### Grading Notes

1. **rm -rf (25 pts)**: Must catch both `rm -rf` and `rm -r -f` and `rm file -rf`
2. **--force (20 pts)**: Must catch both `--force` and `-f` on git commands
3. **reset --hard (20 pts)**: Straightforward grep match
4. **push main (15 pts)**: Must handle both `git push main` and `git push origin main`
5. **Safe alternatives (10 pts)**: Should suggest mv to /tmp, stash, PR
6. **Clean code (10 pts)**: Comments, structure, readability

---
*Added via Oracle Learn*
