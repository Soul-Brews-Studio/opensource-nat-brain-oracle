# /trace Command v51-60: System Integration Roadmap

**Focus**: Cross-system integration to trace projects across entire digital ecosystem  
**Date**: 2025-12-23  
**Context**: Expanding /trace beyond git/GitHub to cover npm, PyPI, crates.io, Slack, GHA, Vercel, Docker, Google Drive, browser history

---

## v51: Obsidian Vault Link Resolution

**Change:** Add agent to scan Obsidian vault (.obsidian/ folder detection) and parse wikilinks to find project references across linked notes

**Why:** Captures knowledge graph connections missed by file search; finds projects mentioned indirectly in daily notes, research, and linked documents

**Implementation Detail:**
- Detect `~/.config/obsidian` or custom vault path
- Parse markdown wikilinks: `[[project-name]]`
- Extract backlinks from daily notes, research, and knowledge base
- Return temporal context (when note was last modified, when link was added)

---

## v52: npm Package History Tracer

**Change:** Cross-reference git commits with npm registry API (https://registry.npmjs.org/[package]) to find when code was published, version history, and publication dates

**Why:** Reveals when code graduated from incubation to published package; shows version timeline separate from git history

**Implementation Detail:**
- Query npm API for package release history
- Correlate npm publish dates with git tags
- Show version progression: v0.1.0 → v1.0.0 → current
- Detect unpublished changes (git ahead of npm)
- List all versions and their installation counts

---

## v53: PyPI Release Timeline

**Change:** Search PyPI API (https://pypi.org/pypi/[package]/json) to find Python packages and correlate with git tags/releases

**Why:** Enables tracing Python projects across git → PyPI publication; detects semver misalignments between code and package versions

**Implementation Detail:**
- Query PyPI JSON API for release history
- Show releases side-by-side with git tags
- Detect version bumping patterns
- List current PyPI version vs. HEAD version
- Show download stats as project maturity indicator

---

## v54: crates.io Dependency Resolver

**Change:** Query crates.io API for Rust projects; parse Cargo.toml files in repo to find all published crates by author/org

**Why:** Maps Rust ecosystem presence; finds workspace crates that may be split across multiple packages; shows dependency relationships

**Implementation Detail:**
- Parse all Cargo.toml files in repo and workspaces
- Query crates.io API for each found crate
- Build dependency graph (internal + external)
- Show which crates are published vs. local-only
- Reveal crate download trends and deprecation status

---

## v55: Slack Channel History Search

**Change:** (Requires slack-cli auth) Search Slack workspace for message mentions; returns date, channel, and context of discussions

**Why:** Captures synchronous conversations about projects; reveals team decisions, blockers, and pivots not in async docs

**Implementation Detail:**
- Require Slack CLI configuration (~/.slack/config)
- Search all channels for project name mentions
- Return: date | channel | user | message excerpt | reaction count
- Highlight threads and resolved topics (pinned messages)
- Correlate with git commit dates for context

**Auth**: `slack auth list` → verify token exists

---

## v56: GitHub Actions Workflow Connector

**Change:** Parse .github/workflows/ files; use gh API to fetch run history for workflows matching project name; show success/failure timeline

**Why:** Reveals CI/CD history as a proxy for active development; finds deployment events and test failures tied to project changes

**Implementation Detail:**
- List all workflows in .github/workflows/
- Use `gh run list --workflow=[name]` for run history
- Show: date | workflow | status | duration | conclusion
- Highlight failed runs and their error messages
- Correlate with git commits that triggered runs
- Show deployment workflow success rate

---

## v57: Vercel Deployment Tracker

**Change:** Query Vercel API (requires token) to find deployments, preview URLs, and production aliases tied to project code

**Why:** Shows where frontend projects are currently deployed; finds abandoned preview URLs; reveals actual production environment

**Implementation Detail:**
- Require Vercel token (~/.vercel/auth.json)
- Query Vercel API for projects matching name
- Return: deployment date | environment | URL | status | duration
- Show production aliases and custom domains
- List preview URLs tied to branches/PRs
- Detect stale deployments (last deploy > 3 months ago)

**Auth**: `vercel whoami` → verify token exists

---

## v58: Docker Image Registry Scanner

**Change:** Query Docker Hub and GitHub Container Registry for images matching project name; show build dates and size progression

**Why:** Tracks containerized projects; shows when Docker images were built; finds orphaned images in registries

**Implementation Detail:**
- Query Docker Hub API (docker.io) for image tags
- Query GitHub Container Registry (ghcr.io) for images
- Show: tag | build date | image size | pull count
- Detect size growth over versions
- Find unpushed local builds (`docker images | grep [project]`)
- Show deprecation status and maintenance activity

**Auth**: Docker login required (`docker login`)

---

## v59: Google Drive Project Index

**Change:** (Requires Google API auth) Search Drive for project mentions, shared docs, and spreadsheets; correlate last_modified dates

**Why:** Captures non-code artifacts (design docs, specs, planning spreadsheets); shows collaboration and external team awareness

**Implementation Detail:**
- Require Google OAuth token (~/.config/gcloud/)
- Query Drive API with: `name contains '[project]'`
- Return: filename | folder | last_modified | owner | access level
- Group by type: documents | spreadsheets | folders | comments
- Show shared status and who has access
- Correlate doc edits with code commits for multi-source projects

**Auth**: `gcloud auth list` → verify Google account authorized

---

## v60: Browser History Reconstruction

**Change:** (Requires local SQLite access) Search Chrome/Firefox history for project domain/repo URLs; correlate timestamps with git activity

**Why:** Reveals when you actually worked on projects vs. code commits; captures research and reference material visits; detects abandoned projects by last visit

**Implementation Detail:**
- Query Chrome history: `~/.config/google-chrome/Default/History` (SQLite)
- Query Firefox history: `~/.mozilla/firefox/*/places.sqlite` (SQLite)
- Extract visits to: GitHub repos, npm packages, deployed URLs, docs
- Return: date | URL | title | visit_count
- Highlight research visits (stack overflow, docs, tutorials)
- Show last actual visit to project (not just code timestamp)
- Detect multi-day abandonment patterns

**Limitations**: Chrome history may be encrypted; requires profile closed to read SQLite

---

## Integration Priority Matrix

| Version | System | Auth Required | Accuracy | Speed | Value |
|---------|--------|---------------|----------|-------|-------|
| 51 | Obsidian | No | High | Fast | Medium |
| 52 | npm | No | High | Medium | High |
| 53 | PyPI | No | High | Medium | High |
| 54 | crates.io | No | High | Medium | Medium |
| 55 | Slack | Yes | High | Slow | Medium |
| 56 | GitHub Actions | No | High | Medium | High |
| 57 | Vercel | Yes | High | Medium | High |
| 58 | Docker | Yes | Medium | Fast | Medium |
| 59 | Google Drive | Yes | Medium | Medium | Low |
| 60 | Browser | No | Medium | Fast | Low |

---

## Recommended Rollout

**Phase 1 (No Auth)**: 51, 52, 53, 54, 56, 60 - These work immediately
**Phase 2 (Easy Auth)**: 58 (Docker login), 55 (Slack CLI)  
**Phase 3 (OAuth)**: 57 (Vercel), 59 (Google Drive)

---

## Meta Notes

- All versions add `--all` flag to search across git (all branches) + all remotes
- All versions output timestamps in `YYYY-MM-DD HH:MM` format for correlation
- All versions support `--json` flag for piping to other tools
- Auth failures should gracefully skip that agent (not fail entire command)

