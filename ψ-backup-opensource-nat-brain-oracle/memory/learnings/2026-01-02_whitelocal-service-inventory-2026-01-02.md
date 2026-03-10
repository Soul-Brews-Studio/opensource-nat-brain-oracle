---
title: ## white.local Service Inventory (2026-01-02)
tags: [white.local, homelab, infrastructure, services, inventory]
created: 2026-01-02
source: Homelab session 2026-01-02
---

# ## white.local Service Inventory (2026-01-02)

## white.local Service Inventory (2026-01-02)

### Server Access
- Host: `white.local` / `floodboy-white4.alchemycat.org`
- SSH: `ssh nat@floodboy-white4.alchemycat.org`
- Access: Cloudflare Tunnel (works from anywhere)

### GitHub Actions Runners (2)
| Runner | Service |
|--------|---------|
| laris-co.floodboy_white | systemd active |
| laris-co.nat_white_local | systemd active |

### Docker Containers
| Container | Port | Purpose |
|-----------|------|---------|
| headline-dagster-daemon | 3000 | Dagster pipeline daemon |
| headline-dagster-web | :3000 | Dagster web UI |
| dustboy-influxdb-2024 | :8087 | InfluxDB for DustBoy PhD data |
| buildx_buildkit_mybuilder0 | - | Docker BuildKit |

### PM2 Processes
| Name | Purpose |
|------|---------|
| gql-subscribe (DustBoy) | GraphQL subscription saving sensor data per minute |
| rag-backend | headline-rag REST API (:8001) |
| rag-frontend | headline-rag React UI (:5173) |
| pm2-logrotate | Log rotation module |

---
*Added via Oracle Learn*
