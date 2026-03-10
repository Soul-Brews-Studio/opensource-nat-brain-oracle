# MAW: When One AI Isn't Enough — Multi-Agent Workflow

**Created**: 2025-12-16 23:44 GMT+7
**Status**: 📝 Draft
**Author**: Human + AI collaboration

---

## 📚 Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Learning | ψ/memory/learnings/2025-12-13_maw-comprehensive-guide.md (449 lines) | Architecture, installation, profiles, commands |
| Learning | ψ/memory/learnings/2025-12-14_maw-control-guide.md | Control patterns, copy-paste commands |
| Learning | ψ/memory/learnings/2025-12-13_maw-index.md | Index reference for all MAW learnings |
| Retrospective | ψ/memory/retrospectives/2025-12/13/22.03_full-day-maw-brewing-architecture.md | 13.5-hour MAW exploration session |
| Retrospective | ψ/memory/retrospectives/2025-12/13/23.24_maw-profile14-setup-journey.md | Profile14 installation |
| Retrospective | ψ/memory/retrospectives/2025-12/14/03.06_maw-incubation-vault-session.md | Latest session |
| Analysis | ψ/active/context/maw/MAW_ANALYSIS.md (686 lines) | Complete architecture deep-dive |
| Reference | ψ/learn/repo/github.com/nazt/weyermann-malt-productpage/ | Real implementation |

---

## 🎯 TL;DR

**MAW (Multi-Agent Workflow Kit)** is tmux + git worktrees + file signals that lets multiple AI agents work in parallel without destroying each other's work. Born from a real workshop project (weyermann-malt-productpage), it's not just a tool — it's **safety infrastructure** with one memorable rule: "Know who you are, sync from the right source, never force anything, respect all boundaries."

**Key Innovation**: Not parallel-for-speed, but parallel-for-safety. Each agent has its own isolated directory, branch, and tmux pane. Communication happens via fast file signals (~100ms). Voice notifications tell you which agent finished what.

**Bottom Line**: If you've ever wanted Claude to work on 5 different files simultaneously without merge conflicts, MAW is your answer.

---

## 🔥 The Problem

### The Sequential Bottleneck

You're building a product page. You need to:
- Generate HTML structure
- Write CSS styling
- Create JavaScript interactions
- Fetch product data from API
- Write tests

**Traditional approach**: Tell Claude to do all 5. Wait. Review. Iterate. Repeat.

**Time**: 30+ minutes of back-and-forth.

**Pain**: Claude can only focus on one thing at a time. While it's writing CSS, it can't be fetching product data. Everything is sequential.

### The "Just Run 5 Claudes" Problem

Okay, fine. Open 5 terminal windows. Run `claude` in each. Give them different tasks.

**What could go wrong?**

1. **Agent 1** modifies `index.html`
2. **Agent 2** also modifies `index.html` (doesn't see Agent 1's changes)
3. **Agent 3** tries to `git pull` → merge conflict
4. **You** spend 20 minutes resolving conflicts
5. **Agent 4** accidentally does `git push --force`, destroying Agent 1-3's work
6. **Everyone** cries

**Real incident from weyermann project**: Force-push destroyed all agent histories. Led to 450+ lines of safety documentation.

### The Core Challenge

**How do you coordinate multiple AI agents working in parallel without:**
- Merge conflicts
- Lost work
- Race conditions
- Agents overwriting each other
- Communication overhead

---

## 🛤️ The Journey

### Origin: A Workshop Demo Gone Production

**November 30, 2025**: FloodBoy Workshop at Soul-Brews-Studio

Morning session: AI Philosophy + Gemini Deep Research + Canvas Mode
Afternoon session: **Agentic Coding + Multi-Agent Workflow**

Demo project: `weyermann-malt-productpage` — a product catalog for German malt varieties.

The demo needed to show:
- How multiple AI agents can collaborate
- Real-world git workflows
- Safety patterns that actually work

