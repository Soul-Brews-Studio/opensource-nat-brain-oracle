---
type: image
target: antigravity
status: pending
created: 2025-12-23
category: workflow-patterns
file_number: 276
---

# Command Inheritance Tree

## Thai Text
ต้นไม้สืบทอด: Project → User → Plugin

(Inheritance Tree: Project → User → Plugin)

## Prompt
```
Inverted tree diagram (roots at top, branches flowing downward) showing command inheritance
hierarchy. Monochrome ink with cyan and golden accents on inheritance relationships.

ROOT NODE (top center): "PROJECT" shown as large black circle with bold ink border.
Golden rays emanate outward. This is the highest-level command scope.

SECOND LEVEL (branches downward): Two major branches:
- LEFT BRANCH: "USER SCOPE" shown as slightly smaller circle with finer ink lines
- RIGHT BRANCH: "SYSTEM SCOPE" shown as similar-sized circle

THIRD LEVEL (further down): Multiple "PLUGIN" nodes shown as smaller circles, each
connected to parent scopes via golden inheritance lines. Cyan halos around plugin
nodes show "active context."

FOURTH LEVEL (leaves): Individual command definitions shown as small rectangles branching
from plugin nodes. Commands with ink hatching show those inherited from parents,
solid black shows those overridden locally.

VISUAL HIERARCHY:
- Solid black ink = immutable core commands
- Finer lines = overrideable commands
- Cyan highlight = currently active scope
- Golden lines = inheritance paths
- Dashed lines = conditional/conditional execution paths

LEFT MARGIN: Small legend showing:
  ● Project-level command
  ● User-level command
  ● Plugin command
  ├─ Inherited
  └─ Overridden

CONNECTIONS: Show parameter flow from parent to child scopes using fine golden threads.

Style: Botanical tree structure meets technical inheritance diagram. Organic branching
with precise geometric nodes. Heavy contrast between active (filled) and inactive (outline)
elements. Generous whitespace showing scope separation.
--ar 16:9
Font: Use open source Thai fonts ONLY (Noto Sans Thai, Prompt, Kanit, Sarabun)
```

## Expected Output
- Format: PNG
- Save: results/276-command-inheritance.png
