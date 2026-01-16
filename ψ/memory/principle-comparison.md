# Constitution Principles: Side-by-Side Comparison

## Universal Safety Principles (All Projects)

### I. Safety-First Operations (No -f/--force flags)
All projects enforce:
- NEVER: `git push --force`, `git checkout -f`, `git clean -f`
- NEVER: `rm -rf` without explicit user permission
- NEVER: Package manager `--force` flags
- Use: `rm -i` (interactive), safe git operations
- Rationale: Forced operations bypass safety, causing data loss and corruption

**Evolution**: Early versions had basic rule; v1.2.2 (esphome-fw) adds explicit rm -rf clause after violation

---

### II. Version Control Integrity (GitHub Flow)
All projects require:
- No direct commits to main branch
- Feature branches from latest main
- PR-first pattern (create PR early, mark draft if WIP)
- No self-merging without explicit approval
- Main branch always deployable

**Unique variants**:
- **esphome-fw**: Extensive workflow feedback requirements (time in GMT+7, link formatting standards)
- **esphome-floodboy-4g**: Simplified, POC-focused
- **multi-agent-kit**: Worktree coordination model explained

---

### III. Safe, Traceable Changes
All projects require:
- Small, focused commits with meaningful messages
- Git as version control/backup (no manual copies)
- Version pinning for dependencies
- Commit links to issues
- Incremental, reversible operations

**esphome-fw adds**: Git-as-backup philosophy, `git diff` and `git checkout --` for reverting

---

## Platform-Specific Principles

### A. ESPHome Firmware Platform (esphome-fw v1.2.2)

**Principle IV: Validate-Before-Deploy**
- Compilation verification mandatory via `esphome compile <config>`
- Post-implementation testing required
- TDD NOT required (pragmatic approach)
- Testing focus:
  - New device configurations
  - Modified sensor/component settings
  - Network configuration changes
  - OTA update procedures
- Rationale: Firmware runs in production; pre-deployment validation prevents bricked devices

**Principle V: Documentation-As-Code**
- Config documentation in YAML comments (not separate)
- Every non-obvious choice must be explained
- Device-specific quirks, pin mappings, calibration values documented
- External markdown supplements but doesn't replace inline comments
- Rationale: Declarative configs are complex; future maintainers need context

**Principle VI: Observability & Debugging**
- Devices must expose diagnostic sensors:
  - WiFi signal strength and connection status
  - Uptime and restart counters
  - Free heap memory monitoring
  - Component-specific debug logging
  - Web server interface for direct access
- Rationale: IoT devices operate in diverse conditions; observability enables remote troubleshooting

**Principle VII: Task Granularity & Time Management**
- Maximum 60 minutes per task (NON-NEGOTIABLE)
- Ideal size: 15-30 minutes
- Task splitting rules:
  - Multiple "AND" statements = split
  - Touching > 3 files = consider splitting
  - Testing > 15 minutes = separate task
  - Substantial documentation = separate task
- Parallel tasks marked with [P]
- Dependencies explicitly documented
- Rationale: Small tasks improve focus, prevent fatigue, enable accurate tracking

**Constraints** (Technology, Security, Performance):
- Framework: ESPHome only
- Platforms: ESP32, ESP8266, RP2040
- Communication: MQTT, Native API, Web Server
- Security: No hardcoded credentials, secrets.yaml required, OTA passwords mandatory
- Performance: Boot < 10s, WiFi < 5s, Memory < 80% heap

**Governance**:
- Constitution supersedes all practices
- Amendment: Issue → branch → 48h review → approval required
- Version bumping per SemVer
- PR compliance checks mandatory

---

### B. ESPHome FloodBoy 4G POC (esphome-floodboy-4g v0.1.0)

**Principle 1: Simplicity-First POC**
- Smallest end-to-end slice that works
- Prefer stock ESPHome components (no custom C++ unless blocked)
- Defer optimizations until working demo exists
- Keep configuration in single primary YAML file
- Rationale: "Make it work first, fast later"

**Principle 2: ESPHome-First Implementation**
- ESPHome is single source of truth
- Prefer native components
- Use UART + simple automation for modem control
- Only introduce external components if blocked
- Pin ESPHome version for reproducible builds
- Rationale: Simplifies architecture, reduces maintenance burden

**Principle 3: Single Target Hardware (POC Scope)**
- Only: Seeed XIAO ESP32-C3 + Waveshare SIM7600E
- Other boards/modules out of scope
- Default UART baud: 115200
- Rationale: Focuses POC, enables rapid iteration

**Principle 4: Observability Over Performance (Initially)**
- Verbose serial logging for bring-up
- Visible success signal (LED blink pattern)
- Record exact AT command sequence
- Rationale: Transparency > performance in POC phase

**Principle 5: Safe, Traceable Changes**
- Repository safety rules (no forced operations)
- Pin all critical versions
- Small commits with meaningful messages
- Each commit advances device toward acceptance criteria

**MVO (Minimum Viable Outcome)**:
- Device boots ESPHome on XIAO ESP32-C3
- UART link to SIM7600E established, SIM/network detected
- Modem attaches to cellular network via configured APN
- One verifiable transmit (HTTP POST or SMS)
- LED indicates success/failure, logs confirm AT interactions

**Development Gates** (Must pass to proceed):
- G1: Modem responds to `AT` over UART from ESPHome
- G2: Network attach confirmed, signal reported
- G3: First transmit succeeds and externally verifiable

**Non-Goals** (Explicitly out of scope):
- Deep power management (PSM/eDRX, fuel gauge)
- TLS client cert management beyond defaults
- FOTA over LTE
- Multi-region carrier quirks
- Generalizing to additional boards/modems

