# Principle: Infrastructure Config Is Not Learning

**Date**: 2026-03-10
**Source**: Prune cycle 15, Agent 2
**Tags**: pruning, infrastructure, config

## Pattern

Implementation details tied to infrastructure, build systems, or specific codebases lack transferable insight. Port numbers, PM2 configs, DMG build scripts, and SQLite flag resets are machine-specific configuration that becomes stale.
