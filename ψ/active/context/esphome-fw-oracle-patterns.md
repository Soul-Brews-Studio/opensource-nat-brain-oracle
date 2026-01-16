# ESPHome-FW Oracle-Like Governance Patterns

## Executive Summary

The `esphome-fw` repository implements a sophisticated Oracle-like governance system that mirrors the Oracle philosophy from Nat's Agents. The governance structure centers on a **Constitution** (`.specify/memory/constitution.md`) that serves as the single source of truth for project principles, with supporting infrastructure for retroactive learning, memory, and compliance.

**Key Finding**: ESPHome-FW has already evolved the pattern to v1.2.2 with 6 core principles and comprehensive governance, showing the pattern is reusable and evolving.

---

## 1. Core Philosophy Alignment

### Oracle Philosophy in ESPHome-FW

The esphome-fw repository embodies three core Oracle principles:

1. **Nothing is Deleted** → Retrospectives archive every session
2. **Patterns Over Intentions** → Constitution built on observed behavior
3. **External Brain, Not Command** → Constitution guides but doesn't override human judgment

**Evidence**:
- Constitution v1.2.2 explicitly states: "This constitution supersedes all other practices and conventions in the repository"
- Amendment process requires human confirmation
- Compliance verification happens retroactively via retrospectives

---

## 2. Constitutional Structure

### Location & Versioning
- **File**: `.specify/memory/constitution.md` (276 lines)
- **Current Version**: v1.2.2 (ratified 2025-09-23, amended 2025-09-27)
- **Versioning**: Semantic (MAJOR/MINOR/PATCH based on governance impact)

### Six Core Principles

| # | Name | Focus | Enforcement |
|---|------|-------|-------------|
| I | Safety-First Operations | No -f/--force flags, rm -rf prohibition, reversibility | Pre-commit, code review |
| II | Validate-Before-Deploy | Compilation + device testing (NO TDD required) | Workflow step |
| III | Version Control Integrity | GitHub Flow + PR-First pattern + feedback requirements | CI/CD, branch protection |
| IV | Documentation-As-Code | Inline YAML comments explain non-obvious choices | Code review |
| V | Observability & Debugging | Diagnostic sensors, WiFi status, debug logging | Architecture review |
| VI | Task Granularity | Max 60-min tasks, granular splitting, parallel execution | Issue creation |

### Amendment History (v1.0.0 → v1.2.2)
- **v1.0.0** → Initial governance framework
- **v1.1.7** → Added context retrieval standards (use gh CLI, not WebFetch)
- **v1.2.0** → Added Principle VI (task granularity)
- **v1.2.1** → Added Git-first backup strategy (Git IS the backup)
- **v1.2.2** → Reinforced rm -rf prohibition (PATCH after violation)

**Pattern**: Each amendment came from observed violation or friction - governance evolves from practice.

---

## 3. Governance Infrastructure

### .specify/ Folder Structure
```
.specify/
├── memory/
│   └── constitution.md          # Single source of truth
├── templates/
│   ├── plan-template.md
│   ├── spec-template.md
│   ├── tasks-template.md
│   └── commands/
│       └── [claude commands]
└── scripts/
    └── [utility scripts]
```

### Supporting Artifacts

#### A. Retrospectives (`.specify/memory` + `/retrospectives/`)
Every session generates a timestamped retrospective:
```
retrospectives/2025/09/2025-09-27_15-56_retrospective.md
```

**Structure**:
- Session metadata (date, time, duration, focus)
- Timeline with minute-level tracking
- Technical details (files modified, commits)
- AI Diary (vulnerability + reflection)
- What went well/didn't/learned
- Action items

**Finding**: The "AI Diary" section is REQUIRED and contains honest reflection - matches Oracle's vulnerability principle.

#### B. Compliance Tracking
Constitution states explicit verification:
```
- All PRs must include constitution compliance check
- CI/CD pipeline enforces no-force-flag policy where possible
- Code review explicitly validates safety principles
- Retrospectives document constitution adherence
- Violations require written justification or design change
```

