---
title: Docker multi-stage builds: Use builder stage for compilation, minimal runtime st
tags: [docker, multi-stage, optimization, containers, devops]
created: 2026-01-03
source: Knowledge gap fill
---

# Docker multi-stage builds: Use builder stage for compilation, minimal runtime st

Docker multi-stage builds: Use builder stage for compilation, minimal runtime stage for deployment. Copy only artifacts needed (not node_modules, not source). Use alpine or distroless base images. Order Dockerfile commands by change frequency (dependencies before code). Leverage build cache with --mount=type=cache.

---
*Added via Oracle Learn*
