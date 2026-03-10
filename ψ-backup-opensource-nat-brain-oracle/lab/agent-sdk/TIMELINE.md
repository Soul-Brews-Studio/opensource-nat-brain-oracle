# Claude Agent SDK - Feature Timeline

> Generated: 2025-12-11
>
> Source: Complete CHANGELOG analysis from v0.1.0 through v0.1.61
>
> Purpose: Understand the evolution of Agent SDK capabilities and upgrade path

---

## Quick Reference

| Phase | Versions | Duration | Key Theme |
|-------|----------|----------|-----------|
| **Foundation** | 0.1.0-0.1.15 | Initial | Architecture Refactor |
| **Growth** | 0.1.16-0.1.30 | Stabilization | Production Features |
| **Maturity** | 0.1.31-0.1.45 | Expansion | Enterprise Support |
| **Innovation** | 0.1.46-0.1.54 | API Evolution | V2 Sessions & Opus 4.5 |
| **Current** | 0.1.55-0.1.61 | Latest | Advanced Context & Tools |

---

## Phase 1: Foundation (v0.1.0 - v0.1.15)
### Architecture Shift from Magic to Explicit Control

#### v0.1.0 - Major Refactor
**Breaking Changes** (all by design):
- Unified `systemPrompt` field (merged `customSystemPrompt` + `appendSystemPrompt`)
- No default Claude Code system prompt included (full control to developer)
- No auto-loading of settings files (`settings.json`, `CLAUDE.md`)
- No auto-loading of slash commands or subagents
- Explicit `settingSources` control: `["user", "project", "local"]` per deployment

**New Capabilities**:
- Session forking with `forkSession` option (branch conversations)
- Programmatic subagents via `agents` option (dynamic creation in code)
- Granular settings control (isolation for CI/CD, testing, production)

**Design Philosophy**: "Explicit over implicit" - SDK applications are predictable and isolated from local filesystem

---

#### v0.1.3 - v0.1.8 (Stabilization)
- Parity updates with Claude Code v2.0.1-v2.0.8
- Bug fixes for system prompt application

---

#### v0.1.9 - System Prompt Fix
**Bug Fix**: System prompt sometimes not applied correctly
- **Impact**: Core feature now reliable
- **Reference**: anthropics/claude-agent-sdk-typescript#8

---

#### v0.1.10 - Zod Dependency Added
**Changes**: Added `zod ^3.24.1` as peer dependency
- **Use case**: Schema validation foundation for future features

---

#### v0.1.12 - MCP Timeout Fix
**Bug Fix**: SDK MCP channel closure timeout increased to 60s
- **Impact**: Reliable cleanup for long-running tool calls
- **Reference**: anthropics/claude-agent-sdk-typescript#15

---

#### v0.1.15 - Performance Optimization
**Changes**:
- Updated `env` type (removed Bun `Dict` dependency)
- Startup performance improvements with multiple SDK MCP servers
- **Impact**: Faster initialization, better cross-platform support

---

## Phase 2: Growth (v0.1.16 - v0.1.30)
### Production Features & Framework Maturation

#### v0.1.16 - SDK Foundation Release
- Initial SDK release synced with Claude Code v2.0.17
- Baseline functionality established

---

#### v0.1.17-0.1.24 (Parity Cycle)
- Versions 0.1.17-0.1.22: Regular sync with Claude Code
- v0.1.23-0.1.24: Undocumented (likely internal stability work)

---

#### v0.1.25 - Skills & Settings Enhancement
**Features**:
- Added `skills` field to `SDKSystemMessage`
  - **Use case**: Dynamically expose available skills to agents
  - Agents can introspect their capabilities at runtime
- Project-level skills loading (fixed)

