# Gemini CLI Native TOML Commands

**Date**: 2026-01-05
**Category**: Pattern
**Source**: Session retrospective (10.15_gemini-cli-migration)

## The Rule/Pattern

Gemini CLI custom slash commands must be defined as `.toml` files in the `.gemini/commands/` directory. Each file must have a `prompt` key and can optionally have a `description`.

## Why It Matters

Using the native `.toml` format ensures the commands are recognized by the Gemini CLI. Furthermore, using the `!{...}` shell execution syntax within the TOML prompt allows for high-speed context gathering that is executed *before* the model starts generating, reducing the need for expensive sub-agent task tool calls.

## Example

```toml
# .gemini/commands/status.toml
description = "Show git status"
prompt = """
Check the current project status:
!{git status --short}
"""
```

## Prevention/Application

1.  Always prefer `.toml` for Gemini-native extensions.
2.  Use shell execution `!{}` to gather logs, diffs, and file lists to make prompts data-aware.
3.  Migrate legacy `.md` commands by wrapping their prompts in the TOML schema.

---

**Related**: [Retrospective 10.15_gemini-cli-migration](../../retrospectives/2026-01/05/10.15_gemini-cli-migration.md)
