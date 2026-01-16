#!/usr/bin/env python3
"""
Build Your Oracle - Database Initialization
Run this first to set up your Oracle database.
"""

import sqlite3
from pathlib import Path

DB_PATH = "oracle.db"
SCHEMA_PATH = Path(__file__).parent / "schema.sql"

def init_db():
    """Initialize the Oracle database with schema."""
    print("Initializing Oracle database...")

    # Read schema
    with open(SCHEMA_PATH) as f:
        schema = f.read()

    # Create database
    conn = sqlite3.connect(DB_PATH)
    conn.executescript(schema)
    conn.commit()
    conn.close()

    print(f"Database created: {DB_PATH}")
    print("Ready to use: python oracle.py search 'test'")

if __name__ == "__main__":
    init_db()
