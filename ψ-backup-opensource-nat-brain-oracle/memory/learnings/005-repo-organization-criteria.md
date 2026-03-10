# 005 - Repository Organization Criteria

**Date**: 2025-12-16  
**Pattern**: How to assess if a repo is "organized" vs chaotic  
**Use case**: Triage repos for keep/archive/delete decisions

---

## Part 1: Checklist - Organized Repo Indicators

### README & Documentation (REQUIRED)
- [ ] Has `README.md` in root
- [ ] README describes purpose (1-2 sentences)
- [ ] README has setup instructions OR link to docs
- [ ] Has CONTRIBUTING.md (if accepting PRs)
- [ ] Has LICENSE file

### GitHub Metadata (REQUIRED)
- [ ] Repository has description (visible in GitHub UI)
- [ ] Topics/tags added (searchable)
- [ ] Correct visibility (public/private matches intent)
- [ ] Branch protection configured (if main repo, not fork)

### Code Structure
- [ ] Consistent directory organization
- [ ] Clear separation of concerns (src/, tests/, docs/, etc.)
- [ ] No random files in root (except standard ones: README, LICENSE, .gitignore, etc.)
- [ ] Naming convention consistent (camelCase or snake_case throughout)

### Commit History
- [ ] Has meaningful commits (not "WIP", "fix", "asdf")
- [ ] Commit messages follow conventional format OR project convention
- [ ] Regular commit activity (not 1 commit in 2 years)
- [ ] YOUR commits present (not just forked with no changes)

### Active vs Abandoned Signals
- [ ] Last commit < 6 months ago (active)
- [ ] Has open PRs OR active issues (maintained)
- [ ] Responds to issues (if public)
- [ ] Dependencies kept up-to-date (not deprecated)

### Operational Health
- [ ] `.gitignore` exists and excludes node_modules, .env, etc.
- [ ] No secrets in git history (no API keys, passwords)
- [ ] CI/CD configured (.github/workflows/ or equivalent)
- [ ] File sizes reasonable (< 50MB repo, < 10MB largest file)

---

## Part 2: Red Flags - Signs of Unorganized Repo

| Red Flag | Severity | Why It Matters |
|----------|----------|----------------|
| No README | 🔴 Critical | Purpose unknown, unteachable |
| Multiple abandoned branches | 🔴 Critical | Confusing, outdated context |
| Secrets in git (API keys) | 🔴 Critical | Security risk |
| 100+ unresolved issues | 🟠 High | Unmaintained, unclear priorities |
| Last commit 2+ years ago | 🟠 High | Dead repo, don't invest |
| No .gitignore, huge files | 🟠 High | Poor practices, hard to clone |
| Inconsistent naming/structure | 🟡 Medium | Low-quality codebase |
| Vague commit messages | 🟡 Medium | History unreadable |
| No license | 🟡 Medium | Legal ambiguity |
| Your fork only, no changes | 🟡 Medium | Questionable ownership |

---

## Part 3: Organization Action Items (Decision Tree)

### Step 1: Is this YOUR repo or a fork?

```
YOUR REPO?
├── YES → Go to Step 2 (Own it properly)
└── NO → Go to Step 3 (Fork assessment)
```

### Step 2: Own Repo - Get Organized

**If you own it, follow this sequence:**

1. **Documentation (do first)**
   - [ ] Write/update README with purpose, setup, usage
   - [ ] Add GitHub description (60 chars max, searchable terms)
   - [ ] Add 3-5 GitHub topics (programming language, framework, use case)
   - [ ] Add LICENSE (MIT/Apache/GPL as appropriate)

2. **Structure (do second)**
   - [ ] Create standard directories: `src/`, `tests/`, `docs/`
   - [ ] Move random root files → appropriate home
   - [ ] Create `.gitignore` from template (gitignore.io)

3. **Commit History (do third)**
   - [ ] Rewrite bad commits (if < 10 commits and < 1 week old)
   - [ ] Otherwise, start fresh commits going forward
   - [ ] Follow conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`

4. **Operational (do last)**
   - [ ] Check for secrets: `git log --all -p | grep -i "password\|api_key\|token"`
   - [ ] If found: Use BFG to clean history
   - [ ] Set up CI/CD (.github/workflows/ for GitHub)
   - [ ] Add branch protection to main (if public/important)

### Step 3: Fork Assessment

**For forks where you don't own the upstream:**

```
Have YOU made commits?
├── YES (3+ meaningful commits)
│   ├── Is upstream stale (2+ years no activity)?
│   │   ├── YES → Consider adopting (contact owner) or archive
│   │   └── NO → Keep as fork, document your changes in README
│   └── Action: Add fork README explaining your modifications
│
└── NO (0 commits, just watching)
    ├── Do you use it actively?
    │   ├── YES → Keep, but automate updates (Dependabot)
    │   └── NO → Delete and re-clone when needed
    └── Action: Delete or archive
