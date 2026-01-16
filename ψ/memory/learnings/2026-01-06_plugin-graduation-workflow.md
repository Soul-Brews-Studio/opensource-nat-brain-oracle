# Plugin Graduation Workflow

**Date**: 2026-01-06

## What We Learned

- **Incubate → Graduate pattern**: Plugins start in `plugins/` folder, graduate to own repo with symlink back
- **AI trace instructions**: Add parent commit reference so future AI can trace full history
- **Archive with redirect**: Old repo becomes redirect sign, not dead link
- **Session isolation**: PR #15853 pattern - SessionStart hook captures `session_id`, state files keyed by session

## The Graduation Flow

```
1. Create repo in target org (Soul-Brews-Studio)
2. Push all code + documentation
3. Clone to ~/Code/github.com/[org]/[repo]
4. Replace plugins/[name]/ with symlink
5. Add AI trace instructions (parent commit)
6. Archive old repo with redirect README
```

## Key Files

| File | Purpose |
|------|---------|
| `marketplace.json` | Plugin discovery for `/plugin marketplace add` |
| `hooks/session-start-hook.sh` | Capture session_id for isolation |
| `README.md` AI Trace section | Points to parent commit for history |

## How Things Connect

- **ralph-local** graduated from Nat-s-Agents to Soul-Brews-Studio
- Parent commit `c4920605` contains 64+ knowledge files
- Symlink keeps plugin working in original location
- Archive prevents confusion about which repo is active

## Tags

`plugin` `graduation` `workflow` `symlink` `archive` `session-isolation`
