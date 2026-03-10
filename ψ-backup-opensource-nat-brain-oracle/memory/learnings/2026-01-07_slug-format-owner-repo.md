---
date: 2026-01-07
type: idea
status: pending
concepts: [project-manager, slugs, ghq]
---

# Slug Format: owner/repo

## Current Format
```yaml
claude-mem: ~/Code/github.com/thedotmack/claude-mem
headline: ~/Code/github.com/laris-co/the-headline
```

## Proposed Format
```yaml
thedotmack/claude-mem: ~/Code/github.com/thedotmack/claude-mem
laris-co/the-headline: ~/Code/github.com/laris-co/the-headline
```

## Lookup Logic (Mixed)

```bash
resolve_slug() {
    local input="$1"

    # 1. Full path match (owner/repo) - priority
    if [[ "$input" == */* ]]; then
        grep "^$input:" slugs.yaml | cut -d: -f2
        return
    fi

    # 2. Short slug - search all orgs
    grep "/$input:" slugs.yaml | head -1 | cut -d: -f2
}
```

## Benefits

- No collision (`laris-co/utils` vs `other-org/utils`)
- Matches `gh` and `ghq` patterns
- Still allows short slugs for convenience

## Files to Update

- [ ] `scripts/learn.sh`
- [ ] `scripts/incubate.sh`
- [ ] `scripts/reunion.sh`
- [ ] `scripts/offload.sh`
- [ ] `scripts/history.sh`
- [ ] `slugs.yaml` (migrate existing entries)

## Migration

```bash
# Convert existing slugs
# claude-mem: path → thedotmack/claude-mem: path
```
