# Claude Code Autonomous Mode - Complete Reference

> **Living Document**: Append new learnings at bottom. Never delete.
> **Last Updated**: 2025-12-30 14:15

---

## 1. Context Monitoring

### How It Works
- `ψ/active/statusline.json` stores current token usage
- Pre/Post hooks on Bash/Task/Read show context %
- Formula: `usable = total * 80%` (auto-compact reserves 20%)
- Total context: 200k tokens, Usable: 160k tokens

### Urgency Levels
| % Used | Icon | Action |
|--------|------|--------|
| < 70%  | 📊 | Normal work |
| 70-79% | ⚡ | Finish current task soon |
| 80-89% | ⚠️ | Wrap up, prepare handoff |
| 90%+   | 🚨 | HANDOFF NOW - stop and write |

### Script Location
`.claude/scripts/token-check.sh`

### Hook Configuration
```json
// .claude/settings.json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [".claude/scripts/token-check.sh"] },
      { "matcher": "Task", "hooks": [".claude/scripts/token-check.sh"] },
      { "matcher": "Read", "hooks": [".claude/scripts/token-check.sh"] }
    ],
    "PostToolUse": [
      { "matcher": "Bash", "hooks": [".claude/scripts/token-check.sh"] },
      { "matcher": "Task", "hooks": [".claude/scripts/token-check.sh"] },
      { "matcher": "Read", "hooks": [".claude/scripts/token-check.sh"] }
    ],
    "SessionStart": [
      ".claude/scripts/show-latest-handoff.sh"
    ]
  }
}
```

---

## 2. Handoff System

### When to Write
- Context reaches 90%+
- Switching to different task
- End of work session
- Before complex operation that might fail

### Handoff Location
```
ψ/inbox/handoff/YYYY-MM-DD_HH-MM_topic.md
```

### Handoff Template
```markdown
# Handoff: [Topic]

**Date**: YYYY-MM-DD HH:MM-HH:MM
**Duration**: ~XX minutes
**Context at handoff**: XX% (XXXk/160k usable)

---

## Done This Session
- [x] Task 1 description
- [x] Task 2 description
- [ ] Incomplete task (explain why)

## Files Changed
| File | Change |
|------|--------|
| path/to/file.ts | What was changed |
| path/to/other.md | What was changed |

## Commands to Remember
```bash
pm2 restart oracle-v2-server  # Restart server
maw sync                       # Sync agents
```

## Errors Encountered & Fixed
1. **Error**: [description]
   **Fix**: [solution]

## Next Steps (Priority Order)
1. [ ] Most important next task
2. [ ] Second priority
3. [ ] Can wait

## Key Learnings
- Learning 1
- Learning 2

---

*Generated at XX% context*
```

### Reading Handoff (Session Start)
- Hook: `.claude/scripts/show-latest-handoff.sh`
- Checks `ψ/inbox/handoff/` for today/yesterday files
- Displays content at session start
- AI should continue where previous session stopped

### show-latest-handoff.sh
```bash
#!/bin/bash
ROOT="${CLAUDE_PROJECT_DIR:-/Users/nat/Code/github.com/laris-co/Nat-s-Agents}"
HANDOFF_DIR="$ROOT/ψ/inbox/handoff"
[ ! -d "$HANDOFF_DIR" ] && exit 0
LATEST=$(ls -t "$HANDOFF_DIR"/*.md 2>/dev/null | head -1)
[ -z "$LATEST" ] && exit 0

HANDOFF_DATE=$(basename "$LATEST" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
TODAY=$(date '+%Y-%m-%d')
YESTERDAY=$(date -v-1d '+%Y-%m-%d' 2>/dev/null)

if [ "$HANDOFF_DATE" = "$TODAY" ] || [ "$HANDOFF_DATE" = "$YESTERDAY" ]; then
  echo "📋 RECENT HANDOFF: $LATEST"
  cat "$LATEST"
  echo "💡 Continue where previous session left off."
fi
```

---

## 3. Lesson Learning System

### When to Write Lesson Learned
- Fixed an error (especially tricky ones)
- Discovered a useful pattern
- Found a workaround for a limitation
- Resolved a merge conflict
- Learned something about the codebase

### How to Write (Oracle MCP)
```bash
oracle_learn("## Title

Description of the pattern or lesson...

### The Problem
What went wrong or was confusing

### The Solution
How to fix it

### Key Points
1. Point 1
2. Point 2",
concepts=["tag1", "tag2", "tag3"])
```

