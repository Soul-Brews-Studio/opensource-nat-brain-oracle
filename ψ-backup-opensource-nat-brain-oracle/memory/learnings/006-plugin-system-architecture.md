---
title: Plugin System Architecture and Hooks
created: 2025-12-10
focus: Claude Code Plugin System, hooks auto-discovery, folder conventions
models_used:
  - Haiku (investigation)
  - Opus (design review)
time_investment: 3 hours debugging + design
tags:
  - plugin-system
  - claude-code
  - hooks
  - auto-discovery
  - psi-convention
  - subagent-workflow
aliases:
  - plugin hooks
  - auto-discovery
  - psi prefix
---

# Technical Learnings: Plugin System Architecture & Hooks

## Context Links

- **Source Retrospectives**:
  - [[16.37_claude-code-plugin|Claude Code Plugin]] - Initial plugin exploration
  - [[18.57_cellar-and-psi-adoption|Cellar and Psi Adoption]] - Psi folder structure adoption
- **Related Learnings**:
  - [[000-naming-philosophy|Naming Philosophy]] - Naming conventions foundation
  - [[007-knowledge-distillation-loop|Knowledge Distillation Loop]] - Uses psi structure
- **Commits**: `e681a29`, `1af04a7`, `63f8169`, `c6d04aa`, `f0f5c8c`, `86ed4a2`

---

## Part 1: Plugin Hooks Auto-Discovery

### Discovery Timeline

| Time | Event | Learning |
|------|-------|----------|
| 10:30 | Fixed hooks.json format (SessionStart injection) | Format matters: `{"SessionStart": [...]}` not `{"hooks": {"SessionStart": [...]}}` |
| 10:43 | Plugin system debugging session | hooks loaded but content wasn't injecting properly |
| 11:31 | Auto-discovery validation | Claude Code uses auto-discovery - don't specify paths |
| 13:49 | Folder structure refactor | Adopt ψ prefix for consciousness-tier folders |

### Key Findings: How Claude Code Finds Plugins

#### File Structure Requirement

Claude Code auto-discovers plugin components using standard folder names. NO explicit paths needed in `plugin.json`:

```
plugins/my-plugin/
├── .claude-plugin/
│   ├── plugin.json          ← NO "commands" or "hooks" fields needed
│   └── marketplace.json
├── commands/                ← Auto-discovered (no path in plugin.json)
│   ├── my-command-1.md
│   └── my-command-2.md
├── hooks/                   ← Auto-discovered
│   └── hooks.json           ← IMPORTANT: Must be in hooks/ subdirectory
├── agents/                  ← Auto-discovered
│   ├── agent-1.md
│   └── agent-2.md
└── knowledge/               ← Custom folder (not auto-discovered)
    ├── philosophy.md
    └── style.md
```

#### What Works (CORRECT)

```json
// plugins/nat-data-personal/.claude-plugin/plugin.json
{
  "name": "nat-data-personal",
  "version": "1.0.0",
  "description": "Personal philosophy and writing style",
  "keywords": ["personal", "philosophy"],
  "hooks": "./hooks.json"   // ONLY this field needed
}
```

**Why it works**: Claude Code looks for `hooks/hooks.json` automatically.

#### What Doesn't Work (BROKEN)

```json
// WRONG - explicit paths confuse discovery
{
  "name": "my-plugin",
  "hooks": ["./hooks/hooks.json"],     // ← Wrong: list instead of string
  "commands": "../commands/"           // ← Wrong: Claude will look in wrong place
}
```

### Hooks Configuration Format

#### Hook Format (Must be at root level of hooks.json)

```json
// plugins/nat-data-personal/hooks/hooks.json
{
  "SessionStart": [
    {
      "type": "command",
      "command": "echo 'Oracle philosophy loaded from plugin'"
    }
  ]
}
```

**Key Detail**: Root-level event type key, NOT wrapped in `{"hooks": {...}}` object

#### How SessionStart Hook Works

1. **Trigger**: Every Claude Code session initialization (session start)
2. **Behavior**: Execute the command and capture stdout
3. **Output**: stdout becomes part of Claude's conversation context (context injection)
4. **Purpose**: Load shared knowledge (oracle philosophy, writing style) without explicit agent knowledge

