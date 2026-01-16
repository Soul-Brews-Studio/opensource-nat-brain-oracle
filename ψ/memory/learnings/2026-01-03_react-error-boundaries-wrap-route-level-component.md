---
title: React error boundaries: Wrap route-level components to prevent full app crashes.
tags: [error-boundary, react, error-handling, resilience, ux]
created: 2026-01-03
source: Knowledge gap fill
---

# React error boundaries: Wrap route-level components to prevent full app crashes.

React error boundaries: Wrap route-level components to prevent full app crashes. Show user-friendly fallback UI with retry option. Log errors to monitoring service (Sentry, LogRocket). Use multiple boundaries at different levels for granular recovery. Error boundaries don't catch async errors - use try/catch for those. Reset boundary state on navigation.

---
*Added via Oracle Learn*
