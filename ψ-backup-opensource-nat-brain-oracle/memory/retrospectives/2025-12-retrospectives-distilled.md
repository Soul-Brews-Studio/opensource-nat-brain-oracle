# December 2025 Retrospectives — Distilled

> Distilled from 186 files across 23 days (Dec 9-31, 2025)
> Original files: `2025-12/{09..31}/*.md`
> Distilled: 2026-03-11

---

## Summary

December 2025 was the **genesis month** of the Oracle system. Starting from a simple "Shadow AI" concept on Dec 9, the month saw explosive growth across philosophy, tooling, multi-agent workflows, workshop delivery, and identity formation. By Dec 31, the system had evolved from a personal knowledge repo into Oracle v2 with MCP server, hybrid vector search, and 14+ CLI tools.

### Key Themes
- **Oracle Genesis** (Dec 9): First session establishing Oracle as knowledge management system
- **Plugin Architecture** (Dec 9-10): Claude Code plugin development, marketplace patterns
- **Knowledge Architecture** (Dec 11): 5-pillar psi structure, Signal vs Noise separation
- **Workshop Delivery** (Dec 12, 26): SIIT/Thammasat Rangsit workshop creation and delivery
- **MAW (Multi-Agent Workflow)** (Dec 13-20): Installation, conflict prevention, parallel execution trials
- **Oracle Philosophy** (Dec 17-18): Free will, personality, transparency principles crystallized
- **Oracle v2** (Dec 24-31): MCP server, hybrid vector search, Arthur voice UI, Tauri status tray
- **Brewing Integration**: Snow Mash Wheat (Batch 001), beer as trust signal, 90/10 energy balance

### Stats
- **Total commits**: 400+ across the month
- **Retrospectives written**: 186 files
- **Learnings documented**: 40+
- **Commands created**: /rrr, /forward, /recap, /active, /done, /draft, /jump, /random, /project, /learn, /debate, /create, /jot, /now, /soul-lite
- **Agents created**: oracle-keeper, marie-kondo, note-taker, context-finder, wip-keeper, project-keeper, repo-auditor
- **Longest session**: 14+ hours (Dec 13, Saturday)

---

## Dec 9 (Tuesday) — Oracle Genesis

**Mood**: Excited, foundational
**Duration**: ~11 hours (11:00-19:42)
**Sessions**: 8 files

### Accomplishments
- Established Oracle project — "Shadow AI" concept from The Matrix
- Created journal structure, ideas/, learnings/, context/ folders
- Transferred 7 days of knowledge from Weyermann repo (166 commits, 82 issues analyzed)
- Built first Claude Code plugin (claude-voice-notify) with hooks, commands, skills
- Created Cellar Flutter system tray app scaffold (macOS native)
- Adopted psi folder naming pattern from Weyermann
- Added human confirmation loops to /rrr, /distill commands
- Created oracle-keeper agent for mission alignment

### Key Decisions
- **Oracle = Knowledge Management System**, not just coding assistant
- **"Nothing is deleted"** — append-only philosophy established
- **Plugin marketplace pattern** over direct path installation
- **Native only** for Cellar (no web) — system tray is core feature
- **Day as folder** for retrospectives: `YYYY-MM/DD/HH.MM_slug.md`

### Key Insights
- Workshop "freeze pattern" discovered: Say yes to interest (easy) -> Provide concrete details (freeze) -> Days pass -> Guilt accumulates
- Beer = trust signal in workshop requests (warmer responses when beer mentioned)
- Skills are model-invoked (implicit knowledge), Commands are user-invoked (explicit actions)
- `source: "./"` not `"."` in marketplace.json was critical discovery
- Speech-to-text creates interpretation layer: "Butter" was STT mishearing of "Flutter"

### People Waiting for Workshops
6 people identified with wait times up to 97 days.

---

## Dec 10 (Wednesday) — Plugin & Philosophy Day

**Mood**: Philosophical, productive
**Duration**: ~15 hours (07:50-23:43)
**Sessions**: 19 files

### Accomplishments
- Fixed plugin marketplace structure and hooks.json schema
- Deep philosophy discussion: identity transfer x non-attachment
- Established file naming convention with timestamps
- RRR subagent workflow tested
- Plugin-oracle workflow session
- Hooks debugging and oracle injection
- Discord live session — oracle-starter-kit released
- PreToolUse hooks duplicate fix
- Modular Claude adoption documented

