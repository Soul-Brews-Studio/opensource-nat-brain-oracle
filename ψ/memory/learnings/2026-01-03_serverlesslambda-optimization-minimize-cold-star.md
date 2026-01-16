---
title: Serverless/Lambda optimization: Minimize cold starts with provisioned concurrenc
tags: [serverless, lambda, aws, cold-start, optimization]
created: 2026-01-03
source: Knowledge gap fill
---

# Serverless/Lambda optimization: Minimize cold starts with provisioned concurrenc

Serverless/Lambda optimization: Minimize cold starts with provisioned concurrency for critical paths. Keep deployment packages small (<50MB). Use connection pooling (RDS Proxy) for databases. Set memory based on CPU needs (more memory = more CPU). Use layers for shared dependencies. Avoid VPC unless necessary - it adds cold start latency.

---
*Added via Oracle Learn*
