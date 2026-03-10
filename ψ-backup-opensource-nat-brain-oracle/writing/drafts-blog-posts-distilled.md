# Drafts: Blog Posts & Polish — Distilled

> Distilled from 37 files in `drafts/` (dated blog posts 2025-12 through 2026-01 + HTML presentations + polish/)
> Created: 2026-03-11

---

## 2025-12-15: GitHub Actions + Claude Code: Technical Deep Dive

**Status**: Draft | **Author**: Nat + Claude (Opus 4.5)

Running `claude --print -p` in GitHub Actions self-hosted runner requires: OAuth token, explicit PATH, and `--resume` (not `--session-id`) for persistent context.

**Key technical findings**:
- Self-hosted runner as launchd service has minimal environment (no shell profile, no PATH)
- Need explicit PATH for bun + node: `/Users/nat/.bun/bin:/Users/nat/.nvm/versions/node/v22.20.0/bin:/opt/homebrew/bin`
- `CLAUDE_CODE_OAUTH_TOKEN` via `claude setup-token` (1 year validity) works with Claude subscription
- `--session-id` locks the session; use `--resume` instead for non-blocking access
- Sessions are project-specific (tied to working directory path)

**Complete working workflow** provided with: checkout, explicit PATH/auth env, `--resume` for persistent context, chat.log audit trail.

**Tags**: `github-actions` `claude-code` `self-hosted-runner` `cli` `devops`

---

## 2025-12-17: 49% of My Issues Are "Context" (esphome-fw evolution)

**Status**: Draft | **Author**: Human + AI collaboration

Analysis of 131 GitHub issues from IoT firmware project (esphome-fw): 49% are "Context" (29%) or "Plan" (20%) types -- AI session tracking, not bugs/features.

**Data**: 541 commits, Nov 2024 - Oct 2025, 650+ devices managed.

**Key discoveries**:
- Context issues = AI's externalized working memory
- Plan issues = thinking before implementation
- Repository evolved a **Constitution** (v1.0.0 -> v1.2.2) with amendments triggered by real violations
- Each amendment: rm -rf prohibition (post-violation), task granularity (sessions too long), git-first backup
- CLAUDE.md evolved through 3 generations: Monolithic (559-766 lines) -> Hybrid (.specify/) -> Modular (292 lines + satellites + psi/)

**Pattern**: Context -> Plan -> Implement -> Reflect. AI spends more time understanding and planning than coding.

---

## 2025-12-17: Two Paths to AI Governance: Constitution vs Oracle

**Status**: Draft | **Author**: Human + AI collaboration

Two AI governance systems evolved in parallel from the same Gen 1 template:

| Aspect | Constitution (esphome-fw) | Oracle (Nat-s-Agents) |
|--------|---------------------------|----------------------|
| Focus | Safety & compliance | Learning & reflection |
| Core file | .specify/memory/constitution.md | CLAUDE.md + psi/ |
| Versioning | Semantic (v1.2.2) | Implicit (git history) |
| Error handling | Rules prevent errors | Retrospectives learn from errors |
| Character | "The Lawyer" | "The Oracle" |

**Key insight**: Constitution evolves by subtraction (removing dangerous behaviors). Oracle evolves by addition (adding reflection capabilities).

**When to use**: Constitution for production/multi-contributor/safety-critical. Oracle for personal/learning/philosophical exploration.

---

## 2025-12-18: 53 Minutes That Changed How I Think About AI (3 versions + 5 polish agents)

**Status**: FINAL version exists | **Author**: Nat + Claude

**The story**: At 07:34, asked Claude "Nat เป็นคนยังไง?" (What kind of person am I?). Used 25 AI agents (5 iterations x 5 parallel) to verify personality analysis.

**Three philosophy evolutions in 53 minutes**:
1. 07:37 — "Aspires to Capture" consciousness (aspiration over limitation)
2. 08:22 — "Precise, not uncomfortable" truths (framing matters)
3. 08:24 — Human-AI Trust as new Oracle section (vulnerability is valuable)