**What happened**: The demo pattern worked so well it became production infrastructure. By December 6, the multi-agent coordination system was extracted into a standalone toolkit: **MAW (Multi-Agent Workflow Kit)**.

### The Aha Moment: Git Worktrees

Most people think "multiple agents = multiple git branches."

Wrong.

**Git worktrees** = separate filesystem directories, each with its own branch.

```
repo/                    ← Main worktree (branch: main)
├── agents/1/           ← Agent 1 (branch: agents/1)
├── agents/2/           ← Agent 2 (branch: agents/2)
└── agents/3/           ← Agent 3 (branch: agents/3)
```

**Why this matters**:
- Each agent has **completely isolated filesystem**
- No shared `.git/index` (no index.lock conflicts)
- Each agent can `git status` without blocking others
- Merge conflicts happen at merge-time, not during work

**Mental shift**: Stop thinking "agents on branches." Start thinking "agents in separate rooms."

### The Force-Push Incident

**What happened**: During sync, someone executed `git push --force` to "fix" a divergence.

**Result**: All agent branches lost their history. Hours of work gone.

**Root cause**: Had read the safety rules, but didn't internalize them under pressure.

**The learning**: Complex safety rules fail when you're stressed. You need something that fits in working memory.

### Distilling The Golden Rule

After the incident, 450 lines of `SYNC-RULES.md` were distilled into 4 principles:

```
"Know who you are, sync from the right source,
never force anything, respect all boundaries."
```

| Principle | Check | Prevents |
|-----------|-------|----------|
| **Know who you are** | `pwd`, `git branch --show-current` | Wrong identity operations |
| **Sync from right source** | Main→origin, Agent→local main | Sync conflicts |
| **Never force anything** | No `-f` flags ever | Data loss |
| **Respect boundaries** | Stay in worktree, use `git -C` | Cross-contamination |

**This rule saved the project.** It's printed at the top of every terminal. It's spoken by voice notification on session start. It's the first thing new contributors learn.

### Profile14: The Layout That Worked

Tried layouts:
- **Profile0**: 3 agents stacked vertically → too cramped
- **Profile5**: 6 agents in grid → hard to read
- **Profile8**: 2 windows, 3 vertical each → scrolling issues

**Profile14**: 2 windows, 3 horizontal panes each (side-by-side)

```
Window 1: [Agent 1 | Agent 2 | Agent 3]
Window 2: [Agent 4 | Agent 5 | Monitor ]
```

**Why it works**:
- Horizontal splits = more readable (terminals are wide, not tall)
- 3 panes per window = manageable cognitive load
- Window switching (Cmd+[, Cmd+]) = fast navigation
- Monitor pane = always visible system status

**The pattern**: Layout affects productivity more than you think. Optimize for readability + context switching, not just "fitting more stuff on screen."

---

## ✅ The Solution

### Architecture in 3 Layers

#### Layer 1: Isolation (Git Worktrees)

```bash
# Initialize worktrees
git worktree add agents/1 -b agents/1
git worktree add agents/2 -b agents/2
git worktree add agents/3 -b agents/3
```

Each agent gets:
- Separate directory
- Own git branch
- Independent working tree
- No shared locks

#### Layer 2: Visibility (Tmux)

```bash
# Start tmux session with profile14
maw start profile14
```

Creates:
- 2 tmux windows
- 6 panes total (3 per window)
- Each pane = one agent terminal
- All visible simultaneously

#### Layer 3: Control (MAW Commands)

```bash
# Send task to agent
maw hey 1 "Create index.html with product catalog"

# Broadcast to all
maw hey all "git status"

# Capture output
tmux capture-pane -t ai-project:1.1 -p -S -50 | tail -15

# Sync all agents
maw sync
```

### Smart Sync Algorithm

**Problem**: Blindly syncing agents causes conflicts.

**Solution**: Check status first, then decide.

```bash
# For each agent worktree:

git status --porcelain
│
├─ CLEAN → Auto-merge from main (fast ✓)
├─ DIRTY → Send voice notification (safe ⚠️)
└─ ERROR → Report issue (investigate ❌)
```

