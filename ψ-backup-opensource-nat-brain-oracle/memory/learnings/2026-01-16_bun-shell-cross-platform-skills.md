---
title: Bun Shell for Cross-Platform Skills
tags: [bun, shell, skills, cross-platform, pattern]
created: 2026-01-16
source: Session retrospective
---

# Bun Shell for Cross-Platform Skills

## The Problem

Skill scripts need to work on Mac, Linux, and Windows:
- Bash → Mac/Linux only
- Python → Needs install
- Node → Guaranteed (Claude Code requires it)

## The Solution: Bun Shell

```typescript
import { $ } from "bun"

// Clean, Python-like syntax
const result = await $`git log --oneline --grep=${query}`.text()
const files = await $`grep -ril ${query} . 2>/dev/null`.text()
const pkg = await $`cat package.json`.json()
```

## Why Bun Shell Wins

| Feature | Bash | Python | Node | Bun Shell |
|---------|------|--------|------|-----------|
| Guaranteed | ❌ | ❌ | ✅ | ✅ |
| Syntax | OK | Good | Verbose | **Best** |
| Escaping | Manual | Manual | Manual | **Auto** |
| Output parsing | Manual | Manual | Manual | **Built-in** |

## Key Patterns

### Basic Command
```typescript
const output = await $`git status`.text()
```

### With Variables (Auto-escaped!)
```typescript
const query = "user input with spaces"
const result = await $`grep ${query} file.txt`.text()
```

### JSON Output
```typescript
const pkg = await $`cat package.json`.json()
```

### Error Handling
```typescript
const { exitCode } = await $`git diff --quiet`.quiet()
if (exitCode !== 0) console.log("Has changes")
```

### Multi-line Commands
```typescript
const commits = await $`
  git log --oneline
  --since="1 week ago"
  --author="nat"
`.text()
```

## Skill Template

```
skills/my-skill/
├── SKILL.md          ← Instructions for Claude
└── scripts/
    └── main.ts       ← Bun Shell logic
```

### main.ts Template

```typescript
#!/usr/bin/env bun
import { $ } from "bun"

const args = process.argv.slice(2)
const input = args[0] || ""

const result = await $`your-command ${input}`.text()

console.log(JSON.stringify({ input, result }, null, 2))
```

## Fallback for Non-Bun Environments

```bash
# Works with Node + tsx too
npx tsx scripts/main.ts "args"
```

## Related

- Created in: `plugin-marketplace/oracle-skills/skills/_template/`
- /skill-creator uses this pattern
- All 14 oracle-skills moving to this pattern
