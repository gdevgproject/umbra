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
| Architecture conformance | capability/layer dependency, public/internal surface, cycle, loader/client import và contract inventory đúng | Java dependency/bytecode rule + generated architecture report; exact tool do `DB-021` chọn | mọi code/build; violation fixtures ở C1 |
| Pure unit/model | formula/state/idempotency/modifier/codec | Fabric Loader JUnit | mọi build |
| Server GameTest | world/entity/block/action/save rule | Minecraft/Fabric GameTest | build/CI |
| Client GameTest | input/UI/render/camera/screenshot | Fabric client GameTest | camera/UI/render change |
| Integration | command→event→state→sync/persistence | integrated + dedicated harness | capability gate |
| Simulation/property | progression/economy/TTK/generation/edge space | seeded simulation/property tests | balance/content change |
| Soak/chaos | unload/reload/reconnect/lag/crash/long-run | bot, fault injection, repeated seeds | snapshot/release |
| Performance | tick/frame/memory/GC/network/save/cardinality budgets | counters, benchmark scenes, soak/profilers | theo `PR-0–PR-3`, capability/release |
| Compatibility | versions/mods/shaders/config/world modes | pinned matrix | release baseline/change |
| Human playtest | feel, learning, agency, attachment, comfort | protocol + capture bundle | sau automated green |

