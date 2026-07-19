# QLT-MINECRAFT-LIFECYCLE — Ma trận lifecycle và mode bắt buộc

> **DRI:** QA Lead + Platform Lead
> **Status:** `DISCOVERY`

## 1. World/session lifecycle

| ID | Transition | State phải kiểm |
|---|---|---|
| `LIFE-01` | install → first launch → new world | registry/config/default schema/localization |
| `LIFE-02` | save → quit title → reload | player/world/Gate/quest/Shadow/item identity |
| `LIFE-03` | quit desktop → restart → reload | dirty/save flush, no static-state leak |
| `LIFE-04` | pause/unpause, focus lost | input buffer/camera/action clock |
| `LIFE-05` | chunk unload/reload | entity assignment, corpses/Echo, AI/LOD, timers |
| `LIFE-06` | Nether/End/custom dimension travel | owner/reference/target/camera/return path |
| `LIFE-07` | teleport/portal during action | cancel/rebind/position/idempotency |
| `LIFE-08` | datapack/config/resource reload | validation/version/fallback/no half-applied state |
| `LIFE-09` | crash/forced stop during transaction | journal/recovery/no duplicate reward |
| `LIFE-10` | upgrade save, downgrade attempt, missing definition | backup/migration/refusal/placeholder/report |
| `LIFE-11` | final previous-line release → successor candidate → save/reload | exact manifest, restore-as-copy, migration journal, invariant parity, downgrade refusal |
| `LIFE-12` | wrong Minecraft/loader/artifact or EOL line | fail-fast compatibility reason, no world mutation, correct download/support guidance |

## 2. Player lifecycle

| ID | Scenario | Questions bắt buộc |
|---|---|---|
| `PLY-01` | normal damage/death/respawn | persistent, reset, dropped, derived state nào? |
| `PLY-02` | death trong Gate/boss/Arise/command | participant/objective/target/resource/Shadow deployment? |
| `PLY-03` | disconnect/reconnect giữa action/transaction | timeout, ownership, retry, duplicate? |
| `PLY-04` | change dimension/world/respawn point | camera, target, companion, quest marker? |
| `PLY-05` | spectator/adventure/creative/survival | capability, reward, damage, interaction policy? |
| `PLY-06` | operator commands and `/give` | validation/audit/default component/progression exploit? |
| `PLY-07` | inventory full/drop/pickup/despawn/death | item identity, ownership, rollback? |
| `PLY-08` | sleep/bed/skip time | Fatigue, deadlines, events, spawn, offline clocks? |
| `PLY-09` | Hardcore death → spectator | flush/recall/cleanup; UMBRA không tạo respawn trái world rule |
| `PLY-10` | Creative ↔ Survival rồi save/reload | state giữ đúng, provenance/eligibility theo event, không taint/delete cả world |
| `PLY-11` | quit/reconnect/death/portal/dimension khi attached, launching, descending hoặc pre-impact | cleanup locomotion mode/reservation/contact/fall conversion; preserve unlock/Vigor theo contract, không ghost flight/refill |
| `PLY-12` | quit/reconnect/death/portal/dimension giữa Aerial Step/Aerial Dodge chain | cleanup action/chain/buffer/defense; không refill use/resource, ghost impulse/i-frame hoặc mất fall attribution |
| `PLY-13` | quit/reconnect/death/portal/resource reload giữa Lightness ground/wall charge, launch hoặc descent | cleanup hold/reserve/contact/gravity/chain; không relaunch, refund kép, wall-freeze, hover hoặc refill |
| `PLY-14` | lifecycle event giữa Grounding armed/arrest/descent/impact/recovery | cleanup buffer/reserve/fall conversion/hit ID; không ghost immunity, double AoE hoặc held mining reinterpret |

Mỗi persistent field có bảng `copy on death / reset / retain / derive / forbidden` trước code. Không dùng mặc định API thay cho quyết định game.

## 3. Item và creative paths

Mỗi item/weapon/skill token kiểm acquisition từ intended loot/craft, creative tab, `/give`, clone stack, split/merge, drop/pickup, container/hopper nếu hợp lệ, death, dimension, save/reload, repair/enchant/anvil, missing/old component và invalid forged data.

Item creative không có unlock/history phải:

- hoạt động với safe default;
- có provenance creative/debug và inspect được;
- chỉ bị loại khỏi challenge/ranked eligibility tương ứng, không bị vô hiệu hóa trong solo sandbox.

Không được crash, silently corrupt hoặc gây damage chỉ vì UI unlock chưa chạy.

## 4. Combat cadence/adversarial input

| ID | Input/race | Oracle |
|---|---|---|
| `COM-01` | click nhanh/hold/autoclick-like burst | action cadence cap; một intent/hit instance đúng luật |
| `COM-02` | duplicate/replayed/out-of-order packet | reject/idempotent; không double cost/damage |
| `COM-03` | target chết/despawn/unload giữa active | cancel/complete attribution an toàn |
| `COM-04` | weapon swap/drop/death/menu giữa action | snapshot/cancel policy rõ |
| `COM-05` | low TPS/high latency/FPS khác nhau | gameplay tick outcome ổn; presentation reconcile |
| `COM-06` | vanilla attack cooldown/invulnerability/sweep | coexist/override contract duy nhất |
| `COM-07` | multi-hit/AoE/projectile/DoT | declared cadence; cùng hit ID không lặp ngoài rule |
| `COM-08` | creative/spectator/permission edge | không damage/reward ngoài policy |

## 5. Server matrix

Mỗi capability chạy ít nhất integrated single-player và dedicated server one-client smoke. Future-ready lanes thêm reconnect, two-client visibility/ownership fixture chỉ để bắt singleton/client-truth bug; future performance lane có tối đa 4 automated clients theo `PERF-S08`. Không gọi các fixture đó là multiplayer gameplay support.

## 6. Exit artifact

Mỗi snapshot lưu matrix result, failing IDs, commit/schema/baseline và world fixtures. Không cho capability sau phụ thuộc một transition chưa có oracle.
