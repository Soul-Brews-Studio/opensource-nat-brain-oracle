# Dagster Pipeline Implementation Pattern

**Date**: 2026-01-02
**Project**: the-headline-mono
**Context**: Converted simple Python fetch script to Dagster-orchestrated pipeline

---

## What is Dagster?

Dagster is a **data orchestration platform** that transforms scripts into observable, testable, and maintainable pipelines.

### Key Concepts

| Concept | Description |
|---------|-------------|
| **Asset** | A data product (table, file, model) - the fundamental unit |
| **Resource** | Shared infrastructure (database connections, APIs) |
| **Definitions** | Entry point that registers all assets and resources |
| **Materialization** | The act of computing/updating an asset |

---

## Pattern: Script to Dagster Conversion

### Before (Simple Script)
```python
def main():
    fetch_apis()
    transform_data()
    save_to_db()
```

### After (Dagster Assets)
```python
@asset(group_name="extract")
def raw_api_data() -> dict:
    return fetch_apis()

@asset(group_name="transform", deps=[raw_api_data])
def messages_table(raw_api_data: dict) -> MaterializeResult:
    return transform_and_save(raw_api_data)

@asset(group_name="report", deps=[messages_table])
def fetch_summary() -> dict:
    return generate_report()
```

### Key Differences

| Aspect | Script | Dagster |
|--------|--------|---------|
| Dependencies | Implicit | Explicit via `deps=[]` |
| State | Lost between runs | Tracked via materialization |
| Observability | Print statements | Web UI + metadata |
| Testing | Manual | Built-in asset tests |
| Scheduling | Cron external | Native schedules |

---

## Implementation Steps

1. **Create project structure**
   ```
   pipeline/
   ├── pyproject.toml          # Dependencies
   ├── headline_pipeline/
   │   ├── __init__.py         # Definitions entry
   │   ├── assets.py           # Asset definitions
   │   └── resources.py        # Database resource
   ```

2. **Define resources** (database connections)
   ```python
   class DuckDBResource(ConfigurableResource):
       db_path: str = "data/headlines.db"

       @contextmanager
       def get_connection(self):
           conn = duckdb.connect(self.db_path)
           yield conn
           conn.close()
   ```

3. **Define assets** with dependencies
   ```python
   @asset(group_name="extract")
   def raw_api_data(context: AssetExecutionContext) -> dict:
       # Fetch from APIs
       return data

   @asset(deps=[raw_api_data])
   def messages_table(duckdb: DuckDBResource, raw_api_data: dict):
       # Transform and store
       return MaterializeResult(metadata={...})
   ```

4. **Register in Definitions**
   ```python
   defs = Definitions(
       assets=load_assets_from_modules([assets]),
       resources={"duckdb": DuckDBResource()}
   )
   ```

---

## DuckDB vs SQLite Decision

| Factor | DuckDB | SQLite |
|--------|--------|--------|
| **Storage** | Columnar (OLAP) | Row-based (OLTP) |
| **Best for** | Analytics, aggregations | Transactions, point lookups |
| **`SELECT AVG() GROUP BY`** | 12-35x faster | Baseline |
| **`SELECT * WHERE id=X`** | Slower | 10-20% faster |
| **Compression** | Automatic | Manual |
| **Python/Pandas** | Native integration | Works |

**Decision**: DuckDB for HEADLINE because it's analytics-heavy (dashboard queries, aggregations by source/date).

---

## Gotchas Encountered

### 1. DuckDB has no auto-increment
```python
# WRONG - causes NOT NULL error
CREATE TABLE logs (id INTEGER PRIMARY KEY, ...)

# RIGHT - omit id or use SEQUENCE
CREATE TABLE logs (api VARCHAR, fetched_count INTEGER, ...)
```

### 2. API field names vary
```python
# Different APIs use different field names
content = r.get("text", "") or r.get("message", "") or r.get("content", "")
```

### 3. pyproject.toml needs README
```toml
[project]
readme = "README.md"  # Required by hatchling
```

---

## Commands

```bash
# Install dependencies
cd pipeline && uv sync

# Run pipeline once (materialize all assets)
uv run dagster asset materialize --select "*" -m headline_pipeline

# Start web UI
uv run dagster dev -m headline_pipeline -p 3333
```

---

## Results

- **1,293 records** stored in DuckDB
- **7 API sources** fetched in parallel
- **3 asset groups**: extract, transform, report
- **Web UI** at localhost:3333 for monitoring

---

## When to Use Dagster

| Use Dagster When | Don't Use When |
|------------------|----------------|
| Multiple data sources | Single simple script |
| Need observability | One-off task |
| Team collaboration | Solo quick hack |
| Scheduling required | Manual triggers only |
| Data lineage matters | Simple ETL |

---

## Sources

- [Dagster Docs](https://docs.dagster.io/)
- [DuckDB vs SQLite](https://motherduck.com/learn-more/duckdb-vs-sqlite-databases/)
- [Dagster GitHub](https://github.com/dagster-io/dagster)
