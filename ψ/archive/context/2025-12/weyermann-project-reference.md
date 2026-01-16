# Weyermann Project — Complete Timeline & Locations

## Executive Summary

**Weyermann** is a multi-agent development project for a specialty malt product page. It ran from **Nov 30 - Dec 6, 2025** (~7 days) and was subsequently transferred to the current Oracle project on **Dec 9, 2025**. The knowledge transfer established core patterns now in use across Nat's Agents.

---

## Timeline

### Phase 1: Foundation (Nov 30)
- **Date**: 2025-11-30
- **Work**: CLAUDE.md setup, spec-kit integration, initial architecture
- **Files**: CLAUDE.md, CLAUDE_safety.md, CLAUDE_workflows.md, CLAUDE_subagents.md created

### Phase 2: Product Display (Dec 1-2)
- **Date**: 2025-12-01 to 2025-12-02
- **Work**: Vanilla HTML/CSS/JS product catalog for 17 malt categories, 60+ products
- **Features**: Responsive design, Intl.NumberFormat for Thai Baht, semantic HTML
- **Files**: index.html, styles.css, app.js, products.json

### Phase 3: Multi-Agent Workflow (Dec 2-3)
- **Date**: 2025-12-02 to 2025-12-03
- **Work**: Git worktree management, agent locking system, smart sync
- **Systems**: agent-lock.sh, smart-sync.sh, worktree isolation (agents/1, agents/2, agents/3)
- **Pattern**: Prevents concurrent work conflicts with atomic lock files

### Phase 4: Voice Notifications (Dec 4-5)
- **Date**: 2025-12-04 to 2025-12-05
- **Work**: macOS voice system, TOML configuration, speech queue
- **Systems**: Hooks (SessionStart, Stop, SubagentStop), say command, desktop notifications
- **Voices**: Samantha, Daniel, Karen, Rishi (configurable via TOML)
- **Limitation**: osascript notifications need System Settings permission

### Phase 5: Integration & Polish (Dec 6)
- **Date**: 2025-12-06
- **Work**: Final testing, documentation, retrospectives
- **Output**: 7-day DEVELOPMENT-REPORT.md, 166 commits analyzed

---

## Git Commits Related to Weyermann

| Commit Hash | Date | Message |
|-------------|------|---------|
| ad9b49f | 2025-12-09 14:02:50 | docs: weyermann vs oracle system analysis |
| 3705d09 | 2025-12-09 16:23:50 | feat: add agents and commands from weyermann |
| fde81b3 | 2025-12-09 18:56:59 | feat: adopt ψ patterns from Weyermann — structure without prefix |

---

## File Locations

### In Current Repo

#### 1. Retrospectives & Logs
```
ψ/memory/retrospectives/2025-12/09/14.15_oracle-weyermann-transfer.md
ψ/memory/logs/2025-12/09_16.36_claude-code-plugin-complete.md
ψ/memory/logs/2025-12/09_18.29_retrospective-naming-pattern.md
ψ/memory/logs/2025-12/09_18.41_psi-pattern-adoption.md
ψ/memory/logs/2025-12/09_19.44_full-day-oracle-foundation.md
```

#### 2. Knowledge Transfer Documentation
```
.claude/commands/rrr.md          # Retrospective command from weyermann
.claude/agents/context-finder.md # Search agent from weyermann
scripts/agent-*.sh                # Voice notification hooks
```

#### 3. Archived Weyermann Copy
```
.tmp/weyermann-malt-productpage/  # Complete project clone
├── ψ-archive/                    # Past work
├── ψ-docs/                       # Documentation
│   └── DEVELOPMENT-REPORT.md     # 7-day timeline
├── ψ-learnings/                  # Institutional memory
├── ψ-logs/                       # Session logs
├── ψ-retrospectives/             # Session reflections
├── .claude/                       # Agent & command configs
├── .codex/                        # Code specifications
├── CLAUDE.md                      # AI assistant reference
├── AGENTS.md                      # Subagent docs
└── [web files]                    # HTML/CSS/JS product page
```

---

## Key Knowledge Transferred to Oracle

### 1. Agents & Commands
- **context-finder**: Haiku model for searching git/issues/retrospectives
- **rrr command**: Structured session retrospective creation
- **/snapshot command**: Quick knowledge capture (not yet in CLAUDE.md)
- **/ccc command**: Create context issue + compact conversation

### 2. Voice System
- **macOS native `say` command** with per-agent voices
- **TOML configuration** for voice selection
- **Speech queue** using atomic mkdir locking
- **Hooks** for SessionStart, SessionStop, SubagentStop events
- **Limitation discovered**: osascript notifications need System Settings; use terminal-notifier as fallback

### 3. Patterns
- **Bridge Report pattern**: Comprehensive analysis of project history (166 commits → 1 report)
- **Worktree management**: Git-based agent isolation with lock system
- **Parallel sub-agents**: Spawn multiple agents in single message call
- **Learning capture**: Proactive documentation without being asked

