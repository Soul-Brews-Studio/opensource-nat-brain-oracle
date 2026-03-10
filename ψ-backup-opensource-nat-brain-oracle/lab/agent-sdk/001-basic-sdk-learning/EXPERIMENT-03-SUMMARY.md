# Experiment 03: Tools & Sandbox Configuration

**File**: `experiments/03-tools-sandbox.ts`
**Status**: Complete
**Lines**: 299

## Overview

Demonstrates three tool configuration patterns for the Claude Agent SDK, showing how different tool allowlists affect agent behavior.

## Configurations Tested

### Config A: Full Tools (Preset)
```typescript
tools: { type: 'preset', preset: 'claude_code' }
```
- Available: Bash, Read, Write, Edit, Glob, Grep
- Best for: General-purpose agent work
- Result: Agent can execute any operation

### Config B: Restricted Tools (Allowlist)
```typescript
tools: ['Read', 'Glob', 'Grep']
```
- Available: File reading operations only
- NOT available: Bash (command execution)
- Best for: Safe, sandboxed read-only operations
- Result: Agent limited to filesystem inspection

### Config C: No Tools
```typescript
tools: []
```
- Available: None
- Best for: Pure reasoning/analysis without external operations
- Result: Natural language response only

### Config D: Sandbox Configuration (Reference)
Commented example showing how to combine:
- Tool allowlist (what tools are available)
- Sandbox restrictions (what tools can access)

Includes examples for:
- **Filesystem restrictions**: Allowlist/blocklist paths
- **Network restrictions**: Control outbound connections
- **Process restrictions**: Block dangerous commands

## Functions

| Function | Purpose |
|----------|---------|
| `configA_FullTools()` | Test with all standard tools |
| `configB_RestrictedTools()` | Test with Read/Glob/Grep only |
| `configC_NoTools()` | Test with no tools available |
| `configD_SandboxReferenceExample()` | Show sandbox configuration patterns |
| `demonstrateToolPatterns()` | Display configuration best practices |
| `main()` | Orchestrate all tests |

## How to Run

```bash
# From poc directory
npm run exp:tools

# Or directly
npx tsx experiments/03-tools-sandbox.ts
```

## Expected Outcomes

1. **Config A**: Agent successfully uses available tools to list files
2. **Config B**: Agent may use Glob to read directory, or explain limitations
3. **Config C**: Agent responds with explanation only (no tool use)
4. **Config D**: Reference for production sandbox patterns

## Key Learnings

- Tool allowlists provide explicit control over agent capabilities
- Sandbox restrictions add defense-in-depth beyond tool allowlists
- Different use cases require different tool configurations
- PRESET mode is convenient but ALLOWLIST mode is more explicit for production

## Security Implications

- Use ALLOWLIST in production (explicit > implicit)
- Use SANDBOX for multi-tenant scenarios
- Combine both for defense-in-depth
- NO TOOLS prevents accidental system access

---

**Created**: 2025-12-11
**Framework**: Claude Agent SDK v0.1.61+
**Model**: Claude Opus 4.5 (20251101)
