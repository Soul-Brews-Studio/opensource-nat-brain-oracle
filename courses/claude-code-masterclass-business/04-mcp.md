# Module 4: MCP (Model Context Protocol)

> "เชื่อมต่อ AI กับระบบภายนอก" | 2 hours | Advanced

## Learning Objectives

หลังจบ module นี้ ผู้เรียนจะ:
- เข้าใจ MCP และทำไมมันสำคัญ
- ติดตั้งและ configure MCP servers
- เชื่อมต่อกับ business tools
- รู้จัก use cases สำหรับธุรกิจ

## What is MCP?

**MCP = Model Context Protocol**

```
Claude ←→ MCP Server ←→ External System

เหมือน "adapter" ให้ AI คุยกับระบบอื่นได้
```

### Without MCP
```
User: "ดูข้อมูลลูกค้าใน CRM ให้หน่อย"
Claude: "ผมไม่สามารถเข้าถึง CRM ของคุณได้ครับ"
```

### With MCP
```
User: "ดูข้อมูลลูกค้าใน CRM ให้หน่อย"
Claude: *calls CRM MCP server*
        "ลูกค้า John มี 5 deals open, รวม $50,000"
```

## MCP Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ Claude Code │ ←→  │ MCP Server  │ ←→  │  External   │
│   (Client)  │     │  (Bridge)   │     │   System    │
└─────────────┘     └─────────────┘     └─────────────┘

Examples:
Claude ←→ filesystem MCP ←→ Local Files
Claude ←→ github MCP ←→ GitHub API
Claude ←→ postgres MCP ←→ Database
Claude ←→ slack MCP ←→ Slack Workspace
```

## Available MCP Servers

### Official (Anthropic)
| Server | Purpose | Use Case |
|--------|---------|----------|
| `filesystem` | File access | Read/write files safely |
| `github` | GitHub API | Issues, PRs, repos |
| `postgres` | PostgreSQL | Database queries |
| `sqlite` | SQLite | Local databases |

### Community
| Server | Purpose | Use Case |
|--------|---------|----------|
| `slack` | Slack API | Messages, channels |
| `notion` | Notion API | Docs, databases |
| `google-drive` | Google Drive | Files, docs |
| `linear` | Linear API | Project management |
| `browserbase` | Web browsing | Research, scraping |

### Custom
You can build your own MCP server for any API!

## Installing MCP Servers

### Step 1: Check Claude Code Config
```bash
cat ~/.claude.json
```

### Step 2: Add MCP Server
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-filesystem", "/path/to/allowed/dir"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "your-token-here"
      }
    }
  }
}
```

### Step 3: Restart Claude Code
```bash
# Exit and restart
claude
```

### Step 4: Verify
```
User: "what MCP servers are available?"
Claude: *lists connected servers*
```

## Hands-On Exercise 1: GitHub MCP

### Setup
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "ghp_xxxxxxxxxxxx"
      }
    }
  }
}
```

### Get Token
1. Go to github.com/settings/tokens
2. Generate new token (classic)
3. Select scopes: repo, issues, pull_request
4. Copy token to config

### Try It
```
User: "list my open PRs"
Claude: *calls github MCP*
        "You have 3 open PRs:
         #123 - Feature X
         #124 - Bug fix Y
         #125 - Update docs"
```

### Business Use Cases
- Review PR status across projects
- Create issues from conversations
- Check CI/CD status
- Manage releases

## Hands-On Exercise 2: Database MCP

### Setup (SQLite)
```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-sqlite", "path/to/database.db"]
    }
  }
}
```

### Try It
```
User: "show me top 10 customers by revenue"
Claude: *queries database*
        "Top 10 customers:
         1. Acme Corp - $500,000
         2. Tech Inc - $350,000
         ..."
```

### Business Use Cases
- Query sales data
- Generate reports from database
- Analyze customer data
- Track inventory

## Hands-On Exercise 3: Slack MCP

### Setup
```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "mcp-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-xxxx",
        "SLACK_TEAM_ID": "T0xxxxx"
      }
    }
  }
}
```

### Try It
```
User: "summarize #general channel from today"
Claude: *reads slack messages*
        "Today in #general:
         - Team standup at 9am
         - John announced new feature launch
         - 3 people discussing Q1 goals"
