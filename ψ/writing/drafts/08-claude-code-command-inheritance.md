# The Undocumented Feature That Makes Claude Code Perfect for Monorepos

**Created**: 2025-12-14 03:38 GMT+7
**Status**: Draft
**Author**: Human + AI collaboration

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Learning | ψ/memory/learnings/2025-12-14_claude-code-command-inheritance.md | Core discovery |
| Learning | ψ/memory/learnings/incubation-command-reference.md | Incubation system |
| Retro | ψ/memory/retrospectives/2025-12/14/03.06_maw-incubation-vault-session.md | Session context |
| Docs | Official Claude Code docs | What docs say |
| Community | danielcorin.com TIL | Symlink workaround |

---

## TL;DR

Claude Code inherits `.claude/commands/` from parent directories — an **undocumented feature** that makes it perfect for monorepo setups and "Oracle Hub" patterns. No plugins, no symlinks, just put your repo inside a parent with commands, and they're automatically available.

---

## The Problem

I wanted to build an "Oracle" system — a central hub of AI commands that any project could use. The workflow:

1. Clone a repo into `~/oracle/incubate/`
2. Work on it with Claude Code
3. Have all my Oracle commands (`/rrr`, `/feel`, `/snapshot`) available automatically

**But the docs said this wasn't possible.**

### What the Docs Say

Official Claude Code documentation describes only two scopes:

| Scope | Location |
|-------|----------|
| Project | `.claude/commands/` |
| Personal | `~/.claude/commands/` |

No mention of parent directories. No inheritance. The community even says:

> "Claude Code doesn't natively support cascading commands across monorepo subfolders."
> — danielcorin.com

The recommended workaround? **Symlinks.** Create a symlink from your child project to the parent's commands folder.

---

## The Journey

### Attempt 1: Read the Docs

I searched everywhere. Official docs, GitHub issues, community posts. Everyone agreed: no inheritance, use symlinks.

### Attempt 2: Test Anyway

Something didn't feel right. My Agent 1 (running in a child repo) seemed to see parent commands. Was I imagining it?

I decided to prove it empirically.

### The Test

**Setup:**
```
Nat-s-Agents/                         (Parent - Oracle Hub)
├── .claude/commands/
│   ├── rrr.md
│   ├── feel.md
│   └── prove-inheritance.md          (NEW - just created)
│
└── ψ/incubate/repo/
    └── headline-analyzer/            (Child - incubated project)
```

**Question:** Does headline-analyzer see `/prove-inheritance`?

### The Result

```
> /prove

  /prove-inheritance    /prove-inheritance (project)
  /project              /project - Project Lifecycle Manager
```

**IT WORKS.**

The child project sees the parent's command. No symlinks. No configuration. Just... works.

---

## The Solution

**Claude Code DOES inherit commands from parent directories** — it's just not documented.

### Behavior Details

| Test | Result |
|------|--------|
| Empty `.claude/commands/` in child | Still inherits parent |
| File in child commands/ | Still inherits parent (MERGE) |
| Move repo outside parent tree | No inheritance |
| Create new command in parent | Child sees it after restart |

### The Model: MERGE, Not Replace

Claude Code walks UP the directory tree and MERGES all commands found. Child commands add to parent commands, never block them.

```
Child (.claude/commands/)
    ↓ MERGE
Parent (.claude/commands/)
    ↓ MERGE
Grandparent (.claude/commands/)
    ↓ MERGE
~/.claude/commands/ (User)
```

---

## The Pattern: Oracle Incubation

This undocumented feature enables a powerful pattern:

```
Oracle-Hub/                           (Your central repo)
├── .claude/commands/                 (Your command library)
│   ├── rrr.md                       (Retrospectives)
│   ├── feel.md                      (Emotion logging)
│   ├── snapshot.md                  (Knowledge capture)
│   └── ...                          (40+ commands)
│
└── ψ/incubate/repo/                 (Gitignored)
    └── any-project/                 (Cloned repos)
        └── (automatically gets all Oracle commands!)
```

### The Workflow

```bash
# Clone repo into incubate folder
GHQ_ROOT=ψ/incubate/repo ghq get https://github.com/org/repo

# Start Claude Code in the child
cd ψ/incubate/repo/github.com/org/repo
claude

# All parent commands available!
> /rrr    # Works!
> /feel   # Works!
```

**Zero setup. Instant access to your command library.**

### Before vs After

| Before (Plugin/Symlink) | After (Inheritance) |
|-------------------------|---------------------|
| Install plugin every repo | No installation |
| Create symlinks manually | Just clone |
| Maintain multiple copies | Single source of truth |
| Manual updates | Auto-propagates |

---

## Key Takeaways

### 1. Test Assumptions

Documentation isn't always complete. When something feels possible but docs say no, test it empirically.

### 2. Undocumented != Unsupported

This feature works consistently. It's either intentional-but-undocumented, or a happy accident that Anthropic hasn't removed.

### 3. Monorepo Pattern

If you have a monorepo or want centralized commands, structure your repos as nested directories. Child projects inherit parent commands automatically.

### When to Use

**Good for:**
- Monorepos with shared tooling
- "Oracle Hub" patterns with command libraries
- Teams wanting consistent commands across projects
- Incubation workflows (clone → work → discard)

**Caution:**
- Undocumented behavior may change
- Commands cached at session start (restart to see new parent commands)
- Only works within directory tree (not symlinks)

---

## Full Context (for AI continuation)

### Session Timeline

| Time | Event |
|------|-------|
| 03:11 | Started investigating Agent 1 commands |
| 03:16 | Created empty .claude/commands in child |
| 03:19 | Added README.md to test blocking |
| 03:23 | Confirmed MERGE behavior |
| 03:25 | Created /prove-inheritance in parent |
| 03:28 | Agent 1 confirmed seeing new command |
| 03:31 | Documented as learning |

### Key Commits

```
b3fcba7 feat: incubate.sh - clone repos to ψ/incubate/repo
b729caf feat: learn.sh - clone repos to ψ/learn/repo
db08749 feat: add incubate/learn actions to project-keeper
```

### Related Files

- `ψ/memory/learnings/2025-12-14_claude-code-command-inheritance.md`
- `.claude/scripts/incubate.sh`
- `.claude/scripts/learn.sh`

---

## Tags

`claude-code` `undocumented` `monorepo` `commands` `inheritance` `oracle-pattern` `developer-experience`

---

## Writing Notes

### Tone
Technical but accessible. Story-driven discovery narrative.

### Target Audience
- Claude Code power users
- Developers with monorepo setups
- Anyone wanting centralized AI command libraries

### Suggested Titles
1. "The Undocumented Feature That Makes Claude Code Perfect for Monorepos"
2. "Claude Code's Hidden Command Inheritance: What the Docs Don't Tell You"
3. "Building an Oracle Hub with Claude Code's Secret Inheritance"

### Next Steps
- [ ] Add screenshots of the test
- [ ] Include code blocks with full paths
- [ ] Consider filing GitHub issue for docs update
- [ ] Polish language
- [ ] Publish

---

*Draft generated from session knowledge — 2025-12-14*
*Proven empirically with Agent 1 in headline-analyzer*
