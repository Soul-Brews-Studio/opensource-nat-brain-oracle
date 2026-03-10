# Constitution & Governance Files: Evolution Across Repos

Generated: 2025-12-17

## Executive Summary

Found **23 constitution/governance files** across the laris-co organization. Three distinct patterns emerge:

1. **Template-Based Constitutions** (esphome-heating-visualizer): Unfilled template with placeholders
2. **Project-Specific Constitutions**: Filled constitutions for specific hardware/projects
3. **Multi-Agent Frameworks** (AGENTS.md): Safety rules + governance guidance

### Key Statistics

| Category | Count | Repos |
|----------|-------|-------|
| Constitution files | 15 | esphome-fw, esphome-radar, esphome-floodboy-4g, esphome-heating-visualizer |
| AGENTS.md files | 8 | multi-agent-workflow-kit, proof-maw-multi-agent-worktree-kit, 0xkm, esphome-fw, esphome-floodboy-4g, esphome-radar |
| Template locations | 3 per repo | .claude/commands/, .codex/prompts/, .specify/memory/ |

---

## Pattern 1: Template Constitution (Unfilled)

**Location**: `/Users/nat/Code/github.com/laris-co/esphome-heating-visualizer/.specify/memory/constitution.md`

**Status**: Template with placeholders (NOT filled)

**Size**: 2.3 KB

**Key Content**:
```markdown
# [PROJECT_NAME] Constitution

## Core Principles
### [PRINCIPLE_1_NAME]
[PRINCIPLE_1_DESCRIPTION]

### [PRINCIPLE_2_NAME]
[PRINCIPLE_2_DESCRIPTION]
...

## Governance
[GOVERNANCE_RULES]

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE] | **Last Amended**: [LAST_AMENDED_DATE]
```

**Analysis**: 
- Pure template with no concrete values filled in
- Designed for other projects to copy and customize
- Contains 8 placeholder types: [PROJECT_NAME], [PRINCIPLE_N_NAME/DESCRIPTION], [SECTION_N_NAME/CONTENT], [GOVERNANCE_RULES], [CONSTITUTION_VERSION], [RATIFICATION_DATE], [LAST_AMENDED_DATE]

---

## Pattern 2: ESPHome Hardware Project Constitutions

### A. ESPHome Firmware Platform Constitution

**Primary Repo**: `esphome-fw`

**Locations** (3 copies - templating system):
- `.claude/commands/constitution.md` (73 lines)
- `.codex/prompts/constitution.md` (73 lines - IDENTICAL)
- `.specify/memory/constitution.md` (276 lines - FILLED)

**Version**: 1.2.2 (v1.0.0 → v1.2.2)

**Ratified**: 2025-09-23 | **Last Amended**: 2025-09-27

**Size**: 15 KB (memory version is the authoritative full version)

**Core Principles** (6 principles + Constraints + Workflow):
1. **Safety-First Operations** - No -f/--force flags, explicit file operation safety (explicitly prohibits `rm -rf` without user permission - added in v1.2.2)
2. **Validate-Before-Deploy** - Compile verification mandatory, post-implementation testing (TDD not required)
3. **Version Control Integrity (GitHub Flow)** - PR-first pattern, draft PRs, time reporting in GMT+7
4. **Documentation-As-Code** - YAML comments for configuration
5. **Observability & Debugging** - WiFi, uptime, memory monitoring
6. **Task Granularity & Time Management** - Max 60 minutes per task, prefer 15-30 min tasks

**Key Evolution**:
- v1.0.0 → v1.2.2: Added PR-first drafting, task granularity, removed TDD requirement, added rm -rf prohibition

**Constraints** (Technology, Security, Performance):
- Framework: ESPHome, ESP32/ESP8266/RP2040
- Communication: MQTT, Native API, Web Server
- Security: No hardcoded credentials, secrets.yaml required
- Performance: Boot < 10s, WiFi < 5s, Memory < 80% heap

**Governance**:
- Constitution supersedes all practices
- Amendment requires: Issue → branch → review (48h) → approval
- SemVer versioning (MAJOR/MINOR/PATCH)
- PR compliance checks mandatory

**Unique Features**:
- Explicit time zone requirements (GMT+7 primary, UTC secondary)
- Link formatting standards specified
- `gh` CLI as primary GitHub interaction tool
- Git as backup system (replaces manual backups)

