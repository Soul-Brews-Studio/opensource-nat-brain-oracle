# Dev Browser UI Testing Patterns

**Date**: 2026-01-01
**Context**: UI/UX verification of Data-Aware RAG v2 using Playwright-based dev-browser skill
**Impact**: Reliable automated UI testing patterns for future projects

## What We Tested

| Component | Method | Result |
|-----------|--------|--------|
| Dashboard stats | ARIA snapshot | 42,145 docs verified |
| Explorer pagination | ARIA snapshot | 250 pages, clickable rows |
| Explorer modal | Click + snapshot | Full path with file:// link |
| Charts rendering | Screenshot | 4 charts (bar, doughnut, line, horizontal) |
| Search with debug | Fill + click + snapshot | Pipeline logs visible |
| Search modal | Click result | Score, source, metadata shown |
| URL persistence | Navigate + refresh | Hash routing works |
| About page | Navigate + snapshot | Documentation renders |

## Key Patterns Learned

### 1. ARIA Snapshots for Element Discovery

```typescript
const snapshot = await client.getAISnapshot("page-name");
// Returns YAML with refs like [ref=e39]
// Use refs to interact: client.selectSnapshotRef("page-name", "e39")
```

Better than CSS selectors for dynamic React apps.

### 2. Chart.js Click Events Don't Work in Playwright

Chart.js canvas onClick handlers don't trigger from Playwright mouse clicks. The click coordinates hit the canvas but Chart.js internal hit detection doesn't fire.

**Workaround**: Verify charts render via screenshot, test click behavior manually.

### 3. Modal Detection via Error Messages

When Playwright says `<div class="modal-overlay"> intercepts pointer events`, the modal IS open! This error confirms the modal appeared.

### 4. Wait Times for Chart Rendering

```typescript
await page.waitForTimeout(2000); // Charts need time to render
await page.waitForTimeout(500);  // Modals need less time
```

Chart.js animations need 1.5-2 seconds to complete.

### 5. Screenshot Strategy

| Screenshot | When |
|------------|------|
| After navigation | Verify page loaded |
| After interaction | Verify state changed |
| On error | Debug what went wrong |
| Full page | Capture everything |

## Testing Workflow

```bash
# 1. Start server (runs in background)
cd ~/.claude/skills/dev-browser && ./server.sh &

# 2. Run test script
cd ~/.claude/skills/dev-browser && npx tsx <<'EOF'
import { connect, waitForPageLoad } from "@/client.js";
const client = await connect();
const page = await client.page("unique-name");
await page.setViewportSize({ width: 1400, height: 900 });

// Navigate and wait
await page.goto("http://localhost:PORT/#route");
await waitForPageLoad(page);
await page.waitForTimeout(500);

// Capture state
await page.screenshot({ path: "tmp/screenshot.png" });
const snapshot = await client.getAISnapshot("unique-name");

// Interact
const element = await client.selectSnapshotRef("unique-name", "e39");
await element.click();

await client.disconnect();
EOF
```

## Files Verified

```
ψ/lab/data-aware-rag/frontend/src/
├── App.tsx              # URL hash persistence ✅
├── components/
│   ├── Dashboard.tsx    # Stats + search ✅
│   ├── Explorer.tsx     # Table + modal + file links ✅
│   ├── Charts.tsx       # 4 charts + drilldown ✅
│   ├── SearchResults.tsx # Modal + file links ✅
│   └── About.tsx        # Documentation ✅
└── index.css            # Styles ✅
```

## Lessons for Future UI Testing

1. **Use ARIA snapshots** - More reliable than DOM selectors
2. **Screenshot everything** - Visual verification catches layout issues
3. **Expect Canvas limitations** - Chart.js/D3 clicks may not work
4. **Check error messages** - "intercepts pointer" = modal is open
5. **Unique page names** - Avoid state pollution between tests