### Lesson Template
```markdown
## [Descriptive Title]

[1-2 sentence summary of the lesson]

### The Problem
[What error occurred or what was confusing]

### The Error Pattern
```
[Exact error message if applicable]
```

### The Solution
```bash
[Commands or code that fixed it]
```

### Why This Works
[Brief explanation of why the solution works]

### Key Points
1. First key takeaway
2. Second key takeaway
3. Third key takeaway

### Related
- [Link to related docs if any]
- [Related concept]
```

### Storage Location
```
ψ/memory/learnings/YYYY-MM-DD_title-slug.md
```

### Querying Past Learnings
```bash
oracle_search("keywords", limit=10)
oracle_list(type="learning", limit=20)
```

---

## 4. Safety Rules

### Git - NEVER Do
| Command | Why Blocked |
|---------|-------------|
| `git push --force` | Destroys remote history |
| `git push --force-with-lease` | Still dangerous |
| `git reset --hard` | Loses uncommitted work |
| `git commit --amend` | Changes hash, breaks multi-agent |
| `git clean -fd` | Deletes untracked files permanently |

### Git - Safe Alternatives
```bash
# Instead of force push after rebase:
git branch -m old-branch old-branch-v2
git push -u origin old-branch-v2
gh pr close OLD_NUMBER --comment "Superseded by new PR"
gh pr create --title "..." --body "Supersedes #OLD"

# Instead of reset --hard:
git stash
git stash list  # Recovery: git stash pop

# Instead of amend:
git commit -m "fix: correction to previous commit"
```

### File Operations - NEVER Do
| Command | Why Blocked |
|---------|-------------|
| `rm -rf` | Permanent deletion |
| Delete outside repo | User must know |
| Write to system dirs | Dangerous |

### File Operations - Safe Alternatives
```bash
# Instead of rm -rf:
mv /path/to/delete /tmp/trash_$(date +%Y%m%d_%H%M%S)_$(basename /path/to/delete)

# Recovery:
ls /tmp/trash_*

# Temp files inside repo:
.tmp/           # gitignored temp dir
ψ/active/       # gitignored active research
```

### PR Operations
| Action | Allowed? |
|--------|----------|
| Create PR | ✅ Yes |
| Merge PR | ✅ Yes (updated 2025-12-30) |
| Force merge | ❌ Never |
| Delete branch | ✅ After merge only |

### Hook: safety-check.sh
Location: `.claude/hooks/safety-check.sh`
Blocks dangerous commands before execution.

---

## 5. Oracle Consultation

### Before Starting Work
```bash
# Search for related patterns
oracle_search("topic keywords", limit=10)

# Get guidance on decisions
oracle_consult("should I use X or Y?", context="current situation")
```

### After Completing Work
```bash
# Record what you learned
oracle_learn("pattern description", concepts=["tag1", "tag2"])
```

### For Inspiration
```bash
# Random principle or learning
oracle_reflect()
```

### Browsing Knowledge
```bash
# List all learnings
oracle_list(type="learning", limit=20)

# List principles
oracle_list(type="principle", limit=10)

# List retrospectives
oracle_list(type="retro", limit=10)
```

---

## 6. MAW Multi-Agent Coordination

### Check Status
```bash
source .agents/maw.env.sh
maw peek          # See all agents status
```

### Sync After Changes
```bash
git push origin main  # Push to remote first!
maw sync              # Then sync all agents
```

### Common Commands
```bash
maw peek              # Status of all agents
maw sync              # Sync all to main
maw hey 1 "task"      # Send task to agent 1
maw merge 1           # Merge agent 1 work to main
maw watch             # Poll until agents done
```

### Key Rules
1. Always `git push` before `maw sync`
2. Never force push in multi-agent setup
3. Use `git -C /path` not `cd` for worktree ops
4. Check `pwd` at session start - might be in wrong worktree

---

## 7. Quick Reference Card

```
┌─────────────────────────────────────────────┐
│           AUTONOMOUS MODE RULES             │
├─────────────────────────────────────────────┤
│ 90%+ context  → Write handoff NOW           │
│ Error fixed   → Write lesson learned        │
│ Before work   → Check Oracle                │
│ After merge   → git push, then maw sync     │
│ Delete files  → mv to /tmp, never rm -rf    │
│ Force push    → NEVER, use new branch       │
│ Session start → Read latest handoff         │
│ Session end   → Commit, push, handoff       │
└─────────────────────────────────────────────┘
```

---

## Appendix: Session Log

> Append new learnings below this line. Format: `### YYYY-MM-DD: Topic`

### 2025-12-30: Initial Documentation
- Created this reference document
- Documented context monitoring, handoff, lesson learning, safety rules
- Session completed Spec 050 (Arthur UI) and /trace enhancement

