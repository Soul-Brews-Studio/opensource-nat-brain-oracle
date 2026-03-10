---
title: Testing pyramid strategy: Many unit tests (fast, isolated), fewer integration te
tags: [testing, unit-test, integration-test, e2e, best-practices]
created: 2026-01-03
source: Knowledge gap fill
---

# Testing pyramid strategy: Many unit tests (fast, isolated), fewer integration te

Testing pyramid strategy: Many unit tests (fast, isolated), fewer integration tests (test boundaries), few E2E tests (slow, brittle). Unit test business logic, integration test API contracts, E2E test critical user flows. Mock external dependencies in unit tests. Use test containers for integration tests. Run E2E in CI, not on every commit.

---
*Added via Oracle Learn*
