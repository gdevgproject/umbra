# FEAT-COMBAT-DODGE — Scenario inventory

> **Status:** `DISCOVERY`
> **Mục đích:** inventory câu hỏi/test; không phải expected result final.

## 1. Input và context

| Scenario ID | Given / When | Quyết định cần có |
|---|---|---|
| `DOD-S-001` | đứng yên + Dodge | neutral behavior |
| `DOD-S-002` | W/S/A/D + Dodge | direction basis/facing |
| `DOD-S-003` | hai phím chéo | normalize distance và animation sector |
| `DOD-S-004` | đổi hướng camera đúng tick intent | input sampling clock |
| `DOD-S-005` | keybind conflict/mod key | discovery/remap/fallback |
| `DOD-S-006` | giữ Dodge hoặc key repeat | một action mỗi press hay repeat policy |
| `DOD-S-007` | double-tap movement nếu option có | accessibility/conflict/off default |
| `DOD-S-008` | ngoài combat khi đang xây/đào | context/no accidental action |
| `DOD-S-009` | đang dùng shield/bow/food/block interaction | precedence/cancel/deny feedback |

## 2. Action interaction

| Scenario ID | Given / When | Quyết định cần có |
|---|---|---|
| `DOD-S-020` | light startup/active/recovery + Dodge | cancel window từng phase |
| `DOD-S-021` | heavy charge/commit/recovery + Dodge | commitment và refund |
| `DOD-S-022` | parry startup/active/recovery + Dodge | queue/cancel priority |
| `DOD-S-023` | skill cast/channel + Dodge | per-skill override contract |
| `DOD-S-024` | nhận stagger/knockdown/grab + Dodge | hard interrupt/escape rule |
| `DOD-S-025` | spam attack và Dodge packet | authority/cadence/idempotency |
| `DOD-S-026` | Dodge được buffer trước recovery end | buffer duration và feel |

## 3. Locomotion và collision

| Scenario ID | Context | Quyết định cần có |
|---|---|---|
| `DOD-S-040` | tường phẳng/góc/hành lang một block | stop/slide/shorten |
| `DOD-S-041` | slab/stair/fence/door/trapdoor | vanilla collision parity |
| `DOD-S-042` | sát mép vực | được rơi, clamp hay assist |
| `DOD-S-043` | đang nhảy/rơi/knockback | horizontal/vertical composition |
| `DOD-S-044` | nước/bơi/crawl/ladder/vine | deny hay variant riêng |
| `DOD-S-045` | mount/boat/minecart/elytra | deny/route feature khác |
| `DOD-S-046` | cobweb/powder snow/honey/soul sand | movement modifier policy |
| `DOD-S-047` | world border/portal/chunk edge | safety/authority |

## 4. Threat và defensive window

| Scenario ID | Hit category | Quyết định cần có |
|---|---|---|
| `DOD-S-060` | melee single hit | window và attack-ID resolution |
| `DOD-S-061` | projectile | direct hit/tracking/collision timing |
| `DOD-S-062` | explosion/wave | avoid/mitigate/unchanged |
| `DOD-S-063` | lingering ground hazard | entry/tick behavior |
| `DOD-S-064` | DoT đã áp dụng | có xóa tick không |
| `DOD-S-065` | fire/lava/fall/suffocation/void | environmental exclusions |
| `DOD-S-066` | grab/pin/scripted mechanic | explicit telegraph/category |
| `DOD-S-067` | multi-hit cùng attack ID | re-hit cooldown/one resolution |
| `DOD-S-068` | nhiều attack đồng thời | từng hit hay window global |
| `DOD-S-069` | perfect boundary tick | inclusive/exclusive/server clock |

## 5. Resource, authority và presentation

| Scenario ID | Given / When | Quyết định cần có |
|---|---|---|
| `DOD-S-080` | Vigor 17/18 và exact multiple | pay moment/reject cue, không âm/double charge |
| `DOD-S-081` | Vigor recovery delay/allowed/denied locomotion | authoritative regen state đúng |
| `DOD-S-082` | collision ngay startup | cost/refund |
| `DOD-S-083` | packet duplicate/out-of-order | action ID/idempotency |
| `DOD-S-084` | latency 0/50/100/200ms | prediction/fair timing/correction |
| `DOD-S-085` | switch first↔third mid-action | rule parity/camera continuity |
| `DOD-S-086` | reduced motion/camera shake off | cue redundancy |
| `DOD-S-087` | save/reload/disconnect mid-action | ephemeral state/reconnect policy |
| `DOD-S-088` | death/dimension change during action | cleanup/no ghost immunity |
| `DOD-S-089` | Max Vigor đổi khi current đang không đầy | current clamp, notch/ghost cost và không refill miễn phí |
| `DOD-S-090` | giữ W khi orbit/recenter/acquire–break lock qua ±180° | world direction không đảo đột ngột; accepted Dodge giữ basis snapshot |

## Exit của scenario inventory

Mỗi row phải có expected result, owner contract và automated/manual oracle trước khi `IMPLEMENTATION_READY`. Scenario có cùng lifecycle độc lập được tách Feature Cell; scenario chỉ là biến thể input không được biến thành ticket nghiên cứu riêng.
