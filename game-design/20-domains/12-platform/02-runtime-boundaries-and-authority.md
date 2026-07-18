# SYS-RUNTIME — Bounded capability, layer, authority và phạm vi thay đổi

> **DRI:** Technical Director
> **Approver:** Technical Director
> **Reviewers:** Gameplay Engineering, Data, AI, Presentation, Platform/Compatibility, Performance, QA
> **Status:** `DISCOVERY`

## 1. Mục tiêu kiến trúc

UMBRA dùng **modular monolith**: một sản phẩm/gameplay truth thống nhất, chia thành bounded capability có owner và contract kiểm được. Mục tiêu không phải có nhiều package đẹp; mục tiêu là khi thêm hoặc sửa một hành vi, Agent xác định được state nào được phép đổi, consumer nào có thể bị ảnh hưởng, lỗi dừng ở boundary nào và evidence nào chứng minh không có domino ngoài ý muốn.

Ba trục phải được tách rõ:

- **Bounded capability** chia theo lý do thay đổi và quyền sở hữu ngữ nghĩa: Combat, Skills, Shadows, Actor AI, Gate/Dungeon, Quest/Narrative, Items/Economy, World, Presentation và Platform services.
- **Logical layer** chia theo loại trách nhiệm kỹ thuật bên trong hoặc xuyên capability: domain, application/orchestration, port, adapter/presentation và composition.
- **Capability Slice** cắt dọc nhiều capability/layer để tạo một proof chơi được; nó không cấp quyền bỏ qua boundary.

Không ép ba trục thành cùng một cây thư mục. `DB-021` mới khóa package/source-set/Gradle topology sau compile proof và ít nhất hai consumer thật.

## 2. Bounded capability contract

Mỗi capability trước khi có implementation phải khai tối thiểu:

| Mặt | Contract bắt buộc |
|---|---|
| Purpose | player/technical outcome, stable ID, owner và non-goals |
| Public surface | command, query, result/error và published event được consumer gọi |
| State | authoritative records, derived views, cache; create/load/unload/migrate/recover lifecycle |
| Mutation | writer duy nhất hoặc arbitration rõ; transaction/idempotency/ordering |
| Knowledge | dữ kiện capability được phép biết và dữ kiện bị cấm đọc trực tiếp |
| Time/thread | clock, cadence, owner thread, async preparation và commit boundary |
| Failure | reason taxonomy, retry/compensation/fallback và degraded capability state |
| Consumers | caller/subscriber, version/compatibility promise và blast-radius class |
| Evidence | contract tests, fixtures, diagnostics, performance risk và lifecycle matrix |

Capability sở hữu **ngữ nghĩa và state**, không nhất thiết sở hữu toàn bộ object Minecraft chứa state đó. Ví dụ Combat sở hữu damage semantics nhưng health storage dùng Minecraft `LivingEntity`; Platform adapter cung cấp hook/storage mà không tự quyết damage rule.

## 3. Logical layers và dependency direction

| Layer | Sở hữu | Được gọi | Bị cấm |
|---|---|---|---|
| `domain` | value, invariant, state transition, policy thuần và domain result | Java/UMBRA contract ổn định | loader/client/render, persistence API, global service lookup |
| `application` | use case, command handler, transaction/process orchestration, authorization | domain + declared ports | nhét formula/game rule mới vào handler; đọc internals capability khác |
| `port` | nhu cầu ngữ nghĩa đi ra platform/capability khác, error/thread contract | stable UMBRA/vanilla-neutral value | Fabric/NeoForge event/context/handle hoặc implementation convenience |
| `adapter` | Minecraft/Fabric hiện tại, storage/network/scheduler/render/input binding | application/port + API được phép | sở hữu gameplay rule, canonical schema hoặc fork outcome |
| `presentation` | projection, camera/UI/animation/VFX/SFX cue và prediction có rollback | immutable/read model + intent port | authoritative mutation hoặc suy gameplay truth từ frame/asset |
| `composition` | bootstrap, dependency wiring, capability manifest và fail-fast startup | public surfaces | service locator toàn cục, runtime loader detection trong core |

Dependency đi vào contract ổn định; adapter phụ thuộc core, core không phụ thuộc adapter. Một convenience API chỉ được đưa vào domain nếu nó thực sự là vanilla semantic ổn định đã được boundary owner duyệt; loader type không bao giờ vượt adapter theo [`SYS-LOADER-PORTABILITY`](07-loader-portability-and-adapter-contract.md).

Shared kernel chỉ chứa primitive có fan-out cao và semantics ổn định. Không có `CommonUtils`, `GameManager`, global mutable registry hoặc “God Context” cho mọi feature. Reuse chỉ hợp lệ khi owner, lifecycle, failure policy và meaning giống nhau; trùng vài dòng không đủ lý do hợp nhất.

## 4. Giao tiếp giữa capability

Chọn cơ chế nhỏ nhất giữ được ownership và khả năng truy vết:

