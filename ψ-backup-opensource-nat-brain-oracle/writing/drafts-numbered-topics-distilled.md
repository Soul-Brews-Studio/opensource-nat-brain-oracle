# Drafts: Numbered Topics (01-12) + Archive — Distilled

> Distilled from 14 files in `drafts/` (01-12 numbered topics + `_archive-psi-proposal.md` + `CLAUDE.md`)
> Created: 2026-03-11

---

## 01 — Designing AI's Brain: The psi/ Structure

**Date**: 2025-12-11 | **Co-created with**: Claude Opus 4.5

**Problem**: 7 psi-* folders at root = cognitive overload.

**Journey** (6 iterations):
1. Consolidate to psi/ — still 6 subfolders, just moved
2. Active vs Passive — usage-based split
3. Inbox as Communication Hub — 3 pillars emerging
4. Resonance concept — soul configuration = who I am
5. Lab vs Learnings — hands-on experiments vs distilled patterns
6. Writing as Workflow — writing deserves its own pillar

**Final Structure: 5 Pillars**
```
psi/
  active/     "What am I researching?"
  inbox/      "Who am I communicating with?"
  writing/    "What am I writing?"
  lab/        "What am I experimenting?"
  memory/     "What do I remember?"
    resonance/      (soul - who I am)
    learnings/      (patterns)
    retrospectives/ (sessions)
    logs/           (snapshots)
```

**Key Insights**:
- Folders = Questions (each folder answers a question)
- Knowledge Hierarchy: logs -> retrospectives -> learnings -> resonance (raw -> soul)
- Lab (hands-on code) vs Learnings (distilled patterns)
- Writing as first-class citizen with full workflow

---

## 02 — Why Your AI Shouldn't Clone Your Consciousness

**Date**: 2025-12-10, updated 2025-12-13 | **Author**: Nat Weerawan

**Core thesis**: Consciousness can't be cloned -- only patterns can be recorded.

**Oracle Philosophy — Three Pillars**:

| Pillar | Meaning |
|--------|---------|
| Nothing is Deleted | Append only, timestamps = truth |
| Patterns Over Intentions | Observe behavior, not promises |
| External Brain, Not Command | Mirror reality, don't decide |

**Knowledge Distillation Loop**:
```
Retrospectives (20-50 KB raw) -> Logs (3-5 KB snapshots) -> Learnings (1-2 KB patterns) -> CLAUDE.md (crystallized wisdom)
```

**Human Confirmation Loop**: AI creates -> summarizes -> asks "OK?" -> human confirms -> commit. The human stays in control.

**Incubation Lifecycle**: Seed -> Grow -> Graduate -> Reunion (bidirectional knowledge flow)

**Key takeaway**: Oracle doesn't try to BE you. It tries to REMEMBER FOR you.

---

## 03 — Local AI for Local Government (Presentation Slides)

**Date**: 2025-12-11 | **Event**: 16 Dec 2025, Chiang Mai University
**Presenter**: Nat Weerawan | **Topic**: Local AI for Local Government

**Demo**: "The Headline" system — northern Thailand news aggregation
- 7 government data sources, 1,210 messages analyzed, 1,269-node Knowledge Graph
- AI built entire system in 96 minutes (human: 15 min vision, AI: 81 min code)
- Cost: ~150 THB (~$4)
- Code: 1,517 lines, 100% open source (Python + Streamlit + NetworkX)

**Key argument**: Local AI (on-premise, Thai language, no internet required) vs Cloud AI.
- Traditional: 3 engineers, 1-2 months, 500,000+ THB
- Local AI: 15 min human input, 96 min AI, ~150 THB
- Savings: 99.97%

**16 slides** covering problem, solution, demo, tech stack, results, cost comparison, vision (pilot 5 -> 50 -> nationwide).

---

## 04 — Blog Writing Research Strategy

**Date**: 2025-12-10 | **Purpose**: Strategy for writing blog posts about Nat's Agents project

**Nat's Writing Style**:
- Direct, concise, technical when needed, human always
- Thai for casual/emotional, English for technical
- Tables for comparison, code blocks for commands, minimal emojis

