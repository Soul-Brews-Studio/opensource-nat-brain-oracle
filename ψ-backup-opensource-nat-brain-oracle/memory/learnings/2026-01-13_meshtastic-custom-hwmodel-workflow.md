---
title: Meshtastic Custom hwModel Workflow
tags: [meshtastic, firmware, hwmodel, protobuf, esp32-s3, custom-hardware]
created: 2026-01-13
source: Session 2026-01-13: FIREMAN hwModel implementation
---

# Meshtastic Custom hwModel Workflow

## The Pattern

To add a custom hardware model to Meshtastic firmware:

### 1. Edit mesh.proto
```protobuf
// In protobufs/meshtastic/mesh.proto, before PRIVATE_HW
FIREMAN = 200;  // Pick unused number 122-254
```

### 2. Edit mesh.pb.h (generated header)
```cpp
// In src/mesh/generated/meshtastic/mesh.pb.h
meshtastic_HardwareModel_FIREMAN = 200,
```

### 3. Edit architecture.h
```cpp
// In src/platform/esp32/architecture.h
#elif defined(CUSTOM_SX1280_BOARD_S3)
#define HW_VENDOR meshtastic_HardwareModel_FIREMAN
```

### 4. Edit variant.h (optional)
```cpp
// In variants/custom_sx1280_board/variant.h
#define HW_VENDOR meshtastic_HardwareModel_FIREMAN
```

### 5. Add build flag in platformio.ini
```ini
build_flags =
  -D CUSTOM_SX1280_BOARD_S3
```

## Key Insight

The proper way is to regenerate protos with nanopb:
```bash
./bin/regen-protos.sh
```

But if nanopb isn't installed, manually editing mesh.pb.h works for development.

## Result

Device shows `hwModel: 200` in meshtastic CLI instead of `PRIVATE_HW`.

## Caveat

The Python meshtastic library throws DecodeError for unknown hwModel values, but functionality still works. The error is cosmetic.

---

*Learned during FIREMAN-1/FIREMAN-5 flash session*