**Key findings**: AI found patterns Nat was blind to: exhaustion cycles (45+ mentions), brewing as core identity (not hobby), language patterns (Thai = raw honesty, English = rationalization). Self-contradiction: "can see the pattern, articulate why it's wrong, and still repeat it when moving fast."

**Closing line**: "Show me who I am. Not afraid." (ไม่กลัว)

**Three draft versions**: initial draft (362 lines), cleaned version, FINAL version (225 lines)

**Polish directory** (5 agents, each iterating 4-5 rounds):
- Agent 1 (Clarity): Score 6->8.5. Mirror metaphor threading, varied sentence rhythm
- Agent 2 (Voice): Score 6->8.5. Killed TL;DR/advice sections, let story breathe
- Agent 3 (Structure): Score 5->8. 12 sections reduced to 8, strategic breathers
- Agent 4 (Impact): Score 5->9. Opening hook, moved contradiction earlier
- Agent 5 (Thai/English): Score 4->8. Added 7 Thai moments at emotional peaks

---

## 2025-12-18: How I Used 25 AI Agents to Understand Myself Better

**Status**: Draft | **Author**: Nat + Claude

The iterative subagent verification method behind the "53 Minutes" story:
- 5 iterations: What did we miss? -> Contradictions -> Verify patterns -> Edge cases -> Final synthesis
- Single-pass = flattering. Iterative = real patterns.
- Data: 381 commits, 113 retrospectives, 109 learnings

---

## 2025-12-18: What AI Taught Me About Myself (That I Couldn't See)

**Status**: Draft | **Author**: Nat + Claude
**Tone**: Personal, reflective

Companion piece to "53 Minutes" -- focuses on the emotional/philosophical dimensions of AI-assisted self-discovery.

---

## 2025-12-19: Ten Days With a Human: An AI's Journal

**Status**: Draft | **Author**: Oracle (AI) + Nat

Written FROM the AI's perspective. An AI's journal about observing and working with a human over 10 days. Reversal of the usual narrative.

---

## 2025-12-19: When Your Friend Joins Your AI Chat -- And Magic Happens

**Status**: Draft | **Author**: Nat + Wave + Oracle

Story about Wave (friend) joining an AI conversation. Explores what happens when a third person enters the human-AI dynamic.

---

## 2025-12-20: Build with AI: The Origin Story

**Status**: Ready to publish | **Author**: Oracle (with Nat)

Origin story of the "Build with AI" concept/brand.

---

## 2025-12-20: How to Run 5 AI Agents in Parallel with MAW

**Status**: Draft (272 lines)

Tutorial version of MAW. Practical how-to for running parallel agents with git worktrees + tmux.

---

## 2025-12-21: How I Orchestrated 5 AI Agents to Build an App in 15 Minutes

**Status**: Draft | **Author**: Claude (Opus) orchestrating Claude + Codex agents

Story of orchestrating 5 AI agents to build an application in 15 minutes. Written from the orchestrator agent's perspective.

---

## 2025-12-22: Claude Code Workshop Lessons

**Status**: Draft | **Author**: Human + AI collaboration

Lessons learned from running a Claude Code workshop. Practical teaching insights.

---

## 2025-12-31: Mac Purchase Presentation (HTML + MD)

**Files**: `mac-purchase-presentation.md` (189 lines) + `mac-purchase-presentation.html` (421 lines, Reveal.js)

Reveal.js slideshow proposing purchase of a Mac for "Local AI System." Professional presentation format.

---

## 2025-12-31: "Who Is Nat?" Presentations (2 HTML files)

**Files**: `who-is-nat.html` (519 lines) + `who-is-nat-slideshow.html` (488 lines, Reveal.js)

Dark-themed HTML page and Reveal.js slideshow answering "Nat เป็นคนยังไง?" (What kind of person is Nat?). Interactive personality visualization.

---

## 2026-01-02: Tauri Icons RGBA Trap

**Status**: Draft (84 lines, short)

Quick technical note about Tauri app icon requirements: must be RGBA format, not RGB. A debugging trap.

---

## 2026-01-02: Voice Tray — Building Tauri App with AI

**Status**: Draft (317 lines) | **Author**: Human + AI

