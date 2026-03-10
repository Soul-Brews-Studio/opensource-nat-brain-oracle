# Claude Agent SDK Versions 0.1.16 - 0.1.30 Analysis

## Growth Phase (v0.1.16 - v0.1.30)

### v0.1.30 - Budget & Hook Management
**Features**:
- `--max-budget-usd` flag: Set token spend limits per run → Use case: Cost control in production agents with unpredictable token usage

**Bug Fixes**:
- Fixed hook failures in stream mode → Impact: Reliable event handling for streaming multi-turn conversations
- Parity with Claude Code v2.0.31

---

### v0.1.29 - Parity Update
- Synchronized with Claude Code v2.0.29

---

### v0.1.28 - Custom Tool Timeout Fix
**Bug Fixes**:
- Fixed custom tools timing out after 30s instead of respecting `MCP_TOOL_TIMEOUT` env var
  → Use case: Long-running tools (data processing, external API calls) now respect configurable timeouts
  → Practical impact: Prevents premature tool failures in batch processing workflows

**Issues Fixed**: anthropics/claude-agent-sdk-typescript#42

---

### v0.1.27 - Plugin Architecture Added
**Features**:
- Added `plugins` field to Options → Use case: Extend SDK behavior with custom logic, middleware, or integrations

---

### v0.1.26 - Parity Update
- Synchronized with Claude Code v2.0.26

---

### v0.1.25 - Skills & Settings Enhancement
**Features**:
- `skills` field added to SDKSystemMessage → Use case: Dynamically expose available skills to agents in system context
- Project-level skills loading fixed

**Bug Fixes**:
- Fixed project-level skills not loading with `'project'` settings source
  → Impact: Reliable skill discovery in multi-project environments
- Fixed exported type import errors (anthropics/claude-agent-sdk-typescript#39)
  → Impact: Better TypeScript support for SDK consumers

---

### v0.1.24 - Gap (not documented)

---

### v0.1.23 - Gap (not documented)

---

### v0.1.22 - Parity Update
- Synchronized with Claude Code v2.0.22

---

### v0.1.21 - Parity Update
- Synchronized with Claude Code v2.0.21

---

### v0.1.20 - Parity Update
- Synchronized with Claude Code v2.0.20

---

### v0.1.19 - Parity Update
- Synchronized with Claude Code v2.0.19

---

### v0.1.18 - Gap (not documented)

---

### v0.1.17 - Parity Update
- Synchronized with Claude Code v2.0.18

---

### v0.1.16 - Foundation Release
**Status**: Initial SDK release
- Parity with Claude Code v2.0.17
- Base agent functionality established

---

## Key Insights for Agent Building

### Critical Features
1. **Custom Tool Timeout Control** (v0.1.28): Essential for production agents with variable execution times
2. **Plugin Architecture** (v0.1.27): Enables middleware patterns, logging, and custom integrations
3. **Skills Discovery** (v0.1.25): Dynamic skill exposure improves agent self-awareness
4. **Budget Control** (v0.1.30): Cost management is now first-class

### Breaking Changes
None explicitly documented in this range - primarily parity updates and additive features

### Evolution Pattern
- Versions 0.1.16-0.1.30 show transition from "keep-in-sync-with-Claude-Code" to "add-SDK-specific-features"
- v0.1.25+ introduces framework concepts (skills, plugins) suggesting maturation toward production use

### Most Impactful for Production
1. v0.1.30: Budget limits (prevents runaway costs)
2. v0.1.28: Tool timeout control (reliability)
3. v0.1.27: Plugin system (extensibility)
4. v0.1.25: Skills management (agent awareness)
