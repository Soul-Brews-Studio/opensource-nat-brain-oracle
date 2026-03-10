---
title: # Private Data in Oracle Starter Kit - NEVER Export
tags: [privacy, security, data-hygiene, oracle-starter-kit, export-safety]
created: 2026-01-16
source: nats-brain-oracle audit session 2026-01-16
---

# # Private Data in Oracle Starter Kit - NEVER Export

# Private Data in Oracle Starter Kit - NEVER Export

**Date**: 2026-01-16
**Context**: nats-brain-oracle repo audit

## What Was Found & Removed

16 files containing private data were found in the Oracle Starter Kit:

### Facebook Data (8 files)
- `facebook-posts-complete-timeline.md` (7,132 lines of posts)
- `facebook-posts-timeline.md`, `facebook-profile-extraction.md`
- `facebook-data-export-2025-12-14.md`, `FACEBOOK-POSTS-INDEX.md`
- Analysis reports and comprehensive profile

### Chat/Conversation Data (8 files)
- LINE group exports (DustBoy team, Headline project)
- Personal chat histories (Tacha, Chatchawal, Nuttasit)
- Training data from consulting chats

## The Pattern

**Private data categories to NEVER include in public repos:**
1. Social media posts/feeds (Facebook, Twitter, etc.)
2. Chat transcripts (LINE, Messenger, Discord DMs)
3. Personal profiles with real names
4. Meeting notes with participant names
5. Contact information (phone, email, address)

## What TO Keep

- Parsing techniques (how to extract data)
- Tool code (fb-explorer, ETL pipelines)
- Session retrospectives about building tools
- Anonymized patterns and learnings

## Rule

> "Code travels, data stays home"

Before publishing/sharing any Oracle-based repo:
1. Scan for `*chat*`, `*export*`, `*profile*`, `*timeline*`
2. Check `ψ/writing/` for personal content
3. Check `ψ/memory/logs/info/` for contact data
4. Grep for real names, phone numbers, emails

---
*Added via Oracle Learn*
