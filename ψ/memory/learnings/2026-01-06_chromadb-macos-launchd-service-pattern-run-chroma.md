---
title: ChromaDB macOS Launchd Service Pattern: Run ChromaDB as a persistent macOS servi
tags: [chromadb, launchd, macos, vector-search, infrastructure, hybrid-search]
created: 2026-01-06
source: Session 2026-01-06: ChromaDB setup
---

# ChromaDB macOS Launchd Service Pattern: Run ChromaDB as a persistent macOS servi

ChromaDB macOS Launchd Service Pattern: Run ChromaDB as a persistent macOS service using launchd, not spawned by the app. Key details: (1) Command is `uvx --from chromadb chroma run --path ~/.chromadb`, (2) Data path must match between service and indexer, (3) Use launchd plist at ~/Library/LaunchAgents/com.chromadb.server.plist with RunAtLoad=true and KeepAlive=true, (4) Check health via curl http://localhost:8000/api/v2/heartbeat. This enables reliable hybrid search (FTS5 + vectors) with auto-start on boot.

---
*Added via Oracle Learn*
