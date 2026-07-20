# SYS-PLAYER-MASTERY — Capability mastery và build

> **DRI:** Systems Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Skills, Combat, Traversal, Items, Shadows, UI, Balance, QA
> **Status:** `DISCOVERY`

## 1. Boundary

UMBRA không còn Primary Attributes, Rank, Potential hoặc Prestige. Build identity đến từ các lựa chọn có hành vi quan sát được: skill/loadout, weapon/gear, tối đa bốn active Shadow và mastery bounded của từng capability.

Mastery không phải một bảng chỉ số tổng hợp mới. Mỗi mastery owner phải khai hành động được ghi nhận, milestone, reward, cap, anti-AFK, migration và cách preview.

## 2. Các lớp build hợp lệ

| Lớp | Vai trò | Không được làm |
|---|---|---|
| Skill/loadout | đổi động từ, timing, target, vị trí hoặc setup | chỉ cộng multiplier; giấu skill tương lai |
| Weapon/gear | chuẩn bị và trade-off theo encounter | tạo Rank/GearScore bắt buộc trá hình |
| Active Retinue | role coverage, command và phối hợp, cap 4 active | reserve slot 5–8 cộng power miễn phí |
| Capability mastery | bounded capacity/recovery/expression qua hành vi liên quan | mở core access, vô hạn tài nguyên hoặc cộng stat toàn cục |

## 3. Vigor mastery đã khóa

- Max Vigor tăng chậm qua milestone leo hợp lệ theo `VIG-MAX-001` và `VIG-MASTERY-CLIMB-001`.
- Regen tăng chậm qua milestone di chuyển mặt đất hợp lệ theo `VIG-REGEN-001` và `VIG-MASTERY-GROUND-001`.
- Mục tiêu trần dài hạn theo `VIG-MASTERY-TIME-001`; đây là minimum progression work, không là daily quota, streak hoặc khuyến khích lịch chơi dài mỗi ngày.
- Teleport, vehicle, knockback, AFK conveyor, loop tại chỗ và displacement không do player locomotion không được tính; exact validation thuộc Platform/QA.
- Mỗi milestone được preview, có progress reason và idempotent grant; cap không bị gear/equip/relog vượt qua hoặc refill miễn phí.

## 4. Skill/weapon/Retinue mastery

Các mastery này vẫn `DISCOVERY`. Chúng có thể mở sidegrade, variant hoặc information, nhưng không được tái tạo STR/AGI/VIT/INT/PER dưới tên khác. Nếu một reward chỉ là tăng damage/HP thẳng, Balance phải chứng minh cap và lý do thay vì coi “mastery” là authorization.

## 5. Migration

Save cũ có field Rank/attribute/Potential/Prestige phải được migration đọc an toàn, chuyển thành compensation/grant đã được quyết định hoặc lưu quarantine diagnostic; không tiếp tục dùng field cũ làm gameplay truth. Chính sách compensation cụ thể cần ADR trước implementation, không được ngầm quy đổi điểm cũ sang power mới.

## 6. Proof

- Không UI/content/formula nào yêu cầu Rank hoặc Primary Attribute.
- Hai build cùng Level khác nhau bằng hành vi/loadout thật, không chỉ số tổng.
- Vigor distance ledger chống teleport/AFK/retry/reload duplication và đạt cap đúng một lần.
- New-save, long-save và migration giữ Level/skill/capability; missing content có recovery rõ.
