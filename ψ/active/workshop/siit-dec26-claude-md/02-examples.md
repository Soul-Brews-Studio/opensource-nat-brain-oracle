# CLAUDE.md Examples

## Example 1: Minimal (Beginner)

```markdown
# My Project - AI Guide

## Rules
1. Never push directly to main
2. Ask before deleting files
3. Use TypeScript for all new files

## Project Structure
- src/ - Source code
- tests/ - Test files
- docs/ - Documentation

## Stack
- Next.js 14
- TypeScript
- Tailwind CSS
- Prisma + PostgreSQL

## Conventions
- Use kebab-case for files
- Use PascalCase for components
- Put API routes in src/app/api/
```

**Lines: ~25** - Good starting point!

---

## Example 2: Medium (Intermediate)

```markdown
# E-Commerce Project - AI Guide

## Golden Rules
1. NEVER commit API keys or secrets
2. NEVER push to main - always use PR
3. NEVER delete production data
4. Ask before major refactors
5. Run tests before committing

## Project Structure
```
src/
├── app/          # Next.js app router
├── components/   # React components
├── lib/          # Utilities
├── hooks/        # Custom hooks
└── types/        # TypeScript types
```

## Conventions
- Components: PascalCase (Button.tsx)
- Utilities: camelCase (formatPrice.ts)
- Types: PascalCase with 'I' prefix (IProduct.ts)
- Tests: same name + .test.ts

## Git Workflow
1. Create branch: feature/[name] or fix/[name]
2. Make changes
3. Run `npm test`
4. Create PR with description
5. Wait for review

## Key Files
- `.env.local` - Environment variables (DO NOT COMMIT)
- `prisma/schema.prisma` - Database schema
- `src/lib/auth.ts` - Authentication logic

## Common Tasks
- Add component: `src/components/[Name]/index.tsx`
- Add API route: `src/app/api/[route]/route.ts`
- Add hook: `src/hooks/use[Name].ts`
```

**Lines: ~50** - Covers most needs

---

## Example 3: Full (Advanced)

```markdown
# Enterprise App - AI Guide

> Navigation: [Main](CLAUDE.md) | [Safety](CLAUDE_safety.md) | [Workflows](CLAUDE_workflows.md)

## Navigation

| File | Content | When to Read |
|------|---------|--------------|
| CLAUDE.md | This file - overview | Every session |
| CLAUDE_safety.md | Security rules | Before git/deploy |
| CLAUDE_workflows.md | Development flows | When coding |
| CLAUDE_api.md | API documentation | When working on API |

## Golden Rules

1. **Security First**
   - Never log sensitive data
   - Never commit secrets
   - Always validate input

2. **Git Safety**
   - Never force push
   - Never push to main/develop
   - Always squash before merge

3. **Code Quality**
   - Run lint before commit
   - Run tests before PR
   - Document public APIs

## Architecture

```
┌─────────────────────────────────────────┐
│              Frontend (Next.js)          │
├─────────────────────────────────────────┤
│              API Layer (tRPC)            │
├─────────────────────────────────────────┤
│           Business Logic (Services)      │
├─────────────────────────────────────────┤
│           Data Layer (Prisma)            │
└─────────────────────────────────────────┘
```

## Folder Structure

| Folder | Purpose | Example |
|--------|---------|---------|
| src/app | Routes | src/app/dashboard/page.tsx |
| src/components | UI | src/components/Button/index.tsx |
| src/server | API | src/server/routers/user.ts |
| src/services | Logic | src/services/payment.ts |
| src/lib | Utils | src/lib/format.ts |

## Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Component | PascalCase | `UserProfile.tsx` |
| Hook | camelCase + use | `useAuth.ts` |
| Service | camelCase | `paymentService.ts` |
| Type | PascalCase + I | `IUser.ts` |
| Constant | UPPER_SNAKE | `MAX_RETRY_COUNT` |

## Environment

| Variable | Purpose | Required |
|----------|---------|----------|
| DATABASE_URL | DB connection | Yes |
| NEXTAUTH_SECRET | Auth secret | Yes |
| STRIPE_KEY | Payments | Production |

## Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start dev server |
| `npm run test` | Run tests |
| `npm run lint` | Check code |
| `npm run build` | Production build |

## Workflows

### Adding a Feature
1. Create branch: `feature/[name]`
2. Implement in `src/`
3. Add tests in `tests/`
4. Run `npm run test`
5. Create PR

### Fixing a Bug
1. Create branch: `fix/[issue-number]`
2. Write failing test first
3. Fix the bug
4. Verify test passes
5. Create PR with issue reference

## Knowledge Base

| Topic | Location |
|-------|----------|
| Session history | ψ/memory/retrospectives/ |
| Patterns learned | ψ/memory/learnings/ |
| Current work | ψ/WIP.md |

## Quick Start

```bash
/recap           # Get caught up
# ... work ...
rrr              # Create retrospective
```
```

**Lines: ~150** - Enterprise-ready

---

## Example 4: Plugin-Based (Using nat-agents-core)

After installing the plugin:

```markdown
# My Project - AI Guide

## Setup
This project uses nat-agents-core plugin.
Run `/awaken` to install commands.

## Available Commands
- `/recap` - Fresh start context
- `/trace [topic]` - Search history
- `rrr` - Session retrospective
- `/snapshot` - Quick capture

## Project-Specific Rules
1. Use Python 3.11+
2. Use uv for package management
3. Follow PEP 8

## Structure
- src/ - Main code
- tests/ - pytest tests
- ψ/ - AI knowledge base
```

**Lines: ~25** - Leverage plugin!

---

## Comparison

| Level | Lines | Use Case |
|-------|-------|----------|
| Minimal | ~25 | Personal projects, prototypes |
| Medium | ~50 | Team projects, startups |
| Full | ~150 | Enterprise, complex systems |
| Plugin | ~25 | When using nat-agents-core |

**Start minimal, grow as needed!**
