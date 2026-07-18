# CTR-VITALS-HUD — Sinh lực, Mana, Focus và HUD chiến đấu

> **Owner:** Combat Systems + UI/UX
> **Approver:** Game Director + Lead Game Designer + Technical Director
> **Reviewers:** Balance, Items, Platform, Accessibility, Localization, QA, Performance
> **Status:** `PROPOSED`

## 1. Player outcome và quyền sở hữu

Người chơi đọc được trong một cái liếc: còn chịu được bao nhiêu sai lầm, còn đủ Mana/Focus cho hành động nào, vừa mất gì và vì sao. Tăng Max HP/Mana/Focus làm thanh **đầy hơn về năng lực**, không làm HUD dài thêm hoặc sinh hàng tim tràn màn hình.

Contract này sở hữu:

- biên giữa Minecraft health/damage substrate và UMBRA combat semantics;
- topology/presentation của HP, Mana, Focus, absorption và hunger trong HUD;
- policy khi max value đổi, save/reload/migration và fallback;
- environmental-damage classification dùng chung Combat, Items, World, Death và QA.

Exact formula, số HP/Mana/Focus, cost, regeneration, color/art asset và layout pixel thuộc `DB-042/046` + Parameter Registry/prototype. Cost transaction vẫn theo [`CTR-RESOURCE-MODIFIER`](02-resource-and-modifier-contract.md).

## 2. Một nguồn HP—not parallel health

Direction kiến trúc:

```text
Minecraft/UMBRA DamageSource + authoritative context
→ classify semantic/category/tags
→ UMBRA attack/environment/status modifiers
→ vanilla-compatible mitigation/effect hooks theo policy
→ một final health commit trên logical server
→ death/attribution/telemetry + HUD projection
```

- `LivingEntity` health và `MAX_HEALTH` là authoritative storage/substrate cho player và living actor. UMBRA **không tạo thanh “RPG HP thật” song song** rồi cố đồng bộ với tim vanilla.
- Damage type/source/tag, attacker/owner, action/hit ID và environmental context không được làm mất khi đi qua UMBRA pipeline.
- Combat damage có UMBRA formula; vanilla/environmental source đi qua một mapping tập trung. Không patch từng nguồn rơi/lửa/ngạt ở feature rời.
- Final commit idempotent: packet/retry/render frame không được trừ HP hai lần.
- Death, advancement/stat, gamerule/mode, command, resistance, absorption và death message phải có compatibility scenario; thứ unsupported phải fail/communicate rõ, không im lặng bỏ damage.
- Max HP có thể tăng theo progression nhưng raw numerical band phải được simulation và giữ ổn định. Fantasy tăng trưởng không được dựa vào số cực lớn gây precision, UI hoặc content-migration debt.

## 3. Environmental Damage Matrix

Mỗi source profile khai `semantic`, `magnitude_model`, `mitigation_tags`, `bypass`, `cadence`, `cue`, `attribution`, `difficulty/mode`, `death/recovery` và test fixture.

| Family | Intent phải bảo tồn | Không được giả định trước research |
|---|---|---|
| Mob/projectile/explosion | combat source, owner, hit cadence/counterplay | mọi thứ dùng cùng armor formula |
| Fall/kinetic | độ cao, landing/collision và mitigation mobility có nghĩa | Max HP cao làm rơi vô hại; Dodge xóa fall damage mặc định |
| Fire/lava/hot block | buildup/tick/resistance và thoát vùng nguy hiểm đọc được | mỗi tick flat mãi hoặc tất cả là % Max HP |
| Drowning/oxygen | oxygen warning trước health consequence | Mana/Focus thay oxygen; ngạt bị armor chặn |
| Suffocation/cramming | thoát geometry, anti-stuck/recovery | tick vô hạn không diagnostics |
| Hunger/starvation | giữ vòng survival/gamerule/difficulty có nghĩa | Combat Flask thay đồ ăn hoặc no-food build miễn phí |
| Poison/wither/magic/status | source, buildup/duration/dispel/resistance riêng | gộp mọi DoT thành một elemental multiplier |
| Void/kill/admin/script | recovery/lethal policy rõ theo mode/activity | dùng như damage thường có thể tank vô hạn |

Magnitude model có thể là `ABSOLUTE`, `PERCENT_MAX`, `HYBRID`, `SOURCE_FORMULA` hoặc `SCRIPTED_LETHAL`, nhưng exact mapping chỉ approve sau matrix simulation. Mục tiêu là growth vẫn nhìn thấy mà hazard quan trọng không thành trang trí.

## 4. Fixed-width combat HUD

### Player vitals cluster

- **Health:** bar chính có current/max normalized fill, damage-lag/preview layer và low-health state. Numeric current/max là setting hoặc context, không buộc mọi người nhìn số.
- **Absorption/barrier:** lớp khác màu/pattern/icon, không giả là Max HP vĩnh viễn và không chỉ dựa màu.
- **Mana:** fixed-width bar riêng, cho thấy available/reserved/insufficient; không nối dài theo INT.
- **Focus:** fixed-width bar hồi nhanh, chỉ hiện bền khi combat/recovery liên quan. Notch/ghost cost cho biết còn thực hiện được bao nhiêu Dodge/defensive action theo loadout hiện tại.
- **Hunger:** vẫn là survival resource của Minecraft. Ngoài combat có thể dùng presentation vanilla/adapted; trong combat HUD không được che mất nó hoặc giả nó là Focus.
- **Combat Flask:** một quick-recovery icon + charge count + unavailable/interrupted state; không thêm mười icon chai khi capacity tăng.

