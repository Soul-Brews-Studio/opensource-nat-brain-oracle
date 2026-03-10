---
title: ESPHome-FW Project (laris-co/esphome-fw) Key Patterns:
tags: [esphome, esphome-fw, reunion, constitution, safety, floodboy, iot]
created: 2026-01-12
source: Reunion: laris-co/esphome-fw
---

# ESPHome-FW Project (laris-co/esphome-fw) Key Patterns:

ESPHome-FW Project (laris-co/esphome-fw) Key Patterns:

1. **Constitution-First**: Repository operates under formal constitution (v1.0.0) - all AI actions subject to it
2. **Safety Rules**: No force flags (git push --force, rm -rf), prefer reversible commands
3. **Documentation Hierarchy**: CLAUDE.md for quick orientation → AGENTS.md for safety → docs/ for full detail
4. **Command Namespaces**: Keep custom commands (ccc, nnn, rrr, gogogo) separate from framework commands (.specify)
5. **Auto-Discovery**: Commands should auto-find context, not require explicit arguments
6. **Conventional Commits**: feat:, fix:, chore: with imperative subjects

Devices: FloodBoy C3 Radar, flood detection systems, MQTT-based IoT
Tech: ESPHome, YAML configs, power management, security considerations

---
*Added via Oracle Learn*
