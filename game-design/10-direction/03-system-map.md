# MAP-SYSTEMS — Bản đồ toàn game

> **DRI:** Lead Game Designer
> **Status:** `DISCOVERY`

## 1. Domain map

System Map là **chỉ mục toàn cục** của ownership và dependency, không tự sở hữu ranh giới: [`GOV-ARCH`](../00-governance/01-document-architecture.md) sở hữu tiêu chí tách/ghép; từng Domain Charter sở hữu mission/invariant; Shared Contract sở hữu giao diện; Production sở hữu thứ tự. Vì vậy đổi một row ở đây luôn phải đối chiếu charter/contract/backlog, không được coi việc vẽ lại bảng là đã tái kiến trúc game.

| Domain ID | Năng lực sở hữu | Feature/System chính đã nhận diện | Trạng thái tái thẩm định |
|---|---|---|---|
| `DOM-PLAYER` | identity, năng lực thân thể và tăng trưởng người chơi | Level/XP 1→100+, capability mastery, Free Climb, Hạ Kình, Khinh Công | `DISCOVERY` |
| `DOM-COMBAT` | giải quyết hành động chiến đấu | stance, input buffer, light/heavy attack, attack cadence, Vigor Dodge, parry, stagger states, combo, HP/damage/status, Combat Flask interaction, death/recovery | `DISCOVERY` |
| `DOM-SKILLS` | học, trang bị và dùng năng lực | skill library, loadout, tree, rune, synergy, class skills | `DISCOVERY` |
| `DOM-SHADOWS` | thu phục và chỉ huy bóng | corpse/echo, Arise, Retinue slot 1→8, active cap 4, reserve, summon/revive, identity, role, formation, command, progression, home assignment | `DISCOVERY` |
| `DOM-AI` | hành vi actor không phải người chơi | perception, individual brain, squad, morale, director, LOD, social/family AI, Level personality/Bully/Guardian/flee | `DISCOVERY` |
| `DOM-DUNGEONS` | lifecycle không gian instance | Gate spawn/state, objective ledger, room grammar, generation, cleanup, Break/Field, Tower | `DISCOVERY` |
| `DOM-ENCOUNTERS` | cấu trúc thử thách có chủ đích | enemy composition, boss teaching, phase, escort, arena, failure/retry | `DISCOVERY` |
| `DOM-WORLD` | thế giới persistent và vanilla integration | city, Level-power/density hubs, respect, home/family, events, strata, dimensions, mounts, territory | `DISCOVERY` |
| `DOM-NARRATIVE` | ý nghĩa/câu chuyện/quest | prologue, main arc, reveal, endings, character arcs, Quest Kernel/content/dialogue | `DISCOVERY` |
| `DOM-ITEMS` | ownership và biến đổi item/equipment | loot, rarity, affix, loadout, growth weapon, crafting/reforge, shadow gear | `DISCOVERY` |
| `DOM-ECONOMY` | nguồn–hút và giao dịch | currencies, sell loop, shop/catalog, price response, reward allocation | `DISCOVERY` |
| `DOM-PRESENTATION` | cách người chơi thấy/nghe/điều khiển | versioned input/actions, camera-relative movement/facing, core third-person default, first-person support, aim/targeting, fixed-width combat HUD, UI design system, animation, VFX, audio, onboarding | `DISCOVERY` |
| `DOM-PLATFORM` | foundation, dữ liệu và runtime boundary | kernel, authority/ownership/security seams, portable save/migration/recovery, Fabric-first/NeoForge-ready loader ports | `DISCOVERY` |

UMBRA hiện có **13 product/design domain**. `DOM-ITEMS` và `DOM-ECONOMY` dùng hai charter/DRI riêng dù đang co-locate trong một gói đọc. `Quality`, `Content`, `Production`, `Research` và `Governance` là cross-cutting plane: chúng chứng minh/author/xếp thứ tự/quản trị domain nhưng không sở hữu gameplay outcome.

### Boundary watch — chưa phải lệnh tách

