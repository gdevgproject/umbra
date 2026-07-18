# SYS-SHADOW-DEPLOYMENT — Chỉ huy, triển khai và sinh tồn

> **DRI:** Shadow Systems Designer
> **Status:** `DISCOVERY`

## Trạng thái deployment

```text
STORED ↔ MATERIALIZING ↔ ACTIVE ↔ DISMISSING
                       ACTIVE → SHATTERED → REVIVING → ACTIVE/STORED
STORED ↔ GARRISONED
```

- Summon/dismiss là transition có feedback và idempotency.
- Shattered không xóa identity. Người chơi chọn hồi sinh nhanh có mana cost hoặc chờ hồi miễn phí chậm; công thức thuộc Parameter Registry.
- Garrison cho shadow bảo vệ/đóng góp ở world location mà không giả vờ nó vẫn là entity active gần player.

## Command stack

Thứ tự ưu tiên: safety/system constraint → direct command → formation/role order → squad tactic → autonomous behavior. Lệnh có target, scope, expiry và acknowledgement; lệnh bất khả thi phải trả feedback, không im lặng.

Các công cụ dự kiến: summon preset, select squad/role, attack/focus, defend position/entity, follow, retreat, formation, ping và autonomy mode. Chỉ mở dần theo usability, không đổ toàn bộ RTS UI vào người chơi.

## Quy mô và LOD

| Tier | Representation |
|---|---|
| Near/critical | full entity, combat AI, animation |
| Near/non-critical | simplified decision/animation cadence |
| Far/garrison | aggregate simulation + event result |
| Stored | identity record, không tick AI |

Chuyển tier không được heal, duplicate, mất command hoặc đổi combat outcome vô lý.
