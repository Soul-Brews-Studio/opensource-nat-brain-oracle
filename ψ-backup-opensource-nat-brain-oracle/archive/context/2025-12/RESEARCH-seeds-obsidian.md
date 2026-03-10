# Research: Seeds + Obsidian Compatibility

## 1. SEEDS ANALYSIS

### Key Findings

**Total Files with "Seeds Planted"**: 28 retrospectives

**Seeds by Type** (from recent structure):
- Incremental: ~35-40 seeds
- Transformative: ~15-20 seeds  
- Moonshot: ~10-15 seeds
- Total estimated: **60-75 unique seeds** across all retrospectives

### Most Common Seed Categories

From pattern analysis:

1. **Agent/Tool Extensions** (12-15 seeds)
   - Repository publishing
   - Plugin marketplace
   - Tool integration patterns
   - Performance optimizations

2. **Knowledge Infrastructure** (10-12 seeds)
   - Learning system improvements
   - Documentation patterns
   - Context management
   - Cross-project knowledge graphs

3. **Personal Productivity** (8-10 seeds)
   - Energy tracking (90/10 system)
   - Brewing schedule integration
   - Session optimization
   - Context overload mitigation

4. **Project-Specific** (8-10 seeds)
   - Headline/API integration
   - Cellar local brain
   - Multi-device sync
   - LINE Messaging API

5. **Workshop/Teaching** (5-7 seeds)
   - Philosophy framework
   - Oracle adoption
   - Coaching content

### Patterns Observed

**Frequency of Seed Reappearance**:
- Cellar unified brain: appears in 4-5 retrospectives
- Oracle monitoring: appears in 3-4 retrospectives
- Agent SDK improvements: appears in 3+ retrospectives
- Learning system overhaul: appears in 2+ retrospectives

**Observation**: Some seeds are "resonant" (repeated across sessions) indicating strong priority

### Current Storage Issues

**Retrospectives structure**:
```
ψ/memory/retrospectives/
├── README.md (template)
├── 2025-12/
│   ├── 09/
│   ├── 10/
│   └── 11/
```

**Problems**:
1. Seeds scattered across 28 files
2. Difficult to search by seed category
3. Reappearing seeds hard to track
4. No "seed graduation" tracking (when incremental → transformative)
5. No urgency/timeline metadata

---

## 2. OBSIDIAN COMPATIBILITY ANALYSIS

### Current State

**Stats**:
- Total markdown files: 213
- Total lines: 43,736 (avg ~205 lines/file)
- Wiki links [[]] found: 0
- Frontmatter (---) sections: 1,813 (suggests some files have it)

### What Works for Obsidian

✅ **Strengths**:
1. **Clear hierarchical structure** - ψ/ 5-pillar matches Obsidian vault organization
2. **Existing metadata** - Many files have timestamps in filenames
3. **Markdown only** - Pure .md files, no binary dependencies
4. **Cross-file patterns** - Different files discuss same topics (link potential)

### What Doesn't Work

❌ **Compatibility Issues**:

1. **NO Wiki Links** - 0 [[]] references found
   - Current: Raw text references, inconsistent
   - Obsidian needs: [[filename]] for graph view
   - Migration effort: HIGH

2. **NO Consistent Frontmatter** - 1,813 dashes found but likely not YAML front matter
   - Current: Mixed formats, some files have ---at end
   - Obsidian needs: At top with date, tags, category
   - Migration effort: MEDIUM

3. **Naming inconsistency** 
   - Some files: ISO dates (2025-12-10_...)
   - Some files: Timestamps with periods (10.00-psi-5...)
   - Some files: Human names (oracle-begins.md)
   - Obsidian prefers: Consistent naming (with dashes, not dots/underscores)

