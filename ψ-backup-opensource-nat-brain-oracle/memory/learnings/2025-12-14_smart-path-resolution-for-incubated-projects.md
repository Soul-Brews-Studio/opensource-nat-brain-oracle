# Smart Path Resolution for Incubated Projects

**Date**: 2025-12-14
**Tags**: #commands #incubate #inheritance #patterns

---

## Problem

Commands in `.claude/commands/` are inherited by incubated projects in `ψ/incubate/repo/`.

When a command references `ψ/WIP.md`, the path resolution was problematic:
- Parent's WIP was read instead of project's local WIP
- Lost project-specific context

```
Nat-s-Agents/
├── .claude/commands/wip.md    ← command location
├── ψ/WIP.md                   ← parent's WIP (was read)
└── ψ/incubate/repo/project/
    └── ψ/WIP.md               ← project's WIP (IGNORED)
```

## Solution: Smart Path Detection

Check for local `./ψ/WIP.md` first, fallback to parent:

```bash
# Pattern 1: Simple if-else
if [ -f "./ψ/WIP.md" ]; then
    cat ./ψ/WIP.md
else
    cat ψ/WIP.md
fi

# Pattern 2: Inline ternary
[ -f "./ψ/WIP.md" ] && cat ./ψ/WIP.md || cat ψ/WIP.md
```

## Commands Updated

| Command | Line | Change |
|---------|------|--------|
| `/wip` | bash block | Full if-else with location indicator |
| `/pending` | Step 1 | Smart path for Read tool |
| `/recap` | Step 0 + prompt | Smart path for WIP check |
| `/forward` | Step 1 | Smart path for head command |

## Visual Indicator (Bonus)

When local WIP is used, show the location:
```bash
echo "📍 $(pwd)/ψ/WIP.md"
```

## Why This Matters

1. **Incubated projects have autonomy** — their own WIP, their own context
2. **Parent context as fallback** — if no local ψ/, inherit parent
3. **Transparent** — user knows which WIP is being read

---

*Discovered during session 2025-12-14*
*Root cause: Command inheritance + relative path resolution*
