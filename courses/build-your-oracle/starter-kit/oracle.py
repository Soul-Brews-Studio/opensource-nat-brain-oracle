#!/usr/bin/env python3
"""
Build Your Oracle - CLI Tool
Day 1-2: Memory + Context-Finder
"""

import click
import sqlite3
import os
from pathlib import Path
from datetime import datetime

DB_PATH = "oracle.db"

def get_db():
    """Get database connection."""
    return sqlite3.connect(DB_PATH)

def init_db():
    """Initialize database with schema."""
    schema_path = Path(__file__).parent / "schema.sql"
    with open(schema_path) as f:
        schema = f.read()

    conn = get_db()
    conn.executescript(schema)
    conn.commit()
    conn.close()
    print("Database initialized.")

@click.group()
def cli():
    """Oracle - Your AI Knowledge System"""
    pass

@cli.command()
def init():
    """Initialize the Oracle database."""
    init_db()

@cli.command()
@click.argument('query')
def search(query):
    """Search your knowledge base."""
    conn = get_db()
    cursor = conn.execute("""
        SELECT o.id, o.content, o.source_file, o.created_at
        FROM observations_fts fts
        JOIN observations o ON fts.rowid = o.id
        WHERE observations_fts MATCH ?
        ORDER BY rank
        LIMIT 10
    """, [query])

    results = cursor.fetchall()

    if not results:
        print(f"No results for: {query}")
        return

    print(f"Found {len(results)} results:\n")
    for id, content, source, created in results:
        print(f"[{id}] {source or 'direct'} ({created[:10]})")
        # Show first 200 chars
        preview = content[:200] + "..." if len(content) > 200 else content
        print(f"    {preview}\n")

    conn.close()

@cli.command()
@click.argument('content')
@click.option('--type', '-t', default='observation', help='Type: learning, retro, log')
def add(content, type):
    """Add a new observation."""
    conn = get_db()
    conn.execute("""
        INSERT INTO observations (content, type)
        VALUES (?, ?)
    """, [content, type])
    conn.commit()
    conn.close()
    print(f"Added {type}: {content[:50]}...")

@cli.command()
@click.argument('path')
def index(path):
    """Index markdown files from a directory."""
    path = Path(path)

    if not path.exists():
        print(f"Path not found: {path}")
        return

    conn = get_db()
    count = 0

    for md_file in path.rglob("*.md"):
        content = md_file.read_text()

        # Check if already indexed
        existing = conn.execute(
            "SELECT id FROM observations WHERE source_file = ?",
            [str(md_file)]
        ).fetchone()

        if existing:
            # Update
            conn.execute("""
                UPDATE observations
                SET content = ?, updated_at = CURRENT_TIMESTAMP
                WHERE source_file = ?
            """, [content, str(md_file)])
        else:
            # Insert
            conn.execute("""
                INSERT INTO observations (content, source_file, type)
                VALUES (?, ?, 'indexed')
            """, [content, str(md_file)])

        count += 1

    conn.commit()
    conn.close()
    print(f"Indexed {count} files from {path}")

@cli.command()
def stats():
    """Show database statistics."""
    conn = get_db()

    total = conn.execute("SELECT COUNT(*) FROM observations").fetchone()[0]
    by_type = conn.execute("""
        SELECT type, COUNT(*) FROM observations GROUP BY type
    """).fetchall()

    print(f"Total observations: {total}\n")
    print("By type:")
    for type, count in by_type:
        print(f"  {type}: {count}")

    conn.close()

# Day 2: Context-finder pattern (placeholder)
@cli.command()
@click.argument('query')
def smart_search(query):
    """Search with context-finder pattern (Day 2)."""
    print("Context-finder search:")
    print("1. FTS5 finds candidates...")

    # Phase 1: FTS5
    conn = get_db()
    candidates = conn.execute("""
        SELECT o.id, o.content, o.source_file
        FROM observations_fts fts
        JOIN observations o ON fts.rowid = o.id
        WHERE observations_fts MATCH ?
        LIMIT 50
    """, [query]).fetchall()

    print(f"   Found {len(candidates)} candidates")

    # Phase 2: Would use Haiku here
    print("2. Haiku would summarize candidates...")
    print("   (Implement with your API key)")

    # Phase 3: Would use Opus here
    print("3. Opus would analyze top results...")
    print("   (Implement with your API key)")

    # For now, just show candidates
    print(f"\nCandidate files:")
    for id, content, source in candidates[:10]:
        print(f"  - {source or f'observation {id}'}")

    conn.close()

if __name__ == "__main__":
    cli()