| Boundary đang theo dõi | Giữ hiện trạng vì | Trigger phải audit lại |
|---|---|---|
| `DOM-PLAYER` ↔ `SYS-PLAYER-TRAVERSAL` | traversal vẫn là player-owned physical capability và acquisition/progression cần một mission thống nhất | non-player traversal hoặc release/state owner độc lập buộc Progression review lặp vô ích |
| `DOM-NARRATIVE` ↔ `SYS-QUEST` | Quest Kernel phục vụ delivery/meaning, còn Platform chỉ cung cấp persistence/orchestration primitive | quest trở thành general activity runtime có approver/lifecycle độc lập với Narrative content |
| các system trong `DOM-PRESENTATION` | input→camera→animation→UI/audio là một communication/control surface cần coherence | backlog/lifecycle cho thấy UI, Camera hoặc Animation thường bị chặn bởi review không liên quan và chỉ giao tiếp qua contract hữu hạn |
| `DOM-ITEMS` ↔ `DOM-ECONOMY` | đã tách ownership/state nhưng co-locate để reward loop dễ đọc | physical navigation quá tải; không nhập lại domain chỉ vì feature cross-domain như Flask |

## 2. Shared contracts ưu tiên nền tảng

Những contract sau có fan-out cao nên phải được discovery trước feature phụ thuộc:

1. `CTR-INPUT-ACTION` — action context, remap, buffer, intent và conflict.
2. `CTR-ACTION-TIMELINE` — startup/commit/active/recovery/cancel và game tick.
3. `CTR-COMBAT-HIT` — hit authorization, attack cadence, damage instance, immunity, spam prevention.
4. `CTR-RESOURCE` + `CTR-VITALS-HUD` — cost transaction; một HP truth, một Vigor action resource, damage mapping và fixed-width HUD.
5. `CTR-CAMERA-TARGET` — core rig góc 3, góc 1, aim basis, obstruction, crosshair/soft/lock target.
6. `CTR-ANIMATION-EVENT` — animation state, gameplay event, hitbox và cancel synchronization.
7. `CTR-ACTOR-AUTHORITY` — client intent, server authority, prediction/correction.
8. `CTR-PERSISTENCE` — state taxonomy, save/migration/rollback.
9. `CTR-LOCALIZATION-TERM` — ID, Vietnamese/English canonical term, grammar/fallback.
10. `CTR-ACCESSIBILITY` — cue đa kênh, reduced motion, input/timing assistance policy.
11. `CTR-GATE-LIFECYCLE` — Gate/objective/exit/deadline/cleanup.
12. `CTR-CONTENT-DEFINITION` — definition/instance/schema validation/versioning.
13. `CTR-CAPABILITY-OWNERSHIP` — availability, owner, death/reconnect/creative/migration policy.
14. `CTR-MULTIPLAYER-READINESS` — logical-server authority, ownership, packet/security/sync seams.
15. `CTR-PERFORMANCE-BUDGET` — budget, representation/degradation và evidence theo risk.
16. `CTR-LOADER-PORTABILITY` — common semantics/schema, loader ports, adapter conformance và artifact parity.
17. `CTR-SHADOW-RETINUE` — slot/membership/claim/active cap dùng chung Capture, AI, UI, Balance và Save.
18. `CTR-TRAVERSAL` — locomotion state, Vigor, climbable surface, fall transition và authority dùng chung Player, World, Combat, Camera, Animation và Save.

Chi tiết/status nằm ở [Shared Contract Catalog](../30-shared-contracts/catalog.md).

## 3. Chuỗi phụ thuộc chính

```text
Pinned Fabric Baseline + Foundation Kernel + Loader Boundary + Test/Diagnostics
→ {Camera/Movement/Aim train ∥ Skill Definition/Preview/Grant train}
→ Action Registry/Localization/UI/HP–Vigor primitives
→ Traversal State/Surface/Vigor → Level-1 Dodge + Free Climb/Mantle
→ Action Timeline/Hit
→ Hạ Kình + Level-10 Lightness + Combat Flask action
→ Hit, Vitals & Resource Resolution + Early Danger exemplar
→ Enemy Telegraph / Encounter
→ Quest Kernel / Persistent Activity
→ Minimal Becoming Spine / Production Reward / Return Record
→ Shadow Capture
→ Retinue Capacity / Command / Expression
→ World/Narrative Consequence
```

