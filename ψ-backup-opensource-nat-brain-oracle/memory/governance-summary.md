# Constitution & Governance Summary - Quick Reference

Generated: 2025-12-17

## Three Governance Patterns

### Pattern 1: Template (Unfilled)
**esphome-heating-visualizer** - 2.3 KB
- Pure template with [PLACEHOLDER] syntax
- Awaiting project-specific values
- Same template copied to agents/1 and agents/2
- Agent 3 has diverged with filled version (7.5 KB)

### Pattern 2: Project Constitutions (Filled)
Three distinct styles:

| Repo | Version | Type | Size | Principles | Key Focus |
|------|---------|------|------|-----------|-----------|
| **esphome-fw** | 1.2.2 | Platform | 15 KB | 6 + constraints | Comprehensive, evolved |
| **esphome-floodboy-4g** | 0.1.0 | POC | 4.8 KB | 5 + gates | Hardware bring-up, pragmatic |
| **esphome-radar** | ? | Condensed | 2.3 KB | Compact | Stripped essentials |

### Pattern 3: Framework Guides (AGENTS.md)
Multi-agent worktree safety rules

| Repo | Size | Content |
|------|------|---------|
| **esphome-fw** | 22 KB | Complete guide (constitution reference header, tools, short codes, retrospectives) |
| **esphome-floodboy-4g** | 7.3 KB | Safety rules + short codes + AI diary template |
| **multi-agent-workflow-kit** | 3.8 KB | Worktree setup + 10 safety categories |
| **proof-maw-multi-agent-worktree-kit** | 2.1 KB | Minimal safety rules + coordination |
| **0xkm** | 2.1 KB | Template-style safety rules |
| **esphome-radar** | 346 B | Stub link |

---

## Core Principles - Evolution & Differences

### Universal (All Projects)
1. **Safety-First Operations** - No -f/--force flags, no rm -rf without permission
2. **Version Control Integrity** - GitHub Flow, PR-first, no merge without approval
3. **Safe, Traceable Changes** - Small commits, git as backup system

### Platform-Specific (esphome-fw)
4. **Validate-Before-Deploy** - Compilation mandatory, post-implementation testing (TDD optional)
5. **Documentation-As-Code** - YAML comments required
6. **Observability & Debugging** - WiFi, memory, uptime monitoring
7. **Task Granularity** - Max 60 min tasks, prefer 15-30 min

### POC-Specific (esphome-floodboy-4g)
1. **Simplicity-First** - Smallest end-to-end slice, no custom C++ unless necessary
2. **ESPHome-First** - Single source of truth, native components preferred
3. **Single Hardware Target** - XIAO ESP32-C3 + SIM7600E only (POC scope)
4. **Observability Over Performance** - Verbose logging, visible success signals
5. **Safe, Traceable Changes** (shared with platform)

---

## Version Control Approach

**All constitutions use SemVer for governance text**:
- **MAJOR** = Philosophy change or principle removal
- **MINOR** = New principle or material expansion
- **PATCH** = Clarifications and wording fixes

**Evolution Example** (esphome-fw):
```
v1.0.0 (2025-09-23) - Initial: 6 principles
v1.1.x (2025-09-25) - Added task granularity, removed TDD requirement
v1.2.2 (2025-09-27) - Added rm -rf prohibition after violation (PATCH escalation)
```

---

## Governance Metadata

Every constitution includes:
1. **Ratification Date** - When first adopted (adoption point in history)
2. **Last Amended Date** - Most recent change
3. **Version** - SemVer string
4. **Sync Impact Report** - HTML comment at top with version bump rationale (for filled constitutions)

---

## Safety Rules Evolution

### Generation 1 (Early)
- Basic no-force-flag rule
- General safety guidelines

### Generation 2 (esphome-fw v1.2.2)
- Explicit rm -rf prohibition
- GitHub CLI tool preference (gh vs web)
- Time zone requirements (GMT+7 primary)
- Link formatting standards
- PR feedback requirements

### Generation 3 (Current Frameworks)
- Per-category safety rules (6-10 categories)
- Tool preferences (rg vs grep, fd vs find, jq for JSON)
- Worktree coordination model
- Explicit approval gates for merges

---

## Critical Findings

