---
title: API rate limiting: Implement at multiple layers (API gateway, application, datab
tags: [rate-limiting, api, throttling, security, architecture]
created: 2026-01-03
source: Knowledge gap fill
---

# API rate limiting: Implement at multiple layers (API gateway, application, datab

API rate limiting: Implement at multiple layers (API gateway, application, database). Use token bucket or sliding window algorithms. Return 429 with Retry-After header. Differentiate limits by auth tier (free/pro/enterprise). Cache rate limit state in Redis for distributed systems. Log rate limit hits for abuse detection.

---
*Added via Oracle Learn*