### Critical Discovery: Plugin Hook Isolation

**Finding**: SessionStart hooks from different plugins do NOT merge for the same event type.

```
Plugin A: hooks/hooks.json → {"SessionStart": [...]}
Plugin B: hooks/hooks.json → {"SessionStart": [...]}

Expected: Both load on SessionStart
Actual: Only one loads (unclear which one wins)
```

**Implication**: 
- Don't rely on multiple plugins contributing to same SessionStart event
- If multiple plugins need SessionStart context, consolidate into one plugin
- Workaround: Add SessionStart hooks to `~/.claude/settings.json` for critical knowledge

**Investigation Status**: Unclear if this is Claude Code bug or intentional design. Should report to Claude Code team.

---

## Part 2: Folder Structure Conventions (ψ Prefix)

### What Changed in Today's Session

Commits:
- `f0f5c8c` - refactor: context folder convention (seq_project/name.md)
- `86ed4a2` - refactor: adopt ψ prefix for consciousness tier folders

### The ψ (Psi) Convention

#### Layer 1: Consciousness Tiers (ψ-prefix)

Project-wide folder structure reorganized into consciousness layers:

```
repo/
├── ψ-learnings/           (Tier 1: Consciousness - explicit learning capture)
│   ├── 000-naming-philosophy.md
│   ├── 001-delegate-reading.md
│   ├── 002-context-finder-first.md
│   ├── 003-speech-to-text-uncertainty.md
│   ├── 004-human-confirmation-loop.md
│   ├── 005-file-size-check-before-read.md
│   └── 006-plugin-system-architecture.md    ← Today
│
├── ψ-context/            (Tier 2: Memory - timestamped knowledge base)
│   ├── oracle-mission-index.md
│   ├── 2025-12-10-12:15_shared-context-management-patterns.md
│   ├── 001_plugin-debugging/
│   │   ├── index.md
│   │   ├── report.md
│   │   ├── timeline.md
│   │   └── blog-draft.md
│   └── 002_writing-style/
│       ├── style-guide.md
│       └── quick-ref.md
│
├── ψ-logs/              (Tier 3: Session logs - raw capture)
│   └── 2025-12/
│       ├── 10_11.31_plugin-hooks-auto-discovery.md
│       ├── 10_10.43_plugin-system-debugging.md
│       └── 10_10.08_rrr-subagent-workflow-validation.md
│
└── ψ-retrospectives/    (Tier 4: Synthesis - post-session analysis)
    └── 2025-12/10/
        ├── 11.33_plugin-hooks-debugging-oracle-injection.md
        └── 10.45_plugin-oracle-workflow-session.md
```

#### Layer 2: Timestamped Context Files

**Naming Pattern**: `YYYY-MM-DD-HH:MM_topic-name.md`

```
2025-12-10-12:15_shared-context-management-patterns.md
│          │  │   └─ Topic/subject
│          │  └─ Minute (15)
│          └─ Hour (12)
└─ Date (2025-12-10)
```

**Example Usage**:
- `2025-12-10-07:19_plugin-subagent-analysis.md` - First agent analysis of plugin system
- `2025-12-10-08:21_plugin-structure-map.md` - Detailed structure discovery
- `2025-12-10-12:15_shared-context-management-patterns.md` - Multi-agent context patterns

**Benefits**:
1. **Traceability**: Know exactly when knowledge was created
2. **Non-destructive**: Keep all drafts (v1, v2, v3) for comparison
3. **Versioning**: No version numbers needed; filesystem is version history
4. **Archival**: "Nothing is deleted" - all learnings preserved
5. **Sorting**: `ls -t context/` shows newest first

#### Layer 3: Numbered Project Folders

When topic has multiple files, use sequential naming:

```
ψ-context/
├── 001_plugin-debugging/        ← Project #1
│   ├── index.md                  ← Overview
│   ├── report.md                 ← Analysis
│   ├── timeline.md               ← Discovery timeline
│   └── blog-draft.md             ← Documentation draft
│
└── 002_writing-style/           ← Project #2
    ├── style-guide.md
    └── quick-ref.md
```

