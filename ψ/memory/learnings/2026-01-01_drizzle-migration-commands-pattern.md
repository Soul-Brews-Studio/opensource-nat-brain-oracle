---
date: 2026-01-01
tags: [drizzle, migrations, cli, database]
context: Data-Aware RAG - Adding migration commands
---

# Drizzle Migration Commands Pattern

## The CLI Commands

Added migration commands that wrap Drizzle Kit:

```bash
# Generate migration from schema changes
bun run cli migrate generate init --debug

# Push schema directly to database
bun run cli migrate push --debug

# Pull schema from existing database (introspect)
bun run cli migrate pull --debug

# Check migration status
bun run cli migrate status

# Open Drizzle Studio (database browser)
bun run cli migrate studio
```

## Implementation Pattern

Each command spawns `bunx drizzle-kit <command>`:

```typescript
migrate
  .command('push')
  .description('Push schema changes directly to database')
  .option('-d, --debug', 'Show debug output')
  .action(async (options) => {
    if (options.debug) {
      console.log(chalk.magenta('🔍 MIGRATE PUSH PIPELINE'));
      console.log(chalk.dim(`[1] Schema: src/db/schema.ts`));
      console.log(chalk.dim(`[2] Database: data/sqlite.db`));
    }

    const { spawn } = await import('child_process');
    const drizzle = spawn('bunx', ['drizzle-kit', 'push'], {
      stdio: 'inherit',
      cwd: resolve(import.meta.dir, '../..'),
    });
  });
```

## Push vs Pull

| Command | Direction | Use Case |
|---------|-----------|----------|
| `push` | Schema → DB | Apply code changes to database |
| `pull` | DB → Schema | Generate TypeScript from existing DB |

## Drizzle Config

```typescript
// drizzle.config.ts
export default defineConfig({
  schema: './src/db/schema.ts',
  out: './drizzle',
  dialect: 'sqlite',
  dbCredentials: {
    url: './data/sqlite.db',
  },
});
```

## Key Learning

> "Wrap external tools (drizzle-kit) in your CLI for consistent UX. Add --debug flags to show pipeline steps, making actions explainable."

The user never needs to remember `bunx drizzle-kit` commands - they just use `data-rag migrate`.
