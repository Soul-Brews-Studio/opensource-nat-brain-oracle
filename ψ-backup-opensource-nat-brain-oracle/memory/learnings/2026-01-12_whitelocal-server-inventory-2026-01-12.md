---
title: ## white.local Server Inventory (2026-01-12)
tags: [white.local, server, infrastructure, pm2, rag, github-runners, homelab]
created: 2026-01-12
source: SSH exploration 2026-01-12
---

# ## white.local Server Inventory (2026-01-12)

## white.local Server Inventory (2026-01-12)

### Server Access
- Host: `white.local` / `floodboy-white4.alchemycat.org`
- SSH: `ssh nat@white.local` or `ssh nat@floodboy-white4.alchemycat.org`
- Access: Cloudflare Tunnel (works from anywhere)

### System Specs
| Spec | Value |
|------|-------|
| Hostname | white |
| OS | Ubuntu 22.04 (6.8.0-90-generic) |
| RAM | 46GB (41GB available) |
| Disk | 912GB NVMe (351GB free, 60% used) |
| Swap | 71GB |

### PM2 Services (as of 2026-01-12)
| Name | Port | Status | Uptime |
|------|------|--------|--------|
| rag-backend | 8001 | ✅ online | 6 days |
| rag-frontend | 5173 | ✅ online | 6 days |
| gql-subscribe (APT deviceid) | - | ✅ online | 6 days |

### Key Ports
| Port | Service |
|------|---------|
| 22 | SSH |
| 2049 | NFS |
| 5173 | RAG Frontend (Vite) |
| 8501 | Streamlit |
| 37777 | Bun service |
| 1883 | MQTT (localhost) |
| 19999 | Netdata |

### GitHub Actions Runners
| Runner | Status |
|--------|--------|
| laris-co.floodboy_white | ✅ systemd active |
| laris-co.nat_white_local | ✅ systemd active |

### Storage
- `/mnt/sdb` → 8TB-1-SDB
- `/mnt/sda` → 8TB-2

### Docker
Available (v28.4.0) but no containers running.

---
*Added via Oracle Learn*