**Rationale**: 
- Keeps related files grouped
- Sequential numbers show exploration order
- No special characters (just numbers + underscore)
- ψ- prefix unifies all tiers

### Why ψ (Psi) Symbol?

From session research (see ψ-context/2025-12-10_psi-adoption-brainstorm.md):

- **ψ in psychology**: Represents mind/consciousness
- **ψ in physics**: Wave function (interconnection)
- **Visual distinctness**: Easy to spot in file listings
- **Non-ASCII**: Prevents accidental grepping
- **Alignment with philosophy**: Oracle/Shadow = consciousness framework

### File Access Rules with ψ Convention

From CLAUDE.md (updated today):

```
File Access Rules (commit 8637d5d):
1. Subagents must follow same rules as main agent
2. All output stays in repo (context/, scratch/, ψ-*)
3. No /tmp/, ~/.cache/, or external repo dumps
4. Explicit user notification for external file access
```

**In Practice**:
- Session logs → ψ-logs/2025-12/10_HH.MM_topic.md
- Learnings → ψ-learnings/NNN-topic-name.md
- Scratch work → scratch/ (gitignored, not versioned)
- Shared knowledge → ψ-context/YYYY-MM-DD-HH:MM_topic.md

---

## Part 3: Subagent Workflow Patterns

### Discovery: From /rrr Command Refactoring

Commit `b6af851` - feat: /rrr now uses subagents for efficiency

#### The Pattern: 4-Step Workflow

```
User Request
    ↓
Step 0: repo-auditor (Haiku)
    ├─ Check uncommitted files
    ├─ Verify git state
    └─ Return health status
    ↓
Step 1: context-finder (Haiku)
    ├─ Search recent commits
    ├─ Score files by impact
    └─ Return file list + summaries
    ↓
Step 2: Multiple parallel subagents (Haiku)
    ├─ Read context files
    ├─ Extract patterns
    └─ Return analysis
    ↓
Step 3: Opus (Main Agent) Review
    ├─ Synthesize subagent outputs
    ├─ Apply oracle philosophy
    └─ Write retrospective
```

#### Key Discovery: Parallel Execution

From session log `2025-12-10-10:08_rrr-subagent-workflow-validation.md`:

**Before** (Sequential):
```
Agent A: 2 minutes
Agent B: 2 minutes
Agent C: 2 minutes
Total: 6 minutes
```

**After** (Parallel in 1 message):
```
Send 1 message with 3 tool calls:
- Tool 1: context-finder [query]
- Tool 2: api-scanner [url]
- Tool 3: executor [command]
All complete in ~20 seconds (30x faster)
```

**Pattern Code**:
```
SEND ONE MESSAGE with multiple independent tool calls
DO NOT use separate messages for each subagent
DO NOT wait for one agent to finish before launching next
```

#### Subagent Category: Haiku vs Opus

| Category | Model | Cost | Use Case | Example |
|----------|-------|------|----------|---------|
| Data gathering | Haiku | ✓ Cheap | Search, fetch, analyze | context-finder, api-scanner |
| Code generation | Opus | Higher | Quality code writing | coder, planner |
| Review/synthesis | Opus | Higher | QA, final decisions | Main session agent |
| Commands/execution | Haiku | ✓ Cheap | Run bash, git, tools | executor, repo-auditor |

---

## Part 4: Plugin System Architecture Today

### Two Production Plugins (Validated)

Commit `6bbb0eb` - feat: plugin structure for nat-agents-core and nat-data-personal

#### Plugin #1: nat-agents-core

**Purpose**: Generic, reusable workflow agents (GitHub-optional)

```
plugins/nat-agents-core/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
└── agents/
    ├── executor.md      (Run bash commands from specs)
    ├── coder.md         (Write code from requirements)
    ├── context-finder.md (Search git history + codebase)
    └── planner.md       (Create implementation plans)
```

**Key Feature**: All agents work with markdown specs OR GitHub issues (auto-detect gh CLI)

**plugin.json**:
```json
{
  "name": "nat-agents-core",
  "version": "1.0.0",
  "description": "Reusable workflow agents: executor, coder, context-finder, planner",
  "keywords": ["agents", "workflow", "productivity"],
  "agents": "./agents/"
}
```

