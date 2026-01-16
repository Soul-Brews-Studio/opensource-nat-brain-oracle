# Session Timer CLI

Track Claude session duration with simple start/stop/status/history commands.

## Installation

```bash
bun install
```

## Usage

### Start a Session

```bash
bun run src/index.ts start
# ✅ Session started at 10:30:15
```

### Check Status

```bash
bun run src/index.ts status
# Active session: 2h 15m 30s
# Started at: 10:30:15
```

### Stop a Session

```bash
bun run src/index.ts stop
# ✅ Session ended. Duration: 2h 15m 30s

# With note:
bun run src/index.ts stop --note "Finished feature work"
```

### View History

```bash
bun run src/index.ts history
# Session History (last 10):
#   2025-12-31 10:30 - 12:45 (2h 15m) - Finished feature work

# Limit results:
bun run src/index.ts history --limit 5
```

## Philosophy

Built on the Oracle principle: **"Timestamps = Truth"**

- Sessions are append-only (never deleted)
- All timestamps preserved
- SQLite storage for durability

## Tech Stack

- Bun runtime
- Drizzle ORM + bun:sqlite
- Commander.js CLI

## License

MIT