---

### B. ESPHome Radar Constitution

**Repo**: `esphome-radar`

**Locations**:
- `.claude/commands/constitution.md` (73 lines - SAME as esphome-fw)
- `.codex/prompts/constitution.md` (73 lines - SAME as esphome-fw)
- `.specify/memory/constitution.md` (49 lines - CONDENSED)

**Version**: Not explicitly versioned in radar version

**Status**: Uses same framework as esphome-fw but with condensed memory constitution

**Analysis**: Appears to be copied from esphome-fw, but the memory version is stripped down to essentials (49 lines vs 276)

---

### C. ESPHome FloodBoy 4G POC Constitution

**Repo**: `esphome-floodboy-4g`

**Locations**:
- `.codex/prompts/constitution.md` (73 lines)
- `.specify/memory/constitution.md` (112 lines - FILLED)

**Version**: 0.1.0

**Ratified**: 2025-09-22 | **Last Amended**: 2025-09-22

**Size**: 4.8 KB (memory version)

**Scope**: POC for Seeed XIAO ESP32-C3 + Waveshare SIM7600E 4G modem

**Core Principles** (5 principles):
1. **Simplicity-First POC** - Smallest end-to-end slice, no custom C++ unless necessary
2. **ESPHome-First Implementation** - Single source of truth, prefer native components
3. **Single Target Hardware (POC scope)** - XIAO ESP32-C3 + SIM7600E only
4. **Observability Over Performance** - Verbose logging, visible success signals (LED blinks)
5. **Safe, Traceable Changes** - Repository safety rules, version pinning

**POC Constraints**:
- **MVO (Minimum Viable Outcome)**:
  - Device boots ESPHome on XIAO ESP32-C3
  - UART link to SIM7600E established
  - Modem attaches to cellular network
  - One verifiable transmit (HTTP POST or SMS)
  - LED success indication
  
- **Non-Goals**: Deep power management, advanced security, FOTA, multi-region support

**Development Gates** (Pass/Fail criteria):
- G1: Modem responds to `AT` over UART
- G2: Network attach confirmed, signal reported
- G3: First transmit succeeds and is externally verifiable

**Key Difference from esphome-fw**:
- Explicitly POC-scoped (smaller, pragmatic)
- Focused on hardware bring-up gates
- "Make it work first, fast later" philosophy
- No TDD mentioned
- Simpler principle set (5 vs 6)

**Governance** (Simpler):
- Constitution supersedes other practices
- Amendments via PR with rationale + Sync Impact Report
- SemVer for governance text only

---

### D. ESPHome Heating Visualizer Constitution

**Repo**: `esphome-heating-visualizer`

**Locations**:
- Main: `.specify/memory/constitution.md` (2.3 KB - TEMPLATE)
- Agents/1: `.specify/memory/constitution.md` (2.3 KB - SAME TEMPLATE)
- Agents/2: `.specify/memory/constitution.md` (2.3 KB - SAME TEMPLATE)
- Agents/3: `.specify/memory/constitution.md` (7.5 KB - FILLED)

**Status**: Three copies are unfilled templates; Agent 3 has a filled version

**Analysis**: 
- Main worktree + agents not synced
- Agent 3 has a custom filled constitution (7.5 KB)
- Indicates governance drift across multi-agent setup

---

## Pattern 3: Multi-Agent Framework AGENTS.md Files

### A. Multi-Agent Workflow Kit (maw-kit)

**Locations**:
- `/multi-agent-workflow-kit/AGENTS.md` (3.8 KB)
- `/multi-agent-workflow-kit/src/multi_agent_kit/assets/AGENTS.md` (2.1 KB)

**Content Type**: Multi-agent worktree notes + Critical Safety Rules

**Key Sections**:
- **Multi-Agent Worktree Setup**: Git worktree directory structure (agents/<agent-name>/)
- **Coordination Model**: PR-based review/approval workflow
- **Scratch Space**: `.tmp/` directory for test artifacts
- **UV Development Workflow**: Python package management
- **Critical Safety Rules**: 10 categories of safety rules