#### Plugin #2: nat-data-personal

**Purpose**: Personal knowledge + philosophy (forkable template)

```
plugins/nat-data-personal/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── hooks/
│   └── hooks.json       (SessionStart context injection)
└── knowledge/
    ├── oracle-philosophy.md
    └── writing-style.md
```

**How it works**:
1. On session start, SessionStart hook runs
2. Hook echoes: "Oracle/Shadow Philosophy Active"
3. User loads oracle-philosophy.md from knowledge/ folder
4. All agents in session now know Nat's values + writing style

**plugin.json**:
```json
{
  "name": "nat-data-personal",
  "version": "1.0.0",
  "description": "Personal philosophy, writing style. Fork and customize.",
  "keywords": ["personal", "philosophy", "oracle"],
  "hooks": "./hooks.json"
}
```

#### How Multiple Plugins Share Context

**Layer 1**: SessionStart hooks (plugin-based knowledge injection)
```
nat-data-personal/hooks.json runs on SessionStart
└─ Injects oracle-philosophy + writing-style context
```

**Layer 2**: Subagent parallelism (shared context files)
```
ψ-context/YYYY-MM-DD-HH:MM_*.md
└─ All agents in session can read shared knowledge base
```

**Layer 3**: Master index (mission alignment)
```
ψ-context/oracle-mission-index.md
└─ Tracks how today's work serves the larger mission
```

### Plugin Discovery Comparison

#### What Changed from Debugging Session (10:43) to Auto-Discovery Validation (11:31)

| Aspect | Before | After | Learning |
|--------|--------|-------|----------|
| Hook location | hooks.json at root | hooks/hooks.json folder | Folder structure matters |
| Hook format | `{"hooks": {"SessionStart": [...]}}` | `{"SessionStart": [...]}` | Root-level keys only |
| Plugin paths | Explicit paths in plugin.json | No paths needed | Auto-discovery from standard folders |
| Debugging time | 25 minutes | 5 minutes | Structural comparison is key |

**Debugging methodology**: Compare working plugin (voice-notify) with broken (nat-data-personal) → structural differences revealed all issues.

---

## Part 5: Real-World Application: Headline Project

### How Plugin System Solved a Real Problem

From today's morning sessions (commits 08:46-09:55):

**Problem**: Building headline analyzer tool while maintaining plugin/agent separation

**Solution Used**:
1. **nat-agents-core**: Use context-finder agent to analyze repo state
2. **nat-data-personal**: Load oracle philosophy to guide decision-making
3. **Subagent parallelism**: Launch 7 api-scanner agents in parallel
4. **Timestamped context**: Save analysis as `2025-12-10-12:15_shared-context-management-patterns.md`

**Timeline**:
- 08:46 - Plugin marketplace + identity research
- 09:55 - Morning cleanup + agent patterns
- 10:08 - Validate subagent workflow on /rrr command
- 10:43 - Debug plugin system
- 11:31 - Discover auto-discovery rules
- 12:15 - Document shared context management

**Result**: When final synthesis agent runs, it can:
1. Read all timestamped context files (shared knowledge)
2. Execute via nat-agents-core agents (reusable tools)
3. Stay aligned to oracle philosophy (plugin-injected values)
4. Work in parallel without blocking (subagent pattern)

---

## Key Technical Rules Learned

### Rule 1: Auto-Discovery File Structure

```
plugins/my-plugin/
├── commands/        ← Auto-discovered (no plugin.json entry needed)
├── hooks/
│   └── hooks.json   ← MUST be in hooks/ subfolder
├── agents/          ← Auto-discovered
└── skills/          ← Auto-discovered
```

**Gotcha**: `hooks.json` at root level won't load. Must be `hooks/hooks.json`.

### Rule 2: Hooks Format

```json
{
  "SessionStart": [          // ← Root-level key
    {
      "type": "command",
      "command": "echo 'text'"
    }
  ]
}
```

**Common mistake**: Wrapping in extra `{"hooks": {...}}` object breaks it.

### Rule 3: SessionStart Hook Stdout Injection