**Bug Fixes**:
- Fixed skills not loading with `'project'` settings source
- Fixed exported type import errors (anthropics/claude-agent-sdk-typescript#39)
- **Impact**: Better TypeScript support, reliable skill discovery

---

#### v0.1.27 - Plugin Architecture
**Features**:
- Added `plugins` field to Options
- **Use cases**:
  - Custom middleware & logging
  - Integration layers (analytics, monitoring)
  - Behavior extensions without code modification
- **Impact**: Enables ecosystem development

---

#### v0.1.28 - Custom Tool Timeout Control
**Bug Fix**: Custom tools now respect `MCP_TOOL_TIMEOUT` environment variable
- **Previous behavior**: Hard 30s timeout
- **New behavior**: Configurable timeout
- **Use cases**:
  - Long-running batch processing
  - External API calls with retry logic
  - Data processing pipelines
- **Reference**: anthropics/claude-agent-sdk-typescript#42

---

#### v0.1.30 - Budget & Hook Management
**Features**:
- Added `--max-budget-usd` flag
  - **Use case**: Set token spend limits per run
  - Production safety feature for cost-sensitive deployments
  - Prevents runaway costs from unpredictable token usage

**Bug Fixes**:
- Fixed hooks sometimes failing in stream mode
- **Impact**: Reliable event handling for streaming conversations

---

## Phase 3: Maturity (v0.1.31 - v0.1.45)
### Enterprise Readiness & Structured Data

#### v0.1.31-0.1.44 (Steady Sync)
- Continuous parity with Claude Code v2.0.32-v2.0.44
- Stability and compatibility focus

---

#### v0.1.45 - Structured Outputs & Enterprise Support
**Major Features**:
1. **Structured Outputs**
   - Agents can return validated JSON matching your schema
   - **Use cases**:
     - LLM-as-judge systems
     - Batch processing with guaranteed format
     - API integration with strict contracts
   - Built on Zod foundation from v0.1.10

2. **Microsoft Azure AI Foundry Support**
   - Enterprise deployment option
   - **Link**: https://code.claude.com/docs/en/azure-ai-foundry
   - **Impact**: Agents now deployable in enterprise Azure environments

---

## Phase 4: Innovation (v0.1.46 - v0.1.54)
### API Evolution & Model Support

#### v0.1.46-0.1.50 (Parity Updates)
- Sync with Claude Code v2.0.46-v2.0.50
- Foundation for next-generation features

---

#### v0.1.47 - Message Error Field
**Changes**: Added `error` field to some messages
- **Impact**: Better error introspection and debugging
- Foundation for robust error handling patterns

---

#### v0.1.51 - Opus 4.5 Support
**Major Feature**: Support for Claude Opus 4.5
- **Link**: https://www.anthropic.com/news/claude-opus-4-5
- **Capability**: Agents can now use the latest flagship model
- **Use cases**:
  - Complex reasoning tasks
  - Multi-step planning
  - Domain-specific expertise

---

#### v0.1.52-0.1.53 (Parity Updates)
- Sync with Claude Code v2.0.52-v2.0.53

---

#### v0.1.54 - V2 Session APIs (Experimental)
**Major Feature**: Unstable V2 Session APIs introduced
- `unstable_v2_createSession` - Simpler session initialization
- `unstable_v2_resumeSession` - Continue conversations
- `unstable_v2_prompt` - Single multi-turn interaction

**Significance**:
- Simpler multi-turn conversation management
- Foundation for automatic conversation continuity
- Strategic shift toward conversation-first design
- **Status**: Experimental (unstable) - API may change

---

## Phase 5: Current (v0.1.55 - v0.1.61)
### Advanced Context & Tooling

#### v0.1.55 (Foundation for Current Era)
- Parity with Claude Code v2.0.55

---

#### v0.1.56 (Parity)
- Sync with Claude Code v2.0.56

---

#### v0.1.57 - Tools Allowlist
**Major Feature**: `tools` option for precise tool control

**Configuration Options**:
```typescript
// Option 1: Strict allowlist
tools: ['Bash', 'Read', 'Edit']

// Option 2: No tools
tools: []

// Option 3: Preset (all defaults)
tools: { type: 'preset', preset: 'claude_code' }

// Option 4: Omit (keep existing behavior - all tools)
// (no tools field)
```

**Use Cases**:
- Security-constrained environments (read-only agents)
- Specialized agents (only file operations)
- Compliance-sensitive deployments
- Testing with limited tool surface

---

#### v0.1.58 - 1M Context Window Beta
**Major Feature**: `betas` option for beta features

**Currently Available**:
- `'context-1m-2025-08-07'` - 1M token context window on Sonnet 4/4.5

**Configuration**:
```typescript
betas: ['context-1m-2025-08-07']
```

**Use Cases**:
- Long-document analysis
- Multi-file codebase understanding
- Complex project contexts
- **Note**: Requires Sonnet 4/4.5 model

**Reference**: https://docs.anthropic.com/en/api/beta-headers

---

#### v0.1.59-v0.1.61 (Parity Cycle)
- Continuous sync with Claude Code v2.0.59-v2.0.61
- Stability and feature parity maintenance

---

## Feature Categories

### Security & Control

| Version | Feature | Benefit |
|---------|---------|---------|
| v0.1.0 | No default system prompt | Full control over agent behavior |
| v0.1.0 | `settingSources` control | Isolation for different deployments |
| v0.1.57 | Tools allowlist | Restrict capabilities per environment |
| v0.1.30 | `--max-budget-usd` | Cost control and runaway prevention |

---

### Extensibility & Framework

| Version | Feature | Use Case |
|---------|---------|----------|
| v0.1.0 | Programmatic subagents | Dynamic agent creation |
| v0.1.27 | Plugin architecture | Custom middleware & integrations |
| v0.1.25 | Skills field | Agent self-awareness |
| v0.1.45 | Structured outputs | Type-safe data extraction |

---

### Performance & Reliability

| Version | Feature | Impact |
|---------|---------|--------|
| v0.1.9 | System prompt fix | Core feature reliability |
| v0.1.12 | MCP timeout (60s) | Long-running tools |
| v0.1.15 | Startup optimization | Multi-server initialization |
| v0.1.28 | Custom tool timeout | Variable execution times |
| v0.1.30 | Hook stream fix | Streaming reliability |

---

### Model & API Support

| Version | Feature | Details |
|---------|---------|---------|
| v0.1.51 | Opus 4.5 | Latest flagship model |
| v0.1.54 | V2 Session APIs | Experimental conversation APIs |
| v0.1.58 | 1M Context Beta | Extended context window |

---

### Data & Integration

| Version | Feature | Capability |
|---------|---------|-----------|
| v0.1.10 | Zod dependency | Schema validation foundation |
| v0.1.45 | Structured outputs | Validated JSON responses |
| v0.1.47 | Error field | Better error introspection |
| v0.1.45 | Azure Foundry | Enterprise deployment |

---

## Upgrade Recommendations for Nat's Agents

### Minimum Viable Production Setup
**Recommended version: v0.1.30 or later**

```
v0.1.30 provides:
✓ Budget control (--max-budget-usd)
✓ Reliable hooks (fixed stream mode)
✓ Custom tool timeouts (MCP_TOOL_TIMEOUT)
✓ Skills framework (v0.1.25)
✓ All Foundation phase features
```

---

### Recommended Production Setup
**Recommended version: v0.1.45+**

```
v0.1.45 provides everything above, plus:
✓ Structured outputs (validated JSON)
✓ Azure enterprise support
✓ Better error handling (error field in v0.1.47)
✓ Proven stability (post-v0.1.30 refinements)
```

---

### Advanced Feature Setup
**Recommended version: v0.1.57+**

```
v0.1.57+ provides everything above, plus:
✓ Tools allowlist (security control)
✓ 1M context window (v0.1.58 beta)
✓ V2 Session APIs (v0.1.54, for simpler multi-turn)
✓ Opus 4.5 support (v0.1.51)
```

---

## Critical Milestones by Use Case

### Building Cost-Conscious Agents
1. **v0.1.30**: Add `--max-budget-usd` flag
2. **v0.1.25**: Monitor skills with overhead
3. **v0.1.57**: Consider restrictive `tools: ['Bash', 'Read']`

### Building Secure/Compliant Agents
1. **v0.1.0**: Use `settingSources` for isolation
2. **v0.1.57**: Use `tools` allowlist for restrictions
3. **v0.1.27**: Consider plugin middleware for audit logging

### Building Data Processing Agents
1. **v0.1.28**: Set `MCP_TOOL_TIMEOUT` for long jobs
2. **v0.1.45**: Use structured outputs for batch results
3. **v0.1.58**: Consider 1M context for large documents

### Building Conversational Agents
1. **v0.1.0**: Use `forkSession` for multi-path exploration
2. **v0.1.54**: Experiment with `unstable_v2_*` APIs
3. **v0.1.30**: Enable hook stream reliability

---

## Version Stability Overview

### Highly Stable (Production-Ready)
- **v0.1.30-v0.1.61**: All versions post-Growth phase
- **v0.1.45+**: Particularly mature (Maturity + Innovation phases)

### Well-Tested Features
- System prompt and settings (v0.1.0+)
- Custom tools and timeouts (v0.1.28+)
- Skills and plugins (v0.1.25-v0.1.27)

### Experimental
- V2 Session APIs (v0.1.54) - prefix: `unstable_v2_*`
- 1M Context Beta (v0.1.58) - requires beta flag
- Always check Anthropic docs for beta limitations

---

## Key Decision Points

### When to Upgrade Versions

**Upgrade to v0.1.25+** if:
- You need skills discovery/dynamic capability exposure
- You want plugin/middleware patterns

**Upgrade to v0.1.30+** if:
- You deploy to production with unpredictable token costs
- You need reliable streaming hooks
- You use custom MCP tools with variable execution time

**Upgrade to v0.1.45+** if:
- You need structured JSON output validation
- You deploy to Azure enterprise environments
- You want latest stability improvements

**Upgrade to v0.1.51+** if:
- You need Opus 4.5 for complex reasoning
- You want latest Claude model capabilities

**Upgrade to v0.1.57+** if:
- You need tool security restrictions (allowlist)
- You want tight control over agent capabilities

**Upgrade to v0.1.58+** if:
- You need to process documents >100K tokens
- You want 1M context window capability (beta)

---

## References & Links

- **Main API Docs**: https://platform.claude.com/docs/en/agent-sdk/overview
- **Custom Tools Guide**: https://platform.claude.com/docs/en/agent-sdk/custom-tools
- **Structured Outputs**: https://platform.claude.com/docs/en/agent-sdk/structured-outputs
- **Session Management**: https://platform.claude.com/docs/en/agent-sdk/sessions
- **Azure Foundry**: https://code.claude.com/docs/en/azure-ai-foundry
- **Beta Features**: https://docs.anthropic.com/en/api/beta-headers
- **Opus 4.5 Announcement**: https://www.anthropic.com/news/claude-opus-4-5

---

## Methodology

This timeline was constructed by analyzing:
1. **CHANGELOG.md** - Official version history (v0.1.0 through v0.1.61)
2. **CHANGELOG_v0.1.16-0.1.30.md** - Detailed Growth phase analysis
3. **Issue References** - GitHub issue resolution tracking

**Last Updated**: 2025-12-11 | **Versions Covered**: 0.1.0 - 0.1.61