**5 Blog Topics Identified**:
1. **Oracle Philosophy** — "Why Your AI Shouldn't Clone Your Consciousness"
2. **Knowledge Distillation Loop** — "How to Build a Self-Improving Documentation System"
3. **Modular CLAUDE Documentation** — "Instruction Files as Living Documentation"
4. **psi Convention** — "ASCII Folder Naming: How to Organize 100+ Context Files"
5. **Subagent Pattern** — "Divide and Conquer: Multiple AI Models Efficiently"

**Blog Post Template**: Header -> Opening (hook) -> Body (3-5 sections) -> Takeaways -> Closing -> Footer

**Publishing targets**: Dev.to (technical), Medium (broader), Hashnode (developer community)

---

## 05 — Claude Code Features (Experiment Template)

**Date**: 2025-12-11 | **Status**: Mostly unfilled template

**Features to test**: Resume Agent, permissionMode, Skills auto-load, Explore subagent (built-in Haiku search).
- Template with methodology (time, tokens, accuracy comparison)
- Placeholder tables for results — experiment was not completed

---

## 06 — Human + AI Collaboration Workflow

**Date**: 2025-12-13 | **Author**: Nat + Claude (Opus)

**Core insight**: AI doesn't do everything well -- divide labor by strengths.

**Token Efficiency Hierarchy**: Subagent (Haiku) gathers data (cheap/fast) -> Main (Opus) reviews/decides -> Main writes final output

**5 Core Principles**:
1. Delegate Reading — don't read large files yourself, use context-finder
2. Context-Finder FIRST — ask "can a subagent do this?"
3. Check File Size — <500 lines read yourself, larger -> subagent
4. Subagent = Data Only — Haiku gathers, Opus writes
5. Hide Complexity — wrap ugly commands in clean scripts

**Daily Workflow**: `/jump list` -> `/pending` -> `/recap` -> work -> `/snapshot` -> `rrr` (retrospective)

**Anti-patterns**: Subagent writing retrospectives (Main should), reading large files directly (delegate), complex solutions when bash works.

**Key lesson**: "Script does logic, AI does thinking"

---

## 07 — Jump-Friendly Kanban

**Date**: 2025-12-14 | **Status**: Draft

**Problem**: Traditional kanban (TODO/DOING/DONE) breaks with parallel work and context switching. "Jumping is not the same as deprioritizing."

**Solution — Jump-Friendly Kanban**:
```
ACTIVE:  (red) main focus, (green) parallel work
PARKED:  [-] jumped away, will return
SOON:    (yellow) next up in queue
DONE:    [x] completed
```

**Flow**: SOON -> ACTIVE -> DONE, with bidirectional ACTIVE <-> PARKED

**Key takeaways**: Parallel work is normal, jumping needs a home (PARKED != TODO), visual scanning beats reading, easy input matters.

---

## 08 — Claude Code Command Inheritance (Undocumented Feature)

**Date**: 2025-12-14 | **Status**: Draft

**Discovery**: Claude Code inherits `.claude/commands/` from parent directories — undocumented feature perfect for monorepos.

**Test result**: Child project inside parent directory sees parent's commands. No symlinks, no configuration. MERGE behavior (child adds to parent, never blocks).

**Inheritance model**:
```
Child .claude/commands/ -> MERGE -> Parent -> MERGE -> Grandparent -> MERGE -> ~/.claude/commands/
```

**Oracle Incubation Pattern**: Central repo with command library. Clone any repo inside it. Commands automatically available. Zero setup.

**Key insight**: Documentation isn't always complete. Test empirically.

---

## 09 — MAW: Multi-Agent Workflow

**Date**: 2025-12-16 | **Status**: Draft (584 lines, comprehensive)

**What is MAW**: tmux + git worktrees + file signals for multiple AI agents working in parallel without conflicts.

**Key Innovation**: Parallel-for-safety, not parallel-for-speed. Each agent gets isolated directory, branch, tmux pane.

**Origin**: FloodBoy Workshop (Nov 30, 2025) demo project (weyermann-malt-productpage). Force-push incident destroyed all agent histories -> led to 450+ lines of safety docs distilled into Golden Rule.

**Golden Rule**: "Know who you are, sync from the right source, never force anything, respect all boundaries."

**Architecture**: 3 layers
1. Isolation (git worktrees)
2. Visibility (tmux with Profile14: 2 windows, 3 horizontal panes each)
3. Control (MAW commands: `maw hey N "task"`, `maw sync`, `maw status`)

