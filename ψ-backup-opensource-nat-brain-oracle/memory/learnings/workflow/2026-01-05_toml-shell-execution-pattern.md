# TOML Shell Execution Pattern

**Date**: 2026-01-05
**Category**: Pattern
**Source**: Session retrospective (18.50_gemini-core-commands-migration)

## The Rule/Pattern

Use the `!{...}` syntax in Gemini CLI `.toml` commands to execute complex bash logic *before* the prompt reaches the model. This allows for zero-round-trip context gathering and argument parsing.

## Why It Matters

1.  **Speed**: No "tool call" latency. The model receives the data immediately.
2.  **Context Efficiency**: You can filter, head, and format data (like `git log` or `find`) in bash, ensuring the model only sees relevant info, saving tokens.
3.  **Logic**: You can use bash `if/else` to handle subcommands (e.g., `/project learn` vs `/project list`) inside the prompt template itself.

## Example

**Instead of:**
Asking the model "Please list the files in the directory", which triggers a `list_directory` tool call...

**Do this (in .toml):**
```toml
prompt = """
Here are the files:
!{
  ls -la | head -20
}
Analyze them...
"""
```

**Handling Subcommands:**
```toml
!{
  CMD="{{args}}"
  if [ "$CMD" == "status" ]; then
    git status
  else
    echo "Unknown command"
  fi
}
```

## Prevention/Application

-   **Apply**: When migrating commands that were previously "Agent 1 checks X, Agent 2 checks Y", combine them into a single `!{ check X; check Y }` block.
-   **Caution**: Bash scripts in TOML strings have no syntax highlighting. Test complex logic in a real shell first.

---

**Related**: [Retrospective 18.50_gemini-core-commands-migration](../../retrospectives/2026-01/05/18.50_gemini-core-commands-migration.md)
