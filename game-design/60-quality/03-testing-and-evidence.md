# QLT-TEST — Kiến trúc kiểm thử và evidence

> **DRI:** QA Lead + Test Architecture Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Testing principle

Testability là requirement của architecture. Một feature không `IMPLEMENTATION_READY` nếu Agent không thể quan sát state/decision, tạo fixture, tái hiện scenario và phân biệt lỗi design–logic–data–render–compatibility.

Người dùng không làm thay automated oracle. User time chỉ dùng cho feel, comprehension, hardware/mod-specific issue hoặc hiện tượng chưa instrument được.

## 2. Evidence lanes

| Lane | Chứng minh | Công cụ dự kiến | Khi chạy |
|---|---|---|---|
| Static | docs/schema/ref/localization/assets hợp lệ | validator, data generation checks | mọi change |
| Pure unit/model | formula/state/idempotency/modifier/codec | Fabric Loader JUnit | mọi build |
| Server GameTest | world/entity/block/action/save rule | Minecraft/Fabric GameTest | build/CI |
| Client GameTest | input/UI/render/camera/screenshot | Fabric client GameTest | camera/UI/render change |
| Integration | command→event→state→sync/persistence | integrated + dedicated harness | capability gate |
| Simulation/property | progression/economy/TTK/generation/edge space | seeded simulation/property tests | balance/content change |
| Soak/chaos | unload/reload/reconnect/lag/crash/long-run | bot, fault injection, repeated seeds | snapshot/release |
| Performance | tick/frame/network/save budgets | benchmark scenes/profilers | capability/release |
| Compatibility | versions/mods/shaders/config/world modes | pinned matrix | release baseline/change |
| Human playtest | feel, learning, agency, attachment, comfort | protocol + capture bundle | sau automated green |

Fabric documentation hiện hỗ trợ Loader JUnit, server GameTest và client GameTest có screenshot; đây là baseline hypothesis cần pin theo release. [Fabric Automated Testing](https://docs.fabricmc.net/develop/automatic-testing)

Ranh giới claim và thuật toán khi nào mới nhờ user nằm tại [Automation Boundaries](09-automation-boundaries-and-escalation.md).

## 3. Test pyramid không được dùng máy móc

Unit nhiều nhưng không thay integration Minecraft. GameTest không chứng minh combat hay camera dễ chịu. Screenshot không chứng minh animation timing. Playtest cảm giác không chứng minh idempotency/save. Mỗi risk phải chọn đúng oracle.

## 4. Evidence record

Mỗi record ghi:

- requirement/Feature/Contract ID và risk;
- build commit, data/schema version, environment/mod matrix;
- fixture/world seed/player profile/preconditions;
- action script và oracle;
- logs/state trace/screenshot/video/perf artifact;
- expected/actual và reproduction rate;
- limitation/flakiness/quarantine owner;
- verdict + linked bug/ADR/follow-up.

“Đã test” hoặc ảnh không có build/scenario ID không phải evidence đủ.

## 5. Regression invariants nền

1. Gate chỉ `CLOSED` sau full objective + valid exit.
2. Leave/save/reload giữ Gate/objective/enemy/Soul Echo hợp lệ và không duplicate reward.
3. Mana cạn không xóa Shadow đang sống; không có upkeep.
4. Potential có preview/persistence; respec theo luật.
5. Strata không ghi đè World Gốc.
6. Không reward độc quyền do calendar/streak.
7. Action/hit/Arise/reward retry không commit hai lần.
8. Click/packet/render-frame rate không tăng damage ngoài authoritative action cadence.
9. Death/respawn/reconnect áp đúng persist/reset matrix, không clone/mất identity.
10. Item từ loot/craft/creative/`/give` có state hợp lệ hoặc bị từ chối rõ.
11. Integrated và dedicated server cho cùng gameplay outcome ở scenario tương đương.
12. Camera/reticle không làm server accept target/reach xuyên vật cản.

## 6. Feature readiness test pack

Mỗi Feature Cell có happy path, boundary, invalid state, interruption, mode/context, duplicate/reorder, save/reload, death/respawn, reconnect, chunk/dimension lifecycle, first/third camera, creative/operator path, accessibility, localization, performance, missing content/config và backward migration khi liên quan. `N/A` cần lý do.

## 7. Failure handling

Flaky test bị coi là defect: ghi owner, reproduction, quarantine deadline; không rerun tới xanh rồi bỏ qua. Khi test fail, không sửa expectation cho khớp code nếu contract chưa đổi. Bug player-visible cần regression trước hoặc cùng fix.

Một hạn chế automation xuất hiện lần thứ hai phải được triage thành observability/harness backlog hoặc ghi lý do không đáng tự động hóa; không mặc định tiếp tục giao cùng thao tác cho user.
