# SYS-PLAYER-TRAVERSAL — Leo tự do, kỹ thuật đáp đất và Khinh Công

> **DRI:** Player Traversal Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Controls, Camera, Animation, Combat, World, Progression, Platform, Accessibility, QA, Performance
> **Status:** `DISCOVERY`

## 1. Mission

Biến chiều dọc của Minecraft từ một rào cản hình khối thành không gian mastery: người chơi đọc bề mặt, quản lý Khí Lực, chọn đường leo hoặc dùng kỹ thuật trên không—nhưng building, ladder, fall hazard, enemy pressure và cảm giác sinh tồn vẫn có giá trị.

Pillar chính: `PIL-AGENCY` + `PIL-MASTERY`. Pillar phụ: `PIL-ASCENDANCE` khi một capability sớm làm thế giới cũ được nhìn theo cách mới.

Failure modes:

- auto-climb cướp input khi người chơi chỉ muốn đào/xây;
- “bay” vô hạn làm địa hình/Gate/structure vô nghĩa;
- animation đẹp nhưng collision/authority xuyên block;
- core world access bị khóa trong Potential/build;
- shared stamina khiến traversal và combat phá nhịp của nhau.

## 2. Capability decomposition

| ID | Player intent → outcome | Delivery |
|---|---|---|
| `FEAT-TRAVERSAL-FREE-CLIMB` | chủ động bám một face hợp lệ → leo dọc/ngang, bật/tuột và mantle có Vigor | vertical traversal foundation |
| `FEAT-AERIAL-GROUNDING-STRIKE` | bấm attack đúng lúc đang rơi → chuyển cú rơi thành impact có kiểm soát, đáp an toàn và gây damage nhẹ | combat–fall bridge |
| `FEAT-TRAVERSAL-LIGHTNESS` | kích hoạt Khinh Công → giậm đất phóng theo quỹ đạo rồi chủ động hạ chậm/điều hướng | aerial traversal reward |

State/surface/resource canonical nằm tại [`CTR-TRAVERSAL`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md). Không feature nào tự định nghĩa lại Vigor, climbable block hoặc fall suppression.

## 3. Progression direction

Đây là ba **universal capability**, không chiếm `4+1` combat loadout và không là lựa chọn Potential:

1. **Basic mantle/ledge safety:** có từ đầu để movement không thô.
2. **Free Climb:** mở cực sớm sau người chơi đã trải nghiệm shelter/hunger và nhận Awakening/training; level chỉ là eligibility candidate.
3. **Grounding Strike:** mở sau light-attack/fall teaching, đủ sớm để trở thành muscle memory.
4. **Lightness:** mở sau Free Climb + Grounding Strike bằng một milestone luyện tập ngắn, trước khi exploration/Gate lặp nhiều.

Exact level/quest chưa khóa. Production delivery dùng `Quest Kernel`, nhưng implementation snapshot dùng capability flag/debug training grant để traversal không bị chặn bởi `C4`. Player đã vượt level sau migration nhận prompt/grant bù, không bị kẹt vì quest miss.

Progression về sau chỉ tăng bounded capacity/recovery/efficiency, mở route expression hoặc giảm recovery; không xóa collision, tạo hover vô hạn, auto-ground-strike hay biến traversal timing thành stat auto-win.

## 4. Vì sao có Khí Lực riêng

Focus đã sở hữu nhịp Dodge/parry. Khí Lực chỉ phục vụ traversal để:

- người chơi không mất quyền né vì vừa leo một vách dài;
- combat không buộc họ đứng chờ trước khi tiếp tục khám phá;
- HUD chỉ hiện meter traversal đúng context;
- balance có thể chỉnh vertical freedom mà không sửa toàn bộ i-frame/encounter combat.

Ladder/vine/scaffolding vanilla không mặc định rút Khí Lực; chúng là route chuẩn bị an toàn và giữ building có ý nghĩa.

## 5. Experience flow

```text
quan sát độ cao/bề mặt/đường lui
→ chọn route xây/ladders hoặc traversal
→ commit Khí Lực và movement state
→ điều chỉnh camera/hướng trong giới hạn
→ mantle / hạ chậm / Grounding Strike / rơi thất bại
→ nhận feedback về resource, hazard và route tiếp theo
```

Không dùng thanh Vigor như timer chờ. Route tốt, mastery và preparation phải giảm rủi ro/chore; thanh chỉ tạo giới hạn đọc được cho một lần traversal.

## 6. Minecraft và world design

- Solid vertical voxel faces là candidate climbable; partial/hazard/technical surfaces đi qua taxonomy/tag.
- Mining/placing không chạy đồng thời khi cling baseline; detach rõ rồi tương tác.
- Water, ladder, scaffolding, vine, elytra, boat/mount giữ owner riêng.
- Structure/Gate không dùng một bức tường tưởng là khóa nếu player đã có Free Climb/Lightness.
- Khinh Công không phá block, không tạo platform vô hình và không thay Creative flight.
- Enemy/Shadow/worldgen phải có response seam; player lên cao không mặc nhiên thắng encounter.

## 7. Camera, animation và feel

- Third-person là reference presentation; first-person vẫn có parity rule với sway/hand cue giảm khó chịu.
- Climb dùng surface-relative basis; Lightness launch snapshot camera-relative horizontal direction; descent steering có cap.
- Gameplay position/velocity do authority quyết; animation dùng latch/mantle/apex/impact markers và IK cosmetic.
- Mọi transition có fallback pose/clip. Missing weapon/animation asset không làm mất collision hoặc fall rule.
- VFX/SFX đọc start, low Vigor, slip, apex, descent, valid Grounding window, impact và reject bằng nhiều kênh.

## 8. Dependency graph

```text
Foundation/authority + Input Catalog + Camera Movement + Animation seam
→ CTR-TRAVERSAL state/surface/Vigor
→ Free Climb + mantle
→ Combat Action/Hit + Environmental Damage
→ Grounding Strike
→ Lightness launch/descent
→ world/quest/enemy/Shadow traversal content
```

## 9. Read next

1. [Free Climb](01-free-climbing.md)
2. [Grounding Strike](02-aerial-grounding-strike.md)
3. [Lightness Art](03-lightness-art.md)
4. [Traversal Scenario Matrix](scenarios.md)
5. [Traversal research](../../../70-research/09-open-world-traversal-climb-breakfall-lightness.md)

## 10. Gate

System vẫn `DISCOVERY`. Không ticket gameplay Ready. `DB-049–052` phải tạo prototype ở voxel camera room, automated movement/collision/fall traces, performance evidence và human feel/comfort test trước khi từng Feature Cell qua lifecycle.