### 4. Documentation Structure
- **Modular CLAUDE.md**: Hub-and-spoke with safety/workflows/subagents/lessons/templates
- **No ψ- prefix for folders**: Keep naming simple (learnings/ not ψ-learnings/)
- **Commit format**: feat/docs/fix + emoji + brief message
- **Retrospective format**: YYYY-MM/DD/HH.MM_slug.md with sections for timeline, diary, learnings

---

## GitHub Issues Related to Weyermann

| Issue | Created | Title |
|-------|---------|-------|
| #1 | 2025-12-09 12:51:08Z | context: 2025-12-09 Full Day Oracle Foundation |

(Weyermann itself was a standalone project, issues tracked separately)

---

## Technical Specifications

### Product Display
- **Framework**: Vanilla HTML/CSS/JavaScript (no build tools)
- **Data**: products.json with 60+ items across 17 categories
- **Styling**: Mobile-first responsive design (320px+)
- **Currency**: Thai Baht (฿) via Intl.NumberFormat
- **Accessibility**: WCAG AA color contrast

### Multi-Agent Workflow
- **Version Control**: Git worktrees for isolated agent workspaces
- **Locking**: Atomic mkdir-based lock system
- **Synchronization**: Smart sync detects dirty state, validates branches
- **Status**: Real-time availability monitoring

### Voice System
- **Platform**: macOS only
- **Voices Available**: Samantha, Daniel, Karen, Rishi, Victoria, Alex, Bruce, Kathy
- **Configuration**: ~/.claude/settings.json or project TOML
- **Notification Type**: say command + (optional) macOS notification with sound
- **Queue Management**: mkdir-based atomic locks prevent audio overlap

---

## Knowledge Transfer Session Details

### Session: Oracle Weyermann Transfer
- **Date**: 2025-12-09
- **Time**: 11:00 - 14:15 (195 minutes)
- **Focus**: Transfer 7 days of weyermann learnings to Oracle project
- **Files Modified**: 25 files changed, +2,477 lines, -69 lines

### Key Learnings from Transfer Session

1. **Context-finder by default**: Always delegate file searching to sub-agents, don't read directly
2. **Parallel sub-agents**: Spawn multiple agents in single message for 10x speed improvement
3. **Proactive learning capture**: Document patterns without being asked (saves user friction)
4. **osascript notification limitation**: Commands execute (exit 0) but notifications don't appear — use terminal-notifier as fallback

---

## Current Status of Weyermann

| Aspect | Status |
|--------|--------|
| Original Project | Complete (7-day cycle ended Dec 6) |
| Code Archive | In .tmp/weyermann-malt-productpage/ |
| Knowledge Transfer | Complete (Dec 9, 11:00-14:15) |
| Active Use | Patterns now in Oracle project |
| Repository | Standalone (not in git history of main repo) |
| Voice System | Adopted (with osascript limitation noted) |
| Commands | rrr, context-finder, /snapshot, /ccc adopted |

---

## How to Access Weyermann Learning

### For Historical Context
```
ψ/memory/retrospectives/2025-12/09/14.15_oracle-weyermann-transfer.md
```
This 800+ word retrospective covers:
- Complete timeline (11:00-14:15)
- 25 files modified
- Bridge Report analyzing 166 commits
- 4 core learnings about delegation
- Honest feedback about osascript limitations
- Resonance moments and teaching insights

### For Voice System Details
```
.tmp/weyermann-malt-productpage/ψ-docs/DEVELOPMENT-REPORT.md
```
This covers the 7-day weyermann development cycle with:
- Feature inventory (4 major systems built)
- Technical architecture
- Voice configuration details
- Lessons from integration

### For Code References
```
.tmp/weyermann-malt-productpage/.claude/  # Agent configs
.tmp/weyermann-malt-productpage/scripts/  # Voice hooks
```

---

## Unresolved Items

1. **osascript notification display**: Commands execute successfully but no visual notification appears
   - **Workaround**: Use terminal-notifier instead
   - **Status**: Documented in learnings, not yet fixed

2. **ψ/ prefix adoption**: Weyermann used ψ-learnings/, current uses learnings/
   - **Decision**: Current approach (no prefix) is simpler
   - **Status**: Intentionally different from weyermann

3. **Speech-to-text inaccuracy**: Some voice messages were hard to parse
   - **Mitigation**: Confirm unclear messages before acting
   - **Status**: Added to learning 003

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| Project Duration | 7 days (Nov 30 - Dec 6) |
| Commits in Weyermann | 166 analyzed |
| GitHub Issues in Project | 82 analyzed |
| Session Retrospectives | 34 created during project |
| Knowledge Transfer Time | 195 minutes (11:00-14:15) |
| Files in Archive | 29 tracked + several ephemeral |
| Commits in Oracle Repo | 3 direct references to weyermann |
| Agents Transferred | 9 subagent templates |
| Commands Transferred | 4 core commands (rrr, context-finder, /snapshot, /ccc) |
| Lines Added to Oracle | 2,477+ from weyermann integration |

