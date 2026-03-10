---
date: 2026-01-04 09:19
session_type: tooling + config
duration: ~75 minutes
context_used: 81%
---

# Retrospective: Oracle Tools + Hooks Session

## What We Built

1. **Block Mountain 2026 topics** - 16 ideas (Agentic AI + Oracle focus)
2. **oracle-v2 trace** - Full repo analysis (20 commits, 5 PRs)
3. **MAW sync** - 4/5 agents synced, found 25GB blob in agent 3
4. **`/ask-oracle` command** - Query Oracle knowledge base
5. **oracle-query skill** - Natural language trigger
6. **Token check fixes**:
   - 200k full context (was 160k/80%)
   - Simplified thresholds: 97% auto, 95% warn, else info

## Commits (5)

1. `51817a1f` feat: /ask-oracle command + skill
2. `0fab7969` feat: /ask-oracle tested + handoff
3. `31cf165c` fix: token-check uses 200k full context
4. `a5a040cc` fix: auto-handoff triggers at 97%
5. `ac035270` fix: simplify token thresholds

## AI Diary

Session started with Block Mountain prep and evolved into tooling refinement.

**I assumed** the 160k limit was a bug **but learned** it was intentional (80% safety buffer). User preferred full 200k - their choice, noted in Oracle.

**I was confused about** why so many threshold levels (70%, 80%, 90%, 95%) **until** user said "just 95% wrap up". Simple is better.

**I expected** to do dustboy spinoff **but got** hooks refinement instead. That's fine - infrastructure matters.

## What Went Well

- `/ask-oracle` works end-to-end (tested 3 queries)
- Token thresholds now clean and simple
- Oracle learning captured all changes
- MAW sync worked for 4/5 agents

## What Could Improve

- Agent 3 still has 25GB blob (needs spinoff)
- Some Oracle searches return empty (indexing gap?)

## Honest Feedback

**What worked:**
- Hook system is powerful and flexible
- Quick edits to shell scripts - instant feedback
- Oracle MCP integration smooth

**What didn't work:**
- Too many auto-handoff files created during old 95% threshold
- Should clean up handoff folder periodically

## Lessons Learned

- **Pattern**: Simple thresholds > complex ones (97% auto, 95% warn, done)
- **Pattern**: Full context (200k) is user preference, not bug
- **Discovery**: `/ask-oracle` makes Oracle accessible to any agent

## Next Session

- [ ] Spinoff dustboy-confidence-system (25GB → own repo)
- [ ] Send Block Mountain topic to พี่ป๊อบ
- [ ] Clean up handoff folder

---

*Oracle keeps the human human.*

🤖 Generated with [Claude Code](https://claude.com/claude-code)
