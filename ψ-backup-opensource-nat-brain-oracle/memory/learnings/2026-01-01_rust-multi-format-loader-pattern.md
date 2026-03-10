---
date: 2026-01-01
tags: [rust, loader, yaml, json, pattern, extensible]
context: Data-Aware RAG - Adding YAML loader to Rust CLI
---

# Rust Multi-Format Loader Pattern

## The Pattern

Create extensible file loaders with consistent interface.

### 1. Define SourceType Enum

```rust
pub enum SourceType {
    Json,
    Csv,
    Markdown,
    Text,
    Yaml,
    Unknown,
}

impl SourceType {
    pub fn from_extension(ext: &str) -> Self {
        match ext.to_lowercase().as_str() {
            "json" => SourceType::Json,
            "yaml" | "yml" => SourceType::Yaml,
            // ...
            _ => SourceType::Unknown,
        }
    }
}
```

### 2. Consistent Loader Interface

Each loader has the same signature:

```rust
pub async fn load(path: &Path, debug: bool) -> Result<Vec<RawRecord>>
```

### 3. Dispatcher in mod.rs

```rust
match source_type {
    SourceType::Json => json::load(path, debug).await,
    SourceType::Yaml => yaml::load(path, debug).await,
    // ...
    SourceType::Unknown => Ok(vec![]),
}
```

### 4. Adding a New Format

1. Add variant to `SourceType` enum
2. Update `from_extension()` matcher
3. Create `loaders/newformat.rs` with `load()` function
4. Add `pub mod newformat;` to mod.rs
5. Add match arm in dispatcher

## Key Principles

| Principle | Implementation |
|-----------|----------------|
| Single signature | All loaders return `Result<Vec<RawRecord>>` |
| Extension mapping | `from_extension()` centralizes format detection |
| Debug support | Every loader accepts `debug: bool` |
| Graceful skip | Unknown formats return empty vec |

## Example: YAML Loader

```rust
pub async fn load(path: &Path, debug: bool) -> Result<Vec<RawRecord>> {
    let content = tokio::fs::read_to_string(path).await?;
    let data: serde_json::Value = serde_yaml::from_str(&content)?;
    // Parse to RawRecord...
}
```

Note: Parse YAML to `serde_json::Value` for consistency with other loaders.

## Key Learning

> "When building multi-format support, define a consistent interface first. Each new format becomes a simple module that implements that interface. The dispatcher stays simple - just add one match arm per format."
