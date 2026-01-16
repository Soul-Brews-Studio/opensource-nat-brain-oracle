# MAW Fast Context Patterns (2025-12-21)

Purpose
- Capture the fast context patterns that reduce ramp time.
- Document how to skip task discovery when it is already known.
- Record a speed comparison for fast context vs full context.

Scope
- Applies to short, well-scoped changes in the MAW workflow.
- Designed for quick handoffs between agents or sessions.
- Assumes the requester already knows the target change.

Fast context patterns
- build: Provide the minimum build or execution commands.
- build: Keep it to one line if possible.
- build: Include preconditions only if essential.
- build: Avoid long lists of optional tooling.
- issue: State the exact goal in one sentence.
- issue: Include acceptance criteria in 1–3 bullets.
- issue: Name the key constraints explicitly.
- issue: Mention non-goals to prevent scope creep.
- files: List only the files that must change.
- files: Use paths, not descriptions.
- files: Prefer relative paths from repo root.
- files: If unsure, list the starting file and say why.

Pattern example (minimal)
- build: pnpm test --filter core
- issue: Fix crash when cache is empty; do not add new deps.
- files: src/cache/reader.ts

Pattern example (slightly richer)
- build: make test-core
- issue: Align CLI output with spec; avoid breaking flags; add test.
- issue: Acceptance: output matches spec section 2; tests pass.
- files: cli/output.ts
- files: tests/cli/output.spec.ts

How to skip task discovery
- Use fast context when the goal is already precise.
- Explicitly say “skip discovery” or “no discovery needed.”
- Provide the build, issue, and files lines together.
- Include the desired commit message if needed.
- If discovery is skipped, do not ask open-ended questions.
- Only ask for clarifications that block implementation.
- Treat missing details as constraints to keep scope tight.

Signals that skipping discovery is safe
- The issue statement is testable.
- The files list is short and specific.
- There is no architecture decision pending.
- The change does not affect external APIs.
- There is a clear rollback path.

Signals that skipping discovery is risky
- Multiple modules or teams are involved.
- Requirements are framed as “improve” or “refactor.”
- The files list is missing or too broad.
- Build steps are unknown or heavy.
- The request conflicts with existing standards.

Speed comparison
- Full context: includes discovery, repo scan, and optional design.
- Fast context: provides build, issue, and files upfront.
- Typical speed gain: 2x to 4x for small changes.
- Fast context reduces clarification round trips.
- Full context is still preferred for ambiguous tasks.

Notes on usage
- Keep fast context stable across agents and sessions.
- Update fast context only if the task scope changes.
- Add a short “why now” line if timing matters.
- Use a consistent order: build, issue, files.
- Avoid duplicating background narratives.

Template
- build: <single command>
- issue: <one-sentence goal; constraints>
- issue: Acceptance: <1–3 bullets>
- files: <path>
- files: <path>

Checklist for writers
- Is the issue statement precise?
- Are constraints explicit?
- Are files limited and plausible?
- Does the build command run in one step?
- Is discovery explicitly skipped or required?

Checklist for implementers
- Confirm the files exist.
- Run the provided build command only.
- Do not expand scope beyond issue lines.
- Avoid additional discovery unless blocked.
- Report only blocking questions.

End
