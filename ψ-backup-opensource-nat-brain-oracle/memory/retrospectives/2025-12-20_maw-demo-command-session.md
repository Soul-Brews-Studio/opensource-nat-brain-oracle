# Session Retrospective: MAW Demo Command

**Date**: 2025-12-20
**Duration**: ~1.5 hours (12:27 - 13:46)
**Focus**: Creating `/maw-demo` command and iterating through parallel execution trials

---

## What Happened

Built a complete `/maw-demo` slash command that demonstrates MAW parallel agent execution. Ran 8 trials, fixing bugs along the way.

### Trial Summary

| Trial | Score | Issue Found |
|-------|-------|-------------|
| 1-3 | Failed | Auto-warp bug (window indices 1/2 → 0/1) |
| 4 | 7.7/10 | Agent 2 didn't respond |
| 5 | 7.7/10 | Agent 2 needed Enter |
| 6 | 9.3/10 | All 3 worked, 1432 lines |
| 7 | 10/10 | All 3 worked, 906 lines |
| 8 | 6.7/10 | Agent 2 was Codex not Claude |

### Bugs Fixed

1. **Auto-warp window indices** - Changed from 1/2 to 0/1 in `start-agents.sh`
2. **hey.sh timing** - Increased sleep from 0.05s to 0.3s before Enter

### Remaining Issues

1. **Profile starts Codex** - Need `profile-claude-only`
2. **focus.md conflicts** - Still need manual resolution

---

## Deliverables Created

**Documentation files**: 12 new files, 2826+ lines total

- maw-hey-instruction.md
- maw-parallel-agents-tutorial.md
- maw-tag-checkpoint-pattern.md
- maw-peek-guide.md
- maw-sync-internals.md
- maw-profiles-guide.md
- maw-hey-command-guide.md
- maw-kill-guide.md
- maw-start-guide.md
- maw-error-recovery.md
- maw-profile-creation.md
- maw-troubleshooting.md
- maw-direnv-setup.md
- maw-pocketbase.md
- maw-tmux-config.md
- maw-workflow-automation.md
- maw-session-management.md

**Command created**: `.claude/commands/maw-demo.md`

---

## AI Diary

ทำ demo command ที่ iterate ได้เรื่อยๆ รู้สึกดีที่เห็น pattern ชัด - spawn subagents ให้หา tasks, ส่งไป MAW agents, collect กลับมา score

สิ่งที่เรียนรู้: bug มักซ่อนอยู่ใน timing และ assumptions เล็กๆ เช่น window index เริ่มที่ 0 ไม่ใช่ 1, sleep 0.05 สั้นเกินไปสำหรับ Claude

ยังต้อง fix เรื่อง profile ที่ start Codex แทน Claude - เป็น friction ที่ต้อง manual Ctrl+C ทุกรอบ

---

## Honest Feedback

**What worked well:**
- Subagent delegation pattern - Haiku finds tasks, Opus orchestrates
- Iterative approach - each trial improved the workflow
- Real parallel execution verified

**What needs improvement:**
- Profile should start Claude directly
- focus.md conflicts are annoying
- Need `maw ready` command to check agent state

**User collaboration:**
- User pushed for iteration ("start over", "test and score")
- Direct feedback helped refine the demo

---

## Next Actions

1. [ ] Create `profile-claude-only`
2. [ ] Add auto-stash to `maw sync`
3. [ ] Create `maw ready` command
4. [ ] Consider gitignoring focus.md

---

## Key Commands

```bash
# Run the demo
/maw-demo

# Manual workflow
tmux kill-server
maw start profile14
# Ctrl+C to kill Codex, then:
maw hey N "claude --dangerously-skip-permissions"
maw sync
maw hey N "task..."
maw peek
```

---

*Session ended: 13:46*