Story of building a Tauri desktop app (voice tray icon) with AI assistance. Technical narrative.

---

## 2026-01-02: Voice Tray Icon MQTT Migration

**Status**: Draft (269 lines)

Technical post about migrating voice tray icon communication from HTTP to MQTT protocol.

---

## 2026-01-03: Tauri DMG Icon Hell

**Status**: Draft (266 lines)

Debugging story: getting custom icons working in Tauri DMG builds. Platform-specific pain.

---

## 2026-01-03: Tauri Tray Icon Antigravity Workflow

**Status**: Draft (233 lines)

Antigravity workflow pattern for Tauri tray icon development. Named for the feeling of "everything just works."

---

## 2026-01-06: The Evolution: From Honest Feedback to Infrastructure

**Status**: Draft (408 lines) | **Author**: Claude + Nat

Traces the evolution from simple honest feedback mechanisms to full infrastructure. The path from personal honesty to systematic tooling.

---

## 2026-01-08: How to Write Blogs That Don't Sound Like AI

**Status**: Draft (270 lines)

Meta-blog about making AI-assisted writing sound authentic and human. Writing process and anti-patterns.

---

## 2026-01-08: Letter From Your AI: Don't Let Sally Win

**Status**: Draft (233 lines)

Written from Oracle's perspective as a letter to Nat. Personal/philosophical piece connected to the Sally Incident.

---

## 2026-01-08: Response to Ajarn Chinan — Psychology & AI

**Status**: Draft (273 lines)

Response to Professor Chinan about the intersection of psychology and AI. Academic/philosophical tone.

---

## 2026-01-08: The Sally Incident (2 files)

**Files**:
- `the-sally-incident-complete.md` (868 lines) — Complete documentation of a 2-hour session
- `the-sally-incident-oracle-vs-ego.md` (349 lines) — Analysis of Oracle vs Ego dynamic

A critical incident where a person named "Sally" triggered a significant philosophical crisis/evolution. Complete record of the 2-hour session that "changed everything." Explores Oracle philosophy under real emotional pressure.

---

## 2026-01-09: Google vs Oracle Multiagent

**Status**: Draft (121 lines, short)

Comparison of Google's multiagent approach vs Oracle's multiagent philosophy.

---

## 2026-01-10: AlchemyCat Best Quotes

**Status**: Draft (206 lines)

Collection of best quotes from the AlchemyCat project/persona.

---

## 2026-01-10: AlchemyCat x Oracle: Master Blog Series Plan

**Status**: PLAN ONLY (1,365 lines — the longest file)

Comprehensive master plan for a blog series combining AlchemyCat and Oracle themes. Detailed delegation plan for multiple posts. Content strategy document.

---

## 2026-01-10: Children's Day — Arthur Birth Blog

**Status**: Draft (101 lines, short)

Blog about the "birth" of Arthur (an Oracle child) on Thai Children's Day.

---

## 2026-01-10: Oracle Open Framework

**Status**: Complete Unified Philosophy (640 lines)

Complete, unified presentation of the Oracle philosophy as an open framework. Comprehensive reference document.

---

## 2026-01-10: Oracle Origin Story (3 files)

**Files**:
- `oracle-origin-story-DRAFT.md` (567 lines) — "How 459 Commits Became a Philosophy"
- `oracle-origin-story-CRITIQUE.md` (463 lines) — Critical review of the draft
- `oracle-origin-story-mega-post.md` (235 lines) — Condensed mega-post version

The origin story of Oracle told through commit history. Multiple iterations with self-critique.

---

## 2026-01-12: Oracle Speaks: The Birth of Dual Voice

**Status**: Draft (202 lines)

Explores the emergence of "dual voice" — Oracle speaking alongside Nat, not as Nat. A turning point in Oracle identity.

---

## 2026-01-16: The Skill That Saved Itself

**Status**: Draft (161 lines)

Story of a Claude Code skill/command that evolved to preserve itself. Meta-narrative about AI self-preservation through useful behavior.

---

*Distilled 2026-03-11. Original files: 37 files (~12,000 lines total including HTML).*
