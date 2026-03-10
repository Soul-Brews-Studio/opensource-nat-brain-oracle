# /incubation Command & Incubation System - Complete Reference

## Command Status

**Location**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/commands/`

### Status: CONCEPT (NOT YET IMPLEMENTED)
- **File**: `ψ/lab/concepts/002-content-type-commands.md`
- **Status**: 🥚 Ready to move to new repo
- **Decision**: Pending (implement or extract to separate repo)

---

## What is `/incubate`?

A command that signals: **"This idea is ready to move to a separate repository"**

### Design from 002-content-type-commands.md

```markdown
| `/incubate` | 🥚 | Ready to move to new repo | GitHub Issue |
```

### Proposed Usage

```bash
/incubate voice-bridge --repo nazt/voice-bridge
/incubate cellar --repo nazt/cellar
```

### Process Flow

1. User types `/incubate [project-name] --repo [github-repo]`
2. System creates a GitHub Issue in the repo
3. Marks idea as "ready for graduation"
4. Can include symlinks back to main repo if needed

---

## Incubation System Overview

### The 5 Content Type Commands (v1)

| Command | Signal | AI Understands | Storage |
|---------|--------|-----------------|---------|
| `/feeling` | 💭 | Emotion (no action needed) | `ψ/memory/logs/feelings/` |
| `/info` | 📋 | Raw information to store | `ψ/memory/logs/info/` |
| `/idea` | 💡 | Concept/brainstorm | `ψ/lab/concepts/` |
| `/jump` | ⚡ | Change direction (stay connected) | No storage (signal only) |
| `/incubate` | 🥚 | Ready for separate repo | GitHub Issue |

### Implementation Status

- [x] Designed (002-content-type-commands.md)
- [x] note-taker agent created
- [ ] Slash commands implemented
- [ ] Testing with real usage
- [ ] Iterate based on feedback

---

## Incubation Philosophy

### Pattern Identified

1. Ideas start with date-prefixed markdown: `YYYY-MM-DD_name.md`
2. Tracked in `ideas/INDEX.md` for status
3. Decision point: "Separate repo or incubate here?"
4. When graduated: Create symlinks back to main repo if needed
5. Main repo files reference new repo via GitHub URLs

### Knowledge Flow

```
/snapshot → Active research → /rrr (retrospective) → /distill (patterns)
     ↓
ideas/ (incubation) → GitHub Issue → Separate repo → Symlinks
```

---

## Current Active Projects in Incubation

### 1. Voice Bridge (Tauri App)

**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/2025-12-09_voice-bridge.md`

**What it does**:
- Desktop app (Tauri + Rust)
- Listens to voice continuously in background
- Transcribes locally (no AI cost)
- Stores transcripts in SQLite
- Injects text into terminal via AppleScript/tmux

**Tech Stack**:
- Framework: Tauri (Rust + Web)
- Speech-to-Text: Whisper or Vosk (local)
- Database: SQLite (local)
- Injection: AppleScript / tmux send-keys

**Decision Pending**: Separate repo or incubate here?

---

### 2. Cellar (Flutter System Tray App)

**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/2025-12-09_cellar.md`

**What it does**:
- Lightweight desktop app in system tray
- Local SQLite database
- Stores command/task/session data
- Fast, always available

**Use Cases** (pick primary or combine):
1. Claude Code Logger — store session history
2. Voice Transcript Store — partner with voice-bridge
3. Task Tracker — quick capture from tray
4. Unified Local Brain — all of the above

**Tech Stack**:
- Framework: Flutter (cross-platform)
- Database: SQLite (sqflite/drift)
- System Tray: system_tray / tray_manager
- Platform: macOS first, then Windows/Linux

**Decision Pending**: Which use case is primary? Or unified?

---

### 3. Claude Voice Notify (GRADUATED)

**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/claude-voice-notify.md`

**Status**: MIGRATED COMPLETE ✓

**What it does**:
- Voice notification system for Claude agent sessions
- Integrates with `claude-code` command
- Sends audio/visual notifications to system

**Graduated To**: `laris-co/claude-voice-notify` (private repo)

**How Symlinks Work**:
```
Nat-s-Agents/scripts/
├── agent-start-notify.sh    → ~/.../claude-voice-notify/scripts/
├── agent-complete-notify.sh → ~/.../claude-voice-notify/scripts/
└── agent-voices.toml        → ~/.../claude-voice-notify/scripts/
```

**Graduation Timeline**:
- Dec 7: Initial setup (87501a9)
- Dec 9: Idea marked as separate repo (196c53b)
- Dec 9: Migration complete (681d363)
- Dec 9: Symlinks configured (626b27d)

