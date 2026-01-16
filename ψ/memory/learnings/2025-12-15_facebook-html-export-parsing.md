# Facebook HTML Export Parsing (December 2025 Format)

**Date**: 2025-12-15
**Tags**: #facebook #parsing #duckdb #html #beautifulsoup

---

## Problem

Facebook data exports use obfuscated CSS class names and inconsistent HTML structures. First parsing attempt failed because assumed `<div>` but actual structure uses `<section>`.

## Solution: Facebook December 2025 HTML Structure

### Friends (section-based)
```html
<section class="_a6-g">
  <h2 class="_a6-h _a6-i">Friend Name</h2>
  <footer class="_3-94 _a6-o">
    <div class="_a72d">Dec 12, 2025 9:27:43 pm</div>
  </footer>
</section>
```

### Searches (section-based)
```html
<section class="_a6-g">
  <h2>You searched Facebook</h2>
  <div class="_a6-p">
    <div><div><div><div>"search query"</div></div></div></div>
  </div>
  <footer class="_a6-o">
    <div class="_a72d">Dec 20, 2024 12:00:39 pm</div>
  </footer>
</section>
```

### Key CSS Classes

| Class | Purpose |
|-------|---------|
| `_a6-g` | Container (section or div) |
| `_a6-h` | Title/name (bold) |
| `_a6-p` | Content text |
| `_a6-o` | Footer/metadata |
| `_a72d` | Timestamp |
| `_a6-i` | Border bottom |

### BeautifulSoup Patterns

```python
# Friends - use section, h2 for name
for section in soup.find_all('section', class_='_a6-g'):
    h2 = section.find('h2')
    date_div = section.find('div', class_='_a72d')
    name = h2.get_text(strip=True) if h2 else ""

# Searches - nested divs for query
query_div = section.find('div', class_='_a6-p')
inner_divs = query_div.find_all('div')
query = inner_divs[-1].get_text(strip=True)  # deepest div

# Generic pattern - try both section and div
for item in soup.find_all(['section', 'div'], class_='_a6-g'):
    ...
```

## DuckDB vs PostgreSQL

| Feature | PostgreSQL | DuckDB |
|---------|------------|--------|
| Case-insensitive regex | `~*` | Not supported |
| Pattern matching | `SIMILAR TO` | `ILIKE` |
| Regex | `~` | `regexp_matches()` |

```sql
-- PostgreSQL
WHERE content ~* 'AI|Claude'

-- DuckDB
WHERE content ILIKE '%AI%' OR content ILIKE '%Claude%'
```

## Quick uv Setup for Data Projects

```toml
# pyproject.toml
[project]
name = "fb-explorer"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = [
    "duckdb>=1.1.0",
    "beautifulsoup4>=4.12.0",
    "streamlit>=1.40.0",
    "pandas>=2.0.0",
]
```

```bash
uv sync        # Install deps
uv run python script.py  # Run with deps
```

---

## Why This Matters

1. **Facebook exports change** - Class names are minified, structure varies by data type
2. **Always inspect first** - `head -100 file.html` before writing parser
3. **DuckDB is not PostgreSQL** - Syntax differences trip you up
4. **uv simplifies Python** - No more venv/pip dance

---

*Discovered while building fb-explorer toolkit*
*Root cause: Assumed div structure, actual was section*
