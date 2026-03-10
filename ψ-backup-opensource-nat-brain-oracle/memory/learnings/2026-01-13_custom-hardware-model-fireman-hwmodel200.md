---
title: # Custom Hardware Model: FIREMAN (hwModel=200)
tags: [meshtastic, fireman, hwmodel, custom-hardware, esp32-s3, sx1280, firmware]
created: 2026-01-13
source: Session 2026-01-13: FIREMAN hardware model implementation
---

# # Custom Hardware Model: FIREMAN (hwModel=200)

# Custom Hardware Model: FIREMAN (hwModel=200)

## What We Did

1. Added `FIREMAN = 200` to mesh.proto enum
2. Added `meshtastic_HardwareModel_FIREMAN = 200` to mesh.pb.h
3. Added `#elif defined(CUSTOM_SX1280_BOARD_S3)` check in architecture.h
4. Added `#define HW_VENDOR meshtastic_HardwareModel_FIREMAN` to variant.h

## Files Modified

| File | Change |
|------|--------|
| `protobufs/meshtastic/mesh.proto` | Added FIREMAN = 200 |
| `src/mesh/generated/meshtastic/mesh.pb.h` | Added enum value |
| `src/platform/esp32/architecture.h` | Added CUSTOM_SX1280_BOARD_S3 check |
| `variants/custom_sx1280_board/variant.h` | Added HW_VENDOR define |

## Verification

```bash
meshtastic --info | grep hwModel
# Output: "hwModel": 200
```

## Notes

- Meshtastic CLI shows number (200) not name "FIREMAN" 
- Name would require patching meshtastic Python package
- hwModel=200 is between last official (121) and PRIVATE_HW (255)
- Private/custom range: 122-254

---
*Added via Oracle Learn*