**Future Vision** (Issue #2):
- Transform to system tray app
- SQLite for history
- Multi-project support
- Cross-platform (Tauri + Go)

---

## Ideas Folder Structure

**Location**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/`

```
ideas/
├── INDEX.md                          # Master index
├── claude-voice-notify.md            # GRADUATED status + install
├── 2025-12-09_claude-voice-notify.md # Original notes
├── 2025-12-09_voice-bridge.md        # Active incubation
└── 2025-12-09_cellar.md              # Active incubation
```

### INDEX.md Format

```markdown
| File | Status | Last Update |
|------|--------|-------------|
| 2025-12-09_voice-bridge.md | Idea | 2025-12-09 12:20 |

(Graduated, Archived sections below)
```

---

## Agent Support

### note-taker Agent

**Location**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/agents/note-taker.md`

**Model**: Opus (not Haiku - must be smart)

**Function**: Writes feeling/info/idea to files and updates INDEX

**Input Format**:
```
Type: feeling|info|idea
Content: [content]
Context: [optional context]
```

**Output**: File path + "Updated: INDEX.md (+1 entry)"

**Examples**:
```
Type: idea
Content: voice-bridge STT integration
Context: From session with voice research
```

---

## Related Files Reference

| File | Purpose | Location |
|------|---------|----------|
| **002-content-type-commands.md** | Command concept | `ψ/lab/concepts/002-content-type-commands.md` |
| **Project Incubation Report** | Full pattern analysis | `ψ/memory/retrospectives/2025-12-12_project-incubation-patterns.md` |
| **Overnight Session Retro** | Decision history | `ψ/memory/retrospectives/2025-12/12/07.00-overnight-agents-concepts.md` |
| **note-taker Agent** | Implementation | `.claude/agents/note-taker.md` |
| **idea Command** | /idea usage | `.claude/commands/idea.md` |

---

## Command Comparison

### Content Type Commands (v1)

```
/feeling  - Store emotions (no action)
/info     - Store raw information
/idea     - Store concepts/brainstorms
/jump     - Change direction (signal)
/incubate - Ready for new repo (signal)
```

### Related Short Codes

- `ccc` - Create context issue + compact conversation
- `rrr` - Create session retrospective  
- `/snapshot` - Quick knowledge capture
- `/distill` - Extract patterns to learnings
- `/recap` - Fresh start context summary
- `/context-finder` - Search git/issues/retrospectives

---

## Implementation Roadmap

### NEXT STEPS FOR /incubate

1. **Decide location**: 
   - [ ] Create `.claude/commands/incubate.md`
   - [ ] Link to GitHub Issue creation
   - [ ] Set up automation (optional)

2. **Test with real projects**:
   - [ ] Mark voice-bridge as "ready to incubate"
   - [ ] Mark cellar as "ready to incubate"
   - [ ] Create GitHub Issues in new repos

3. **Refine workflow**:
   - [ ] Add symlink strategy
   - [ ] Document graduation checklist
   - [ ] Track graduated projects

---

## Decisions Pending

### For Voice Bridge
**Q**: Build in Nat-s-Agents first or create separate repo?
**Factors**:
- Separate repo: Cleaner scope, independent evolution
- Here first: Easier iteration with main codebase
- System dependency: Whisper/Vosk choice matters

### For Cellar
**Q**: Primary use case - logger vs tasks vs unified?
**Impact**:
- Single focus: Faster MVP
- Multi-use: Higher value but complex
- Related projects waiting: voice-bridge, notifications

### For /incubate Command
**Q**: Implementation approach?
**Options**:
- A. Simple markdown file + manual GitHub Issue creation
- B. Automated shell script (gh cli)
- C. Subagent (executor agent handles it)
- D. Full slash command in Claude Code

**Recommendation**: Start with A (simple), evolve to B/C based on usage

---

## Key Insights from Session

From 2025-12-12 overnight session (07:00-retro):

1. **Concepts stay in ψ/lab/** (not memory/learnings)
   - Concepts are unproven ideas
   - Learnings are proven patterns
   - Distinction matters

2. **note-taker must be Opus**
   - "Journaling for us must be intelligent"
   - Needs to understand nuance
   - Cannot be delegated to Haiku

3. **Content-type commands reduce guessing**
   - AI doesn't have to infer user intent
   - Saves tokens on both sides
   - Cleaner signal flow

4. **Incubation pattern is working**
   - voice-notify graduated successfully
   - voice-bridge & cellar are next candidates
   - Symlinks bridge the gap

---

## References

**Command Files**:
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/commands/idea.md`

**Agent Files**:
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/agents/note-taker.md`

**Concept Files**:
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/lab/concepts/002-content-type-commands.md`

**Idea Files**:
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/2025-12-09_voice-bridge.md`
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ideas/2025-12-09_cellar.md`

**Reports**:
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/retrospectives/2025-12-12_project-incubation-patterns.md`
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/retrospectives/2025-12/12/07.00-overnight-agents-concepts.md`

