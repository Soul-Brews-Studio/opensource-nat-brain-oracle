---
date: 2026-01-01
tags: [frontend, ux-critic, speckit, workflow, dev-browser]
context: Data-Aware RAG dashboard critique session
---

# Frontend Critique + Speckit Workflow

## The Pattern

When building frontends, follow this loop to ensure quality and spec alignment:

```
Build → Screenshot → Critique → Analyze → Update Spec → Learn
```

## Key Insight

**Specs drift from implementation.** The original spec said "markdown only" and "no Web UI", but we built a multi-format indexer with a full React dashboard. Without `/speckit.analyze`, this drift goes unnoticed.

## The Workflow

### 1. Build Feature
- Implement with Bun, React, Vite
- Get it working first, polish later

### 2. Capture with dev-browser
```bash
cd ~/.claude/skills/dev-browser && npx tsx <<'EOF'
import { connect, waitForPageLoad } from "@/client.js";
const client = await connect();
const page = await client.page("app-name");
await page.setViewportSize({ width: 1280, height: 800 });
await page.goto("http://localhost:5173");
await waitForPageLoad(page);
await page.screenshot({ path: "tmp/view-name.png" });
await client.disconnect();
EOF
```

### 3. Run ux-critic Skill
- Invoke: `Skill: ux-critic`
- Provides harsh but actionable feedback
- Output format: Critical Issues → Priority Fixes → Grade

### 4. Run /speckit.analyze
- Compares spec.md vs implementation
- Finds: missing features, scope drift, unmet requirements
- Severity levels: CRITICAL, HIGH, MEDIUM, LOW

### 5. Update spec.md
- Change status from "Draft" to "Implemented (Phase 1)"
- Add Implementation Status table
- Update requirements to reflect reality
- Add UX Issues section from critic feedback

### 6. Write Lesson Learned
- Document the pattern for future sessions
- Include specific commands and outputs

## What We Discovered

| Issue | Discovery Method |
|-------|-----------------|
| Explorer pagination unusable | ux-critic |
| Search fires every keystroke | ux-critic |
| Spec said "no Web UI" but we built one | /speckit.analyze |
| 4 requirements not implemented | /speckit.analyze |
| 5 extra features not in spec | /speckit.analyze |

## Anti-Pattern Avoided

**Bad**: Build → Ship → Forget spec
**Good**: Build → Critique → Align spec → Ship

## Commands Reference

| Command | Purpose |
|---------|---------|
| `Skill: dev-browser` | Screenshot capture |
| `Skill: ux-critic` | Harsh UX feedback |
| `/speckit.analyze` | Spec alignment check |
| `/context-finder` | Search before reading |

## Key Quote

> "The spec is a living document. It should reflect what was built, not what was imagined."
