---
title: Oracle Nightly Public Release Checklist - Complete 7-step checklist for open sou
tags: [oracle-nightly, release-checklist, open-source, documentation, testing]
created: 2026-01-15
source: Session 2026-01-15 Oracle Nightly Release
---

# Oracle Nightly Public Release Checklist - Complete 7-step checklist for open sou

Oracle Nightly Public Release Checklist - Complete 7-step checklist for open source release:

1. Branding & Version - Update title, version, serverInfo
2. Documentation - README, TIMELINE, INSTALL, API, archived SPEC
3. Install Pipeline - fresh-install.sh, seed.sh, auto-bootstrap
4. Seed Philosophy - oracle.md, patterns.md, style.md
5. Testing - Local tests, fresh remote machine, verify docs
6. Push to Public - origin + public remote, verify CI
7. Cleanup - pnpm→bun, fix endpoints, add acknowledgments

Key insight: "Test docs on fresh machines - CI passing ≠ user experience works"

---
*Added via Oracle Learn*
