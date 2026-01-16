---
title: ## Bun Shell Testing Pattern for Scripts
tags: [bun, testing, shell, bash, unit-test, bun:test, bun:$]
created: 2026-01-14
source: Traced from oracle-proof-of-concept-skills/schedule
---

# ## Bun Shell Testing Pattern for Scripts

## Bun Shell Testing Pattern for Scripts

Use `bun:test` + `bun:$` to test shell scripts:

```typescript
import { describe, test, expect, beforeAll } from "bun:test";
import { $ } from "bun";
import { resolve, dirname } from "path";

const SCRIPT = resolve(dirname(import.meta.path), "my-script.sh");

describe("my-script.sh", () => {
  test("should output expected text", async () => {
    const result = await $`${SCRIPT} arg1`.text();
    expect(result).toContain("expected output");
  });

  test("should exit with code 0", async () => {
    const result = await $`${SCRIPT}`;
    expect(result.exitCode).toBe(0);
  });

  test("should block dangerous input", async () => {
    const result = await $`echo '{"tool_input":{"command":"rm -rf /"}}' | ${SCRIPT}`;
    expect(result.exitCode).toBe(2);  // Block exit code
    expect(result.stderr.toString()).toContain("BLOCKED");
  });
});
```

### Run Tests
```bash
bun test                    # Run all
bun test script.test.ts     # Run specific
bun test --watch           # Watch mode
```

### Key: `$` from bun
- `await $\`cmd\`.text()` - Get stdout as string
- `result.exitCode` - Check exit code
- `result.stderr` - Check stderr
- `$.cwd(path)` - Set working directory

---
*Added via Oracle Learn*