| Cơ chế | Dùng khi | Rule |
|---|---|---|
| Direct query | cần snapshot/read model hiện tại để quyết định | read-only, bounded cost, không trả mutable internal object |
| Synchronous command | caller cần accept/reject/result để tiếp tục cùng use case | owner validate và commit; result có reason/correlation; retry idempotent |
| Published event | một fact đã commit có nhiều consumer độc lập hoặc eventual reaction hợp lệ | tên ở thì quá khứ, immutable, versioned, không là RPC ngụy trang |
| Process manager | một player outcome đi qua nhiều owner/transaction và cần resume/compensate | stable process ID, explicit steps, timeout/recovery và journal |
| Presentation signal | cue client không sở hữu gameplay mutation | có causation ID, relevance/budget/fallback; mất cue không đổi truth |

Không dùng event bus để che dependency. Event producer vẫn liệt kê known semantic consumers/risk classes; subscriber không được tạo vòng mutation bí mật. Thứ tự listener của Fabric/NeoForge không được trở thành game rule. Nếu outcome cần ordering mạnh, owner dùng direct orchestration/process manager với order explicit.

Event chỉ publish sau commit. Consumer failure không rollback fact đã xảy ra trừ khi process contract nói rõ compensation; retry không được duplicate damage/reward/item/state. Query trong hot path có cardinality/cost budget, không gọi xuyên capability theo mỗi entity/tick mà thiếu cache/invalidation contract.

## 5. State, transaction và consistency

- Mỗi authoritative fact có đúng một canonical writer; replica/HUD/index/cache là projection có thể rebuild hoặc reconcile.
- Transaction nhỏ kết thúc trong capability owner khi có thể. Cross-capability outcome dùng process manager/journal, không giữ half-mutated object graph và hy vọng bước sau thành công.
- Mọi mutation quan trọng có `operation_id`, `correlation_id`, `causation_id`, actor/owner, accepted tick, before/after version và result reason phù hợp.
- Optimistic/version check hoặc owner-thread serialization phải ngăn lost update; không dùng “last callback wins” như consistency policy.
- Time và random là dependency có owner: server tick/instance clock/seed stream được khai; không gọi wall clock hoặc RNG global trong rule cần tái hiện.
- Persistent write theo [`SYS-DATA`](01-data-and-persistence.md); state availability/lifecycle theo [`CTR-CAPABILITY-OWNERSHIP`](../../30-shared-contracts/06-capability-state-and-ownership.md).

Không yêu cầu ACID toàn game. Strong consistency áp cho ownership, damage/cost/reward, inventory, Shadow identity và irreversible choice; presentation, far simulation và analytics có thể eventual nếu contract ghi staleness/fallback và không đổi kết quả authoritative.

## 6. Thread, tick và work ownership

- World/entity/gameplay mutation chỉ commit trên logical-server owner thread trừ contract engine chứng minh khác.
- Client/render thread chỉ giữ presentation state và gửi intent; không khóa chờ heavy server work.
- Async worker chỉ chuẩn bị dữ liệu immutable/versioned. Trước commit phải revalidate world/chunk/entity/capability version và có cancellation khi owner unload.
- Mỗi queue/cache/task có owner, capacity, priority, deadline, backpressure, cancellation và unload cleanup.
- Tick scheduler phân `FOCUS/ACTIVE/REPRESENTED/AGGREGATED/DORMANT` hoặc cadence tương đương; overload giảm theo [`QLT-PERFORMANCE`](../../60-quality/04-performance-budgets.md), không bỏ legal mutation/cue nguy hiểm.
- Lifecycle callback có thể khác thread/order giữa loader; adapter chuyển về phase/thread contract UMBRA trước khi gọi application layer.

Race ở save/unload/death/reconnect/dimension/resource reload là scenario kiến trúc, không là edge case để bổ sung sau. Không chữa race bằng delay, retry vô hạn hoặc synchronized global lock.

## 7. Failure containment và recovery

Failure được phân tại boundary gần nguyên nhân nhất:

| Family | Ví dụ | Boundary response |
|---|---|---|
| `REJECTED_INTENT` | state/cost/target/permission không hợp lệ | không mutation; reason player/debug đọc được |
| `CONFLICT` | version/order/idempotency collision | return canonical result hoặc yêu cầu safe retry có cap |
| `DEPENDENCY_UNAVAILABLE` | capability/content/chunk/adapter chưa sẵn | fallback/disable path rõ; không half-enable |
| `INVALID_DATA` | schema/ref/range/asset sai | quarantine/placeholder/report; không xóa im lặng |
| `TRANSIENT_RUNTIME` | task cancel/unload/temporary I/O | bounded retry hoặc resume journal; giữ owner state an toàn |
| `INVARIANT_BREACH` | state không thể hợp lệ, duplicate reward, roster vượt cap | fail fast vùng mutation, preserve evidence, recovery/incident |
| `RESOURCE_EXHAUSTED` | queue/cardinality/budget cap | backpressure/degrade/refuse work mới có reason |
| `COMPATIBILITY` | missing hook/version/backend | capability state + diagnostic + safe fallback/refusal |

