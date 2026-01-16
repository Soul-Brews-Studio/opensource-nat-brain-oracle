# Skill vs Command: When to Use Which

**Date**: 2025-12-27

## What We Learned

- **Commands** = explicit invocation (`/foo`) — user must remember to type it
- **Skills** = auto-discovered — Claude suggests based on user intent
- For **search/query features**, Skill is better because user just asks naturally

| Aspect | Command | Skill |
|--------|---------|-------|
| Invocation | Manual `/command` | Automatic detection |
| Structure | Single `.md` file | Directory + `SKILL.md` |
| Parameters | `$ARGUMENTS` works | Claude interprets intent |
| Best for | Quick explicit actions | Complex discoverable capabilities |

## How Things Connect

- **memory-search** should be a Skill because:
  - User asks "how did we handle auth?" → Claude auto-suggests
  - Can bundle scripts (`search.py`, `build_index.py`) in skill directory
  - Natural language > strict command syntax

- **Skill structure for memory-search**:
  ```
  .claude/skills/memory-search/
  ├── SKILL.md              # Overview + quick start
  ├── REFERENCE.md          # ChromaDB details
  └── scripts/
      ├── build_index.py    # Create vector index
      └── search.py         # Query the index
  ```

## When to Use

| Use Case | Choice |
|----------|--------|
| Quick, explicit action | Command |
| Complex capability with discovery | Skill |
| Bundled scripts needed | Skill |
| User remembers to invoke | Command |
| Should auto-suggest | Skill |

## Tags

`claude-code` `skills` `commands` `patterns` `memory-search`
