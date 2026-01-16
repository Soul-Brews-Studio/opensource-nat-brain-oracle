# Cloudflare Tunnel: white.local Remote Access

**Date**: 2026-01-02
**Context**: Remote SSH to home server via Cloudflare Tunnel

## Overview

| Attribute | Value |
|-----------|-------|
| **Local hostname** | white.local |
| **Remote hostname** | floodboy-white4.alchemycat.org |
| **Service** | Cloudflare Tunnel (cloudflared) |
| **Provider** | Cloudflare Zero Trust |

## How It Works

```
┌─────────────┐     ┌──────────────────┐     ┌─────────────────┐     ┌─────────────┐
│  Your Mac   │────▶│ Cloudflare Edge  │────▶│   cloudflared   │────▶│   white     │
│  (anywhere) │     │ (global network) │     │ (home server)   │     │ (services)  │
└─────────────┘     └──────────────────┘     └─────────────────┘     └─────────────┘
      SSH to                 Routes                Tunnel               PM2, RAG,
  floodboy-white4.           traffic              daemon               Oracle, etc.
  alchemycat.org
```

**No port forwarding needed** - Cloudflare Tunnel creates an outbound connection from your server to Cloudflare's edge network.

## Connection Methods

### 1. Remote (via Cloudflare Tunnel)

```bash
ssh nat@floodboy-white4.alchemycat.org
```

Works from anywhere with internet.

### 2. Local (via mDNS)

```bash
ssh nat@white.local
```

Works only on same LAN.

### 3. Tailscale (backup VPN)

```bash
ssh nat@white  # via Tailscale network
```

## Service Status

```bash
# Check cloudflared
ssh nat@floodboy-white4.alchemycat.org "systemctl status cloudflared"

# View logs
ssh nat@floodboy-white4.alchemycat.org "journalctl -u cloudflared -f"

# Restart
ssh nat@floodboy-white4.alchemycat.org "sudo systemctl restart cloudflared"
```

## Current Services on white.local

| Service | Port | Status |
|---------|------|--------|
| RAG Backend | 8001 | ✅ PM2 |
| RAG Frontend | 5173 | ✅ PM2 |
| Oracle API | - | ✅ PM2 |
| SSH | 22 | ✅ systemd |

## Systemd Unit

Location: `/etc/systemd/system/cloudflared.service`

```ini
[Unit]
Description=Cloudflared Tunnel

[Service]
ExecStart=/usr/local/bin/cloudflared tunnel run --token <TOKEN>
Restart=always

[Install]
WantedBy=multi-user.target
```

## Cloudflare Zero Trust Dashboard

Manage tunnels at: https://one.dash.cloudflare.com/

- View connected tunnels
- Add new hostnames/routes
- Configure access policies
- Monitor traffic

## Server Specs

| Spec | Value |
|------|-------|
| Hostname | white |
| OS | Ubuntu |
| Node | v22.14.0 (nvm) |
| Bun | v1.3.5 |
| PM2 | v6.0.14 |
| Docker | v28.4.0 |

## Quick Reference

```bash
# Remote access
ssh nat@floodboy-white4.alchemycat.org

# Check PM2 services
ssh nat@floodboy-white4.alchemycat.org 'source ~/.nvm/nvm.sh && pm2 list'

# View RAG logs
ssh nat@floodboy-white4.alchemycat.org 'source ~/.nvm/nvm.sh && pm2 logs rag-backend'

# Access RAG frontend (via SSH tunnel)
ssh -L 5173:localhost:5173 nat@floodboy-white4.alchemycat.org
# Then open: http://localhost:5173
```

## Security Notes

1. **Cloudflare handles TLS** - Connection to edge is encrypted
2. **Token-based auth** - No exposed ports on home network
3. **Zero Trust policies** - Can add additional auth (SSO, OTP)
4. **Tailscale backup** - Alternative VPN if Cloudflare is down

---

*Cloudflare Tunnel = secure remote access without port forwarding*
