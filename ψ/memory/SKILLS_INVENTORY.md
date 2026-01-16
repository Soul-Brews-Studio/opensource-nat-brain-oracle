# Complete Skills Inventory - Nat's Agents

Generated: 2026-01-16

---

## ACTIVE SKILLS (skills/)

These are the current active skills in the primary skills directory. They contain CLAUDE.md files (not traditional SKILL.md).

| # | Skill | Path | Status |
|----|-------|------|--------|
| 1 | context-finder | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/context-finder/ | Active (new) |
| 2 | feel | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/feel/ | Active (new) |
| 3 | forward | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/forward/ | Active (new) |
| 4 | fyi | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/fyi/ | Active (new) |
| 5 | learn | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/learn/ | Active (new) |
| 6 | project | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/project/ | Active (new) |
| 7 | recap | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/recap/ | Active (new) |
| 8 | schedule | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/schedule/ | Active (new) |
| 9 | standup | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/standup/ | Active (new) |
| 10 | trace | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/trace/ | Active (new) |
| 11 | watch | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/watch/ | Active (new) |
| 12 | where-we-are | /Users/nat/Code/github.com/laris-co/Nat-s-Agents/skills/where-we-are/ | Active (new) |

**Note:** These are newly added skills (not yet committed). Each contains a CLAUDE.md file with claude-mem-context wrapper.

---

## ARCHIVED SKILLS (.claude/_archive/skills/)

These are mature, documented skills with SKILL.md frontmatter containing descriptions.

| # | Skill | Path | Description |
|----|-------|------|-------------|
| 1 | antigravity | .claude/_archive/skills/antigravity/ | Image generation via Antigravity app integration. Use when user asks to "generate an image", "create an icon", "design a logo", or mentions Antigravity/Gemini image generation. |
| 2 | five-pillar-structure | .claude/_archive/skills/five-pillar-structure/ | Navigate and use the ψ/ 5-pillar folder structure. Use when creating files, organizing content, or asking where things should go. Pillars: active (research), inbox (communication), writing (blog), lab (experiments), memory (knowledge). |
| 3 | handoff | .claude/_archive/skills/handoff/ | Use handoff tools for session continuity. Create handoffs at end of session, read handoffs at start, search past handoffs for context. Trigger: "handoff", "end session", "wrap up", "continue from", "where we left off". |
| 4 | interesting | .claude/_archive/skills/interesting/ | Log interesting information for future reference. Use when user says "this is interesting", "remember this", "fyi", or wants to log noteworthy information they found. |
| 5 | jump | .claude/_archive/skills/jump/ | Navigate conversation topics with stack. Use when user says /jump, wants to switch topics, or check current focus. |
| 6 | longrun | .claude/_archive/skills/longrun/ | Marathon mode for extended work sessions. Use when user says "long run", "go long", "marathon". Handles handoffs, learnings, context gates automatically. |
| 7 | maw-orchestrator | .claude/_archive/skills/maw-orchestrator/ | Orchestrate parallel AI agents to build apps fast. Use when user wants to build something big, needs parallel work, or mentions multi-agent. Dispatches tasks to 5 agents, monitors progress, syncs commits. |
| 8 | oracle-philosophy | .claude/_archive/skills/oracle-philosophy/ | Apply Oracle principles for knowledge management and data handling. Core: Nothing is Deleted, Patterns Over Intentions, External Brain Not Command. |
| 9 | project-manager | .claude/_archive/skills/project-manager/ | Clone and track external repos. Use when user shares GitHub URL to study/develop, or says "search repos", "find repo", "where is [project]". Actions: learn (clone for study), incubate (clone for development). |
| 10 | repo-health | .claude/_archive/skills/repo-health/ | Detect large files, data files, and repo bloat before commits. Use when git add, git commit, or file size concerns mentioned. |
| 11 | security-first | .claude/_archive/skills/security-first/ | Apply safety rules before any git operation, file deletion, or destructive action. Never force push, never push to main, never auto-merge PRs. |
| 12 | subagent-dispatch | .claude/_archive/skills/subagent-dispatch/ | Decide when to use subagents vs doing work directly. Prefer Haiku for heavy lifting, Opus for review. Agents: context-finder, marie-kondo, archiver, executor, security-scanner, coder. |
| 13 | trace-finder | .claude/_archive/skills/trace-finder/ | Search code history for relocated/deleted code or graduated projects. Use when user asks to "trace", "find project", "where is [project]", "search history for". |
| 14 | trace-oracle | .claude/_archive/skills/trace-oracle/ | (Description incomplete in source) |