#### C. Amendment Process
Formal governance flow:
1. Propose via GitHub issue + rationale
2. Draft changes in feature branch
3. 48-hour review period
4. Explicit maintainer approval
5. Semantic version bump
6. Sync impact report (what changed, what templates affected)

---

## 4. Key Differences from Nat's Agents Pattern

### ESPHome-FW Innovations

| Aspect | Nat's Agents | ESPHome-FW | Innovation |
|--------|--------------|-----------|-----------|
| Constitution | In CLAUDE.md (lean) | Dedicated .specify/memory | Separation of concerns |
| Task Granularity | Implicit (60-min goal) | Explicit Principle VI | Measurable governance |
| Backup Strategy | Separate ψ/active folder | Git-only (v1.2.1) | Eliminated redundancy |
| Compliance | Trust-based | Explicit verification requirements | Measurable safety |
| TDD | Flexible ("not required") | Explicitly stated "NOT currently required" | Clear policy declaration |
| Link Formatting | Mentioned in rules | Detailed line-break standards | Accessibility focus |

### ESPHome-FW Lacks (but Could Adopt)

| Pattern | Why Useful | Status in ESPHome-FW |
|---------|-----------|---------------------|
| 5-Pillar ψ/ structure | Org + clarity | Not present; uses .specify instead |
| Subagent delegation | Context efficiency | Not mentioned; single-agent focus |
| Short codes (rrr, /recap) | Speed | AGENTS.md mentions but not in constitution |
| Resonance/Soul files | Identity capture | Not found |
| External brain pattern | Knowledge capture | Implicit in retrospectives |

---

## 5. Governance in Action: Example Session

**Session**: 2025-09-27 15-56 (46 minutes)
**Focus**: Constitution evolution + command simplification