4. **No Tags** (#tag format)
   - Current: Categories only in folder structure
   - Obsidian needs: Inline tags for cross-cutting concerns
   - Migration effort: MEDIUM

5. **No Backlinks** - Files don't reference each other
   - Example: Learning lab could link to related seeds
   - Example: Seeds could link back to implementing commits
   - Obsidian benefit: Graph visualization would show connections

### Files That Would Benefit Most

Priority for Obsidian migration:
1. **ψ/memory/retrospectives/** - Most valuable (high connectivity potential)
2. **ψ/memory/learnings/** - Good candidates for tags (#pattern, #mistake)
3. **ψ/inbox/handoff/** - Need clear metadata (date, next-person)
4. **ψ/lab/** - Project tracking (status tags, linked issues)

---

## 3. RECOMMENDED CHANGES FOR OBSIDIAN

### Phase 1: Quick Wins (No breaking changes)

1. **Add Frontmatter to retrospectives**
   ```yaml
   ---
   date: 2025-12-11
   session: "12.38_forward-mariekondo-later"
   duration: 1h 45m
   tags: [seeds-planted, marie-kondo, context]
   seeds: 3  # count
   ---
   ```

2. **Rename files consistently**
   - From: `10.00_plugin-oracle-workflow.md`
   - To: `2025-12-10-10-00-plugin-oracle-workflow.md` (ISO friendly)
   - Batch rename with script

3. **Add tags inline** (minimal change)
   ```markdown
   #agents #sdk-learning #experiment
   ```

### Phase 2: Structure Changes

1. **Create Seeds Index**
   ```
   ψ/memory/retrospectives/
   ├── seeds/  ← NEW
   │   ├── INDEX.md (all seeds)
   │   ├── incremental/
   │   ├── transformative/
   │   └── moonshot/
   ├── 2025-12/
   └── README.md
   ```

2. **Link retrospectives to seeds**
   ```markdown
   ## Seeds Planted
   - Incremental: [[seeds/incremental/cellar-hot-reload]]
   ```

3. **Add backlinks in learnings**
   ```markdown
   # Learning: Delegate Reading
   
   Related seeds:
   - [[seeds/incremental/knowledge-graph]]
   
   From retrospectives:
   - [[2025-12-11-psi-5-pillar]]
   ```

### Phase 3: Full Integration

1. **Create seeds/INDEX.md** with graph matrix:
   - Seed name | Category | Status | Last seen | Count

2. **Establish seed lifecycle**:
   ```yaml
   status: active | implemented | abandoned | evolved
   next-trigger: "when X happens"
   related-seeds: [seed-2, seed-5]
   implementing-commits: [abc123, def456]
   ```

3. **Link learnings → seeds → commits**
   - Learnings reference causing seeds
   - Seeds reference implementing commits
   - Obsidian graph shows the flow

---

## 4. OBSIDIAN SETUP (if adopted)

**Recommended Plugins**:
- **Dataview** - Query seeds by status, date, type
- **Breadcrumbs** - Show parent/child relationships
- **Calendar** - Visualize retrospectives by date
- **Templater** - Auto-generate retrospective template with metadata

**Vault Settings**:
- Strict line breaks: OFF (more readable)
- Fold heading: ON
- Fold indent: ON

**Theme**: Minimal or Sanctum (good markdown visibility)

---

## DECISION MATRIX

| Factor | Current State | Obsidian Benefit | Migration Cost | Priority |
|--------|---|---|---|---|
| Seeds organization | Scattered in 28 files | Unified index + graph | LOW | HIGH |
| Cross-linking | None | Full graph view | MEDIUM | MEDIUM |
| Frontmatter | Partial | Query-able metadata | LOW | HIGH |
| Tagging system | None | Cross-cutting insights | MEDIUM | MEDIUM |
| File naming | Inconsistent | Better findability | LOW | MEDIUM |
| Backlinks | None | Context exploration | MEDIUM | LOW |

---

## RECOMMENDATIONS

### Short Term (This Week)
1. Create `ψ/memory/retrospectives/seeds/INDEX.md`
2. Extract all 60-75 seeds into structured list
3. Add status tracking (active/implemented/waiting)
4. Note which seeds appear 3+ times (resonant = high priority)

### Medium Term (Next 2 weeks)
1. Add YAML frontmatter to all retrospectives
2. Standardize file naming (ISO date format)
3. Add inline tags (#pattern, #tool, #project)
4. Create cross-reference index

### Long Term (Next month)
1. Set up Obsidian with dataview queries
2. Build seeds/learnings/commits graph visualization
3. Establish seed lifecycle workflow
4. Integrate with GitHub issues (auto-link to related issues)

---

## Summary

**Seeds**: ~60-75 scattered seeds with 4-5 resonant patterns emerging
- **Recommendation**: Extract to separate index, add metadata
- **Effort**: 2-3 hours to audit + organize

**Obsidian**: Good structure but needs wiki links + frontmatter
- **Recommendation**: Phase 1 (quick wins) → Phase 2 (structure) → Phase 3 (full integration)
- **Effort**: Phase 1: 2 hours | Phase 2: 4 hours | Phase 3: 8 hours
