# MAP-SYSTEMS — Bản đồ toàn game

> **DRI:** Lead Game Designer
> **Status:** `DISCOVERY`

## 1. Domain map

| Domain ID | Năng lực sở hữu | Feature/System chính đã nhận diện | Trạng thái tái thẩm định |
|---|---|---|---|
| `DOM-PLAYER` | identity và tăng trưởng người chơi | awakening, level/XP, attributes, rank, talent, potential, mastery, specialization, prestige | `DISCOVERY` |
| `DOM-COMBAT` | giải quyết hành động chiến đấu | stance, input buffer, light/heavy attack, attack cadence, dodge, parry, posture, combo, damage/status, death/recovery | `DISCOVERY` |
| `DOM-SKILLS` | học, trang bị và dùng năng lực | skill library, loadout, tree, rune, synergy, class skills | `DISCOVERY` |
| `DOM-SHADOWS` | thu phục và chỉ huy bóng | corpse/echo, Arise, roster, summon/revive, identity, role, formation, command, progression, garrison | `DISCOVERY` |
| `DOM-AI` | hành vi actor không phải người chơi | perception, individual brain, squad, morale, director, LOD, social/family AI | `DISCOVERY` |
| `DOM-ENCOUNTERS` | cấu trúc thử thách có chủ đích | enemy composition, boss teaching, phase, escort, arena, failure/retry | `DISCOVERY` |
| `DOM-DUNGEONS` | lifecycle không gian instance | Gate spawn/state, objective ledger, room grammar, generation, cleanup, Break/Field, Tower | `DISCOVERY` |
| `DOM-WORLD` | thế giới persistent và vanilla integration | city, respect, home/family, events, strata, dimensions, mounts, territory | `DISCOVERY` |
| `DOM-NARRATIVE` | ý nghĩa/câu chuyện/quest | prologue, main arc, reveal, endings, character arcs, quest grammar/dialogue | `DISCOVERY` |
| `DOM-ITEMS` | ownership và biến đổi item/equipment | loot, rarity, affix, loadout, growth weapon, crafting/reforge, shadow gear | `DISCOVERY` |
| `DOM-ECONOMY` | nguồn–hút và giao dịch | currencies, sell loop, shop/catalog, price response, reward allocation | `DISCOVERY` |
| `DOM-PRESENTATION` | cách người chơi thấy/nghe/điều khiển | input, first/third camera, targeting, HUD/screen, animation, VFX, audio, onboarding | `DISCOVERY` |
| `DOM-PLATFORM` | dữ liệu và runtime boundary | data authoring, authority, save/migration, config, compatibility, mod API | `DISCOVERY` |
| `DOM-QUALITY` | oracle và ngân sách | balance, automation, playtest, performance, accessibility, localization, compatibility | `DISCOVERY` |

## 2. Shared contracts ưu tiên nền tảng

Những contract sau có fan-out cao nên phải được discovery trước feature phụ thuộc:

1. `CTR-INPUT-ACTION` — action context, remap, buffer, intent và conflict.
2. `CTR-ACTION-TIMELINE` — startup/commit/active/recovery/cancel và game tick.
3. `CTR-COMBAT-HIT` — hit authorization, attack cadence, damage instance, immunity, spam prevention.
4. `CTR-RESOURCE` — HP/Mana/Focus/Fatigue ownership, cost timing, recovery.
5. `CTR-CAMERA-TARGET` — góc 1/3, camera-relative direction, crosshair/soft/lock target.
6. `CTR-ANIMATION-EVENT` — animation state, gameplay event, hitbox và cancel synchronization.
7. `CTR-ACTOR-AUTHORITY` — client intent, server authority, prediction/correction.
8. `CTR-PERSISTENCE` — state taxonomy, save/migration/rollback.
9. `CTR-LOCALIZATION-TERM` — ID, Vietnamese/English canonical term, grammar/fallback.
10. `CTR-ACCESSIBILITY` — cue đa kênh, reduced motion, input/timing assistance policy.
11. `CTR-GATE-LIFECYCLE` — Gate/objective/exit/deadline/cleanup.
12. `CTR-CONTENT-DEFINITION` — definition/instance/schema validation/versioning.

Chi tiết/status nằm ở [Shared Contract Catalog](../30-shared-contracts/catalog.md).

## 3. Chuỗi phụ thuộc chính

```text
Input Context
→ Action Timeline
→ Attack / Dodge / Parry
→ Hit & Resource Resolution
→ Enemy Telegraph / Encounter
→ Progression & Reward
→ Shadow Capture
→ Legion Command
→ World/Narrative Consequence
```

```text
Content Definition
→ Enemy/Faction/Skill/Item/Quest authoring
→ Save/Instance State
→ Migration + Compatibility
→ Release Confidence
```

Điều này không ép thứ tự code toàn dự án; nó chỉ cho biết quyết định nào có blast radius lớn.

## 4. Capability Slice, không phải “mod con” tùy ý

Một slice hợp lệ là một đoạn trải nghiệm có thể chạy và đánh giá. Ví dụ combat foundation:

```text
Combat dummy có telegraph
→ người chơi dùng một đòn đánh theo nhịp
→ có một dodge với input/camera/animation hoàn chỉnh
→ hit server-authoritative
→ HUD/âm thanh phản hồi
→ first-person và third-person đều đọc được
→ test spam click, collision, latency và accessibility
```

Slice này nhỏ hơn “M1” cũ nhưng lớn hơn một ticket input. Nó cho feedback thật trước khi mở progression, quest hay Gate.

## 5. Inventory từ corpus cũ

Các ý sau được giữ làm `CANDIDATE`, không mặc định `DECIDED`:

- rank F→Vương Giả, level 1→100, năm attributes và ba specialization;
- shadow vĩnh viễn, Arise ba lần, Soul Echo, identity/formation/garrison;
- action combat với Focus/Fatigue, dodge/parry/combo và năm weapon class;
- faction/role/squad/morale/director, Gate lifecycle và dungeon grammar;
- Hunter City, Respect, Home/Family, strata/world events;
- skill/rune/tree, loot/affix/growth weapon và bốn currency;
- main narrative ba hồi, prologue, endings;
- data-driven content, server authority, LOD, save migration;
- no-FOMO, original-reference pipeline, performance-first.

Mỗi ý phải được migrate vào Feature Cell/Shared Contract rồi qua lifecycle.

## 6. Khoảng trống bắt buộc bổ sung

- camera/targeting hai góc nhìn;
- animation architecture và authoring contract;
- localization/terminology/string pipeline;
- quest grammar đủ cho branch, recovery, world change và sandbox;
- combat hit cadence/chống spam click;
- action context trong mining/building/item use/water/vehicle/ladder/fall;
- latency/prediction và multiplayer threat model ở mức constraint;
- design debug/observability;
- player research profiles và prototype questions;
- scope ladder: prototype → slice → alpha → 1.0 → expansion.

