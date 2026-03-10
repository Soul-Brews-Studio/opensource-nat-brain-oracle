# TypeScript API Reference

> **Source**: https://platform.claude.com/docs/en/agent-sdk/typescript
> **Fetched**: 2025-12-11

---

## Core Functions

### `query()`

Primary function for interacting with Claude Code. Creates async generator streaming messages.

```typescript
function query({
  prompt,
  options
}: {
  prompt: string | AsyncIterable<SDKUserMessage>;
  options?: Options;
}): Query
```

### `tool()`

Creates type-safe MCP tool definition.

```typescript
function tool<Schema extends ZodRawShape>(
  name: string,
  description: string,
  inputSchema: Schema,
  handler: (args: z.infer<ZodObject<Schema>>, extra: unknown) => Promise<CallToolResult>
): SdkMcpToolDefinition<Schema>
```

### `createSdkMcpServer()`

Creates MCP server instance in same process.

```typescript
function createSdkMcpServer(options: {
  name: string;
  version?: string;
  tools?: Array<SdkMcpToolDefinition<any>>;
}): McpSdkServerConfigWithInstance
```

---

## Options Type

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `model` | `string` | CLI default | Claude model to use |
| `cwd` | `string` | `process.cwd()` | Working directory |
| `systemPrompt` | `string \| preset` | undefined | System prompt config |
| `tools` | `string[] \| preset` | undefined | Tool configuration |
| `permissionMode` | `PermissionMode` | `'default'` | Permission mode |
| `sandbox` | `SandboxSettings` | undefined | Sandbox configuration |
| `maxTurns` | `number` | undefined | Max conversation turns |
| `maxBudgetUsd` | `number` | undefined | Budget limit in USD |
| `betas` | `SdkBeta[]` | `[]` | Beta features (e.g., `['context-1m-2025-08-07']`) |
| `agents` | `Record<string, AgentDefinition>` | undefined | Subagent definitions |
| `mcpServers` | `Record<string, McpServerConfig>` | `{}` | MCP server configs |
| `hooks` | `Partial<Record<HookEvent, HookCallbackMatcher[]>>` | `{}` | Hook callbacks |
| `settingSources` | `SettingSource[]` | `[]` | Which settings to load |
| `allowDangerouslySkipPermissions` | `boolean` | `false` | Bypass permissions |

---

## Permission Modes

```typescript
type PermissionMode =
  | 'default'           // Standard permission behavior
  | 'acceptEdits'       // Auto-accept file edits
  | 'bypassPermissions' // Bypass all permission checks
  | 'plan'              // Planning mode - no execution
```

---

## Message Types

```typescript
type SDKMessage =
  | SDKAssistantMessage   // Assistant response
  | SDKUserMessage        // User input
  | SDKResultMessage      // Final result
  | SDKSystemMessage      // System init
  | SDKPartialAssistantMessage  // Streaming partial
  | SDKCompactBoundaryMessage   // Compaction boundary
```

### SDKResultMessage

```typescript
type SDKResultMessage = {
  type: 'result';
  subtype: 'success' | 'error_max_turns' | 'error_during_execution' | ...;
  session_id: string;
  duration_ms: number;
  total_cost_usd: number;
  usage: NonNullableUsage;
  result?: string;           // On success
  errors?: string[];         // On error
  structured_output?: unknown;
}
```

---

## Query Interface

```typescript
interface Query extends AsyncGenerator<SDKMessage, void> {
  interrupt(): Promise<void>;
  setPermissionMode(mode: PermissionMode): Promise<void>;
  setModel(model?: string): Promise<void>;
  setMaxThinkingTokens(maxThinkingTokens: number | null): Promise<void>;
  supportedCommands(): Promise<SlashCommand[]>;
  supportedModels(): Promise<ModelInfo[]>;
  mcpServerStatus(): Promise<McpServerStatus[]>;
  accountInfo(): Promise<AccountInfo>;
}
```

---

## Agent Definition

```typescript
type AgentDefinition = {
  description: string;      // When to use this agent
  tools?: string[];         // Allowed tools (inherits if omitted)
  prompt: string;           // Agent's system prompt
  model?: 'sonnet' | 'opus' | 'haiku' | 'inherit';
}
```

---

## Hook Events

```typescript
type HookEvent =
  | 'PreToolUse'
  | 'PostToolUse'
  | 'PostToolUseFailure'
  | 'Notification'
  | 'UserPromptSubmit'
  | 'SessionStart'
  | 'SessionEnd'
  | 'Stop'
  | 'SubagentStart'
  | 'SubagentStop'
  | 'PreCompact'
  | 'PermissionRequest';
```

---

## Beta Features

```typescript
type SdkBeta = 'context-1m-2025-08-07';
```

| Value | Description | Compatible Models |
|-------|-------------|-------------------|
| `'context-1m-2025-08-07'` | 1M token context window | Claude Sonnet 4, Sonnet 4.5 |

---

## Setting Sources

```typescript
type SettingSource = 'user' | 'project' | 'local';
```

| Value | Location | Description |
|-------|----------|-------------|
| `'user'` | `~/.claude/settings.json` | Global user settings |
| `'project'` | `.claude/settings.json` | Shared project settings |
| `'local'` | `.claude/settings.local.json` | Local (gitignored) |

**Note**: When omitted, SDK loads NO filesystem settings (isolated mode).

---

## Tool Input/Output Types

Full documentation of all built-in tool schemas available in official docs.

**Key tools**: Task, Bash, Read, Write, Edit, Glob, Grep, WebFetch, WebSearch, TodoWrite, NotebookEdit

---

*See [v2-interface.md](v2-interface.md) for simplified API*
