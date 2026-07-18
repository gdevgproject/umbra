# SYS-SHADOW-DEPLOYMENT — Chỉ huy, triển khai và sinh tồn

> **DRI:** Shadow Systems Designer
> **Status:** `DISCOVERY`

Membership/capacity do [`CTR-SHADOW-RETINUE`](../../30-shared-contracts/07-shadow-retinue-capacity-and-membership.md) sở hữu. File này chỉ sở hữu cách một member hợp lệ được triển khai, chỉ huy, Tán Vỡ và quay về.

## Trạng thái deployment

```text
BONDED_RESERVE ↔ MATERIALIZING ↔ ACTIVE ↔ DISMISSING
                               ACTIVE → SHATTERED → REVIVING → ACTIVE/BONDED_RESERVE
BONDED_RESERVE ↔ ASSIGNED_HOME
```

- Summon/dismiss là transition có feedback và idempotency.
- Shattered không xóa identity. Người chơi chọn hồi sinh nhanh có mana cost hoặc chờ hồi miễn phí chậm; công thức thuộc Parameter Registry.
- `ASSIGNED_HOME` cho Shadow hiện diện/bảo vệ/đóng góp tại một nơi hợp lệ mà không giả vờ nó vẫn là combat-deployed gần player; nó vẫn chiếm slot roster.
- Active party có hard cap bốn. Tối đa bốn Shadow còn lại là dự bị/home; đổi vào giữa combat không được reset HP/cooldown, né Tán Vỡ hoặc nhân bản contribution.

## Command stack

Thứ tự ưu tiên: safety/system constraint → direct command → formation/role order → squad tactic → autonomous behavior. Lệnh có target, scope, expiry và acknowledgement; lệnh bất khả thi phải trả feedback, không im lặng.

Các công cụ dự kiến: summon preset tối đa bốn thành viên, chọn một Shadow/role, attack/focus, defend position/entity, follow, retreat, formation, ping và autonomy mode. Chỉ mở dần theo usability; hard cap nhỏ cho phép command nhanh theo portrait/role thay vì RTS multi-select và bảng quân số.

## Quy mô và LOD

| Tier | Representation |
|---|---|
| Near/critical | full entity, combat AI, animation |
| Near/non-critical | simplified decision/animation cadence |
| Far/home | aggregate simulation + event result |
| Reserve | identity + assignment record; không tick combat AI |

Chuyển tier không được heal, duplicate, mất command hoặc đổi combat outcome vô lý.

Combat party luôn nằm ở `Near/critical` hoặc `Near/non-critical` khi có khả năng tác động. `Far/home` dùng aggregate/social cadence nhưng không được làm một member đang commit action biến mất. Large hostile crowd vẫn có representation tiers riêng; cap bốn Shadow không phải lý do bỏ performance proof.