```

---

## Part 4: Triage Rules - Keep, Archive, or Delete?

### Decision Matrix

| Scenario | Decision | Rationale |
|----------|----------|-----------|
| **Active own repo** (commits < 6mo) | ✅ KEEP | Living project |
| **Stale own repo** (2-5 years) | 🟡 ARCHIVE | Might revive, document why paused |
| **Dead own repo** (5+ years, no users) | ❌ DELETE | Deadweight, GitHub search finds originals |
| **Fork with your commits** (3+) | ✅ KEEP | You own this derivative work |
| **Fork, no changes, using actively** | ✅ KEEP | Reference copy, keep updated |
| **Fork, no changes, abandoned** | ❌ DELETE | Dead weight, can re-clone anytime |
| **Learning fork** (study project) | 🟡 ARCHIVE → ψ/learn/ | Move to learn/ folder (gitignored) |
| **Experiment/POC** (works but abandoned) | 🟡 ARCHIVE → ψ/lab/ | Move to lab/ (gitignored) |

### Archive Locations (Don't delete, move!)

**Philosophy: "Nothing is Deleted"** — Move to:

1. **ψ/learn/[repo-name]/** — Forks you studied from (gitignored)
   ```
   Purpose: Keep the knowledge, not the repo
   Cleanup: Symlink or organize by date (learn/2025-12/project-name/)
   ```

2. **ψ/lab/[repo-name]/** — POCs, experiments (gitignored)
   ```
   Purpose: Might revive, keep the experiment
   Cleanup: Add ψ/lab/[repo-name]/README-status.md with why paused
   ```

3. **ψ/archive/[YYYY-MM]/[repo-name]/** — Old own repos
   ```
   Purpose: Historical record, searchable by date
   Cleanup: Document why archived, when can delete
   ```

**Never fully delete** — use `git archive` or export if needed later.

---

## Part 5: Quick Reference Decision Tree

```
Found a repo in your local machine...

Is it a directory with .git/?
├── YES
│   ├── Do you own it on GitHub (or is it a real fork with your work)?
│   │   ├── YES
│   │   │   ├── Do you use it actively (commits < 6 months)?
│   │   │   │   ├── YES → Clean it up (STEP 2: Own Repo)
│   │   │   │   └── NO → Archive it (ψ/archive/YYYY-MM/)
│   │   │   │
│   │   │   └── NO (fork, no your changes)
│   │   │       ├── Do you study from it actively?
│   │   │       │   ├── YES → Archive to ψ/learn/
│   │   │       │   └── NO → DELETE
│   │   │       └── Is it a live dependency (CI/CD uses it)?
│   │   │           ├── YES → Keep + automate updates
│   │   │           └── NO → DELETE
│   │   │
│   │   └── NO (forked, but your modifications exist)
│   │       ├── Is this a useful derivative work?
│   │       │   ├── YES → Keep + document in README
│   │       │   └── NO → Archive to ψ/lab/
│   │       │
│   │       └── Consider proposing PR upstream
│   │
│   └── Red flags present (secrets, huge files)?
│       ├── YES → Fix immediately
│       └── NO → Proceed with triage
│
└── NO (not a git repo)
    └── Should this be version controlled?
        ├── YES → git init + follow Part 3
        └── NO → Delete or move outside repo
```

---

## Part 6: Scoring Rubric (Optional: Rate Your Repos)

Use this to score repos 0-100:

| Category | Criteria | Points |
|----------|----------|--------|
| **Documentation** | README exists + describes purpose | 0-20 |
| **Code Quality** | Consistent structure + no obvious red flags | 0-20 |
| **Maintainability** | Clear commits + reasonable file sizes | 0-20 |
| **Activity** | Last commit < 6 months | 0-20 |
| **Ownership** | Your work OR meaningful fork | 0-20 |

**Scoring:**
- **80-100**: Organization champion ✨
- **60-79**: Good, minor cleanup needed
- **40-59**: Organized repo, needs love
- **0-39**: Archive or delete candidate

---

## Examples

### Example 1: Living Project (KEEP)
```
✅ Has README describing purpose
✅ Last commit 1 month ago
✅ Clean directory structure (src/, tests/, docs/)
✅ Consistent commit messages
✅ GitHub description + topics
✅ Open issues = active maintenance

Decision: KEEP
Action: Update dependencies quarterly
```

### Example 2: Stale Fork (ARCHIVE)
```
❌ No README (forked as-is)
❌ Last commit 3 years ago
❌ No your modifications
⚠️ Has secrets (API key in config.json)
✅ Small, clean structure

Decision: ARCHIVE → ψ/learn/ (fix secrets first!)
Action: git-bfg to clean secrets, move folder
```

### Example 3: Active Experiment (ARCHIVE)
```
✅ Has README ("WIP: Testing new pattern")
✅ Your commits (5 meaningful)
❌ Last commit 6 months ago (paused)
❌ No CI/CD
⚠️ Incomplete (tests fail)

Decision: ARCHIVE → ψ/lab/
Action: Update README with "paused on 2025-12-16, reason: ..."
Next: When reviving, move to /Users/nat/Code/laris-co/ and clean up
```

---

## Integration with Your System

**Marie Kondo Rule**: Use this checklist BEFORE asking "should I keep this repo?"

**Triage Workflow**:
1. Identify all local repos: `find ~/ -maxdepth 3 -name ".git" -type d`
2. Score each with rubric (Part 6)
3. Triage using decision tree (Part 5)
4. Move/archive using Part 4 locations
5. Update ψ/inbox/focus.md when done

**Subagent Task**: repo-auditor can:
- [ ] Find all .git folders in ~/
- [ ] Check last commit date + count your commits
- [ ] Detect secrets (pre-flight check)
- [ ] Generate triage report

---

## Oracle Principle Applied

> "Nothing is Deleted" — Move, don't destroy

Even repos you don't use anymore have value:
- **Learning repos** → Teach future-you a pattern
- **Experiments** → Reference for what didn't work
- **Old projects** → Historical record of your growth

Archive by date, never truly delete.

