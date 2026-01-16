---
type: image
target: antigravity
status: pending
created: 2025-12-23
category: workflow-patterns
file_number: 282
---

# GHQ Organization Map

## Thai Text
แผนที่ GHQ: โครงสร้างที่องค์กร

(Map: Organized Structure)

## Prompt
```
Architectural map of GHQ directory structure rendered as a bird's-eye view city planning map
or traditional East Asian garden layout. Monochrome ink with golden pathways and cyan
wayfinding markers. Suggests order emerging from organic arrangement.

THE OVERALL LAYOUT:
Circular or asymmetrically balanced composition suggesting harmony and balance. Think
Forbidden City or Japanese karesansui garden layout.

CENTRAL HUB (centermost):
Large golden circle representing the GHQ root directory. Radiating from center: 8 major
pathways (compass directions + diagonals) extending toward outer regions. Each pathway
marked with golden lines showing primary organization axis.

PRIMARY ZONES (arranged around center):
Each zone is a distinct territory rendered with ink wash creating subtle boundaries.
No harsh borders, but clear visual separation through ink density and wayfinding markers.

ZONE 1 (North): "LOCAL PROJECTS"
- Contains nested rectangular blocks showing local project repositories
- Organized in loose grid pattern suggesting active development
- Cyan highlights on currently "checked out" projects
- Golden stars marking favorite/frequently accessed projects
- File count notation in corner of each block

ZONE 2 (Northeast): "LEARNING REPOS"
- Slightly faded ink wash suggesting secondary priority
- Organized in loose chronological layers (recent on top)
- Cyan date markers showing when each was cloned
- Note: "Read-only" notation to suggest reference status

ZONE 3 (East): "VENDOR LIBRARIES"
- Organized by source domain (github.com, gitlab.com, etc)
- Golden separators marking different sources
- Compressed blocks showing many repos in small space
- Notation: "Auto-managed" suggesting automated curation

ZONE 4-8: Other zones including archived, templates, forks, starred, etc.
Each zone visually unique but harmoniously arranged.

CONNECTING INFRASTRUCTURE:
- Fine black lines show symlink bridges between zones (representing convenience links)
- Cyan veins running through entire structure showing "data flow" (git sync, updates)
- Golden dots marking cache locations and index points for quick access

WAYFINDING ELEMENTS:
- Compass rose in upper-left corner (traditional map marker) showing organization direction
- Distance markers between zones in fine text (path length, disk usage)
- Legend boxes showing density coding (more dots = more repos in that area)
- Scale indicator showing relative directory sizes

TEMPORAL LAYER (overlaid faintly):
- Calendar months marked around perimeter showing seasonal organization
- Activity heat map showing which zones were modified recently (golden highlights)
- "Trending" arrow showing growth direction of workspace organization

INFRASTRUCTURE SERVICES (shown as small buildings/structures around edges):
- .git cache (shown as vault)
- Index file (shown as library)
- Config files (shown as control tower)
- Hooks (shown as watchtowers)

DETAIL INSETS (corners):
- Upper-left: Filesystem tree visualization showing actual directory nesting
- Lower-right: Domain organization showing how projects cluster by source (github/gitlab/etc)
- Lower-left: Activity timeline showing recent modifications
- Upper-right: Storage statistics (GB used per zone)

ANOMALIES/SPECIAL MARKERS:
- Broken symlinks shown as faded/dashed lines with warning symbols
- Duplicate repositories marked with red flag symbols
- Orphaned directories marked with fading into whitespace

ORACLE PHILOSOPHY NOTE (bottom corner):
"GHQ is organized geography, not arbitrary taxonomy" showing intentionality of structure

OVERALL STYLE: Combines topographic map (contour lines suggesting filesystem hierarchy)
with garden layout (suggesting harmony and intentional design). Monochrome ink provides
calm, readable structure. Golden accent lines show primary traffic and organization logic.
Cyan wayfinding guides the eye. Heavy use of whitespace for breathing room and clarity.
Ink wash used to suggest zones without hard boundaries, suggesting flexibility and growth.
--ar 16:9
Font: Use open source Thai fonts ONLY (Noto Sans Thai, Prompt, Kanit, Sarabun)
```

## Expected Output
- Format: PNG
- Save: results/282-ghq-organization.png