```
hook.json → command → stdout
             ↓
         Claude's conversation context
```

SessionStart hook output becomes part of Claude's context automatically. Use for:
- Philosophy injection
- Writing style reminders
- Knowledge base pointers

### Rule 4: Plugin Hook Isolation

If Plugin A and Plugin B both define SessionStart:
- Result: Unclear which one loads
- Workaround: Use one plugin for SessionStart, OR add critical hooks to `~/.claude/settings.json`

### Rule 5: Timestamped Context Files

```
ψ-context/2025-12-10-12:15_shared-context-management-patterns.md
         └─ YYYY-MM-DD-HH:MM_topic.md (always this format)
```

- Timestamp shows when knowledge was captured
- Enables "Nothing is deleted" principle
- Easy sorting by recency: `ls -t`
- Multiple versions of same topic OK (v1, v2, v3)

### Rule 6: ψ Prefix = Consciousness Tier

```
ψ-learnings/   → Explicit learning capture (Tier 1: Consciousness)
ψ-context/     → Timestamped knowledge base (Tier 2: Memory)
ψ-logs/        → Raw session capture (Tier 3: Session logs)
ψ-retrospectives/ → Synthesis analysis (Tier 4: Reflection)
```

Non-ψ folders stay for code/tools/plugins (not consciousness-related).

---

## Commits from Today's Investigation

| Hash | Time | Message | Key Learning |
|------|------|---------|--------------|
| 3a8863c | 10:39 | feat: add /oracle-init command | Curl fallback for hook issues |
| e681a29 | 10:30 | fix: nat-data-personal hooks.json format for SessionStart | Root-level event keys only |
| 1af04a7 | 11:30 | fix: plugin structure for auto-discovery + hooks format | hooks/ folder required |
| 63f8169 | 11:31 | learn: plugin hooks auto-discovery | Auto-discovery explained |
| c6d04aa | 11:49 | fix: plugin hooks format + add context-finder command | Format + command validation |
| 8637d5d | 12:15 | docs: add subagent rule for file reading + sound toggle | Rule documentation |
| f0f5c8c | 13:16 | refactor: context folder convention (seq_project/name.md) | Numbered folders explained |
| 86ed4a2 | 13:49 | refactor: adopt ψ prefix for consciousness tier folders | ψ convention fully adopted |

---

## Open Questions / Future Investigation

1. **Plugin hook merging**: Why don't SessionStart hooks from different plugins merge? Bug or design?
2. **${CLAUDE_PLUGIN_ROOT} resolution**: Does it work in local marketplace? Needs testing.
3. **Nested hooks.json discovery**: Can Claude Code discover hooks at deeper paths, or only `hooks/hooks.json`?
4. **Hook execution order**: If multiple plugins define same event, what determines execution order?
5. **Performance**: Do parallel subagents share the same session context, or do they each get isolated copies?

---

## Next Steps for Implementation

1. Test plugin installation with fresh Claude instance
2. Verify ψ-context/ folder naming across all agents
3. Create comprehensive plugin documentation
4. Test multi-plugin SessionStart behavior (merge vs isolation)
5. Build MCP server for personal knowledge (Phase 4 of #3)

---

## Files to Review

- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-context/2025-12-10-12:15_shared-context-management-patterns.md` - Multi-agent context architecture
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-context/2025-12-10-07:52_plugin-development-summary.md` - Plugin system overview
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-logs/2025-12/10_11.31_plugin-hooks-auto-discovery.md` - Auto-discovery findings
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE.md` - Project rules (updated)

---

**Timestamp**: 2025-12-10 14:00 GMT+7
**Duration**: ~3 hours (debugging + documentation)
**Generated by**: context-finder (Haiku) + manual synthesis
**Status**: Complete - Ready for team review

---

## See Also

- [[001-delegate-reading|Delegate Reading]] - Subagent pattern for reading
- [[002-context-finder-first|Context Finder First]] - When to use context-finder
- [[005-file-size-check-before-read|File Size Check]] - Token efficiency patterns
- [[2025-12-10_nat-priorities-from-frequency|Nat Priorities from Frequency]] - Oracle philosophy context