### Evolution Timeline
- 22:10 GMT+7: Resumed session
- 22:11: Updated constitution to v1.1.7 (context standards)
- 22:14: Generated tasks with no-TDD stance
- 22:22: User feedback: "over-engineering"
- 22:40: Created multiple plans (#203, #204)
- 22:43: User feedback: "consolidate"
- 22:50: Updated constitution to v1.2.0 (task granularity)
- 22:53: Updated constitution to v1.2.1 (Git-first backup)
- 22:56: Final retrospective

### Key Behavior
- Constitution updates were **responsive** to feedback (not prescriptive)
- Each principle evolved from **observed friction** (backup complexity, over-engineering)
- **Retroactive documentation**: Behavior came first, principle written after
- **Transparency**: All updates had impact reports showing what templates needed sync

---

## 6. Templates & Commands

### Constitution Commands
Located in `.claude/commands/constitution.md`:
- Loads existing constitution
- Identifies placeholder tokens
- Collects/derives values from repo context
- Generates sync impact report
- Updates dependent templates automatically
- Validates no placeholder tokens remain

### Related Templates
1. **plan-template.md** - Scope + tasks must align with constitutionGranularity principle
2. **spec-template.md** - Requirements must include compliance checks
3. **tasks-template.md** - Task categorization reflects principles (observability, versioning, testing)
4. **retrospective-template.md** - Captures compliance adherence

---

## 7. Compliance & Safety

### Safety Principles in Action

#### No -f/--force Flags
```
NEVER use `rm -rf` without explicit user permission
NEVER use `git push --force` or `git push -f`
NEVER use `git checkout -f` or `git clean -f`
```
**Tracking**: v1.2.2 PATCH added explicit rm -rf prohibition after violation

#### GitHub Flow Enforcement
```
Direct commits to main = FORBIDDEN
Every change requires:
  - Issue creation
  - Feature branch
  - Draft PR (signal WIP)
  - Continue development
  - Mark PR ready
  - Explicit approval before merge
```

#### Validation Requirements
```
Every firmware change MUST compile successfully
No configuration reaches devices without validation
Testing: Post-implementation when needed (NOT TDD first)
Verification in PRs: Constitution compliance check mandatory
```

---

## 8. Memory & Learning (Implicit Oracle Pattern)

### Retrospectives as Oracle Archive
Every session creates append-only record:
- Timestamp = truth
- AI Diary = vulnerability
- Timeline = behavior pattern
- Technical details = what changed

### Pattern Evolution
Constitution amendments show **patterns over intentions**:
- v1.2.1 amendment: User pointed out Git eliminates backup needs
- Agent's observation: "Why didn't I see that initially?"
- Result: Principle now reads "Git IS the backup"

This is pure Oracle: **observe behavior → extract pattern → document principle**

---

## 9. Migration Path: How to Apply to Other Projects

### Minimum Implementation (Phase 1)
```
.specify/
├── memory/
│   └── constitution.md (copy structure + adapt principles)
└── templates/
    └── plan-template.md
```

### Full Implementation (Phase 2)
- Templated amendment process
- Compliance verification in CI/CD
- Sync impact reporting
- Retrospective integration
- Constitution command automation

### Adaptation Checklist
- [ ] Identify core governance principles (3-6 max)
- [ ] Document each with Name, Focus, Enforcement
- [ ] Create amendment process (GitHub issue → review → approve)
- [ ] Add compliance verification to code review
- [ ] Template all artifact types (plans, specs, tasks)
- [ ] Implement retrospective integration
- [ ] Version constitution semantically
- [ ] Document policy changes explicitly (e.g., "TDD not required")

---

## 10. Key Takeaways for Nat's Agents

### What's Working in ESPHome-FW
1. **Dedicated constitution file** keeps governance focused
2. **Semantic versioning** makes evolution transparent
3. **Sync impact reports** prevent template drift
4. **Amendment process** ensures deliberate governance
5. **Explicit policy statements** ("TDD NOT required") prevent ambiguity
6. **Compliance verification** in PRs makes safety measurable

### Ideas to Adopt in Nat's Agents
1. Add explicit compliance check to PR templates
2. Create amendment tracker showing all constitution versions
3. Add "TDD not required" to CLAUDE_lessons.md (vs. implicit)
4. Implement sync impact report generation
5. Add task granularity verification to plan validation
6. Create quarterly "compliance audit" retrospective

### Potential Improvements for ESPHome-FW
1. Add Resonance/Soul file (identity capture)
2. Document subagent delegation pattern in AGENTS.md
3. Add /recap, /snapshot, /distill short codes
4. Create learnings folder (vs. only retrospectives)
5. Add ψ/ memory structure (vs. .specify)
6. Link AGENTS.md roles to constitution principles

---

## 11. Files Analyzed

| File | Lines | Purpose |
|------|-------|---------|
| `.specify/memory/constitution.md` | 276 | Core governance |
| `.claude/commands/constitution.md` | ~180 | Amendment automation |
| `AGENTS.md` | ~60 | Agent instructions |
| `retrospectives/2025/09/2025-09-27_15-56_retrospective.md` | ~180 | Session archive |
| `obsidian-vault/06-templates/retrospective-template.md` | ~100 | Template |

---

## Conclusion

ESPHome-FW has implemented a fully-functional Oracle-like governance system that:

✅ Treats Constitution as single source of truth  
✅ Documents principles from observed patterns  
✅ Implements retroactive compliance verification  
✅ Archives sessions as append-only records  
✅ Updates governance through formal amendment process  
✅ Automates template synchronization  
✅ Makes policy decisions explicit (e.g., "no TDD required")

The pattern is **proven, reusable, and already evolving** (v1.0.0 → v1.2.2 in less than 3 months).

**Recommendation**: Consider adopting ESPHome-FW's amendment process + sync impact reporting in Nat's Agents CLAUDE.md.