**Output example**:
```
✅ Agent 1: clean worktree, auto-syncing...
   ✓ Synced successfully

⚠️  Agent 2: has uncommitted work
   Files changed:
   M  src/app.js
   ?? test.txt

✅ Agent 3: clean worktree, auto-syncing...
   ✓ Synced successfully
```

**Key insight**: Safety through awareness, not restriction.

### Fast Task Communication (~100ms)

**Old way** (2+ seconds):
```bash
Task(prompt="Generate HTML")
# Wait for polling...
```

**MAW way** (100ms):
```bash
# Get shared signal directory (main repo, not agent worktree!)
REPO_ROOT=$(git rev-parse --show-toplevel)
SIGNAL="$REPO_ROOT/.sync/maw-signal-$$"

# Send task with completion trigger
maw hey 2 "Generate HTML. When done: touch $SIGNAL"

# Poll at 100ms intervals
for i in {1..100}; do
  if [ -f "$SIGNAL" ]; then
    # Capture response immediately
    RESPONSE=$(tmux capture-pane -t session:1.2 -p -S -30)
    rm -f "$SIGNAL"
    break
  fi
  sleep 0.1
done
```

**Why `$REPO_ROOT/.sync/`**: Shared across all agent worktrees + gitignored + atomic file creation on POSIX systems.

**Latency comparison**:
- Traditional polling: 2000ms
- File signal detection: ~100ms
- **20x faster**

### Voice Notifications (Per-Agent Voices)

Each agent has a unique macOS voice:

```toml
[voices]
main = "Samantha"      # Clear, natural
agent_1 = "Daniel"     # British male
agent_2 = "Karen"      # Australian female
agent_3 = "Rishi"      # Indian male
```

**Integration**:
```bash
# On agent completion
say -v "Daniel" -r 220 "Agent 1 task complete"
```

**Speech queue** (prevents overlapping audio):
```bash
# Atomic lock via mkdir
QUEUE_DIR=".agent-locks/speech-queue"

while ! mkdir "$QUEUE_DIR" 2>/dev/null; do
  sleep 0.1
done

say -v "Samantha" "Main agent ready"

rmdir "$QUEUE_DIR"
```

**Why it matters**: When you're context-switching between 5 agents, audio cues help you know who finished what without looking.

---

## 🧠 The Pattern

### Pattern 1: Safety Through Design, Not Restriction

**Old thinking**: "Lock everything down. Review every change."

**MAW thinking**: "Give each agent a safe sandbox. Let them work freely within boundaries."