**Status:** These are mature skills with full SKILL.md documentation. Duplicated across all agent worktrees (agents/1-5/).

---

## SYSTEM SKILLS (.codex/skills/)

| # | Skill | Path | Type |
|----|-------|------|------|
| 1 | skill-creator | .codex/skills/.system/skill-creator/ | System skill |
| 2 | skill-installer | .codex/skills/.system/skill-installer/ | System skill |

---

## USER-ARCHIVED SKILLS (.claude/_archive/user-skills/)

Legacy skills for reference, organized by category.

### Anthropic Skills
- theme-factory
- doc-coauthoring
- xlsx
- pdf
- algorithmic-art
- internal-comms
- skill-creator
- canvas-design
- pptx
- slack-gif-creator
- webapp-testing
- frontend-design
- mcp-builder
- brand-guidelines
- docx
- web-artifacts-builder

### User Skills
- content-research-writer
- dev-browser
- domain-name-brainstormer
- frontend-design
- lead-research-assistant
- mem-search
- notebooklm (modified)
- skill-creator
- stripe-integration
- trace-finder
- trace-oracle
- ux-critic

**Path:** /Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/_archive/user-skills/

---

## CHALLENGE/LAB SKILLS (ψ/lab/squad-challenge-parser-bug/)

| # | Skill | Path |
|----|-------|------|
| 1 | skill-alpha | ψ/lab/squad-challenge-parser-bug/challenge-skills/skill-alpha/ |
| 2 | skill-beta | ψ/lab/squad-challenge-parser-bug/challenge-skills/skill-beta/ |
| 3 | skill-gamma | ψ/lab/squad-challenge-parser-bug/challenge-skills/skill-gamma/ |
| 4 | skill-delta | ψ/lab/squad-challenge-parser-bug/challenge-skills/skill-delta/ |

**Status:** Test skills from squad challenge lab exercise.

---

## AGENT-SPECIFIC SKILLS

Each worktree agent (agents/1-5/) contains local copies of core skills:

### Distributed to All Agents (1-5)
- five-pillar-structure/
- jump/
- oracle-philosophy/
- repo-health/
- security-first/
- subagent-dispatch/

### Distributed to Some Agents (varies)
- antigravity/ (agents/2-5)
- handoff/ (agents/1-4)
- longrun/ (agents/1-5)

---

## SUMMARY

| Category | Count | Status |
|----------|-------|--------|
| Active Skills (skills/) | 12 | New (untracked) |
| Archived Skills (.claude/_archive/) | 14 | Mature |
| System Skills (.codex/) | 2 | System |
| Legacy/User Skills (archived) | 28+ | Historical |
| Challenge Skills (lab) | 4 | Experimental |
| **Total Unique Skills** | **60+** | Mixed |

### Key Observations

1. **Migration Pattern:** New skills being placed in `skills/` directory with `CLAUDE.md` format
2. **Archived Skills:** Mature skills in `.claude/_archive/skills/` use traditional `SKILL.md` with YAML frontmatter
3. **Worktree Distribution:** Core skills duplicated across agent worktrees for isolation
4. **Legacy Content:** Many user/anthropic skills archived for reference but not actively used
5. **Focus Areas:** New skills emphasize: context-finding, learning, status tracking, scheduling, handoffs

