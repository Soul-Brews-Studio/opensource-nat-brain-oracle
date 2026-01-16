---
title: OAuth vs JWT authentication: Use OAuth for third-party auth (Google, GitHub logi
tags: [oauth, jwt, authentication, security, api]
created: 2026-01-03
source: Knowledge gap fill
---

# OAuth vs JWT authentication: Use OAuth for third-party auth (Google, GitHub logi

OAuth vs JWT authentication: Use OAuth for third-party auth (Google, GitHub login). Use JWT for stateless API authentication. Store refresh tokens securely (httpOnly cookies), access tokens short-lived (15min). Never store JWTs in localStorage - use httpOnly cookies or memory. Implement token rotation for refresh tokens.

---
*Added via Oracle Learn*
