---
title: Web Scraping - Find API Before Browser Automation
tags: [scraping, api, browser, automation, performance, pattern]
created: 2026-01-08
source: ERC rooftop PV scraping session
---

# Web Scraping: Find API Before Browser Automation

## The Pattern

**Always check for AJAX/API endpoints before writing browser automation scripts.**

Browser scraping should be the last resort, not the first approach.

## Why It Matters

| Approach | Time | Complexity | Data |
|----------|------|------------|------|
| Browser pagination | ~150 sec | High (wait times, selectors) | Limited (HTML only) |
| Direct API call | ~16 sec | Low (single curl) | Full (JSON with all fields) |

**10x faster, simpler code, more data.**

## How to Find Hidden APIs

### 1. Recognize the Pattern
DataTables, AG-Grid, or any "Showing X to Y of Z" pagination usually means server-side data fetching.

### 2. Intercept Network Requests
```typescript
// Playwright
page.on('request', req => {
  if (req.url().includes('.ashx') || req.url().includes('api') || req.method() === 'POST') {
    console.log(req.url(), req.postData());
  }
});
```

### 3. Look for Common Endpoints
- `.ashx` - ASP.NET Generic Handlers
- `.asmx` - ASP.NET Web Services
- `/api/` - REST APIs
- `/data/` - Data endpoints
- `ajax=true` query params

### 4. Test with curl
```bash
# Try empty POST first
curl -s -X POST "https://example.com/data/handler.ashx" --data-raw ''

# Or with DataTables params
curl -s "https://example.com/api/data?start=0&length=10000"
```

### 5. Check Response
Often APIs return ALL data when:
- No pagination params sent
- `length=-1` or `length=99999`
- Empty POST body

## Real Example: ERC Rooftop PV

**Website**: `https://app04.erc.or.th/ElicenseRooftop/PV/Public/`
**Records**: 9,372 entries

**Browser approach** (first attempt):
- 94 pages × 1.5 sec wait = ~150 seconds
- Complex: selectors, pagination logic, error handling

**API approach** (discovered):
```bash
curl -s -X POST \
  "https://app04.erc.or.th/ElicenseRooftop/Data/PV/get_list_importdata.ashx" \
  --data-raw '' > data.json
```
- Single request = 16 seconds
- Full JSON with 50 columns (vs 17 displayed)

## Decision Tree

```
Need to scrape paginated data?
    │
    ├─► Check Network tab for AJAX calls
    │       │
    │       ├─► Found API endpoint?
    │       │       │
    │       │       └─► Test with curl → Use API
    │       │
    │       └─► No API found?
    │               │
    │               └─► Use browser automation
    │
    └─► Static HTML only?
            │
            └─► Use simple HTTP + parsing
```

## Key Takeaway

> "The best scraper is no scraper - just call the API directly."

Browser automation is powerful but expensive. Spend 5 minutes looking for APIs before writing 50 lines of Playwright code.

---
*Learned from: ERC rooftop PV database scraping, 2026-01-08*
