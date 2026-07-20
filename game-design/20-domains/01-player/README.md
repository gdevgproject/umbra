# DOM-PLAYER — Player Character và Progression Charter

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

Domain sở hữu player-owned capability, Level/EXP và mastery milestone theo capability. `SYS-PLAYER-TRAVERSAL` sở hữu luật Free Climb/Hạ Kình/Khinh Công; Skills sở hữu skill acquisition/loadout, Presentation sở hữu camera/input/animation, Combat sở hữu hit/damage và World sở hữu geometry/content response.

## Fantasy

Người chơi là ngoại lệ có thể tăng Level liên tục trong một xã hội nơi Level NPC cố định. Tăng trưởng phải được nhìn thấy, dự báo và chứng minh qua chơi; không được biến save thành bẫy vì skill tương lai bị giấu.

## Invariants đã khóa ở Product

- `Level` từ 1 tới 100+ là trục tiến trình nhân vật toàn cục duy nhất.
- Không còn Rank, Primary Attributes, Potential hoặc Prestige trong lõi. Không artifact nào được dùng tên cũ làm gate ẩn.
- Build khác nhau bằng skill/loadout, gear, Retinue và mastery capability; các lớp này không tạo thêm một ordinal rank toàn cục.
- HP là health truth Minecraft-compatible; Vigor là custom action resource duy nhất. Hunger/saturation vẫn thuộc Minecraft.
- Hai mặt `Self` và `Active Retinue` cộng hưởng nhưng không trùng vai trò; tối đa bốn reserve trong roster tám member không tính power trận hiện tại.

## Feature map

```text
new save/Level 1 → Dodge + Free Climb + active skill đầu tiên
→ combat lesson → Hạ Kình
→ mỗi mốc 5 level: authored skill unlock event
→ Level 10 training: Khinh Công
→ skill/loadout/gear/Retinue + capability mastery tiếp tục mở rộng tới Level 100+
```

## Tài liệu

- [Level và progression](01-level-and-progression.md)
- [Capability mastery và build](02-capability-mastery.md)
- [Tuyến review Level, Skill và Vigor](03-level-skill-and-vigor-review-guide.md)
- [Traversal: Free Climb, Hạ Kình và Khinh Công](traversal/README.md)
