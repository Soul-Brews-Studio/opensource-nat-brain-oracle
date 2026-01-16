---
title: DustBoy Model Name Cleanup Pattern
tags: [dustboy, phd, model-names, data-cleaning, white-server]
created: 2026-01-01
source: Session 2026-01-02 DustBoy cleanup
---

# DustBoy Model Name Cleanup Pattern

DustBoy Model Name Cleanup Pattern

Raw model names from database need cleaning for PhD thesis:
- model_n-nc-2025_1s → NC-2025
- model_n-nh_1s → NH
- tags_model_n-nbiotdb_1s → NBIoT
- model_t3db_1s → T3DB
- model_n-nh-wifi_1s → NH-WiFi
- tags_model_n-wifidb_1s → WiFiDB
- model_n-wplus-dustboy22db_1s → WPlus-DustBoy22
- model_n-wifiblackdb_1s → WiFiBlackDB
- model_n-wifidb2_1s → WiFiDB2
- model_n-nc-wifi_1s → NC-WiFi

Pattern: Remove prefix (model_n-, tags_model_n-) and suffix (_1s), capitalize properly.

Clean data should be ground truth on WHITE, then rsync to local.

---
*Added via Oracle Learn*
