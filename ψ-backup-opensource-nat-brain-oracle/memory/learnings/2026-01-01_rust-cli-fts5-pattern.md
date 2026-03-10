# Rust CLI with FTS5 Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v6 Phase 4 - Rust CLI parity

## The Pattern

### 1. Clap Command Structure

```rust
#[derive(Subcommand)]
enum Commands {
    /// Command description (becomes --help text)
    CommandName {
        /// Argument description
        #[arg(short, long, default_value = "value")]
        option_name: Type,
    },
}

// In main():
match cli.command {
    Commands::CommandName { option_name } => {
        commands::command_name::run(option_name, cli.debug).await?;
    }
}
```

Key points:
- `#[arg(short, long)]` - enables both `-o` and `--option`
- `default_value` - string that gets parsed to the type
- `global = true` - option applies to all subcommands

### 2. rusqlite FTS5 Queries

```rust
// FTS5 MATCH query
let results = conn.query_map(
    "SELECT id, source_file, rank as score
     FROM documents_fts
     WHERE documents_fts MATCH ?
     ORDER BY rank
     LIMIT ?",
    [&search_query, &limit.to_string()],
    |row| Ok((row.get(0)?, row.get(1)?, row.get(2)?)),
)?;

// Build OR query for multiple terms
let search_query = terms.join(" OR ");
```

### 3. Colored CLI Output

```rust
use colored::*;

println!("{}", "Header".bright_blue().bold());
println!("{}", "Success".green());
println!("{}", "Warning".yellow());
println!("{}", "Error".red());
println!("{}", "Dimmed text".dimmed());
println!("{}", format!("[DEBUG] {}", msg).cyan());
```

### 4. Relative Timestamps

```rust
fn format_timestamp(ts: i64) -> String {
    use std::time::{SystemTime, UNIX_EPOCH};

    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs() as i64;

    let diff = now - ts;

    if diff < 60 { "just now".to_string() }
    else if diff < 3600 { format!("{}m ago", diff / 60) }
    else if diff < 86400 { format!("{}h ago", diff / 3600) }
    else { format!("{}d ago", diff / 86400) }
}
```

### 5. Working Directory Considerations

```rust
// Database path is relative to where CLI is run
let db_path = "data/sqlite.db";

// Run from project root, not cli-rust/
// cd project-root && ./cli-rust/target/debug/rag history
```

## Anti-Patterns

```rust
// BAD: Hardcoded absolute paths
let db_path = "/Users/nat/.../data/sqlite.db";

// GOOD: Relative paths from execution directory
let db_path = "data/sqlite.db";

// BAD: Panicking on missing database
let conn = Connection::open(db_path).unwrap();

// GOOD: Return error with context
let conn = Connection::open(db_path)?;
```

## Directory Structure

```
cli-rust/
├── Cargo.toml
├── Cargo.lock
└── src/
    ├── main.rs        # CLI entry + Commands enum
    ├── commands/
    │   ├── mod.rs     # pub mod declarations
    │   ├── history.rs
    │   ├── similar.rs
    │   └── ...
    ├── loaders/
    └── types.rs
```

## Commands Implemented

| Command | Purpose | Key Options |
|---------|---------|-------------|
| history | Show search history | --popular, --clear, --limit |
| similar | Find similar docs | --json, --limit |
| search | Hybrid FTS5+vector | --mode, --limit |
| stats | Database stats | --format |
| explain | Analyze files | --format |
| index | Index documents | --dry-run, --batch-size |

---

*Rust CLI: Clap for args, rusqlite for FTS5, colored for output*
