-- Build Your Oracle - Database Schema
-- Day 1: Basic storage + FTS5

-- Main observations table
CREATE TABLE IF NOT EXISTS observations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT NOT NULL,
    type TEXT DEFAULT 'observation',  -- 'learning', 'retro', 'log', 'observation'
    source_file TEXT,
    concepts TEXT,  -- JSON array of concepts (Day 3)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Full-text search index
CREATE VIRTUAL TABLE IF NOT EXISTS observations_fts
USING fts5(
    content,
    source_file,
    content=observations,
    content_rowid=id
);

-- Triggers to keep FTS in sync
CREATE TRIGGER IF NOT EXISTS observations_ai AFTER INSERT ON observations BEGIN
    INSERT INTO observations_fts(rowid, content, source_file)
    VALUES (new.id, new.content, new.source_file);
END;

CREATE TRIGGER IF NOT EXISTS observations_ad AFTER DELETE ON observations BEGIN
    INSERT INTO observations_fts(observations_fts, rowid, content, source_file)
    VALUES('delete', old.id, old.content, old.source_file);
END;

CREATE TRIGGER IF NOT EXISTS observations_au AFTER UPDATE ON observations BEGIN
    INSERT INTO observations_fts(observations_fts, rowid, content, source_file)
    VALUES('delete', old.id, old.content, old.source_file);
    INSERT INTO observations_fts(rowid, content, source_file)
    VALUES (new.id, new.content, new.source_file);
END;

-- Day 3: Concepts table for pattern recognition
CREATE TABLE IF NOT EXISTS concepts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    observation_id INTEGER NOT NULL,
    concept TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (observation_id) REFERENCES observations(id)
);

-- Index for concept lookups
CREATE INDEX IF NOT EXISTS idx_concepts_concept ON concepts(concept);
CREATE INDEX IF NOT EXISTS idx_concepts_observation ON concepts(observation_id);

-- Useful views
CREATE VIEW IF NOT EXISTS learnings AS
    SELECT * FROM observations WHERE type = 'learning';

CREATE VIEW IF NOT EXISTS retrospectives AS
    SELECT * FROM observations WHERE type = 'retro';

-- Example queries:
--
-- Search (FTS5):
-- SELECT * FROM observations_fts WHERE observations_fts MATCH 'context-finder';
--
-- Find by concept:
-- SELECT o.* FROM observations o
-- JOIN concepts c ON o.id = c.observation_id
-- WHERE c.concept = 'git-safety';
--
-- Pattern discovery (co-occurring concepts):
-- SELECT c1.concept, c2.concept, COUNT(*) as co_occurrences
-- FROM concepts c1
-- JOIN concepts c2 ON c1.observation_id = c2.observation_id AND c1.concept < c2.concept
-- GROUP BY c1.concept, c2.concept
-- HAVING COUNT(*) > 2
-- ORDER BY co_occurrences DESC;