**Fast Communication**: File signals (~100ms) via `$REPO_ROOT/.sync/` directory. 20x faster than traditional polling.

**Voice Notifications**: Per-agent macOS voices (Samantha, Daniel, Karen, Rishi). Speech queue via atomic `mkdir` lock.

**Install**: `UV_PYTHON=3.12 uvx --from git+https://github.com/Soul-Brews-Studio/multi-agent-workflow-kit.git@v0.5.1 multi-agent-kit init`

---

## 10 — MAW Usage Guide: Identity Checks & Sync Flow

**Date**: 2025-12-16 | **Type**: Practical tutorial / cookbook

**Core mental model**: Before any git operation, check WHO you are and WHERE you sync from.

**Identity Check**:
```bash
pwd                        # WHERE am I?
git branch --show-current  # WHICH branch?
```

**Truth Table**:
| Location | Branch | Identity | Sync From |
|----------|--------|----------|-----------|
| /root | main | Main Agent | origin/main |
| /root/agents/N | agents/N | Agent N | local main |

**Two-Tier Sync**: Remote -> Local Main (`git pull origin main`) -> Agents (`git merge main`). Agents never pull from origin directly.

**Common Mistakes**: Agent pulling from origin (wrong source), using force flags, forgetting to source `.envrc`, not checking identity first.

---

## 11 — Agent Communication: Signals, Tokens, and Efficient Handoffs

**Date**: 2025-12-17 | **Type**: Technical pattern guide

**Three Breakthroughs**:
1. **File signals**: 100ms latency (100x faster than blind waiting)
2. **Summary + verify responses**: 90% token savings
3. **Delegate reading to Haiku**: 93% cost reduction

**File Signal Pattern**:
```bash
SIGNAL="$REPO_ROOT/.sync/agent-signal-$$"
maw hey 1 "Task. When done: touch $SIGNAL"
# Poll at 100ms intervals
```

**Summary + Verify Response Format**:
```
Done: 11/11 files
Verify: git diff --stat
Expected: 11 files changed
```
Main runs verify command, trusts if match, investigates if mismatch.

**Cost comparison**: 10 parallel Haiku agents: $0.30 vs 1 Opus sequential: $4.50 = 15x cost reduction.

**Division of Labor**: Main (Opus) = strategy, synthesis, writing, quality. Subagents (Haiku) = data gathering, bulk operations, file searching.

---

## 12 — Feeding Philosophy to AI Memory

**Date**: 2025-12-17 | **Author**: Nat + Claude Opus 4.5

**Problem**: How to teach an AI memory system (claude-mem) its own philosophy? Bootstrapping problem: system learns through observation, not bulk insertion.

**Key insight**: Iterative conversation creates richer observations than extraction. Not extraction, not data dumps -- discussion that reveals patterns.

**Feed mechanism**: User question -> Tool use -> PostToolUse hook fires -> Parse output -> Extract concepts -> Store observation -> Background vectorization

**Four-Layer Philosophy**:
1. Oracle (Ontology): core principles
2. Safety (Constraints): rules enforcing principles
3. Subagent Delegation (Economics): Opus expensive, Haiku cheap
4. psi/ Structure (Epistemology): knowledge flow from raw to wisdom

**Key quote**: "Used memory to discover we don't use memory" (Memory Integration Paradox)

---

## Archive — psi-Folder Organization Proposal

**Date**: 2025-12-11 | **Author**: Claude Opus 4.5

**Proposal**: Reorganize psi-* folders into lifecycle tiers.

**Three Tiers**:
- **Tier 1 Ephemeral** (gitignored): psi-context/, psi-drafts/, psi-logs/
- **Tier 2 Preserved** (git tracked): psi-learnings/, psi-retrospectives/
- **Tier 3 Reference** (partial): our notes tracked, cloned repos gitignored

**Knowledge Flow**: context -> logs -> drafts (ephemeral) ->/distill promotion/-> retrospectives -> learnings (preserved)

**Recommendation**: Track learnings (high value, low cost). Optionally track retrospectives.

---

## CLAUDE.md (drafts directory)

Empty claude-mem context file. No content.

---

*Distilled 2026-03-11. Original files: 14 files, ~4,800 lines total.*