**Safety Rules** (Extensive):
1. Repository Usage: Never create issues/PRs on upstream
2. Command Usage: No -f/--force flags
3. Git Operations: No force push, force checkout, force clean; Never merge without explicit permission
4. File Operations: Use `rm -i`, never `rm -rf`
5. Package Manager Operations: No --force flags, review lockfile changes
6. General Guidelines: Reversibility, ask for confirmation, explain implications

**Size**: 3.8 KB (main), 2.1 KB (asset copy)

**Markdown Structure**:
```
# Multi-Agent Worktree Notes
- Worktree setup explanation
- Git coordination model
- Scratch space policy
## Critical Safety Rules (extensive)
- 6 subsections, ~20 explicit rules
```

---

### B. Proof of Concept: MAW Multi-Agent Worktree Kit

**Repo**: `proof-maw-multi-agent-worktree-kit`

**Location**: `/AGENTS.md` (2.1 KB)

**Content Type**: Safety rules focused (shorter version)

**Key Sections**:
- **Multi-Agent Worktree Notes** (abbreviated)
- **Critical Safety Rules** (same core rules as maw-kit)

**Analysis**: 
- Appears to be a reference/template version
- Shorter than full maw-kit version (2.1 KB vs 3.8 KB)
- Same safety rules, less detail on UV/worktree setup

---

### C. 0xkm Repository

**Location**: `/0xkm/AGENTS.md` (2.1 KB)

**Content Type**: Minimal safety rules + coordination

**Status**: Generic template following maw-kit pattern

---

### D. ESPHome FW + Floodboy AGENTS.md

**esphome-fw/AGENTS.md** (22 KB - LARGEST):
- Constitution reference header
- Ripgrep/fd/jq tool guidance
- CLAUDE.md comprehensive guidelines (99 KB total when expanded)
- Short codes: ccc, nnn, lll, rrr
- Retrospective templates
- Context management
- Development practices
- Lessons learned

**esphome-floodboy-4g/AGENTS.md** (7.3 KB):
- Critical Safety Rules (GitHub interaction, no force flags)
- Target repository specification (nazt/firmware)
- Core Short Codes (ccc, nnn, lll, rrr)
- Retrospective template
- AI Diary + Honest Feedback mandatory sections

**Key Difference**:
- esphome-fw: Comprehensive 22 KB guide
- esphome-floodboy-4g: Focused 7.3 KB safety + short codes

---

### E. ESPHome Radar

**Location**: `/docs/reference/AGENTS.md` (346 bytes - MINIMAL)

**Content Type**: Just a link/reference

**Status**: Stub file pointing elsewhere

---

## Comparison Matrix

| Repo | Constitution | AGENTS.md | Size | Scope | Maturity |
|------|--------------|-----------|------|-------|----------|
| **esphome-fw** | v1.2.2 (276 KB) | 22 KB | Large | Comprehensive platform | v1.2.2 |
| **esphome-radar** | v? (49 KB) | 346 B | Small | Condensed | Stub |
| **esphome-floodboy-4g** | v0.1.0 (112 KB) | 7.3 KB | Medium | POC-scoped | v0.1.0 |
| **esphome-heating-viz** | Template (2.3 KB) | - | Small | Unfilled | Template |
| **multi-agent-workflow-kit** | - | 3.8 KB | Medium | Safety + worktree | Reference |
| **proof-maw-multi-agent-worktree-kit** | - | 2.1 KB | Small | Safety rules | Reference |
| **0xkm** | - | 2.1 KB | Small | Safety rules | Reference |

---

## Evolution Timeline

```
2025-09-22: esphome-floodboy-4g created (v0.1.0)
2025-09-23: esphome-fw ratified (v1.0.0)
2025-09-27: esphome-fw amended → v1.2.2 (added rm -rf prohibition)
2025-10-10: multi-agent-workflow-kit finalized
2025-10-11: esphome-radar, esphome-heating-visualizer initialized
2025-12-13: esphome-heating-visualizer agents begin diverging
```

---

## Key Patterns & Insights

### 1. Three-Layer Constitution System
Each project repo uses templating across 3 locations:
- `.claude/commands/constitution.md` — Command definition (prompt)
- `.codex/prompts/constitution.md` — Prompt template (reference)
- `.specify/memory/constitution.md` — Authoritative memory (filled)

The `.specify/memory/` version is the source of truth; others are synchronized.

