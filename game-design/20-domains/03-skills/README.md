# DOM-SKILLS — Skill System

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

## Contract

Mỗi skill phải thay đổi một động từ, timing, target, vị trí hoặc preparation; không tồn tại chỉ để cộng số. Loadout candidate có 4 active + 1 class để giữ trần thao tác, trong khi library rộng tạo build.

“Phối hợp thành bộ kỹ năng” không đồng nghĩa một rotation cố định. Mỗi loadout phải khai `setup`, `conversion`, `mobility/defense`, `resource/commitment`, `countered-by` và ít nhất một quan hệ với weapon/Shadow/world state; hai kỹ năng chỉ cộng multiplier cho nhau không đủ gọi là synergy. Proof kiểm cả đường ứng biến khi combo lý tưởng bị ngắt, tránh build chỉ hoạt động trên dummy hoặc macro.

## Ba nguồn

| Tầng | Nguồn | Vai trò |
|---|---|---|
| Passive | tree/mastery/gear | định hình build |
| Active | tree + rune loot | quyết định trong combat |
| Monarch/Class | progression | fantasy signature: Arise, Storage, Exchange, Domain |

Free Climb, Hạ Kình và Khinh Công là **universal traversal techniques**, không chiếm `4+1` combat loadout và không nằm trong Potential. Skill domain có thể cung cấp bounded modifier/variant sau này nhưng không sở hữu core access/state; canonical owner là [Traversal System](../01-player/traversal/README.md).

Nhịp Không Trung/Double Jump và Aerial Dodge là future capability/skill candidates tại `DB-057`. Nếu tree/rune/loadout cấp quyền dùng hoặc modifier, execution vẫn thuộc [`FEAT-TRAVERSAL-AERIAL-STEP`](../01-player/traversal/04-aerial-step.md), [`FEAT-COMBAT-AERIAL-DODGE`](../02-combat/dodge/aerial-dodge.md) và `CTR-TRAVERSAL`; Skill Definition không được tự reset aerial use, gọi actor attached là airborne hoặc ghép Vigor–Focus thành một cost.

## Skill Contract bắt buộc

Fantasy/động từ; input/target; tối đa hai combat roles; cost/window; counterplay; VFX/SFX/hitbox; AI/Minecraft interaction; scaling/cap/PB; accessibility; automated/manual test.

## Kiến trúc library/execution

- `Skill Definition` là data/content versioned: stable ID, requirement/loadout tags, action reference, target contract, cost/cooldown, bounded effect composition, presentation/AI hints và migration. Runtime chỉ lưu equip/unlock/cooldown/instance state cần thiết.
- Activation đi qua `CTR-INPUT-ACTION` → `CTR-ACTION-TIMELINE` → resource transaction → typed effect/result. Client/animation không tự commit cost, hit, status hoặc cooldown.
- Effect primitive có owner tập trung (damage, status, movement, summon, world mutation). Skill không đọc/ghi field domain khác hoặc chứa script tùy ý để né contract.
- Skill tạo động từ/state/counterplay mới phải mở/reuse Feature Cell trước; data-driven không biến unknown mechanic thành một chuỗi config không test được. Một “skill nhỏ” phải tách cell nếu có target lifecycle, movement, summon/world mutation, state machine, presentation hoặc counterplay thay đổi độc lập.
- Mọi active/passive có thể bấm khi locomotion đặc biệt phải khai `Locomotion Interaction Profile` theo `CTR-TRAVERSAL`: source mode → `ALLOW_IN_PLACE / TRANSITION / SHORT_BUFFER / DENY_NO_COST / EXTERNAL_OWNER / FORCED_RELEASE`, input consumer, cost/refund, fall effect và reset guard. Thiếu profile thì deny no cost; không chạy thử ground action trên wall/air.
- Variant/rune composition có provides/requires/conflicts, stacking/precedence/cap và interaction tags; validator từ chối cycle, recursion, unbounded fan-out hoặc missing fallback.
- Không tạo class riêng cho từng skill khi chỉ khác definition; cũng không ép hero skill khác nghĩa vào universal effect graph. Representative exemplar quyết boundary theo [`CNT-INSTANCE-ARCH`](../../40-content/07-content-instance-architecture.md).
- Trace nối skill/action/resource/effect/hit IDs; inspector cho biết eligibility, resolved modifiers, rejection và authoritative result. Performance budget cap target/AoE/status/VFX cardinality.

Package, effect DSL/codec và authoring tool chỉ được khóa sau `DB-012/035` có ít nhất hai skill khác role và một skill cần mechanic mới để chứng minh đường mở rộng lẫn giới hạn abstraction.