**Implementation**:
- Worktrees = natural boundaries (filesystem isolation)
- Golden Rule = memorable checklist (fits in working memory)
- Smart Sync = status-aware (doesn't blindly force)

**When to apply**: Any system where agents/users need autonomy but must avoid conflicts.

### Pattern 2: Memorable Rules > Comprehensive Rules

**Before**: 450+ lines of `SYNC-RULES.md`
- Comprehensive
- Correct
- **Impossible to remember under pressure**

**After**: 4-line Golden Rule
- Covers 90% of cases
- Fits in working memory
- **Actually used in practice**

**Key insight**: Complex safety documentation fails when it's needed most (high-stress situations). Distill to the essence.

### Pattern 3: Notes Tracked, Repos Ignored

**Structure**:
```
ψ/learn/maw.md              ← Tracked (your notes/insights)
ψ/learn/repo/github.com/... ← Gitignored (cloned code)
```

**Why**:
- Notes = knowledge that evolves (yours)
- Repos = code snapshot (theirs)
- Separate concerns = clean git history

**When to apply**: Learning from external projects.

### Pattern 4: Incubate → Learn → Graduate

```
ψ/incubate/repo/...  ← Clone for active development
ψ/learn/repo/...     ← Clone for studying/reference
External repo        ← Graduate to own repository
```

**Pattern**:
1. Clone to `incubate/` if you'll modify it
2. Clone to `learn/` if you'll just study it
3. Graduate to own repo when mature

**Example**: MAW started in weyermann project (incubate) → Extracted to toolkit → Graduated to `Soul-Brews-Studio/multi-agent-workflow-kit`

### Pattern 5: Simple Beats Complex (When Reliability Matters)

**Tested**: Haiku executor for `/jump` command
**Result**: Output lost 2 out of 5 times
**Solution**: Reverted to simple bash script
**Reliability**: 100%

**The lesson**: Don't over-engineer for the sake of showing AI capabilities. Use the simplest solution that works reliably.

**When to apply**: Infrastructure code, safety-critical systems, operations that run unattended.

---

## 🔧 How to Try MAW

### Prerequisites

- macOS/Linux with tmux
- Git ≥ 2.5
- Python 3.12 (not 3.14 — compatibility issues)
- yq (YAML processor)

### Installation (One Command)

```bash
UV_PYTHON=3.12 uvx --no-cache \
  --from git+https://github.com/Soul-Brews-Studio/multi-agent-workflow-kit.git@v0.5.1 \
  multi-agent-kit init
```

**What it creates**:
```
.agents/           ← Scripts, profiles, config
.claude/commands/  ← Slash commands (maw.*)
agents/1,2,3/      ← Git worktrees
MAW-AGENTS.md      ← Documentation
```

### Basic Usage

```bash
# Start session with profile14
source .envrc && maw start profile14

# Send task to agent 1
maw hey 1 "Create index.html with navigation"

# Broadcast to all agents
maw hey all "git status"

# Sync all agents from main
maw sync

# Attach to tmux session
maw attach

# Stop session
maw kill
```

### Quick Reference

| Command | Purpose |
|---------|---------|
| `maw start <profile>` | Launch tmux session |
| `maw hey N "task"` | Send task to Agent N |
| `maw hey all "cmd"` | Broadcast to all agents |
| `maw sync` | Smart sync all agents |
| `maw attach` | Connect to session |
| `maw kill` | Stop all agents |
| `maw status` | Check worktree/lock status |

---

## 📖 Full Context (for AI continuation)

### Session Timeline (MAW Discovery)

| Date | Event | Impact |
|------|-------|--------|
| 2025-11-30 | weyermann project begins | Workshop demo |
| 2025-12-06 | weyermann complete | Production MAW pattern |
| 2025-12-07 | FloodBoy Workshop | AI Philosophy + Multi-Agent |
| 2025-12-13 14:13 | **Genesis commit** | feat: add maw.md |
| 2025-12-13 22:03-23:46 | **Major exploration** | 13.5-hour session, 70+ commits |
| 2025-12-13 23:00 | **Installation** | MAW Profile14 installed |
| 2025-12-14 03:06 | Latest session | Incubation vault work |

### Commits (Dec 13, 2025)

| Hash | Time | Message |
|------|------|---------|
| f41375f | 14:13 | feat: add weyermann.md reunion entry |
| d5e2d13 | 14:15 | **feat: add maw.md + update weyermann** |
| cbcacf5 | 14:16 | docs: weyermann = MAW origin story |
| 449d844 | 14:18 | docs: add FloodBoy Workshop origin |
| 173db4b | 22:02 | docs: brewing notes + WIP for MAW |
| ee7928e | 22:08 | docs: comprehensive full-day retro |
| fdb19c8 | 22:33 | learn: MAW start & control patterns |
| 5b1ef42 | 22:43 | learn: MAW profile14 + auto-start |
| 55b82b3 | 23:00 | **docs: MAW installed + WIP forward** |
| 6dc2a3b | 23:31 | docs: MAW Profile14 journey |
| 2c08046 | 23:44 | docs: full session retro + antigravity |

### Files Changed (MAW-Related)

**Created**:
- `MAW-AGENTS.md` — Main documentation
- `.agents/scripts/maw*` — 6 control scripts
- `.agents/profiles/profile14.sh` — Layout definition
- `ψ/memory/learnings/2025-12-13_maw-*.md` — 10 learning files (813 lines)
- `ψ/memory/retrospectives/.../maw-*.md` — 17 session retrospectives

**Modified**:
- `.envrc` — MAW environment setup
- `.claude/commands/*.md` — MAW slash commands

### Key Repositories

| Repo | Role | Status |
|------|------|--------|
| `Soul-Brews-Studio/multi-agent-workflow-kit` | Official toolkit | Upstream source |
| `nazt/weyermann-malt-productpage` | Reference implementation | Production example |
| `laris-co/proof-maw-multi-agent-worktree-kit` | Proof of concept | Experimental |

### Raw Notes

**From retrospective**:
- 13.5-hour session (longest ever)
- 70+ commits, 9 retrospectives, 12 learnings
- Beer ↔ Code rhythm = no burnout
- Force-push incident → Golden Rule distillation
- Simple bash > complex Haiku executor (reliability)
- Profile14 = best layout (horizontal splits)
- Snow Mash secret code = shared experience
- MAW integration to Nat-s-Agents next

**From comprehensive guide**:
- Python 3.14 breaks MAW (use 3.12)
- `maw` is shell function, must source `.envrc`
- tmux pane refs: `session:window.pane` (e.g., `ai-Nat-s-Agents:1.1`)
- Capture-after-send pattern: `maw hey` → `sleep 1` → `tmux capture-pane`
- Vertical = stacked (top/bottom), Horizontal = side-by-side (confusing!)

**From analysis**:
- Golden Rule = lockout/tagout equivalent for git
- Smart Sync = status-aware synchronization (3 states: clean/dirty/error)
- Voice notifications = per-agent identity (Samantha, Daniel, Karen, Rishi)
- Lock system = atomic `mkdir` (POSIX-compatible, works on macOS)
- File signals = $REPO_ROOT/.sync/ directory (shared, gitignored, <100ms latency)
- 9 Claude Code subagents in weyermann (maw, coder, executor, context-finder, etc.)

---

## 🏷️ Tags

`multi-agent` `tmux` `git-worktrees` `claude-code` `workflow` `safety` `parallel` `AI` `collaboration` `maw`

---

## 📝 Writing Notes

### Tone
- **Technical but accessible** — Explain git worktrees clearly
- **Story-driven** — Lead with problem → journey → solution
- **Honest about failures** — Force-push incident is central to the story
- **Practical** — Include installation + usage commands

### Target Audience
- **Developers using AI assistants** (Claude, Copilot, etc.)
- **Teams exploring multi-agent workflows**
- **Anyone who's hit merge conflicts with parallel work**
- **Claude Code power users**

### Suggested Title Alternatives
1. "MAW: Orchestrating 5 Claudes Without Losing Your Mind"
2. "The Golden Rule of Multi-Agent Workflows"
3. "How a Force-Push Incident Created Production-Ready Multi-Agent Infrastructure"
4. "Git Worktrees + Tmux + AI = Parallel Work That Actually Works"
5. "From Workshop Demo to Production: The MAW Story"

### Next Steps
- [ ] Review draft structure
- [ ] Add architecture diagram (worktree layout)
- [ ] Add screenshot of Profile14 in action
- [ ] Consider code syntax highlighting for bash examples
- [ ] Polish "The Journey" section (most important part)
- [ ] Add "Common Pitfalls" section?
- [ ] Link to official MAW repository
- [ ] Get feedback on Golden Rule explanation

### Publishing Checklist
- [ ] Verify all commands work (test install + usage)
- [ ] Check links to Soul-Brews-Studio repo
- [ ] Add author bio (who built MAW?)
- [ ] Consider adding "Related Reading" section
- [ ] SEO: "multi agent workflow", "git worktrees", "claude code"

---

*Draft generated from 13.5-hour MAW exploration session (Dec 13, 2025)*
*Ready for human review and AI continuation*
*Total source material: 1000+ lines of learnings, retrospectives, and analysis*
