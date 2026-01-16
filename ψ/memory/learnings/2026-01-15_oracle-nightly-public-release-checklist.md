---
title: Oracle Nightly Public Release Checklist
created: 2026-01-15
tags: [oracle-nightly, release, checklist, public, open-source]
---

# Oracle Nightly Public Release Checklist

## The Complete Checklist

Used for releasing Oracle Nightly v0.2.1 to Soul-Brews-Studio.

### 1. Branding & Version
- [x] Update title in README (Oracle v2 → Oracle Nightly)
- [x] Bump version in package.json (0.2.1-nightly)
- [x] Update serverInfo in src/index.ts
- [x] Update banner in src/server.ts

### 2. Documentation
- [x] README with Evolution Timeline
- [x] TIMELINE.md with full history
- [x] INSTALL.md with step-by-step guide
- [x] API.md with correct endpoints (/api/ prefix)
- [x] Archive SPEC.md with annotations

### 3. Install Pipeline
- [x] fresh-install.sh (one-liner curl)
- [x] seed.sh (philosophy starter kit)
- [x] setup.sh (manual setup)
- [x] Auto-bootstrap tables for fresh install

### 4. Seed Philosophy
- [x] oracle.md (core principles)
- [x] patterns.md (decision patterns)
- [x] style.md (communication style)
- [x] Test learning document

### 5. Testing
- [x] Run tests locally (bun test)
- [x] Test on fresh remote machine
- [x] Verify curl commands from docs work
- [x] Confirm search returns results
- [x] Check hybrid search (FTS5 + vector)

### 6. Push to Public
- [x] Push to origin (private)
- [x] Push to public remote
- [x] Verify GitHub Actions pass
- [x] Check README renders correctly

### 7. Cleanup
- [x] Replace pnpm with bun in all docs
- [x] Fix API endpoint documentation
- [x] Add acknowledgments (claude-mem)
- [x] Link learnings in References

## Key Files Created

| File | Purpose |
|------|---------|
| `TIMELINE.md` | Evolution history |
| `docs/INSTALL.md` | Installation guide |
| `docs/SPEC-original.md` | Archived spec |
| `scripts/fresh-install.sh` | One-liner setup |
| `scripts/seed.sh` | Philosophy starter |

## Commits for Release (15 total)

```
135cce9 docs: pnpm→bun
8a17cac docs: INSTALL.md
63ea5a2 docs: Rich workflow learning
3fd3232 rrr: retrospective
f31fea1 feat: install scripts
baefa12 fix: /api/ prefix
cc50547 docs: Services section
fc1581c docs: SPEC annotations
6eb4eb5 docs: Archive SPEC
876bfcb docs: Timeline + rebrand
487726e docs: TIMELINE.md
fc9cd47 fix: version 0.2.1
2c95f77 chore: rebrand
c4378cb feat: install script
bcac9b7 feat: auto-bootstrap
```

## Learnings from Release

1. **Test on fresh machines** - Don't trust CI alone
2. **Document the one-liner** - curl | bash is expected
3. **Seed data matters** - Empty demos are useless
4. **Archive, don't delete** - History has value
5. **Fix docs first** - Wrong docs waste user time

## Quick Reference

### One-Liner Install
```bash
curl -sSL https://raw.githubusercontent.com/Soul-Brews-Studio/oracle-v2/main/scripts/fresh-install.sh | bash
```

### Test Search
```bash
curl "http://localhost:47778/api/search?q=nothing+deleted"
```

### Expected Result
- 29 documents indexed
- Top result: "Nothing is Deleted" principle
- Score: ~0.58

---

*Created during Oracle Nightly v0.2.1 public release, 2026-01-15*
