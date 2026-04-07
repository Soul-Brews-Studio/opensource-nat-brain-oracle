# Archive Context + Later + Handoffs + Seeds + Data — Distilled

> Distilled 2026-03-11 from archive/context/2025-12/ (14 files), later/ (4 files), handoffs/ (1 file), memory/seeds/ (1 file), data/ (1 file)

---

## Archive Context: Psi Structure Audit (2025-12-11)

Full audit of the 7-pillar psi folder structure: active, inbox, lab, later, memory, noise, writing.

**Key findings**:
- Missing INDEX.md in inbox/, lab/, memory/
- 229 prompt files in outbox (16M) creating git bloat — 21x imbalance vs knowledge
- Total tracked: ~300 files, ~800KB knowledge vs ~16MB prompts
- Recommendation: .gitignore outbox prompts immediately

## Archive Context: Identity Compilation (Dec 2025)

Nat identity extraction from 2,200+ GitHub repos across 32 orgs:

**Life phases**: Maker (IoT/hardware) -> Blockchain -> Brewing -> AI/Oracle
- 500+ repos, 30 orgs: IoT 30%, Blockchain 25%, AI/LLM 15%, Full-stack 15%
- Personality: builder-philosopher, Thai-English bilingual, pattern-seeker
- Communication style: direct, code-first, emoji-punctuated
- Core identity: "creator who uses technology to understand consciousness"

**Key documents compiled**:
- NAT-IDENTITY-COMPILATION.md — full personality profile from GitHub analysis
- NAT-IDENTITY-INDEX.md — categorized traits and patterns
- NAT-SONG-PROMPT-KEYWORDS.md — creative expression keywords for Suno songs
- EXECUTIVE-SUMMARY.md — condensed identity for quick reference

## Archive Context: Weyermann Project

Quick reference for Weyermann malt/brewing project:
- Technical malt specifications and brewing parameters
- German-Thai brewing terminology reference
- Project timeline and milestones

## Archive Context: Research Seeds & Obsidian

- Obsidian vault structure analysis for knowledge management
- Seeds concept: ideas extracted from retrospectives, categorized as Incremental/Transformative/Moonshot
- Detailed examples of seed patterns from Dec 2025 sessions

## Archive Context: CCC Analysis

Context-finder command (ccc) workflow analysis — creating GitHub issues for context when stuck.

## Archive Context: Search Results Summary

Aggregated search results from GitHub API exploration of repos, organizations, and contribution patterns.

---

## Later: Task Queue (Dec 2025)

**Backlog items** (status at time of archival):

### 1. GitHub Deep Dive (Medium priority)
- Goal: Analyze Nat's GitHub profile across life phases
- Steps: Select 5-10 key repos, clone, analyze patterns, create timeline
- Output target: memory/resonance/github-personality.md
- Status: Pending (initial scan done — 500+ repos, 30 orgs found)

### 2. Outbox Restructure (High priority)
- Problem: 229 ephemeral prompt files (16M) violating architecture
- **Option A (1hr, recommended)**: .gitignore prompts, keep INDEX tracked
- **Option B (3hr)**: Reorganize by project (antigravity/, suno/)
- **Option C (8hr)**: Separate repos per AI project
- Decision needed from Nat

### 3. Repository Consolidation (High priority, 4 weeks)
- Target: 2,200 repos -> 300 active across 5 orgs (down from 32)
- 873 forks -> <30, 32 archived -> 300+
- Phase plan: Assessment -> Prepare -> Execute Batch 1 -> Execute Batch 2 -> Cleanup
- Quick wins: delete unused forks (2-3hr), archive inactive repos (4-5hr)
- File placement decision tree for ~/Code vs psi/incubate vs psi/learn vs psi/lab

---

## Seeds Index (Dec 2025)

Top recurring seeds from retrospectives:

| Seed | Count | Type |
|------|-------|------|
| Cellar: Unified Local Brain | 5x | Moonshot |
| Oracle Monitoring System | 4x | Transformative |
| Agent SDK Learning Labs | 3x | Incremental |
| Knowledge Graph | 3x | Moonshot |
| Parallel Agent Research | 3x | Transformative |

**30+ seeds total** across 3 categories:
- **Incremental**: Verify sources before citing, ask about time constraints, pitch template, learning labs pattern, judge agent code review, pre-commit hooks, auto-trigger /forward
- **Transformative**: Deadline-driven mode recognition, GitHub profile personality model, inbox/external for multi-agent comms, personality plugin pattern, parallel agent research (60% faster)
- **Moonshot**: AI that knows full coding history, resonance as shareable identity config, retrospective indexing by theme

Flow: Retrospective -> Seeds INDEX -> Later (if actionable) -> Active -> Done

---

## Handoffs & Data

- handoffs/CLAUDE.md: Empty claude-mem-context placeholder (no content)
- data/oracle-v2/CLAUDE.md: Empty claude-mem-context placeholder (no content)

---

## HOME.md Summary (Psi Brain Navigation)

The psi brain was organized around 6 pillars + 1 noise filter:
- **Thinking** (active/) — ephemeral research
- **Communication** (inbox/) — live conversations
- **Waiting** (later/) — queued tasks
- **Building** (lab/) — experiments
- **Publishing** (writing/) — articles
- **Knowing** (memory/) — eternal patterns
- **Separating** (noise/) — signal vs noise

Knowledge flow: active/context -> memory/logs -> memory/retrospectives -> memory/learnings -> memory/resonance

Commands: /snapshot, /distill, rrr (retrospective), /recap, /context-finder, ccc

---

## WIP-CRITIC.md Summary (Recap Command Design Critique)

10-flaw analysis of /recap command design (Agent 7 vs Agent 9), dated 2025-12-27:

1. State machine edge cases (stale WIP detection)
2. Blocker detection misses runtime failures (need actual test runs, not commit grep)
3. 3-path ranking is static (needs time-awareness)
4. One Haiku agent is brittle (needs parallel with fallback)
5. Multi-project workflow support missing
6. External blockers undetectable without heuristics
7. Scoring ignores change magnitude
8. No escalation for deep blockers
9. Template selection criteria vague
10. "3 paths" terminology misleading in blocker case

**Recommendation**: Merge Agent 7's state machine + blockers with Agent 9's scoring + tiers, add 3 parallel agents with fallback.

---

## Memory: Governance & Constitution Analysis

Analysis of 23 constitution/governance files across laris-co repos:

**Three patterns**:
1. Template-based (unfilled placeholders)
2. Project-specific (filled, evolved — esphome-fw v1.2.2 most mature at 15KB)
3. Multi-agent frameworks (AGENTS.md safety rules)

**Universal safety principles**: No force flags, GitHub Flow branching, modular documentation, testing gates.

**Key files**: governance-comparison.md (full analysis), governance-summary.md (quick ref), principle-comparison.md (side-by-side), constitution-index.md (navigation).

## Memory: Skills Inventory & Team System

- **Skills inventory** (Jan 2026): context-finder, feel, forward, fyi, learn, project, recap, schedule — all active in skills/ directory
- **Team system manifest**: Production-ready /bm and /ampere commands for logging requests, schedules, reminders for team members
- **Themes synthesis**: 27 recurring themes from 45+ retrospectives across Oracle Philosophy, Human-AI Collaboration, Technical Architecture, Energy Management, and Meta-Learning

---

*Source directories: archive/context/2025-12/, later/, handoffs/, memory/seeds/, data/, plus HOME.md, WIP-CRITIC.md, CLAUDE.md, later.md, and non-distilled memory/ files*
