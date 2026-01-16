---
title: Date/time handling: Store timestamps in UTC, display in user's timezone. Use ISO
tags: [datetime, timezone, utc, date-fns, internationalization]
created: 2026-01-03
source: Knowledge gap fill
---

# Date/time handling: Store timestamps in UTC, display in user's timezone. Use ISO

Date/time handling: Store timestamps in UTC, display in user's timezone. Use ISO 8601 format for APIs. Prefer date-fns or dayjs over moment (smaller bundle). Handle timezone-aware comparisons carefully. Use Intl.DateTimeFormat for localized display. Be explicit about timezone in function names. Test around DST transitions.

---
*Added via Oracle Learn*