```text
Content Definition + Asset Registry + Instance Architecture
→ Discovery Portfolio: transformed-familiar + frontier novelty + systemic recombination
→ Enemy/Faction/Skill/Item/Quest exemplars
→ Save/Instance State
→ Migration + Compatibility
→ Release Confidence
```

Điều này không ép thứ tự code toàn dự án; nó chỉ cho biết quyết định nào có blast radius lớn.

## 4. Capability Slice như mod độc lập có contract

Một slice hợp lệ là một đoạn trải nghiệm có thể chạy và đánh giá như một mod độc lập về outcome, nhưng vẫn nằm trong modular monolith và dùng public contracts chung. Ví dụ Camera snapshot:

```text
Camera room kiểm mine/place/occlusion/aim
→ movement/facing/first-person parity
→ flag/rollback và lifecycle tests
→ snapshot dùng được mà không cần Skill/Combat content
```

Skill Platform snapshot tương tự: definition/validation → full preview → Level 1/5 grant ledger → equip sandbox → một exemplar skill/dummy → save/migration/rollback. Slice lớn hơn một ticket class nhưng nhỏ hơn combat/progression hoàn chỉnh.

## 5. Candidate inventory toàn game

Các ý sau được giữ làm `CANDIDATE`, không mặc định `DECIDED`:

- Level 1→100+, skill/loadout/gear/capability mastery không có Rank/Primary Attributes/Potential/Prestige;
- Shadow vĩnh viễn, Arise ba lần, Soul Echo, Retinue slot 1→8/active cap 4, identity/formation/home assignment;
- action combat với Vigor Dodge, parry/combo và weapon families; không Mana/Focus/Fatigue/Posture meter;
- vertical traversal với Vigor, Free Climb, Hạ Kình và Khinh Công universal mở sớm;
- faction/role/squad/morale/director, Gate lifecycle và dungeon grammar;
- Hunter City, Respect, Home/Family, strata/world events; sinh thái/sinh vật/cơ chế mới phải tạo discovery decision thay vì reskin/catalog;
- skill/rune/tree, loot/affix/growth weapon và bốn currency;
- main narrative ba hồi, prologue, endings;
- data-driven content, server authority, LOD, save migration;
- no-FOMO, original-reference pipeline, performance-first.

Mỗi ý đã có domain owner; chúng phải đi qua Feature Cell/Shared Contract và lifecycle trước triển khai.

## 6. Những vùng discovery ưu tiên

- camera/targeting hai góc nhìn như core capability;
- animation architecture và authoring contract;
- localization/terminology/string pipeline;
- vanilla 26.2 key inventory, action catalog, ergonomic default layout và conflict UX;
- UI information architecture/design tokens cho số lượng screen/object lớn;
- quest grammar đủ cho branch, recovery, world change và sandbox;
- combat hit cadence/chống spam click;
- action context trong mining/building/item use/water/vehicle/ladder/fall;
- latency/prediction và multiplayer threat model ở mức constraint;
- design debug/observability;
- player research profiles và prototype questions;
- scope ladder: prototype → slice → alpha → 1.0 → expansion.
- Minecraft lifecycle: load/save/quit/death/respawn/creative/dimension/reconnect/crash recovery;
- world backup/restore/USB transfer và version port train;
- asset provenance/AI/originality/LOD/VFX-audio budget và content interaction scale;
- early-game player–zombie–world pressure;
- engineering/Git/test handoff để Agent mới không phụ thuộc lịch sử chat.
- performance risk routing `PR-0–PR-3` và benchmark selection tự động theo impact;
- Fabric adapter/import boundary, canonical save và future NeoForge conformance/port train.
- voxel surface/collision, Vigor, fall conversion, Khinh Công và world sequence-break/follower response.