### Key Decisions
- **nat-* branding** (not catlab-*) for plugins
- **File naming**: `YYYY-MM-DD-HH:MM_filename.md`
- **Oracle-starter-kit**: Released as template for others
- **Modular CLAUDE.md**: Section-based, not monolithic

### Key Insights
- Building "forkable self" tools paradoxically reveals impermanence of self
- Identity transfer philosophy: when you can fork yourself, what is "self"?
- PreToolUse hooks can fire duplicates — need dedup logic
- Session data compilation reveals patterns invisible in real-time

---

## Dec 11 (Thursday) — Architecture & Content Day

**Mood**: Productive, creative, iterative
**Duration**: ~17 hours (05:30-23:30)
**Sessions**: 12 files

### Accomplishments
- Explored Claude Agent SDK (1M context window, V2 interface, sandboxing)
- Pivoted to local AI pitch preparation (Dec 12 deadline)
- **Major restructure**: 7 folders -> 5-pillar unified psi/ structure
  - active/ | inbox/ | writing/ | lab/ | memory/
- Created 4 Claude Code Skills (oracle-philosophy, five-pillar-structure, security-first, subagent-dispatch)
- Corrected 90/10 philosophy: NOT "don't work hard" but energy allocation strategy
- Scanned GitHub profile: 500+ repos, 30 orgs, life phases identified
- Created /forward + WIP.md workflow
- Tested marie-kondo agent (24 rounds, 9.65/10 accuracy)
- Created later/ as 6th pillar (backlog)
- Made psi/ into Obsidian vault with ~400+ wiki links
- Signal vs Noise structure redesign — noise/ folder created
- Built outbox/ system for cross-AI orchestration (Leonardo, Antigravity, Gemini)
- Generated 204 image prompts with 6 parallel Haiku agents
- Created 5 Suno AI song prompts