**Governance** (Simpler):
- Constitution supersedes other practices for POC scope
- Amendments via PR with rationale + Sync Impact Report
- SemVer for governance text only

---

## Multi-Agent Framework Principles

### Multi-Agent Workflow Kit (AGENTS.md)

**Worktree Model**:
- Each agent works in isolated directory with own branch
- Coordination via GitHub PRs (no self-merging)
- `.tmp/` directory for scratch/test artifacts (gitignored)
- UV for Python package management

**Safety Rules** (10 categories):
1. **Repository Usage**: Never create issues/PRs on upstream
2. **Command Usage**: No -f/--force flags
3. **Git Operations**: No force push/checkout/clean, never merge without permission
4. **File Operations**: Use `rm -i`, never `rm -rf`
5. **Package Manager**: No --force, review lockfile changes
6. **General Guidelines**: Reversibility, ask confirmation, explain implications
7. **Tool Preferences**: ripgrep (not grep), fd (not find), jq (not regex)
8. **Auth Verification**: Check `gh auth status` before git operations
9. **Rate Limiting**: Respect GitHub API rate limits
10. **Worktree Boundaries**: Use `git -C` not `cd` to respect worktree isolation

---

## Key Differences Summary

| Aspect | esphome-fw | esphome-floodboy-4g | multi-agent-kit |
|--------|-----------|-------------------|-----------------|
| **Scope** | Production platform | POC hardware | Framework |
| **Principles** | 7 (+ constraints) | 5 + gates | Worktree model |
| **TDD Requirement** | No (pragmatic) | No mention | No |
| **Task Time Limit** | 60 min max | Not mentioned | Not specified |
| **Testing Strategy** | Post-implementation | Gates only | N/A |
| **Documentation** | Code + YAML comments | Observability focus | Tool usage |
| **Time Zones** | GMT+7 + UTC required | Not specified | Not specified |
| **MVO/Gates** | Continuous | G1/G2/G3 explicit | No gates |
| **Version Scope** | Comprehensive platform | "Make it work first" | Framework reference |

---

## Evolution Pattern

### esphome-fw Evolution (Most Documented)
```
v1.0.0 (2025-09-23) Ratified
├─ 6 core principles
├─ GitHub Flow basics
└─ No task time limits

v1.1.x (2025-09-25) Internal patch
├─ Added Principle VII (Task Granularity)
├─ Removed TDD requirement (pragmatism)
└─ Added time zone requirements

v1.2.2 (2025-09-27) After safety violation
├─ Explicit rm -rf prohibition (response to incident)
├─ Enhanced GitHub workflow feedback
├─ Link formatting standards
└─ PR-first draft pattern emphasis

Current: Mature, actively evolving (responses to real issues)
```

### esphome-floodboy-4g Creation (Fresh POC)
```
v0.1.0 (2025-09-22) Ratified same day
├─ 5 simplified principles
├─ POC-scoped explicitly
├─ Gates instead of continuous principles
└─ "Make it work first" philosophy

Status: POC-frozen (principles tied to hardware bring-up gates)
```

### Multi-Agent Frameworks (Growing Adoption)
```
2025-10-10: multi-agent-workflow-kit AGENTS.md created
2025-10-11: Copied to proof-maw-multi-agent-worktree-kit (2.1 KB)
2025-10-11: Copied to 0xkm (2.1 KB)

Status: Template copies, minimal divergence
```

---

## Pattern Recognition: Why Principles Differ

### esphome-fw (Comprehensive)
- Production firmware managing hardware in diverse environments
- Requires reliability, observability, human oversight
- Longer task horizon (platform evolution)
- Team context (multiple agents, multiple projects)

### esphome-floodboy-4g (Pragmatic)
- Proof of concept, hardware bring-up focused
- Succeeds only when hardware works end-to-end
- Explicit, measurable gates (G1/G2/G3)
- "Fail fast, iterate quick" culture
- Shorter task horizon (4-6 weeks to MVP)

### multi-agent-kit (Coordination-Focused)
- Enables parallel agent work without conflicts
- Emphasizes git coordination, safety rules
- Worktree isolation prevents cross-contamination
- Tool standardization (rg vs grep, etc.)
- Governance through constraints, not philosophy

---

## Critical Incidents Driving Evolution

### rm -rf Prohibition (v1.2.2)
- **Incident**: Likely rm -rf without permission in esphome-fw
- **Response**: Added explicit principle "NEVER use rm -rf without explicit user permission"
- **Evidence**: Sync Impact Report in v1.2.2 states "Reinforced rm -rf prohibition after violation"
- **Pattern**: Later versions add MORE specificity after real-world failures

---

## Governance Authority Hierarchy

**When principles conflict** (implied ordering):
1. Safety-First (universal, supersedes all)
2. Version Control Integrity (prevents data loss)
3. Project-specific principles (implementation details)
4. Governance rules (how to amend)

**Example**: If a POC principle conflicts with safety, safety wins (no -f/--force, ever)

---

## Recommendations for New Projects

**When creating new constitution**:
1. Start with universal safety principles (always include)
2. Decide: Platform or POC scope?
   - **Platform**: Add validation, documentation, observability, task limits
   - **POC**: Add gates, MVO definition, "make it work first" philosophy
3. Define task time limits if continuous development
4. Specify testing approach (TDD, post-implementation, or gates)
5. Add governance amendment process
6. Include Sync Impact Report header (if using 3-layer template)
7. Use SemVer for governance text versioning

---

Generated: 2025-12-17
Source data: 23 governance files across laris-co organization
Full analysis: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/governance-comparison.md`
