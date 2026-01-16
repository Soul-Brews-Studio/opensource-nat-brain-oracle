# Weyermann Project — Quick Reference Card

## One-Liner
7-day multi-agent product page project (Nov 30-Dec 6) → Knowledge transferred to Oracle (Dec 9)

## Timeline at a Glance
```
Nov 30    Foundation (CLAUDE.md setup)
Dec 1-2   Product Display (HTML/CSS/JS, 60+ malts)
Dec 2-3   Multi-Agent Workflow (git worktrees, locks)
Dec 4-5   Voice Notifications (macOS say + TOML)
Dec 6     Polish & Documentation
Dec 9     Knowledge Transfer → Oracle (195 min, +2,477 lines)
```

## What Was It?
- **Type**: Specialty malt product catalog + Multi-agent development framework
- **User**: Weyermann brand products (17 categories)
- **Innovation**: Voice notifications for agent status + Git-based agent isolation
- **Status**: Complete → Archived in .tmp/ → Patterns live in Oracle

## Key Artifacts

| Location | What | Use When |
|----------|------|----------|
| `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/retrospectives/2025-12/09/14.15_oracle-weyermann-transfer.md` | Transfer session (800+ words) | Need full context |
| `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.tmp/weyermann-malt-productpage/ψ-docs/DEVELOPMENT-REPORT.md` | 7-day development timeline | Need technical details |
| `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.tmp/weyermann-malt-productpage/.claude/` | Agent configs + voice setup | Need code examples |

## Tech Stack
- **Frontend**: Vanilla HTML/CSS/JS (no build tools)
- **Data**: JSON products file (static, read-only)
- **Styling**: Mobile-first responsive (320px+)
- **Currency**: Thai Baht with Intl.NumberFormat
- **Voice**: macOS `say` command + TOML config
- **Versioning**: Git worktrees (agents/1, agents/2, agents/3)
- **Locking**: Atomic mkdir-based system

## What Got Transferred to Oracle?

| What | File |
|------|------|
| Retrospective command | `.claude/commands/rrr.md` |
| Search agent (Haiku) | `.claude/agents/context-finder.md` |
| Voice hooks | `scripts/agent-*.sh` |
| Documentation structure | `CLAUDE*.md` files |
| Subagent templates | 9 agents copied |
| Commands | /snapshot, /ccc, /recap, rrr |

## 4 Core Learnings from Transfer

1. **Context-finder by default** — Don't read files directly, delegate to sub-agent
2. **Parallel sub-agents** — Spawn multiple agents in ONE message for 10x speed
3. **Proactive learning** — Capture patterns without being asked (reduces friction)
4. **Notification fallback** — osascript needs permission; use terminal-notifier instead

## Known Limitations

| Issue | Status | Workaround |
|-------|--------|-----------|
| osascript notifications don't appear | Documented | Use terminal-notifier |
| Speech-to-text sometimes unclear | Documented | Confirm before acting |
| ψ/ prefix vs. no prefix inconsistency | By design | Current: no prefix (simpler) |

## Numbers
- 7 days development
- 166 commits analyzed
- 82 issues in project
- 34 retrospectives created
- 195 minutes transfer session
- +2,477 lines added to Oracle
- 60+ products in catalog
- 17 malt categories

## Git References
```
ad9b49f - docs: weyermann vs oracle system analysis
3705d09 - feat: add agents and commands from weyermann
fde81b3 - feat: adopt ψ patterns from Weyermann — structure without prefix
```

## Next Steps if Needed
- [ ] Fix osascript notifications (System Settings or terminal-notifier)
- [ ] Migrate speech-to-text error handling to CLAUDE_lessons.md
- [ ] Consider open-sourcing product page template
- [ ] Document voice configuration in separate VOICE.md

---

**Full Reference**: See `weyermann-project-reference.md` for comprehensive timeline & locations
