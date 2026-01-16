# ccdc-server-3 (InfluxDB Server)

**Access**: VPN required (human connects manually)

## Quick Commands

```bash
# Memory status
ssh root@202.28.244.195 "free -h"

# Top memory consumers
ssh root@202.28.244.195 "ps aux --sort=-%mem | head -10"

# Docker containers
ssh root@202.28.244.195 "docker ps"

# Docker memory stats
ssh root@202.28.244.195 "docker stats --no-stream"

# InfluxDB databases
ssh root@202.28.244.195 "docker exec docker-compose-influxdb2024-1 influx -execute 'SHOW DATABASES'"

# Retention policy (0s = infinite = bad)
ssh root@202.28.244.195 "docker exec docker-compose-influxdb2024-1 influx -execute 'SHOW RETENTION POLICIES ON telegraf'"

# Set retention (30 days)
ssh root@202.28.244.195 "docker exec docker-compose-influxdb2024-1 influx -execute 'ALTER RETENTION POLICY autogen ON telegraf DURATION 30d'"

# Restart container
ssh root@202.28.244.195 "docker restart docker-compose-influxdb2024-1"

# Add ad-hoc swap (doesn't survive reboot)
ssh root@202.28.244.195 "fallocate -l 16G /swap2.img && chmod 600 /swap2.img && mkswap /swap2.img && swapon /swap2.img"

# Check swap consumers
ssh root@202.28.244.195 "grep VmSwap /proc/*/status 2>/dev/null | sort -t: -k3 -rn | head -10"
```

## Server Info

| Item | Value |
|------|-------|
| IP | 202.28.244.195 |
| Access | VPN required (human connects) |
| RAM | 31GB |
| Swap | 8GB + 16GB (ad-hoc) |

## Services

| Container | Port | Purpose |
|-----------|------|---------|
| influxdb2024-1 | 8087 | Your InfluxDB |
| influxdb-1 | 8086 | Other InfluxDB |
| grafana | 3000 | Dashboard |
| mariadbd | - | MySQL (not ours, don't touch) |

## Patterns Learned

### 1. VPN = Human Dependency
Ask before SSH, don't assume connection.

### 2. Retention 0s = Infinite
Data never dies, memory grows forever. Always set retention.

### 3. Swap 100% = Find Biggest Process
```bash
grep VmSwap /proc/*/status | sort -t: -k3 -rn | head -5
```

### 4. Check Before Act
Our policy: verify first, then execute. Never blind commands.

### 5. Don't Touch What's Not Yours
MariaDB using 8GB swap? Leave it - not our service.

### 6. Ad-hoc Swap is Safe Buffer
```bash
fallocate -l 16G /swap2.img && chmod 600 /swap2.img && mkswap /swap2.img && swapon /swap2.img
```
Quick relief, no fstab change, disappears on reboot.

## 2025-12-29 Session Result

| Before | After |
|--------|-------|
| InfluxDB 13GB RAM | 337MB |
| Swap 8GB/8GB (100%) | 8GB/24GB (33%) |
| No buffer | 16GB buffer |

---

*Captured: 2025-12-29 08:13*
