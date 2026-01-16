# Sandboxing Reference

> **Source**: https://www.anthropic.com/engineering/claude-code-sandboxing
> **Docs**: https://platform.claude.com/docs/en/agent-sdk/typescript#sandbox-configuration
> **Fetched**: 2025-12-11

---

## Overview

Sandboxing creates **two distinct boundaries** using OS-level features:
1. **Filesystem isolation** - Read/write only in working directory
2. **Network isolation** - Controlled internet access via proxy

**Key stat**: Reduces permission prompts by **84%** in internal testing.

---

## Architecture

### Filesystem Isolation

- Uses OS primitives: Linux bubblewrap, macOS seatbelt
- Kernel-level enforcement
- Covers direct interactions AND spawned subprocesses
- Prevents prompt-injected Claude from modifying sensitive system files

### Network Isolation

- Unix domain socket → external proxy server
- Proxy enforces domain restrictions
- Handles user confirmations for new connections
- Prevents data leakage and malware downloads

---

## Configuration

### SandboxSettings

```typescript
type SandboxSettings = {
  enabled?: boolean;                    // Enable sandbox mode
  autoAllowBashIfSandboxed?: boolean;   // Auto-approve bash when sandboxed
  excludedCommands?: string[];          // Commands that bypass sandbox
  allowUnsandboxedCommands?: boolean;   // Allow model to request unsandboxed
  network?: NetworkSandboxSettings;     // Network config
  ignoreViolations?: SandboxIgnoreViolations;
  enableWeakerNestedSandbox?: boolean;
}
```

### NetworkSandboxSettings

```typescript
type NetworkSandboxSettings = {
  allowLocalBinding?: boolean;    // Allow binding to local ports
  allowUnixSockets?: string[];    // Allowed Unix socket paths
  allowAllUnixSockets?: boolean;  // Allow all Unix sockets
  httpProxyPort?: number;
  socksProxyPort?: number;
}
```

### SandboxIgnoreViolations

```typescript
type SandboxIgnoreViolations = {
  file?: string[];     // File paths to ignore violations
  network?: string[];  // Network patterns to ignore
}
```

---

## Example Usage

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

const result = await query({
  prompt: "Build and test my project",
  options: {
    sandbox: {
      enabled: true,
      autoAllowBashIfSandboxed: true,
      excludedCommands: ["docker"],
      network: {
        allowLocalBinding: true,
        allowUnixSockets: ["/var/run/docker.sock"]
      }
    }
  }
});
```

---

## Permissions Fallback

When `allowUnsandboxedCommands: true`:
- Model can request `dangerouslyDisableSandbox: true` in tool input
- Falls back to standard permissions system
- Your `canUseTool` handler gets invoked

```typescript
const result = await query({
  prompt: "Deploy my application",
  options: {
    sandbox: {
      enabled: true,
      allowUnsandboxedCommands: true
    },
    permissionMode: "default",
    canUseTool: async (tool, input) => {
      if (tool === "Bash" && input.dangerouslyDisableSandbox) {
        console.log(`Unsandboxed: ${input.command}`);
        return isCommandAuthorized(input.command);
      }
      return true;
    }
  }
});
```

---

## excludedCommands vs allowUnsandboxedCommands

| Setting | Behavior |
|---------|----------|
| `excludedCommands` | Static list, always bypasses, no model control |
| `allowUnsandboxedCommands` | Model decides at runtime via `dangerouslyDisableSandbox` |

---

## Important Notes

**Filesystem/network restrictions** are NOT configured via sandbox settings!

They come from **permission rules**:
- Filesystem read: Read deny rules
- Filesystem write: Edit allow/deny rules
- Network: WebFetch allow/deny rules

Use sandbox settings for **command execution**, permission rules for **access control**.

---

## Cloud Implementation

Claude Code on web:
- Sessions run in isolated cloud sandboxes
- Sensitive credentials (git tokens, keys) kept external
- Custom proxy service prevents compromised code from accessing auth tokens

---

## Security Benefits

1. Eliminates "approval fatigue" (84% fewer prompts)
2. Kernel-level enforcement (not just application-level)
3. Covers subprocesses and spawned scripts
4. Configurable per-use-case

---

## Open Source

Anthropic open-sourced this feature for other teams building agents.

---

*See [typescript-api.md](typescript-api.md) for full API reference*
