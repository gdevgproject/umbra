# SYS-AI-CORE — Kiến trúc actor intelligence và fairness

> **DRI:** AI Designer + AI Engineer
> **Approver:** Lead Game Designer + Technical Director
> **Reviewers:** Combat, Shadows, Encounter, Animation, Data, Performance, QA
> **Status:** `DISCOVERY`

## 1. Outcome và ranh giới

Đối thủ phải có thể học/counter, đồng đội phải đáng tin và cá tính phải quan sát được mà không tạo một “bộ não tổng quát” biết mọi thứ. AI quyết **ý định** từ facts hợp lệ; action, damage, movement, animation và reward vẫn commit qua owner contract tương ứng.

Enemy, Shadow combat, social/family và encounter director dùng chung envelope/scheduler/trace khi semantics giống nhau nhưng giữ policy riêng. Không ép chúng kế thừa một class/policy khổng lồ.

## 2. Bốn lớp state không được nhập làm một

| Lớp | Owner/lifecycle | Ví dụ |
|---|---|---|
| Identity facts | domain persistent, versioned | role, personality, bond, doctrine, memory có hậu quả |
| Perceived facts | sensor snapshot có timestamp/confidence/source | target thấy/nghe được, threat, cover, command |
| Decision memory | runtime, bounded, hydrate/rebuild policy | current goal, reservation, cooldown reasoning, last failure |
| Action state | Action/Movement contract authoritative | attack instance, path request, cast, recovery |

Không lưu animation frame, path object, entity reference hoặc utility score như identity truth. Blackboard là typed view có owner/expiry, không là `Map<String,Object>` cho mọi system ghi tùy ý.

## 3. Pipeline hybrid

```text
bounded sensors → perceived-fact snapshot
→ safety/legality filter
→ candidate intent providers
→ utility/BT arbitration + squad reservation
→ typed intent
→ Action/Movement/Expression contract
→ result/reason → bounded memory update
```

- Behavior Tree/statechart giữ lifecycle, safety và sequence có điều kiện.
- Utility scoring chọn giữa candidate hợp lệ; score không cấp quyền bypass cost/cooldown/LOS.
- Squad brain phân vai/reservation/shared intent; không điều khiển frame animation của từng actor.
- Encounter director điều pressure/composition/reinforcement theo budget; không sửa bí mật stat/action result cá thể.
- Planner/ML/script engine chỉ được thêm khi một decision question và hai consumer thật chứng minh BT/utility không đủ; không là foundation mặc định.

AI behavior được composition từ sensor, evaluator, intent provider, role/doctrine và capability tags. Enemy/Shadow đặc biệt cần rule mới thì mở Feature/Contract; không dùng `if actor_id` rải trong engine.

## 4. Knowledge và fairness

- AI chỉ dùng fact sensor hoặc shared fact có source hợp lệ. Không đọc keypress, camera ray chưa biểu lộ, inventory kín, target xuyên vật cản hoặc private player state.
- Mỗi perceived fact khai acquisition, confidence, timestamp/expiry, sharing scope và invalidation.
- Reaction có latency/accuracy/prediction band theo archetype/difficulty; noise có seed/constraint và không đổi sau reload để “gian lận”.
- Dangerous intent đi qua same Action Timeline, cooldown, interruption, resource, hit/target authority và telegraph contract như actor tương đương.
- Difficulty ưu tiên doctrine, coordination, pattern composition và decision window; stat/latency exception phải visible và test được.
- Director không spawn sau camera tùy tiện, đọc build rồi vô hiệu hóa nó hoặc buff bí mật khi player thắng.

## 5. Thread, cadence và spatial work

- Sensor, decision, path request và social evaluation có cadence/budget riêng; không chạy toàn pipeline mỗi actor mỗi tick.
- Query dùng spatial/relevance service có cap và snapshot version; node không scan world/roster trực tiếp.
- Pure candidate scoring có thể chuẩn bị async trên immutable snapshot. Trước commit intent phải revalidate actor/world/target/version trên owner thread.
- Path queue có priority, dedupe, timeout, cancellation, backpressure và fallback; target/chunk unload không tạo path storm.
- Cache/blackboard/subscription/task bị cleanup khi entity unload, death, dimension change hoặc capability disable.