Vanilla heart layer được thay/ẩn có chủ đích khi UMBRA HUD hoạt động để không hiển thị hai nguồn truth. Nếu UMBRA HUD/resource asset lỗi, safe fallback phải hiện health tối thiểu bằng vanilla/debug presentation thay vì làm người chơi mù.

### Target health

- Boss/encounter owner có bar cấp encounter; target thường chỉ hiện plate/context khi cần đọc.
- Không world-space health bar trên mọi mob mọi lúc.
- Enemy Max HP lớn không làm thanh dài; phase/posture/barrier/status là layer riêng khi tạo quyết định.
- Damage number density/adaptive aggregation theo Balance/UI/Performance contract; bar không thay damage attribution/recap.

## 5. Resource semantics

### Mana

- UMBRA custom resource, server-authoritative, persistent theo ownership matrix.
- Mỗi spend có reserve/commit/refund ID; không âm, không double-charge, không regen từ render FPS.
- Skill/Shadow summon có cost policy riêng; Retinue cơ bản không có upkeep theo thời gian.
- Max/regen/cost/progression được cap và data-driven. Equipment swap/reload không tạo Mana miễn phí.

### Focus

- Short-horizon defensive resource cho Dodge/parry/defensive burst; **không** bị tiêu bởi đi bộ, chạy, đào, leo hoặc bơi cơ bản.
- Hồi nhanh theo server clock sau recovery delay; purpose là ngăn spam và tạo nhịp, không bắt người chơi chờ lâu giữa traversal.
- Progression có thể mở bounded capacity/recovery/efficiency/milestone, nhưng không cho Dodge miễn phí, i-frame vô hạn hoặc đổi muscle-memory timing bằng stat tùy tiện.
- HUD notch dựa cost thực của action. Khi modifier làm cost đổi, preview/notch phải đổi cùng authoritative definition.

### Khi Max thay đổi

- Equip/config/migration làm Max tăng không mặc nhiên heal/refill; giữ current rồi clamp vào Max mới.
- Max giảm clamp current an toàn và ghi reason; không gây death im lặng do migration.
- Level-up/rest/reward có thể refill bằng event explicit, không bằng side effect của modifier ordering.
- Login/reload/resource-pack reload không reset current HP/Mana/Focus.

## 6. Vanilla food, potion và UMBRA recovery

- Food giữ hunger/saturation, survival preparation và out-of-combat recovery; thời gian ăn/giữ phím vanilla không bị xóa toàn cục.
- Vanilla healing potion/golden food/status consumable vẫn là item hợp lệ qua compatibility mapping và hotbar/use action của chúng.
- Dedicated [Combat Flask](../20-domains/10-items-economy/03-combat-flask-and-quick-recovery.md) tạo recovery nhanh bằng một action riêng; không biến mọi food/potion thành instant quick-use.
- Healing, regeneration, life-steal, food regen, command/Creative và flask đều phát authoritative `HealthChange` có source/transaction ID để death recap/test phân biệt được.

## 7. Camera, accessibility và localization

- Player vitals ở cùng safe region trong first/third person; chuyển camera không reset/duplicate meter animation.
- Critical health/resource cue có visual + optional audio/haptic channel; colorblind pattern/icon và reduced motion bắt buộc.
- Scale, safe area, opacity, number visibility, damage flash và contextual visibility có setting; không cho ẩn hoàn toàn cue bắt buộc trong mode competitive tương lai nếu ruleset yêu cầu.
- Label/help/error dùng `vi_vn`/`en_us`; số/decimal/abbreviation theo locale policy.

## 8. Authority, persistence và compatibility invariants

- Client HUD chỉ project snapshot; không tự tính final damage, healing, cost hoặc resource regen.
- Health dùng player/living-entity save substrate; Mana/Focus/flask state có schema/version/migration và world backup coverage.
- Integrated/dedicated cho cùng outcome; reconnect không heal/refill hoặc replay damage.
- Creative/Spectator/Hardcore/difficulty/keep-inventory không được vô tình dùng cùng recovery eligibility nếu mode contract khác.
- Fabric/NeoForge adapter không fork resource semantics/save; HUD hook là loader/client adapter theo portability contract.

## 9. Proof matrix để approve

- Mọi environmental family: damage, mitigation, attribution, death, reload và difficulty/mode.
- Max HP/Mana/Focus đổi do level/equip/status/respec/migration, kể cả swap spam/exploit.
- absorption/barrier/heal/regen/overheal/DoT cùng tick; ordering và rounding boundary.
- first/third person, GUI scale, `vi_vn/en_us`, colorblind/reduced-motion, missing asset và HUD fallback.
- death/respawn/reconnect/dimension/portal/save/restore/Creative/Hardcore.
- performance: burst damage numbers/status + no per-frame allocation/duplicate sync; screenshot baselines và HUD comprehension playtest.

## 10. Open decisions có owner

- `DB-046`: health numerical band, Max scaling, environmental magnitude matrix, Mana/Focus topology và combat HUD prototype.
- `DB-042`: attribute/damage/defense/counter/Potential relationship và approved formulas.
- UI/Accessibility: layout/tokens/visibility settings sau low-fi + two-camera prototype.