Exception platform không đi xuyên tới player/domain như contract ngẫu nhiên; adapter map về typed failure và giữ nguyên cause/stack trong diagnostics. Không swallow exception, reset state toàn cục hoặc tiếp tục save record đã biết corrupt. Một capability lỗi không được kéo sập feature không phụ thuộc nếu có fallback hợp lệ; nhưng không “cô lập” bằng cách che invariant breach.

Canonical trace/recovery schema thuộc [`CTR-DEBUG-OBSERVABILITY`](../../30-shared-contracts/05-observability-and-recovery.md).

## 8. Change Surface Map và blast-radius control

Trước mọi runtime change, Agent tìm và ghi:

```text
player/technical requirement
→ stable Feature/System/Contract ID
→ authoritative writer + state/clock/thread
→ public command/query/event/port
→ direct callers/subscribers + persisted/schema/network/render surfaces
→ loader hook/patch + lifecycle IDs
→ automated oracle + perf benchmark + recovery path
```

Mỗi dependency edge có một trong ba class:

- `PRIVATE`: thay đổi chỉ trong owner, public contract/evidence không đổi;
- `CONTRACT`: consumer compile/test có thể bị ảnh hưởng, cần version/contract review;
- `BEHAVIORAL`: outcome/save/authority/timing/cue đổi, cần Impact Map, lifecycle/ADR review và regression pack.

Không dùng Git search một symbol duy nhất làm blast-radius proof. Phải tìm stable ID, public type, registration/wiring, serialized key, event subscriber, data/asset reference và test/fixture. Nếu không thể liệt kê consumer vì dynamic registration, registry phải tự xuất consumer/dependency inventory ở diagnostics/build artifact.

## 9. Architecture fitness functions

`C1-FOUNDATION-KERNEL` phải tạo automated proof tương ứng với boundary thật, không khóa trước tool cụ thể:

1. cấm dependency cycle giữa top-level capability;
2. chỉ public API/port được dependency từ capability khác; internals không lộ;
3. cấm Fabric/NeoForge import ngoài adapter/patch và client import trong server-safe layer;
4. domain không gọi persistence/network/render/config/service-locator trực tiếp;
5. mỗi command/event/payload/schema có stable ID/version/owner và duplicate-ID check;
6. event graph không có mutation cycle hoặc listener-order gameplay rule;
7. persistent type có lifecycle/migration/fixture; cache/task/subscription có unload ownership;
8. public contract có conformance/contract test và ít nhất một failure oracle;
9. capability manifest có dependency/version/availability/fallback nhất quán;
10. generated architecture report liệt kê modules, allowed edges, public surfaces, violations và diff so baseline.

Waiver chỉ dùng cho engine quirk không thể tránh: owner, reason, exact edge, risk, regression, expiry/removal trigger và ADR/ticket ID. Không tạo allowlist toàn package để làm validator xanh.

ArchUnit hoặc tool tương đương là candidate cho Java dependency rules, không phải quyết định framework. Evidence seed: [Large-mod architecture and diagnostics](../../70-research/10-large-mod-architecture-and-diagnostics.md).

## 10. Những chiều mở rộng phải kiểm

Một boundary tốt không cố đoán mọi feature; nó chứng minh các trục sau có thể mở rộng bằng thêm definition/instance/adapter hoặc bounded capability mà không sửa hàng loạt internals:

- content breadth: enemy, skill, item, quest, animation/audio profile;
- behavior depth: AI personality, squad doctrine, relationship/expression;
- action semantics: damage/resource/status/timing/weapon grammar;
- presentation: first/third camera, body topology, animation/VFX/audio/accessibility;
- world scale: entity/LOD, Gate, society, long-save data;
- platform: Fabric hiện tại, NeoForge tương lai, Minecraft baseline/render backend;
- play topology: integrated/dedicated hiện tại, co-op/PvP future authority seams;
- schema longevity: migration, missing content, backup/restore và cross-loader fixture.

Nếu một extension cần `if content_id`, loader check, duplicate state hoặc direct cross-domain mutation, boundary chưa đủ và phần đó quay về discovery. Ngược lại, không tạo interface/registry cho một trục chỉ vì “có thể có”; cần hai consumer thật hoặc một blocker khó đảo có evidence.

## 11. Gate `DB-021`

Foundation Architecture Contract chỉ có thể rời `DISCOVERY` khi:

- ít nhất hai vertical fixtures (một happy path, một failure/recovery) đi xuyên domain→application→adapter mà không leak owner;
- schema State/Public-Surface/Dependency Matrix và các fixture row C1 đầu tồn tại; full persist/reset/copy matrix của feature vẫn do `DB-024` sở hữu;
- fitness functions bắt cycle/forbidden import/internal access và một violation fixture có chủ ý;
- causality trace nối intent→validation→mutation→presentation/save qua boundary;
- unload/reload/cancel/duplicate fault injection không để task/cache/subscription/state ma;
- Change Surface Map của cold Agent tìm đúng consumer/test từ repo mà không cần chat;
- package/module/tool choice được ghi là evidence-based ADR, không làm contract phụ thuộc framework.

Open decisions: physical Gradle/source-set topology, exact public API packaging, event registry implementation, architecture-test tool và process-journal storage. Owner: `DB-021`; các lựa chọn này không block việc giữ logical contract ngay từ design.