Performance/representation tiers thuộc [`QLT-PERFORMANCE`](../../60-quality/04-performance-budgets.md). Giảm LOD thay cadence/representation chứ không cho AI biết ít đi một cách làm mất legal committed action hoặc reward.

## 6. Squad, personality và expression seam

- Direct command → formation/role → squad tactic → autonomy theo owner contract; AI không tự phá lệnh để tối ưu DPS.
- Reservation có stable slot/target/action key, expiry và cleanup; duplicate/reconnect không giữ reservation ma.
- Personality biến ưu tiên, khoảng cách, cadence, expression và lựa chọn trong tập hợp hợp lệ; không tự thay damage/cooldown/authority hoặc tạo bất tuân random.
- Combat brain phát semantic/reason. [`SYS-SHADOW-EXPRESSION`](04-shadow-expression-and-ritual-coordination.md) arbitrate presentation; animation/audio không viết ngược bond/memory/command outcome.
- Relationship edge chỉ tồn tại khi tạo behavior/content consequence quan sát được; không tính mọi cặp actor mỗi tick.

## 7. LOD và hydrate/dehydrate

Mỗi actor ở đúng một representation tier. Khi hạ tier, hệ lưu identity + state tối thiểu cần giữ outcome; aggregate simulation có named seed, input facts, time window và audit result. Khi hydrate:

- stable actor/owner ID, health/resource policy, assignment, command và committed consequence không đổi;
- elapsed time được áp một lần, không nhân reward/heal/cooldown;
- position/target/path được rebind với safe fallback, không teleport visible qua geometry;
- decision memory chỉ restore phần canonical đã khai; cache/score/path rebuild.

AI ở xa không được mô phỏng chi tiết giả tạo chỉ vì save chứa nhiều identity. Deep fidelity tập trung nơi người chơi có thể quan sát/quyết định.

## 8. Debug và reproducibility contract

Mỗi decision trace ghi actor/AI profile version, LOD/cadence, perceived facts + source/age, candidates, score/legality/rejection, squad reservation, chosen intent, action result, seed và transition. Trace nối `correlation_id/causation_id` theo [`CTR-DEBUG-OBSERVABILITY`](../../30-shared-contracts/05-observability-and-recovery.md).

Inspector phải trả lời trong một view: “actor biết gì?”, “vì sao chọn/bỏ action?”, “ai giữ reservation?”, “đang chờ path/action nào?”, “vì sao degraded?”. Không log toàn blackboard/entity object graph hoặc private player data.

## 9. Failure scenarios bắt buộc

- target chết/despawn/unload giữa sense→decision→action;
- stale async score/path commit sau state/version đổi;
- two actors reserve cùng slot/target; release bị miss khi interrupt/death;
- LOD oscillation/hydrate không heal, duplicate, teleport hoặc quên command;
- AI dùng fact hết hạn/xuyên vật cản/private state;
- missing behavior/animation/content profile dùng fallback không kẹt brain;
- decision/action rejection lặp tạo busy loop/path storm/log storm;
- save/reload/reconnect/resource reload giữ identity nhưng không giữ cache/action ma;
- 1/2/4 Shadow và hostile stress vẫn giữ telegraph/command/readability trong budget.

## 10. Gate kiến trúc AI

Trước batch content AI cần hai exemplar khác nghĩa (một enemy teaching, một Shadow/ally command) chứng minh:

- cùng intent/action/trace contracts nhưng policy/knowledge khác, không giant base brain;
- typed facts/sensors, public surfaces và dependency rules qua architecture conformance;
- seeded decision fixture + stale/unload/reservation fault injection;
- LOD hydrate/dehydrate continuity và performance counters;
- content dossier thêm behavior bằng tags/profile trước khi cần engine branch.

Exact BT/utility library, blackboard representation, path API adapter, cadence/score bands và authoring tool thuộc `DB-006/009/013/018/041/045`; chưa được khóa bởi tài liệu này.