Fabric documentation hiện hỗ trợ Loader JUnit, server GameTest và client GameTest có screenshot; đây là current baseline hypothesis cần pin theo release. NeoForge cũng có GameTest runner nhưng chỉ trở thành required lane khi adapter/target được mở; shared oracle không phụ thuộc runner. [Fabric Automated Testing](https://docs.fabricmc.net/develop/automatic-testing), [NeoForge Game Tests](https://docs.neoforged.net/docs/misc/gametest/)

Compatibility lane không chạy một ma trận Cartesian vô hạn. Manifest canonical sinh exact jobs cho `SUPPORTED_CURRENT`, port candidate và control cần thiết; snapshot chỉ có diff/spike job khi có decision question. Minecraft baseline promotion luôn là `PR-3` và phải so final previous-line fixture với successor, không lấy clean new world làm bằng chứng migration.

Ranh giới claim và thuật toán khi nào mới nhờ user nằm tại [Automation Boundaries](09-automation-boundaries-and-escalation.md).

## 3. Performance Risk Routing — Agent tự quyết khi nào phải đo

Mọi Feature Cell/ticket/runtime change phải gán đúng một class; `N/A` không thay `PR-0` và luôn cần lý do. Khi không chắc cardinality/thread/hot-path, chọn mức cao hơn rồi hạ bằng evidence.

| Class | Khi dùng | Evidence bắt buộc |
|---|---|---|
| `PR-0 — NONE` | docs/text/data thuần không đổi runtime work hoặc asset weight | `N/A — reason`; không chạy benchmark |
| `PR-1 — WATCH` | thay nhỏ ngoài hot path nhưng chạm runtime/config/content count có cap | counter/smoke của scene gần nhất; xác nhận không mở cardinality mới |
| `PR-2 — TARGETED` | đổi tick/render/input callback, loop/query, AI/path, entity count, allocation/cache, VFX/audio/UI repetition, serialization/save/network, generation hoặc async work | baseline trước/sau + benchmark scene/subsystem profile + budget verdict |
| `PR-3 — STRESS/SOAK` | capability mới có systemic load; scheduler/persistence/render/worldgen/loader/version boundary; cap/backpressure đổi; regression performance/crash; snapshot/release | targeted + stress/soak/lifecycle + relevant hardware/backend/loader matrix |

### Trigger nâng tối thiểu lên `PR-2`

- work chạy theo tick/frame/entity/chunk/player/packet/item/UI row;
- nested iteration hoặc query có input/cardinality do content/save quyết;
- tạo object/buffer/path/task/particle/sound thường xuyên;
- cache/pool/queue có owner, cap hoặc invalidation thay đổi;
- main-thread I/O, codec, migration, world mutation hoặc network payload đổi;
- camera/render/animation hook, Mixin/patch/event callback đổi;
- feature thêm degradation/LOD hoặc dựa vào async/concurrency.

### Trigger nâng lên `PR-3`

- chưa biết worst-case cardinality hoặc chưa có backpressure;
- ảnh hưởng nhiều subsystem hay world chơi dài;
- thay Minecraft/Java/loader/backend hoặc adapter lifecycle;
- thêm group AI, generation, persistent simulation, large battle/VFX hoặc save graph;
- chuẩn bị capability snapshot/public release;
- sửa lag, freeze, memory leak, crash hoặc regression budget.

### Quy trình evidence

1. Impact Map khai risk class, trigger, budget owner và benchmark ID trước implementation.
2. `PR-2/3` lấy baseline/control trước khi đổi nếu build hiện tại chạy được; ghi warm-up, seed, profile, profiler state và noise.
3. Thêm counter/label/fixture cùng feature; không đợi lag mới instrument.
4. Chạy lane nhỏ nhất chứng minh risk, rồi escalation nếu tail/cardinality bất thường.
5. So median/p95/p99, spike, live-set/queue và outcome correctness; không tối ưu theo FPS average hoặc một run.
6. Nếu regression vượt budget/noise: giữ gate đỏ, profile attribution, isolate cause, sửa và chạy lại cùng fixture. Không nới threshold để làm xanh nếu chưa có waiver/timebox/owner.

Exact scene, metric và release condition do [Performance Constitution](04-performance-budgets.md) sở hữu. Test Architecture chỉ sở hữu routing này, không lặp budget.

## 4. Test pyramid không được dùng máy móc

Unit nhiều nhưng không thay integration Minecraft. GameTest không chứng minh combat hay camera dễ chịu. Screenshot không chứng minh animation timing. Playtest cảm giác không chứng minh idempotency/save. Mỗi risk phải chọn đúng oracle.

## 5. Evidence record

Mỗi record ghi:

- requirement/Feature/Contract ID và risk;
- build commit, data/schema version, environment/mod matrix;
- fixture/world seed/player profile/preconditions;
- action script và oracle;
- logs/state trace/screenshot/video/perf artifact;
- expected/actual và reproduction rate;
- limitation/flakiness/quarantine owner;
- verdict + linked bug/ADR/follow-up.
- performance risk class/trigger, benchmark/control ID và before/after khi liên quan.

“Đã test” hoặc ảnh không có build/scenario ID không phải evidence đủ.

## 6. Regression invariants nền

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
13. Roster không vượt tám member, active combat không vượt bốn; full-roster capture không auto-delete/overwrite và retry không duplicate pending claim.
14. Shadow social expression không cắt legal combat action, spam nghi lễ hoặc commit bond/memory hai lần sau interruption/reload.
15. Health chỉ có một authoritative value; HUD, death, save và damage attribution không lệch do render/reconnect/migration.
16. Fall/fire/lava/drowning/suffocation/starvation/status/void giữ đúng source profile; Max HP lớn không âm thầm vô hiệu hazard ngoài approved matrix.
17. Đổi Max HP/Mana/Focus không refill miễn phí; resource transaction không âm hoặc commit hai lần.
18. Quick Recovery mỗi action ID chỉ trừ một charge/heal một lần; cancel trước commit hoàn reservation, sau commit không rollback heal.
19. Orbit/recenter/lock/aim transition không đảo held movement; Dodge/attack đã accepted giữ đúng basis snapshot.
20. Focus và Vigor không rút/hoàn chéo; leo/Khinh Công không làm mất Dodge và combat không khóa traversal ngoài action/context explicit.
21. Một actor không đồng thời ở hai locomotion mode; attach/mantle/launch/landing packet retry không double cost/impulse/transition hoặc xuyên block.
22. Quit/reconnect/death/portal/resource reload không refill Vigor, giữ contact ma, ghost flight hoặc fall immunity.
23. Grounding Strike chỉ chuyển đúng fall component tại valid impact của một action ID; không xóa lava/void/status hoặc gây AoE/block damage lặp.
24. Lightness không thể hover, midair relaunch, wall-touch ground-reset hoặc modifier-stack thành infinite upward/level flight.
25. Capability không dependency cycle, gọi internals hoặc để loader/client type thoát boundary; architecture report khớp public surface/allowed edge canonical.
26. Correlation/causation/operation ID không đứt hoặc đổi owner qua async, adapter, save/reload và presentation; instrumentation overflow/off không đổi gameplay outcome.
27. Free Climb surface truth dùng actor-context collision/support + profile/revision, không opacity/outline/full-cube/block-name heuristic; partial/thin/foliage/fluid/dynamic fixtures không tạo handhold hoặc landing giả.
28. Buffered traversal intent chỉ consume một lần; assist không vượt intent cone/gap/hazard, và block/fluid/piston/entity/hit mutation trước commit luôn được revalidate mà không teleport/double cost/stale contact.
29. Đi/chạy/sprint chỉ va tường không attach; explicit player Jump lineage + direct approach có thể attach, còn auto-jump/passive/external/build/grazing context không được auto-save. Optional precision/hold/assist profiles giữ cùng authoritative truth.
30. Vigor chỉ charge base attached time + accepted actor-effort + committed action đúng một lần; blocked input/assist/correction/external motion không thêm effort, recovery cần stable support, còn HUD lifecycle/current/reserved/next-cost/reason luôn khớp snapshot authority.
31. Mỗi Jump/Sneak physical edge có đúng một semantic consumer theo locomotion/context: không jump+attach/leap kép, không dismount+Drop, không repeat spam; targeted climb leap không fallback sai hướng, charge invalid target hoặc vượt post-contact/cadence guard.

## 7. Feature readiness test pack

Mỗi Feature Cell có happy path, boundary, invalid state, interruption, mode/context, duplicate/reorder, save/reload, death/respawn, reconnect, chunk/dimension lifecycle, first/third camera, creative/operator path, accessibility, localization, performance risk class/evidence, missing content/config và backward migration khi liên quan. Runtime feature còn khai public surface, authoritative writer, thread/clock/transaction, failure reasons, direct consumers và architecture conformance; movement/traversal feature thêm collision-shape, velocity, ground/support, stuck/no-clip và anti-refill/anti-flight fixtures. `N/A` cần lý do.

Free Climb sinh case theo pairwise/adversarial axes canonical tại [`FEAT-TRAVERSAL-FREE-CLIMB §16`](../20-domains/01-player/traversal/01-free-climbing.md), không chỉ cộng hand-written happy paths. Mỗi oracle phải ghi cả input lineage/consumer, locomotion/contact, pose/velocity, Vigor transaction, world revision và cue/reason.

## 8. Failure handling

Flaky test bị coi là defect: ghi owner, reproduction, quarantine deadline; không rerun tới xanh rồi bỏ qua. Khi test fail, không sửa expectation cho khớp code nếu contract chưa đổi. Bug player-visible cần regression trước hoặc cùng fix.

Một hạn chế automation xuất hiện lần thứ hai phải được triage thành observability/harness backlog hoặc ghi lý do không đáng tự động hóa; không mặc định tiếp tục giao cùng thao tác cho user.
