# Pattern: Backend vs Frontend Service Separation

**Date**: 2026-01-02
**Source**: Data-Aware RAG v7 refactoring

---

## Problem

Having both backend (:8001) and frontend (:5173) serve similar dashboard UIs creates confusion. User asks "why do both look the same?"

## Solution

**Clear separation of concerns:**

| Port | Service | Purpose |
|------|---------|---------|
| 8001 | Backend API | Admin page + REST API |
| 5173 | React Frontend | User-facing dashboard |

## Backend (:8001) Should Show

```
- Server status (uptime, memory, port)
- Database stats (document count, source breakdown)
- API endpoint documentation
- Health check endpoint
- Link to frontend
```

## Frontend (:5173) Should Show

```
- Full interactive dashboard
- Document explorer with pagination
- Search with debug mode
- Charts and visualizations
- User-facing features
```

## Implementation

```typescript
// Backend server.ts - root route
if (path === '/' || path === '/admin') {
  // Generate admin HTML with server stats
  const uptime = process.uptime();
  const memUsage = process.memoryUsage();
  // ... render admin page
}

// Redirect old dashboard to frontend
if (path === '/dashboard') {
  return Response.redirect('http://white.local:5173/#dashboard', 302);
}
```

## Key Insight

**Backend = Admin/API, Frontend = User Interface**

Don't duplicate UI across services. Each service has one responsibility.

---

## Related

- `specs/003-generic-markdown-rag/spec.md` - Architecture section updated
- `ψ/lab/data-aware-rag/src/dashboard/server.ts` - Implementation
