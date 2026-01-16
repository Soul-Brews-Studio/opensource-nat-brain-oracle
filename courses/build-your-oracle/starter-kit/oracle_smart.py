#!/usr/bin/env python3
"""
Build Your Oracle - Day 3: Intelligence
Adds vector search, consult, reflect, learn, supersede commands.

Requires: pip install chromadb anthropic
"""

import click
import sqlite3
from pathlib import Path
from datetime import datetime

# Optional: Vector search with ChromaDB
try:
    import chromadb
    VECTORS_AVAILABLE = True
except ImportError:
    VECTORS_AVAILABLE = False
    print("ChromaDB not installed. Run: pip install chromadb")

# Optional: AI synthesis with Anthropic
try:
    import anthropic
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False

DB_PATH = "oracle.db"

def get_db():
    return sqlite3.connect(DB_PATH)

def get_collection():
    """Get or create ChromaDB collection."""
    if not VECTORS_AVAILABLE:
        return None
    client = chromadb.Client()
    return client.get_or_create_collection("oracle")

@click.group()
def cli():
    """Oracle Smart - AI Knowledge System with Intelligence"""
    pass

@cli.command()
@click.argument('query')
def search(query):
    """Hybrid search: keywords + vectors."""
    print(f"Hybrid search for: {query}\n")

    # Phase 1: FTS5 keyword search
    conn = get_db()
    keyword_results = conn.execute("""
        SELECT o.id, o.content, o.source_file
        FROM observations_fts fts
        JOIN observations o ON fts.rowid = o.id
        WHERE observations_fts MATCH ?
        LIMIT 20
    """, [query]).fetchall()
    print(f"Keyword matches: {len(keyword_results)}")

    # Phase 2: Vector search (if available)
    collection = get_collection()
    if collection and collection.count() > 0:
        vector_results = collection.query(
            query_texts=[query],
            n_results=10
        )
        print(f"Semantic matches: {len(vector_results['ids'][0])}")

    # Show results
    print("\nTop results:")
    for id, content, source in keyword_results[:5]:
        preview = content[:150] + "..." if len(content) > 150 else content
        print(f"  [{id}] {source or 'direct'}")
        print(f"      {preview}\n")

    conn.close()

@cli.command()
@click.argument('question')
def consult(question):
    """Get advice based on your knowledge."""
    print(f"Consulting Oracle about: {question}\n")

    # Find relevant knowledge
    conn = get_db()
    results = conn.execute("""
        SELECT content FROM observations_fts
        WHERE observations_fts MATCH ?
        LIMIT 5
    """, [question]).fetchall()

    if not results:
        print("No relevant knowledge found.")
        return

    context = "\n---\n".join([r[0][:500] for r in results])

    if AI_AVAILABLE:
        # Use Claude to synthesize
        client = anthropic.Anthropic()
        response = client.messages.create(
            model="claude-3-haiku-20240307",
            max_tokens=500,
            messages=[{
                "role": "user",
                "content": f"""Based on this knowledge, advise on: {question}

Knowledge:
{context}

Provide concise, actionable advice."""
            }]
        )
        print("Oracle says:")
        print(response.content[0].text)
    else:
        print("Relevant knowledge found:")
        for r in results:
            print(f"  - {r[0][:200]}...")
        print("\n(Install anthropic for AI synthesis: pip install anthropic)")

    conn.close()

@cli.command()
def reflect():
    """Get random wisdom from your knowledge."""
    conn = get_db()
    result = conn.execute("""
        SELECT content, source_file, created_at
        FROM observations
        WHERE type = 'learning'
        ORDER BY RANDOM()
        LIMIT 1
    """).fetchone()

    if result:
        content, source, created = result
        print("Today's reflection:\n")
        print(f"  {content}")
        print(f"\n  — from {source or 'direct input'} ({created[:10]})")
    else:
        print("No learnings yet. Add some with: oracle_smart.py learn 'pattern'")

    conn.close()

@cli.command()
@click.argument('pattern')
def learn(pattern):
    """Add a new learning to Oracle."""
    conn = get_db()

    # Store in SQLite
    conn.execute("""
        INSERT INTO observations (content, type)
        VALUES (?, 'learning')
    """, [pattern])
    conn.commit()

    # Index in vectors (if available)
    collection = get_collection()
    if collection:
        doc_id = f"learning_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        collection.add(
            documents=[pattern],
            ids=[doc_id]
        )
        print(f"Learned (with vectors): {pattern[:50]}...")
    else:
        print(f"Learned: {pattern[:50]}...")

    conn.close()

@cli.command()
@click.argument('old_id')
@click.argument('new_id')
@click.option('--reason', '-r', default='Updated understanding')
def supersede(old_id, new_id, reason):
    """Mark old knowledge as superseded by new.

    Philosophy: "Nothing is Deleted" - old stays, but marked outdated.
    """
    conn = get_db()

    # Check if superseded_by column exists
    try:
        conn.execute("""
            UPDATE observations
            SET superseded_by = ?, supersede_reason = ?
            WHERE id = ?
        """, [new_id, reason, old_id])
        conn.commit()
        print(f"Superseded: {old_id} -> {new_id}")
        print(f"Reason: {reason}")
    except sqlite3.OperationalError:
        print("Note: Run schema migration to add supersede columns")
        print("ALTER TABLE observations ADD COLUMN superseded_by TEXT;")
        print("ALTER TABLE observations ADD COLUMN supersede_reason TEXT;")

    conn.close()

@cli.command()
def stats():
    """Show Oracle statistics."""
    conn = get_db()

    total = conn.execute("SELECT COUNT(*) FROM observations").fetchone()[0]
    by_type = conn.execute("""
        SELECT type, COUNT(*) FROM observations GROUP BY type
    """).fetchall()

    print(f"Total observations: {total}\n")
    print("By type:")
    for t, count in by_type:
        print(f"  {t}: {count}")

    # Vector stats
    collection = get_collection()
    if collection:
        print(f"\nVector index: {collection.count()} documents")

    conn.close()

if __name__ == "__main__":
    cli()
