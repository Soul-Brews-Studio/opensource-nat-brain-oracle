---
title: Environment variables and secrets: Never commit .env files - use .env.example as
tags: [environment, secrets, dotenv, security, configuration]
created: 2026-01-03
source: Knowledge gap fill
---

# Environment variables and secrets: Never commit .env files - use .env.example as

Environment variables and secrets: Never commit .env files - use .env.example as template. Use different env files per environment (.env.local, .env.production). Store secrets in vault (HashiCorp, AWS Secrets Manager), not env vars in CI. Validate required env vars at startup. Prefix public vars with NEXT_PUBLIC_ or VITE_ for frontend exposure.

---
*Added via Oracle Learn*
