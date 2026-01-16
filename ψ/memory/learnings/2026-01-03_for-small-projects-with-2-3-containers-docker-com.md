---
title: For small projects with 2-3 containers, Docker Compose is usually sufficient. On
tags: [kubernetes, docker, architecture, small-projects, devops]
created: 2026-01-03
source: Consult knowledge gap
---

# For small projects with 2-3 containers, Docker Compose is usually sufficient. On

For small projects with 2-3 containers, Docker Compose is usually sufficient. Only use Kubernetes when you need: auto-scaling, multi-node deployment, service mesh, or enterprise features. K8s overhead is not worth it for simple apps - start with docker-compose.yml and migrate to K8s only when complexity demands it.

---
*Added via Oracle Learn*