### 2. Constitution Evolution

**esphome-fw (Most Evolved)**:
- Started with 6 core principles
- Added task granularity principle
- Removed TDD requirement (pragmatic)
- Added explicit rm -rf prohibition (after violation incident, v1.2.2)
- Added GitHub workflow feedback requirements
- Added link formatting standards

**esphome-floodboy-4g (POC-Optimized)**:
- Simpler 5-principle set
- Explicitly POC-scoped
- Development gates instead of continuous principles
- "Make it work, fast later" philosophy

### 3. Multi-Agent Framework Safety Evolution

**Common Safety Rules Across All Frameworks**:
- No -f/--force flags (non-negotiable)
- No rm -rf without permission
- No merge without explicit user approval
- Use `gh` CLI for GitHub operations
- Safe git operations only

**Escalation**: Later versions (esphome-fw v1.2.2) add MORE specificity after violations

### 4. Governance Drift

**esphome-heating-visualizer** shows governance drift:
- Main worktree: Template (unfilled)
- Agents 1-2: Template copies (unfilled)
- Agent 3: Custom filled version (7.5 KB)

**Suggests**: Need for periodic sync/reconciliation across agent worktrees

### 5. Version Control Strategy

All constitutions include:
- Ratification date (adoption)
- Last amended date (current)
- SemVer versioning (MAJOR.MINOR.PATCH)

**SemVer Rules** (consistent across repos):
- MAJOR: Removing principles or changing core philosophy
- MINOR: Adding principles or material expansions
- PATCH: Clarifications and wording fixes

---

## Recommendations

### 1. Consolidate Template System
Create a master constitution template in a shared location:
```
laris-co/governance/
├── constitution-template.md
├── agents-template.md
└── sync-scripts/
    └── sync-constitution.sh
```

### 2. Standardize Constitution Sync
Ensure `.claude/commands/`, `.codex/prompts/`, and `.specify/memory/` versions stay synchronized:
```bash
# After updating .specify/memory/constitution.md
cp .specify/memory/constitution.md .claude/commands/constitution.md
cp .specify/memory/constitution.md .codex/prompts/constitution.md
git add . && git commit -m "docs: sync constitution across templates"
```

### 3. Implement Governance Audit
Regular audit script to detect:
- Unfilled template placeholders
- Mismatched versions across worktrees
- Outdated ratification dates

### 4. Archive Old Versions
Create a `governance/archive/` to track constitution evolution:
```
governance/archive/
├── esphome-fw/
│   ├── v1.0.0_2025-09-23.md
│   ├── v1.1.0_2025-09-25.md
│   └── v1.2.2_2025-09-27.md
└── esphome-floodboy-4g/
    └── v0.1.0_2025-09-22.md
```

### 5. Safety Rules Consolidation
Create `laris-co/safety/CRITICAL-RULES.md`:
- Universal rules (no -f/--force, no rm -rf, no merge without approval)
- Project-specific overrides
- Tools guidance (rg vs grep, fd vs find, jq for JSON)

---

## Files Reference

### Constitution Files (Primary)
- `/Users/nat/Code/github.com/laris-co/esphome-fw/.specify/memory/constitution.md` (15 KB)
- `/Users/nat/Code/github.com/laris-co/esphome-floodboy-4g/.specify/memory/constitution.md` (4.8 KB)
- `/Users/nat/Code/github.com/laris-co/esphome-heating-visualizer/.specify/memory/constitution.md` (2.3 KB - TEMPLATE)
- `/Users/nat/Code/github.com/laris-co/esphome-radar/.specify/memory/constitution.md` (2.3 KB)

### AGENTS.md Files (Primary)
- `/Users/nat/Code/github.com/laris-co/esphome-fw/AGENTS.md` (22 KB)
- `/Users/nat/Code/github.com/laris-co/esphome-floodboy-4g/AGENTS.md` (7.3 KB)
- `/Users/nat/Code/github.com/laris-co/multi-agent-workflow-kit/AGENTS.md` (3.8 KB)
- `/Users/nat/Code/github.com/laris-co/proof-maw-multi-agent-worktree-kit/AGENTS.md` (2.1 KB)
- `/Users/nat/Code/github.com/laris-co/0xkm/AGENTS.md` (2.1 KB)

