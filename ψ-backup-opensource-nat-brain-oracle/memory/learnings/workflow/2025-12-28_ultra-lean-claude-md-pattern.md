# Ultra-Lean CLAUDE.md Pattern

**Date**: 2025-12-28

## What We Learned

- CLAUDE.md should be ~500 tokens (rules + pointers only)
- Details live in `.claude/commands/*.md` (lazy loaded)
- Short codes (ccc, nnn, rrr, gogogo) trigger commands
- Gist = workshop template, Repo = production (intentional divergence)

## Key Patterns

1. **Lazy Loading**: Command details loaded only when called
2. **Token Optimization**: Bash append `>>` instead of Read+Edit
3. **Parallel Bash**: Combine checks with `&& echo "---"`
4. **Smart Hooks**: Detect command start `(^|;|&&|\|\|)` not text content

## Migration Status

- Issue #57 tracks the migration
- Current phase: Probation/Testing
- Next: `gogogo` to execute

## How Things Connect

```
CLAUDE.md (rules) → commands/*.md (details) → ψ/ (data)
     ↓                     ↓                    ↓
  Always loaded      Lazy loaded           Persisted
   ~500 tokens        On demand            Git tracked
```

## Tags

`claude-md` `lazy-loading` `token-optimization` `migration`
