# Bug Report: `$.description.split is not a function` on Command Autocomplete

## Summary

Claude Code crashes when typing partial commands (e.g., `/pro`) if any `.md` file in `.claude/commands/`, `.claude/skills/`, or `~/.claude/skills/` is missing YAML frontmatter with a `description` field.

## Error Message

```
TypeError: $.description.split is not a function. (In '$.description.split(" ")', '$.description.split' is undefined)
    at <anonymous> (/$bunfs/root/claude:2995:27399)
    at map (native:1:11)
    at zKA (/$bunfs/root/claude:2995:27285)
```

## Steps to Reproduce

1. Create a skill or command file without frontmatter:
   ```bash
   echo "# My Command\nDo something." > ~/.claude/commands/test.md
   ```

2. Start Claude Code
3. Type `/te` (partial command for autocomplete)
4. Error occurs

## Expected Behavior

- Autocomplete should work
- Files without `description` should use fallback (empty string or filename)
- Documentation says frontmatter is "optional"

## Actual Behavior

- Parser crashes with `$.description.split is not a function`
- `description` is `undefined` when frontmatter is missing
- Code calls `.split(" ")` without null check

## Root Cause Analysis

From exploring `anthropics/claude-code` repo:

1. **Documentation** (`plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md`) says:
   > All frontmatter fields are **optional**

2. **Python parser** (`plugins/hookify/core/config_loader.py`) handles missing frontmatter:
   ```python
   if not content.startswith('---'):
       return {}, content  # Returns empty dict
   ```

3. **But the main binary** doesn't check for undefined before calling `.split()`:
   ```javascript
   // Likely code (pseudocode):
   const words = description.split(" ");  // CRASH if undefined
   ```

## Suggested Fix

```javascript
// Before
const words = description.split(" ");

// After
const words = (description || "").split(" ");
// OR
const words = description?.split(" ") ?? [];
```

## Workaround

Add YAML frontmatter to ALL `.md` files in skill/command directories:

```markdown
---
name: my-command
description: Brief description here.
---

# Command content...
```

## Affected Locations

The parser scans recursively, so ALL these need frontmatter:
- `.claude/commands/*.md`
- `.claude/skills/**/*.md` (including nested references, operations, etc.)
- `~/.claude/commands/*.md`
- `~/.claude/skills/**/*.md`
- Plugin cache: `~/.claude/plugins/cache/**/*.md`

## Evidence

We fixed 50+ files in our project and still got the error because:
- Global `~/.claude/skills/` had files without frontmatter
- Plugin skills (mem-search, notebooklm, anthropic-skills) have nested `.md` files without frontmatter

## Environment

- Claude Code: Latest (updated 2026-01-08)
- OS: macOS Darwin 25.2.0
- Shell: zsh

## Impact

- Blocks autocomplete functionality
- Confusing error message
- Docs say optional but code requires it

---

**Recommendation**: Either:
1. Make the code handle undefined description (preferred)
2. Update docs to say description is required
3. Add validation with helpful error message on startup