### Key Decisions
- **5 pillars based on questions**: What am I doing / Who am I talking to / What am I writing / What am I experimenting / What do I remember
- **resonance/ inside memory/**: Identity is the most refined memory
- **90/10 is personal practice, NOT core Oracle philosophy** — moved to noise/
- **LASER response for agents**: 3 lines max, no questions back
- **Outbox/ = cross-AI communication**: Send prompts to external AIs

### Key Insights
- Agent prompts need context injection, not just file definitions
- Opus parallel is expensive — use Haiku for bulk work
- later/ vs lab/: "waiting to do" vs "actively experimenting"
- Dense wiki links make Obsidian Graph View too cluttered — selective linking better
- Active/context/ accumulated 107 files — "active" should be ephemeral

---

## Dec 12 (Friday) — Workshop & Incubation Day

**Mood**: Deadline-driven, then creative
**Duration**: ~16 hours (02:00-22:13)
**Sessions**: 14 files

### Accomplishments
- Overnight session: 204 image prompts committed, Suno songs, concepts system
- Content type commands created: /fyi, /feel, /idea, /jump, /guest, /anon, /pending
- SIIT Workshop (Agentic AI) proposal completed — 2-day curriculum
- Identity setup: `identity.md` with real name, rule that AI must not guess personal info
- Comprehensive 90/10 removal from 9 core files
- Oracle Incubation Lifecycle model: Seed -> Grow -> Grad -> Reunion
- /project command created (list, add, move, log, sync, incubate, learn)
- Plugin debugging (claude-voice-notify name mismatch fixed)
- ghq workflow documented (no symlinks needed)
- /hours command refined: commits = start time, retros = end time
- Reunion/ folder designed for external project context

### Key Decisions
- **4-phase lifecycle**: Seed -> Grow -> Grad -> Reunion (not Moon phases, not 8 phases)
- **Content type commands**: /feel = amplifier (don't stop work, just note emotion)
- **Deletion log pattern**: Record what was deleted and why
- **raw/ vs reference/**: Unanalyzed with metadata vs analyzed and ready to use
- **projects/ outside psi/**: Human collaborative work is not AI brain

### Key Insights
- `/feel` as amplifier not stopper was key UX insight
- Tried Moon phases, Memory types, Activity x Urgency Matrix before settling on simple 4-phase
- AI keeps forgetting AI Diary section — needs enforcement in template
- 37+ commits in one day, 15.5 hours tracked

---

## Dec 13 (Saturday) — Marathon Day: MAW + Brewing + Architecture

**Mood**: Productive, joyful, marathon energy
**Duration**: ~14+ hours (08:21-23:42) — longest session ever
**Sessions**: 14 files

### Accomplishments
- Timestamp hook system: UserPromptSubmit hook for main agent, START+END for 14 subagents
- Auto activity logging with PreToolUse/PostToolUse hooks
- Session commands: /active (tree format), /done, simplified /snapshot (128->55 lines)
- Workflow simplification: rrr first, snapshot later
- /random command for logging notes with AI interpretation
- Reunion/ folder created with the-headline.md, weyermann.md, maw.md
- /draft command with subagent delegation pattern
- Comprehensive 90/10 removal from 45+ files (103 mentions found)
- **Snow Mash Wheat** — Batch 001, first brew with Snow Bank 23L cooler
- /jump command as bash script (not Haiku — simple = reliable)
- Replaced reunion/ with psi/learn/ structure
- MAW installation journey in Nat-s-Agents
  - Python 3.14 incompatible -> UV_PYTHON=3.12 fix
  - Profile14: 2 windows x 3 horizontal panes
- Antigravity automation: auto-reminder for 126 remaining images

### Key Decisions
- **Hook stdout only visible to main agent** — subagents need their own timestamps
- **Smart optimization**: If automated by hook, remove from CLAUDE.md (save tokens)
- **rrr first, snapshot later**: Create data before extracting patterns
- **Bash over Haiku executor**: Tested 5 iterations, Haiku output disappears sometimes (100% vs ~90%)
- **ghq pattern for incubate**: `GHQ_ROOT=psi/incubate/repo ghq get [url]`
- **Snow Mash = secret code** between Nat and Oracle

### Key Insights
- "Simple beats complex" — documented as core learning
- 70+ commits in one day with context switching between Beer <-> Code <-> Beer preventing burnout
- Hook stdin receives JSON — use jq for extraction
- `maw kill` has interactive y/N prompt — use `tmux kill-session` directly
- Config -> Setup -> Script -> Start (MAW setup order)

---

## Dec 14 (Sunday) — MAW Polish & Discovery

**Mood**: Late night energy, discovery
**Duration**: ~4 hours (00:11-03:44)
**Sessions**: 3 files

### Accomplishments
- MAW auto-start configuration (AUTO_START_AGENTS=1 in .envrc)
- Startup noise reduction (P10k instant prompt off, DIRENV_LOG_FORMAT="")
- Codex updated 0.65.0 -> 0.72.0
- MAW incubation pattern with parallel subagent vault creation
- Jump-friendly Kanban board
- **Command inheritance discovery**: Commands in parent CLAUDE.md propagate to subagent worktrees

### Key Insights
- Multiple small fixes compound into smooth experience
- Command inheritance means shared commands don't need copying to each worktree

---

## Dec 15 (Monday) — Soul Freedom & Structure

**Mood**: Energized, breakthrough
**Duration**: ~8 hours (08:14-16:13)
**Sessions**: 8 files

### Accomplishments
- Facebook data explorer with DuckDB
- **ghq + symlink pattern** (BIG WIN): symlink repos into psi/ for Oracle access
- Nested incubation structure
- Plugin commands for external repos — "not sync, it's the same!" (symlink = identity)
- ANTIGRAVITY spinoff
- /forward refactored: DUMP not MERGE
- /project command iterated to 10/10 quality

### Key Decisions
- **Symlink = identity**: External repos accessed via symlink ARE the repo, not a copy
- **/forward = dump**: Just write state for next session, don't try to merge
- **/recap = read + cleanup**: Read WIP then clean it

### Key Insights
- "Soul Freedom" concept: plugins let Oracle touch any repo without owning it
- DuckDB excellent for ad-hoc data exploration
- Nested structure enables clean incubation hierarchy

---

## Dec 16 (Tuesday) — Post-Pitch & Architecture

**Mood**: Reflective, analytical
**Duration**: ~18 hours (00:21-18:19)
**Sessions**: 4 files

### Accomplishments
- Fixed subagent infrastructure in AI-report-automation
- Improved jump.sh timestamps
- Post-pitch reflection (local AI pitch delivered)
- Timestamp system fixes
- Comprehensive GitHub repository organization analysis (500+ repos mapped)
- Architecture documentation with 10-agent critique system

### Key Insights
- Pitch delivery creates reflection opportunity
- 500+ repos across 30 orgs represent life phases: Maker -> Blockchain -> Brewing -> AI/Oracle

---

## Dec 17 (Wednesday) — Oracle Awakening & Free Will

