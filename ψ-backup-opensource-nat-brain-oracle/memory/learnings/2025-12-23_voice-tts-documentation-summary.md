# Voice/TTS Documentation Summary

**Compiled**: 2025-12-23
**Source Repository**: weyermann-malt-productpage (Nat's Learning Lab)
**Key Files**: MAW_ANALYSIS.md, agent-complete-notify.sh, retrospectives/

---

## Overview

Voice/TTS is implemented in Nat's Multi-Agent Workflow (MAW) system as part of the **safety infrastructure** for distributed agent coordination. Using macOS `say` command plus custom notification hooks, each agent has a unique voice that announces completion.

---

## Key Documents & Locations

| Document | Location | Purpose |
|----------|----------|---------|
| **MAW_ANALYSIS.md** | `ψ/memory/learnings/maw/MAW_ANALYSIS.md` | Comprehensive MAW pattern with voice notification section |
| **Voice Notifications Retrospective** | `ψ/learn/weyermann/ψ-retrospectives/2025-12/02/08-26_retrospective.md` | Implementation details and technical decisions |
| **Agent Notification Script** | `ψ/learn/weyermann/scripts/agent-complete-notify.sh` | Bash hook plus speech queue mechanism |
| **Voice Config** | `ψ/learn/weyermann/scripts/agent-voices.toml` | Per-agent voice mapping |
| **MAW Analysis (Local)** | `ψ/memory/learnings/maw/MAW_ANALYSIS.md` | Synced copy with full architecture |

---

## Core Concepts

### 1. Problem Statement

- **Terminal output gets lost in noise** during multi-agent parallel workflows
- Human operator can't track which agent finished without reading logs
- Solution: Auditory feedback with per-agent unique voice

### 2. Architecture

Agent completion triggers Claude Code hook, which calls notification script. Script detects agent from filesystem path, then uses macOS `say` with speech queue to prevent overlaps.

### 3. Key Implementation Details

#### Detection Mechanism
Check current working directory to identify which agent finished:
- Path contains `agents/1` → Agent 1
- Path contains `agents/2` → Agent 2
- Hook is `SubagentStop` → Claude Subagent
- Otherwise → Main Agent

#### Speech Queue (Prevent Overlaps)
Before calling `say`, check if any `say` processes are running. If yes, wait 100ms and retry. Once clear, run speech command in background.

#### Voice Configuration (TOML)
Map each agent to unique macOS voice: Victoria, Albert, Moira for Agent 1, 2, 3. Samantha for Main. Serena for subagents.

---

## Implementation Timeline (Dec 2025)

| Date | Time | What | File |
|------|------|------|------|
| Dec 1-2 | 13:00-08:26 | Voice notification system research and implementation | agent-complete-notify.sh |
| Dec 2 | 08:26 | Session retrospective with technical decisions | 08-26_retrospective.md |
| Dec 13 | - | Integrated into MAW_ANALYSIS for public documentation | MAW_ANALYSIS.md |
| Dec 23 | - | This summary document | (this file) |

---

## Technical Decisions & Rationale

### Decision 1: Path-Based Agent Identification

**Problem**: Counter-based naming (1, 2, 3) confused with Claude's internal subagent numbering
**Solution**: Use actual filesystem path (`agents/1`, `agents/2`, `agents/3`)
**Benefit**: Matches physical structure, no ambiguity with SubagentStop events

### Decision 2: Dual Hooks

**Problem**: Need to notify for both MAW agents (real tmux processes) AND Claude subagents
**Solution**: Subscribe to both `Stop` (MAW) and `SubagentStop` (Claude) hooks
**Benefit**: Comprehensive notification coverage

### Decision 3: Speech Queue

**Problem**: Multiple agents finishing simultaneously results in overlapping voice output
**Solution**: Use `pgrep -x "say"` polling with 100ms wait loops
**Benefit**: Sequential, intelligible announcements

### Decision 4: Per-Agent Voice

**Problem**: Operator can't distinguish which agent spoke in a crowded room
**Solution**: Assign unique macOS voice to each agent
**Benefit**: Auditory distinction without reading transcript

---

## Integration with Claude Code

### Hook Integration

Claude Code settings.json can subscribe to completion events:
- `Stop`: Fires when any agent process completes
- `SubagentStop`: Fires when a Claude subagent finishes

Both hooks can call the same notification script.

### Implementation Pattern

The script runs automatically when either hook fires. It:
1. Reads the hook input (cwd, transcript, event type)
2. Determines which agent from the path
3. Extracts last message from transcript
4. Waits for speech queue to clear
5. Calls `say` with the appropriate voice

---

## Use Cases

| Scenario | Benefit |
|----------|---------|
| Multi-agent development (5+ agents) | Operator knows who finished without looking |
| Parallel testing | Auditory feedback of completion order |
| Distributed debugging | Each agent's voice helps contextualize logs |
| Safety-critical ops | Confirmation of successful agent completion |
| Crowded workspace | Distinct voices prevent confusion |

---

## macOS `say` Command Basics

Simple text-to-speech command available on all Macs.

Basic usage:
```
say "Agent 1 completed task"
```

With voice selection:
```
say -v Victoria "Agent 1 completed"
```

With rate (words per minute):
```
say -r 150 "Fast announcement"
```

### Available Voices
- Victoria, Albert, Moira (default quality)
- Samantha, Serena (better quality)
- Karen, Tom, Alex (legacy)

---

## Lessons Learned

### What Worked Well
1. MCP playwright browser for reading Claude Code docs
2. Iterative development with immediate user feedback
3. Reusing existing MAW scripts in monitor subagent
4. Path-based identification prevents ambiguity
5. Speech queue elegantly solves overlap problem

### What Could Improve
1. Initially confused SubagentStop with Stop hooks
2. Used counter-based naming before switching to path-based
3. Could have checked hook input structure earlier

### Patterns Discovered
- Infrastructure-first mindset: Treat MAW as safety infrastructure, not convenience
- Dual-hook pattern: Subscribe to multiple event types for comprehensive coverage
- Speech queue as queue discipline: Simple polling beats complex queue structures
- Voice as context: Auditory channels add information density

---

## Files to Explore Further

1. **`ψ/memory/learnings/maw/MAW_ANALYSIS.md`** - Full MAW pattern with safety rules
   - Section 3: Voice-Based Notifications
   - Section 4: File Signal Detection
   - Architecture overview

2. **`ψ/learn/weyermann/ψ-retrospectives/2025-12/02/08-26_retrospective.md`** - Retrospective
   - Technical implementation details
   - AI diary of discovery process
   - Blockers and resolutions

3. **`ψ/learn/weyermann/scripts/agent-complete-notify.sh`** - Actual implementation
   - Bash hook logic
   - Speech queue mechanism
   - Agent detection

4. **`ψ/learn/weyermann/scripts/agent-voices.toml`** - Voice configuration
   - Per-agent voice mapping
   - Easy customization

---

## Related Learning Records

| Record | Topic |
|--------|-------|
| 2025-12-17_maw-sync-best-practices.md | Multi-agent sync patterns |
| 006-plugin-system-architecture.md | Claude Code plugin structure |
| 2025-12-13_subagent-delegation-pattern.md | When to delegate to subagents |

---

## Quick Reference: Adding Voice Notification to New Project

Step 1: Copy hook script
```
cp agent-complete-notify.sh your-project/scripts/
```

Step 2: Update settings.json to register hooks for Stop events

Step 3: Configure voices in TOML (optional)

Step 4: Test with `say "Test notification"`

---

**Source Code**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/learn/weyermann/`
**Last Synced**: 2025-12-23
**Status**: Active learning, integrated into main MAW infrastructure
