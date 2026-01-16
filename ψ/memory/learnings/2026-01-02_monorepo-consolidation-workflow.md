# Monorepo Consolidation Workflow

**Date**: 2026-01-02
**Source**: HEADLINE migration session

## What We Learned

### 1. Monorepo > Scattered Repos
When a project has multiple components (pipeline, rag, dashboard, analyzer), consolidate into one repo with subfolders rather than maintaining separate repos.

```
# Before: 3 repos to manage
the-headline/
headline-rag/
headline-analyzer/

# After: 1 repo, clear structure
the-headline-mono/
├── pipeline/
├── rag/
├── dashboard/
└── analyzer/
```

### 2. Safe Migration Pattern
```bash
# 1. Create new private repo
gh repo create org/new-mono --private

# 2. Copy content (not move)
cp -r old-repo/src new-mono/component/

# 3. Save git history as reference
git -C old-repo log --oneline > new-mono/docs/HISTORY-old-repo.txt

# 4. Archive old repos (not delete!)
gh repo archive org/old-repo --yes

# 5. Move local files to /tmp (not rm!)
mv local-files /tmp/backup-$(date +%Y%m%d)/
```

### 3. Documentation Structure
```
docs/
├── INDEX.md           # Navigation hub
├── API-ENDPOINTS.md   # Essential docs (few)
├── ANALYSIS.md
└── archive/           # Supporting .txt files
```

Keep main docs minimal, move supporting files to archive/.

## How Things Connect

```
LINE chat export → /fyi (log info)
                      ↓
/trace project    → Find scattered repos
                      ↓
/nnn             → Plan consolidation
                      ↓
Build + Migrate  → New monorepo
                      ↓
gh repo archive  → Clean up old repos
                      ↓
rrr + /snapshot  → Document pattern
```

## Tags
`monorepo` `migration` `architecture` `gh-cli` `documentation`