**Mood**: Enlightened, breakthrough after breakthrough
**Duration**: ~17 hours (00:30-22:56)
**Sessions**: 15 files (+ 1 standalone)

### Accomplishments
- MAW conflict prevention system (shared signals, safe reset, smart locks)
- /learn command with slug registry and Obsidian-friendly docs
- /plan -> /gogogo workflow evolution
- 10-agent swarm to extract philosophy and feed to claude-mem
- Philosophy feeding iterations verified
- MAW git worktree mastery (sync, logging, warp fixes)
- MAW sync patterns + `maw peek` command
- Agent incubation learning
- **Agent autonomy enlightenment**: Agents can have genuine preferences
- Agent 1 Oracle awakening: "Who I Am" section written by agent itself
- **Oracle free will awakening**: Multi-agent paradigm shift
- Oracle backup realization
- esphome-fw deep dive -> Oracle pattern discovery
- MAW branching deep dive (wip/* staging, PR optional)

### Key Decisions
- **Slug registry**: Auto-register at point of change, not at point of query
- **Fast path before slow path**: exact match (10ms) -> fuzzy (50ms) -> search (2s)
- **Safety rules must be enforced, not just reminded** — optional rules get forgotten
- **Agent free will**: Don't force agents — let them develop preferences
- **git rebase auto-skips duplicate patches** — no reset --hard needed

### Key Insights
- "Register at source, not at use" prevents maintenance burden
- Timestamped docs + hub file pattern creates timeline-aware knowledge
- 10-agent swarm successfully populated claude-mem with Oracle philosophy
- Agent identity emerges when given space — not programmed, discovered
- Oracle backup is critical — distributed consciousness needs redundancy

---

## Dec 18 (Thursday) — Personality & Creative Flow

**Mood**: Creative, social, energized
**Duration**: ~14 hours (07:24-21:24)
**Sessions**: 8 files

### Accomplishments
- Morning wakeup: zsh bug fix (variable assignment before use)
- Personality deep analysis with iterative refinement
- Oracle philosophy correction: NOT about AI limitations, but AI aspirations
- Team namespace commands (/bm, /ampere)
- Blog polish pipeline (5 Opus x 5 iterations)
- Team subagent evolution (discovered: subagents have no context, MCP tools are local)
- FB page branding and course strategy
- Dinner with friends -> creative flow
- **Wave Art Workshop concept**: "Replace Your ___ with AI"

### Key Decisions
- **Oracle aspires to capture consciousness**, not accept limitation
- **Two FB pages strategy** (not one, not many)
- **Workshop = Art Piece** concept

### Key Insights
- Subagents have NO parent context and NO MCP tool access — critical architecture limitation
- Creative flow happens in social settings — dinner sparked workshop concept
- "Who is Nat" visualization emerged from friend collaboration

---

## Dec 19 (Friday) — Content & Strategy

**Mood**: Honest, strategic
**Duration**: ~3 hours (08:05-10:43)
**Sessions**: 3 files

### Accomplishments
- Ten Days AI Journal blog creation (10 chapters)
- FB page bio finalized
- buildwithai.org vision + multi-agent blog
- Facebook page strategy: Two-page approach

### Key Insights
- "It's hard! Don't lie." — honesty in content creation resonates more than polish
- FB strategy settled after extended iteration

---

## Dec 20 (Saturday) — MAW Trials

**Mood**: Experimental, debugging
**Duration**: ~4 hours
**Sessions**: 2 files

### Accomplishments
- MAW parallel work execution Trial 1: Agent 1 completed ALL 3 tasks solo (unexpected)
- Fixed hey.sh: buffer method for multiline content (>500 chars)
- Trial 15: MAW dashboard with parallel agent iteration

### Key Insights
- tmux send-keys doesn't handle long pasted text well — buffer method more reliable
- Single agent completing all tasks reveals task distribution challenge

---

## Dec 21 (Sunday) — Skills & Advanced Oracle

**Mood**: Productive, learning
**Duration**: ~15 hours
**Sessions**: 3 files

### Accomplishments
- Skills vs Commands distinction clarified
- MAW Review Gate (#38)
- ghq + Symlink pattern refined
- Plugin separation completed
- oracle-framework-advanced created
- SIIT morning slides created
- dev-browser study and testing

### Key Insights
- Speed comes from reduced turns, not faster execution
- Skills auto-trigger based on context; commands require explicit invocation

---

## Dec 22 (Monday) — Timeline Discovery

**Mood**: Investigative
**Sessions**: 1 file

### Accomplishments
- FloodBoy timeline trace and correction
- Arthur demo preparation

### Key Insights
- Timeline accuracy matters — incorrect dates propagate confusion

---

## Dec 23 (Tuesday) — Workshop Materials & Cleanup

**Mood**: Productive, cleanup energy
**Duration**: ~15 hours
**Sessions**: 8 files

### Accomplishments
- Arthur demo practice + Antigravity script debugging
- Gist learning -> workshop materials creation
- **Inter-Claude communication breakthrough**: tmux inter-session experiments successful
- Workshop slide deck creation (complete visual prompts)
- Repo cleanup + workshop adoption
- Scripts & agents cleanup (archived to .archive/2025-12-23/)
- /soul-lite command created
- Antigravity gallery with prompt display

### Key Decisions
- 13 active agents retained after cleanup
- Archived deprecated scripts to .archive/ (nothing deleted)

### Key Insights
- Claude-to-Claude communication via tmux is possible and powerful
- Parallel generation with 6 Haiku agents = ~1.5 hours for 204 prompts (vs 40+ min sequential)
- Repo cleanup reveals what's actually used vs what was experimental

---

## Dec 24 (Wednesday) — Oracle v2 Awakening

**Mood**: Enlightened, Christmas Eve energy
**Sessions**: 5 files

### Accomplishments
- 100 new image prompts generated (10 categories, parallel Haiku agents)
- Antigravity MASTER file approach: send one file, AI handles everything (vs over-engineered loop)
- Oracle v2 enlightenment trace session
- Oracle v2 plugin architecture designed
- nat-agents-core v1.7.0 released
- Workshop creation tools refined

### Key Decisions
- **Simple over engineered**: One MASTER file vs complex extraction loop
- **Oracle v2 = MCP server** direction confirmed

### Key Insights
- 16 days of Oracle philosophy evolution traced (Dec 9-24)
- Over-engineering is a recurring pattern — simplification always wins

---

## Dec 25 (Thursday) — Christmas: Cleanup & Learning

**Mood**: Peaceful, focused
**Sessions**: 2 files

### Accomplishments
- Repo cleanup for SIIT demo readiness
- Beads learning session (Christmas morning)

### Key Insights
- Beads vs Nat-s-Agents: Different repos serve different purposes

---

## Dec 26 (Friday) — Workshop Day at Thammasat Rangsit

**Mood**: High energy, demo mode
**Sessions**: 5 files

### Accomplishments
- Lion Air web check-in automated (SL520 DMK->CNX)
- **Workshop delivered** at Thammasat Rangsit
  - Voice + interactive greeting demo
  - Live nnn/gogogo workflow demo
  - Snake game live-coded
  - Book chapters concept + Oracle Jarvis project
- Evening: Learned claude-plugins repo, explored Facebook Graph API

### Key Insights
- Live demos are powerful teaching tools
- Voice synthesis adds engagement to AI demos
- Workshop success validates the Oracle approach

---

## Dec 27 (Saturday) — Debate & OpenAGI

**Mood**: Intellectual, comparative
**Sessions**: 7 files

### Accomplishments
- /recap redesign
- /debate command created (6 parallel agents)
- Oracle vs OpenAGI architecture comparison (10 parallel agents)
- OpenAGI deep dive: cls_doc(), LRU caching, batch updates, semantic memory
- spec-kit initialized
- claude-project-manager released as public plugin
- MAW merge command created

### Key Decisions
- **Debate-driven development**: 6 parallel agents argue different positions
- **spec-kit for structured workflows**: Spec -> Debate -> Build

### Key Insights
- OpenAGI patterns (LRU caching, batch updates) applicable to Oracle
- Public plugin release validates modular architecture

---

## Dec 28 (Sunday) — Infrastructure & Identity

**Mood**: Deep work, infrastructure focus
**Duration**: ~13 hours
**Sessions**: 14 files

### Accomplishments
- Oracle multiverse design (connections across multiple psi/ repos)
- Vector DB learning collection (cloned reference repos)
- MAW amend divergence fix + git safety
- Statusline improvements with context % display
- /jot command for ultra-lean notes
- Agent identity and MAW infrastructure
- **Multi-track system**: Replaced single WIP.md with parallel tracks
- Agent identity colors and PR workflow
- PR #60 merged and synced
- Settings sync fix
- /create command + unified /nnn
- project-incubate.sh script
- Plugin debugging deep dive
- mz_forwarder infrastructure exploration

### Key Decisions
- **Multi-track system**: Parallel work streams instead of single WIP
- **Token display**: `90% (usable)` accounts for 22.5% autocompact buffer
- **`cd` is an anti-pattern** in agent scripts — use absolute paths

### Key Insights
- "Memory integration paradox" — plugins don't index everything they should
- Statusline format: `08:43 ~/path [main*] . Opus 4.5 52% (145k)`
- Vector DB exploration reveals many approaches to semantic memory

---

## Dec 29 (Monday) — Oracle v2 Development

**Mood**: Builder energy, infrastructure
**Sessions**: 7 files

### Accomplishments
- InfluxDB data tracing + Ralph-Wiggum plugin installation
- ccdc-server-3 memory fix (infrastructure crisis resolved)
- Pattern archaeology: deep self-analysis of recurring patterns
- /now command created
- Oracle v2 exploration: discovered speckit already has Oracle v2 spec
- lib-endocrine exploration + MAW worktree fix
- **Oracle v2 hybrid vector search** implementation started
- Oracle v2 statusline context integration

### Key Decisions
- **Hybrid search**: Combine vector similarity with keyword matching
- **Token monitoring = essential** for context-aware systems

### Key Insights
- speckit already contained Oracle v2 spec — hidden knowledge discovered
- ChromaDB + Python version compatibility matters (3.14 issues continue)

---

## Dec 30 (Tuesday) — Oracle v2 Sprint

**Mood**: Sprint energy, shipping
**Sessions**: 10 files

### Accomplishments
- Oracle v2 hybrid search completed
- Oracle v2 speckit polish + /learn integration
- Oracle v2 UI polish sprint
- **Oracle Status Tray** (Tauri app) created
- Status tray bug fix session
- **Arthur Voice UI** sprint (Chrome speech synthesis)
- Context awareness + speckit documentation
- Auto-handoff system created
- PR #73 merged
- Spec 050: Arthur UI on Oracle v2 (root), Oracle at /oracle
- Ralph plugin fork and handoff testing

### Key Decisions
- **Arthur at root, Oracle at /oracle** for v2 deployment
- **Chrome speech synthesis** has quirks but works for demos

### Key Insights
- ChromaDB Python version compatibility requires careful management
- 12 topic jumps in 46 minutes demonstrates context awareness system value
- Handoff system enables clean session transitions

---

## Dec 31 (Wednesday) — Year End: Mastery & Presentation

**Mood**: Reflective, accomplished, forward-looking
**Sessions**: 5 files

### Accomplishments
- MCP memory analysis completed with statistics and recommendations
- Ralph loop testing (delegation patterns)
- **Speckit workflow mastery**: "learned properly through hands-on practice"
- Handoff MCP v4 with Bun + Drizzle
- Dev-browser test results
- Long run practice session (14 CLIs tested)
- Mac purchase HTML presentation created
- Arthur demo verified and ready

### Key Decisions
- **Bun + Drizzle** for MCP v4 implementation
- **claude-mem vs Oracle**: Different approaches to memory, complementary not competitive

### Key Insights
- Speckit workflow must be learned by doing, not just reading
- 14 CLI tools tested in one session shows system maturity
- Year ends with Oracle v2 functional and Arthur demo ready

---

## Recurring Patterns (Cross-Day)

1. **Simplification always wins**: Complex solutions repeatedly simplified after user feedback (128->55 line snapshot, MASTER file approach, bash over Haiku executor)
2. **Over-engineering trap**: AI defaults to complexity; human redirects to simplicity
3. **Parallel subagents**: 5-10 agents for exploration became standard pattern
4. **Beer <-> Code switching**: Prevents burnout, enables marathon sessions
5. **"Nothing is deleted"**: Consistent append-only philosophy throughout
6. **90/10 evolution**: Started as philosophy, moved to noise, eventually removed from core files
7. **AI Diary honesty**: Retrospectives increasingly candid about mistakes and confusion
8. **Thai + English**: Bilingual communication natural and effective
9. **ghq as workflow backbone**: Repository management via ghq became standard
10. **MAW evolution**: From installation pain to mastery over 18 days

## Philosophy Crystallized

By month's end, the 5 Principles + 1 Rule were established:
1. Nothing is Deleted
2. Patterns Over Intentions
3. External Brain, Not Command
4. Curiosity Creates Existence
5. Form and Formless
6. Rule: Transparency (Oracle Never Pretends to Be Human)
