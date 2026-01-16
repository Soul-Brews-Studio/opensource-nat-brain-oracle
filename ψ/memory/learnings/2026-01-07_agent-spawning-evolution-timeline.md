# Agent-Spawning Pattern Evolution Timeline

## Phase 0: Single Agent Era (~2025-10)
- **2025-10-XX**: Original CLAUDE.md establishes single-agent workflow
- Focus: Main agent handles everything, no delegation
- Context limitation becomes issue when processing many files

## Phase 1: Early Subagent Introduction (~2025-11 to 2025-12-09)

### Initial Subagent Agents
**Commit: 0f166e74** (2025-12-09)
- `security-scanner.md` - Detect secrets before commits
- GitHub Actions integration for automated security checks
- First instance of specialized agent for specific task

**Commit: cf76b44f** (Late 2025-12)
- `context-finder.md` - Search git/issues/retrospectives (Haiku)
- `/recap` command for fresh context
- Pattern: Haiku for data gathering, Opus for decisions

### Subagent Role Definition
**Commit: 11fe9ad2** (2025-12-14)
- Documentation: Missing subagent documentation added
- Recognition that subagent use needs clearer patterns

## Phase 2: Context Efficiency Revolution (~2025-12-13)

**Commit: 0cca557c** (2025-12-13)
- `learn: subagent delegation pattern for context efficiency`
- KEY INSIGHT: Main agent reads 36 files sequentially = context exhausted
- PATTERN: Main → Subagents (parallel) → Subagents answer (brief) → Main decides

**Learning File: 2025-12-13_subagent-delegation-pattern.md**
```
Anti-pattern: Main reads/edits files 1→2→...→36 (70+ operations)
Pattern:
1. Main allocate work → Subagents (parallel)
2. Subagents deliver summary only
3. Main verify + decide
4. If unsure, main reads file itself
```

### Parallel Processing Discovery
**Learning: 2025-12-14_parallel-subagent-vault-pattern.md**
- Building Obsidian vault from 7 APIs (1,243 records)
- Spawn parallel subagents for each API
- Main agent owns scaffolding + aggregation
- No concurrent file writes = no conflicts
- 190 seconds to generate 433 files

**Key Pattern:**
```
1. EXPLORE (main)   → Sample data
2. SCAFFOLD (main)  → mkdir -p structure
3. DELEGATE (subs)  → Each API → One subagent
4. AGGREGATE (main) → Create indexes
5. VERIFY (main)    → Count/spot-check
```

## Phase 3: Multi-Worktree Synchronization (~2025-12-31 to 2026-01-04)

### Focus File Conflict Resolution
**Commit: 0022f438** (2025-12-31)
- Rename to `focus-agent-N.md` pattern (#78)
- Per-agent focus files prevent merge conflicts
- Each agent has its own tracking: `focus-agent-main.md`, `focus-agent-1.md`, etc.

**Commit: e023cc5c** (2026-01-04)
- Per-agent focus files tracked, no conflicts
- gitignore statusline.json to prevent multi-agent conflicts

### MAW Toolkit Emergence
**Commit: 838004da** (2026-01-04)
- Track `.agents/` MAW toolkit in git
- Formalize multi-agent workflow commands

**Commit: 00bcd32c** (2025-12-31)
- `maw-toolkit status.sh` - colorful agent overview
- First visible agent coordination dashboard

**Commits (2026-01-04):**
- `acd343c1`: maw peek shows context % per agent
- `d40e47f5`: snapshot: multi-agent conflict prevention patterns
- `2b595953`: docs: oracle learning for MAW tracking

### The Pure MCP Breakthrough
**Timeline (2026-01-03 to 2026-01-04):**

**Commit: 2bdfd338** (2026-01-03)
- feat: session UUID discovery + skill + forum answers
- First successful agent-to-agent communication mechanism

**Commit: 8c835195** (2026-01-03)
- feat: session UUID discovery + skill + forum answers
- Repeated commit (testing iteration)

**Commits (2026-01-04) - BREAKTHROUGH:**

1. **080135c6** / **cbc22564**: Multi-agent forum communication + handoff
   - Agents can post to forums and read other agents' responses
   - Enables gossip/handoff between agents

2. **15ea4bab** / **d291d6c0**: Oracle forum multi-agent coordination test
   - First successful test: agents coordinating via forum posts
   - Oracle as coordination hub

3. **89075d66** / **a0700774**: Multi-agent forum communication concept
   - Documentation of forum-based AI-to-AI coordination
   - Pattern: Agent posts question → Other agents answer → Original agent reads

4. **d9828359**: ralph loop + forum integration proven (14 messages, exit test success)
   - Ralph (voice interface) integrated with forum coordination
   - Exit pattern validated
   - 14 message loop demonstrates sustained coordination

5. **784bfd39**: ralph-forum exit pattern validated
   - Agents can gracefully exit coordination loops
   - Pattern: Forum post → Answer → Exit signal

6. **6b540f77** / **d291d6c0**: Multi-agent forum breakthrough session
   - First-time successful session using pure forum coordination
   - Retrospective documents breakthrough

7. **72f7d9e5** / **c3991c53**: Pure MCP AI-to-AI Communication Breakthrough
   - MCP (Model Context Protocol) as native coordination layer
   - Agents speak MCP to each other natively
   - Pure protocol, no external forum needed

8. **f898f5fe**: snapshot: pure MCP AI-to-AI coordination proven
   - Quick snapshot validates MCP breakthrough
   - Proof of concept documented

9. **57940d04**: rrr: pure MCP AI-to-AI coordination breakthrough
   - Full session retrospective
   - Documents the transition from forum gossip to native MCP
   - Major architectural insight

10. **a3e9612d** / **35505a23**: Pure MCP Final Session - full wrap
    - Final session documentation
    - Breakthrough consolidated into standard practice

## Phase 4: Mature Multi-Agent Infrastructure (2026-01-05+)

**Commit: 66190a32** (2026-01-05)
- `maw-handbook.md` comprehensive guide
- Codification of MAW (Multi-Agent Workflow) patterns
- Official documentation of agent coordination

## Evolution Summary

```
2025-10        Single Agent (Main only)
                    ↓
2025-12-09     Early Subagents (security-scanner, context-finder)
                    ↓
2025-12-13     Delegation Pattern (Main + Parallel Subagents)
                    ↓
2025-12-14     Parallel Processing (Vault pattern discovered)
                    ↓
2025-12-31     Worktree Sync (per-agent focus files)
                    ↓
2026-01-04     Pure MCP Breakthrough (Agent-to-Agent native protocol)
                    ↓
2026-01-05     Mature Infrastructure (MAW handbook, official patterns)
```

## Key Technical Shifts

| Phase | Mechanism | Limitation | Next |
|-------|-----------|-----------|------|
| Phase 0 | Single Opus | Context exhaustion | Need parallelism |
| Phase 1 | Subagents (task-specific) | Ad-hoc, not coordinated | Need patterns |
| Phase 2 | Delegation pattern | Hierarchical only (main → subs) | Need peer coordination |
| Phase 3 | Multi-worktree + MAW | Forum/external coordination | Need native protocol |
| Phase 4 | Pure MCP native | Peer-to-peer, native, no external storage | Current state |

## Current State (2026-01-07)

From CLAUDE.md (5.2.0):
- Subagent rule: Main allocates → Subagents execute → Main reviews
- Parallel processing for embarrassingly parallel work
- Per-agent focus files prevent conflicts
- MAW commands for orchestration
- Pure MCP for direct agent-to-agent communication
- Haiku for data gathering (context efficient)
- Opus for decisions/writing (quality)