```

### Business Use Cases
- Summarize channel discussions
- Find specific conversations
- Draft messages
- Monitor important channels

## Business Integration Patterns

### Pattern 1: CRM Integration
```
User: "prepare for meeting with John"
Claude: *calls CRM MCP*
        → Gets John's profile
        → Gets recent interactions
        → Gets open deals
        → Summarizes: "John is CEO of Acme,
           2 open deals worth $100k,
           last contact was about pricing"
```

### Pattern 2: Multi-Source Report
```
User: "weekly sales report"
Claude: *calls multiple MCPs*
        → Database: Sales numbers
        → GitHub: Shipped features
        → Slack: Customer feedback
        → Combines into report
```

### Pattern 3: Automated Workflow
```
User: "process new lead from email"
Claude: *calls MCPs sequentially*
        → Email MCP: Extract lead info
        → CRM MCP: Create contact
        → Slack MCP: Notify sales team
        → Calendar MCP: Schedule follow-up
```

## Security Considerations

### Best Practices

| Practice | Why |
|----------|-----|
| Use read-only tokens when possible | Limit damage from mistakes |
| Restrict file paths | Don't expose entire filesystem |
| Rotate tokens regularly | Security hygiene |
| Audit MCP usage | Know what's being accessed |

### Token Management
```bash
# Don't commit tokens!
# Use environment variables

export GITHUB_TOKEN="ghp_xxx"
export SLACK_TOKEN="xoxb-xxx"
```

### Config with Env Vars
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

## Building Custom MCP Server (Advanced)

### When to Build Custom
- Your business app has no existing MCP
- Need specific functionality
- Want to control data access

### Basic Structure (TypeScript)
```typescript
import { Server } from "@modelcontextprotocol/sdk/server";

const server = new Server({
  name: "my-custom-mcp",
  version: "1.0.0"
});

// Define tools
server.setRequestHandler("tools/list", async () => {
  return {
    tools: [{
      name: "get_customer",
      description: "Get customer by ID",
      inputSchema: {
        type: "object",
        properties: {
          customerId: { type: "string" }
        }
      }
    }]
  };
});

// Handle tool calls
server.setRequestHandler("tools/call", async (request) => {
  if (request.params.name === "get_customer") {
    const customer = await fetchCustomer(request.params.arguments.customerId);
    return { content: [{ type: "text", text: JSON.stringify(customer) }] };
  }
});

server.connect(process.stdin, process.stdout);
```

### Resources
- MCP SDK: https://github.com/anthropics/mcp
- Examples: https://github.com/anthropics/mcp-servers

## Exercise: Plan Your MCP Setup

### Your Task
Design MCP integration for your business:

1. **List your systems**
   - What tools/apps do you use daily?
   - Which have APIs?

2. **Priority ranking**
   - Which would save most time?
   - Which have existing MCP servers?

3. **Security assessment**
   - What data will Claude access?
   - What permissions are needed?

### Template
```markdown
## My MCP Plan

### Systems to Connect
| System | Existing MCP? | Priority | Data Access |
|--------|---------------|----------|-------------|
| [System 1] | Yes/No | High/Med/Low | Read/Write |

### Phase 1 (This week)
- [ ] Setup [MCP 1]
- [ ] Test basic queries

### Phase 2 (This month)
- [ ] Add [MCP 2]
- [ ] Create workflow combining MCPs

### Security Checklist
- [ ] All tokens in env vars
- [ ] Read-only where possible
- [ ] File paths restricted
```

## Summary

| Concept | Key Takeaway |
|---------|--------------|
| MCP | Protocol to connect Claude to external systems |
| Setup | Add to ~/.claude.json, restart |
| Security | Use env vars, limit permissions |
| Custom | Can build for any API |

## Course Wrap-Up

### What You Learned

| Module | Skill |
|--------|-------|
| 1. Sub Agents | Delegate work, save cost |
| 2. Skills | Reusable workflows |
| 3. Commands | Automated shortcuts |
| 4. MCP | External integrations |

### Your AI System Now Has

- [ ] Sub agent patterns for delegation
- [ ] 3+ business skills
- [ ] 5+ custom commands
- [ ] MCP connections to your tools

### Next Steps

1. **Practice daily** - Use your new commands
2. **Iterate** - Improve based on usage
3. **Share** - Help your team adopt
4. **Build** - Create more advanced workflows

### Resources

- Claude Code Docs: https://docs.anthropic.com/claude-code
- MCP Servers: https://github.com/anthropics/mcp-servers
- Community: Discord, GitHub Discussions

---

**Congratulations! You're now a Claude Code Master.**