### Issue 1: Governance Drift
**Problem**: esphome-heating-visualizer agents not synced
- Main + agents/1,2: Template (unfilled)
- Agent 3: Custom filled version (diverged)

**Fix**: Sync quarterly or implement sync scripts

### Issue 2: Template Synchronization
**Problem**: 3-layer template system can drift
- `.claude/commands/` = command definition
- `.codex/prompts/` = reference copy
- `.specify/memory/` = authoritative (should be source of truth)

**Fix**: After constitution update, sync all 3 locations

### Issue 3: Incomplete Adoption
**Problem**: esphome-heating-visualizer using unfilled template placeholder
- Suggests incomplete project setup
- No governance authority defined

**Fix**: Complete filled constitution or clarify if deliberately template

---

## Comparison Table - All Projects

| Repo | Constitution | AGENTS.md | Maturity | Notes |
|------|--------------|-----------|----------|-------|
| esphome-fw | v1.2.2 | 22 KB full guide | Mature | Most evolved, includes comprehensive CLAUDE.md |
| esphome-floodboy-4g | v0.1.0 POC | 7.3 KB focused | Active POC | Hardware bring-up focused, pragmatic |
| esphome-radar | Condensed | 346 B stub | Immature | Stripped version, minimal governance |
| esphome-heating-visualizer | Template | None | Unfinished | Template unfilled, agent drift |
| multi-agent-workflow-kit | None | 3.8 KB | Framework | Safety + worktree reference |
| proof-maw-multi-agent-worktree-kit | None | 2.1 KB | Framework | Template version |
| 0xkm | None | 2.1 KB | Framework | Template-style |

---

## Unique Features by Repo

### esphome-fw (Most Comprehensive)
- Time zone requirements (GMT+7/UTC)
- Link formatting standards
- Git-as-backup philosophy
- Task granularity enforcement (60 min max)
- Removed TDD requirement (pragmatism)
- Security breach response (v1.2.2 rm -rf prohibition)

### esphome-floodboy-4g (Hardware Focus)
- Development gates (G1/G2/G3) not principles
- Minimum Viable Outcome (MVO) definition
- UART bring-up requirements
- LED success signals
- Explicit non-goals
- AI Diary + Honest Feedback mandatory

### esphome-heating-visualizer (Template)
- No concrete governance (yet)
- Setup suggests multi-agent complexity
- Divergence between main and agent 3

---

## Recommendations

### High Priority
1. **Fill esphome-heating-visualizer constitution** - Complete the template or clarify intent
2. **Sync agent worktrees** - Reconcile main + agents for heating-visualizer
3. **Standardize 3-layer template sync** - Create sync script for .claude/ .codex/ .specify/

### Medium Priority
1. **Archive constitution versions** - Create governance/archive/ with historical versions
2. **Document template system** - Explain why 3 layers and how to keep in sync
3. **Consolidate safety rules** - Create shared laris-co/safety/CRITICAL-RULES.md

### Low Priority
1. **Cross-repo governance federation** - Consider if projects should share core principles
2. **Governance audit script** - Regular check for drift, unfilled templates, version mismatches

---

## File Inventory

### Constitution Files (15 total)
**esphome-fw** (3 versions of v1.2.2):
- .claude/commands/constitution.md
- .codex/prompts/constitution.md
- .specify/memory/constitution.md (authoritative, 276 lines)

**esphome-floodboy-4g** (2):
- .codex/prompts/constitution.md (73 lines)
- .specify/memory/constitution.md (112 lines, v0.1.0)

**esphome-radar** (3):
- .claude/commands/constitution.md
- .codex/prompts/constitution.md
- .specify/memory/constitution.md (condensed, 49 lines)

**esphome-heating-visualizer** (4):
- .specify/memory/constitution.md (main - template)
- agents/1/.specify/memory/constitution.md (template copy)
- agents/2/.specify/memory/constitution.md (template copy)
- agents/3/.specify/memory/constitution.md (filled, 7.5 KB)

### AGENTS.md Files (8 total)
See comparison table above for locations and sizes

---

## Document Location
Full analysis saved to: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/governance-comparison.md`

For context on Oracle Philosophy and 5-pillar structure, see: `/CLAUDE.md`
