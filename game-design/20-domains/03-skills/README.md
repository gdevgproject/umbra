# DOM-SKILLS — Skill System

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

## Contract

Mỗi skill phải thay đổi một động từ, timing, target, vị trí hoặc preparation; không tồn tại chỉ để cộng số. Exact loadout cap vẫn cần prototype để giữ trần thao tác, trong khi library và full-future preview tạo build. Không còn class/rank/Primary Attribute gate.

“Phối hợp thành bộ kỹ năng” không đồng nghĩa một rotation cố định. Mỗi loadout phải khai `setup`, `conversion`, `mobility/defense`, `resource/commitment`, `countered-by` và ít nhất một quan hệ với weapon/Shadow/world state; hai kỹ năng chỉ cộng multiplier cho nhau không đủ gọi là synergy. Proof kiểm cả đường ứng biến khi combo lý tưởng bị ngắt, tránh build chỉ hoạt động trên dummy hoặc macro.

## Ba nguồn

| Tầng | Nguồn | Vai trò |
|---|---|---|
| Passive | tree/mastery/gear | định hình build |
| Active | tree + rune loot | quyết định trong combat |
| Signature | Level/content progression | fantasy signature như Arise, Storage, Exchange, Domain; không phụ thuộc Rank |

Dodge, Free Climb, Hạ Kình và Khinh Công là **universal techniques**, không chiếm combat loadout và không nằm trong build choice. Skill domain có thể cung cấp bounded modifier/variant sau này nhưng không sở hữu core access/state; canonical owner là [Traversal System](../01-player/traversal/README.md) và Dodge Feature Cell.

Nhịp Không Trung/Double Jump và Aerial Dodge là future capability/skill candidates. Nếu tree/rune/loadout cấp quyền dùng hoặc modifier, execution vẫn thuộc [`FEAT-TRAVERSAL-AERIAL-STEP`](../01-player/traversal/04-aerial-step.md), [`FEAT-COMBAT-AERIAL-DODGE`](../02-combat/dodge/aerial-dodge.md) và `CTR-TRAVERSAL`; Skill Definition không được tự reset aerial use, gọi actor attached là airborne hoặc tạo resource ngoài Vigor.

## Acquisition và transparency invariants

- Level 1 có đúng một active skill đã biết.
- Mọi Level chia hết cho 5 từ 5 trở đi phát đúng một unlock event idempotent của authored line.
- Grant có thể là skill/node/slot theo line; loadout cap độc lập, nên cadence không làm hotbar tăng vô hạn.
- Từ Level 1, Library/Tree cho xem toàn bộ skill tương lai: stable ID, requirement, role, target, cost/cooldown/charge, damage/effect range, condition/counter, weapon/world interaction và animation preview/fallback.
- Hidden surprise có thể dành cho narrative discovery, nhưng không được giấu thông tin khiến build thành bẫy. Nếu reveal là spoiler, UI vẫn phải công bố gameplay contract trước commitment.
- Update/migration không âm thầm đổi line: preview version, changed marker và compensation/reselection policy bắt buộc.

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

## Tài liệu

- [Tree, rune, synergy và signature skills](01-tree-runes-synergies-and-class-skills.md)
- [Skill acquisition, preview và loadout](02-skill-acquisition-preview-and-loadout.md)
