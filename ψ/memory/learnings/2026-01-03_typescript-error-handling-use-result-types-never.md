---
title: TypeScript error handling: Use Result types (neverthrow, fp-ts) over try/catch f
tags: [typescript, error-handling, best-practices, patterns]
created: 2026-01-03
source: Knowledge gap fill
---

# TypeScript error handling: Use Result types (neverthrow, fp-ts) over try/catch f

TypeScript error handling: Use Result types (neverthrow, fp-ts) over try/catch for expected errors. Reserve exceptions for truly exceptional cases. Create custom error classes extending Error with additional context. Use discriminated unions for error types. In async code, prefer explicit error returns over thrown promises.

---
*Added via Oracle Learn*
