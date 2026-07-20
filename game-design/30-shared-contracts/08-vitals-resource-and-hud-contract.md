# CTR-VITALS-HUD — HP, Vigor và HUD

> **Owner:** Combat Systems + Player Traversal + UI/UX
> **Approver:** Game Director + Lead Game Designer + Technical Director
> **Reviewers:** Balance, Skills, Items, Platform, Accessibility, Localization, QA, Performance
> **Status:** `PROPOSED`

## 1. Outcome và topology đã khóa

Người chơi đọc được trong một cái liếc: còn bao nhiêu HP, còn bao nhiêu Vigor cho Dodge/Sprint Burst/Free Climb/Lightness và vì sao resource chưa hồi. UMBRA chỉ sở hữu hai mutable core meters:

1. `HP`: health authoritative duy nhất, dùng substrate/lifecycle Minecraft.
2. `Vigor`: custom action resource duy nhất, canonical tại [`CTR-TRAVERSAL`](09-traversal-state-surface-and-vigor-contract.md).

Mana, Focus, Fatigue và Posture meter không tồn tại. Skill/AI/Combat không được tạo một resource bar khác dưới tên mới. Stagger/launch/guard-break nếu có là typed state/action result có duration/immunity/recovery, không là hidden Posture pool.

Vanilla hunger/saturation/oxygen/absorption vẫn là Minecraft-owned survival/temporary state. Chúng không trở thành UMBRA core progression meter, không bị đổi tên thành Vigor và không bị xóa khỏi behavior chỉ để HUD có hai thanh. Presentation có thể dùng indicator vanilla/adapted nhưng không được hiển thị như một nguồn HP/Vigor thứ hai.

## 2. Một HP truth tương thích Minecraft

```text
Minecraft/UMBRA DamageSource + authoritative context
→ semantic/category/tag classification
→ approved mitigation/effect mapping
→ một final health commit trên logical server
→ death/attribution/stat/advancement + HUD projection
```

- `LivingEntity` health và `MAX_HEALTH` là authoritative storage cho player/living actor. Không có “RPG HP thật” song song.
- Damage giữ source/type/tag, attacker/owner, action/hit ID, world context và operation ID; retry/render frame không trừ hai lần.
- Combat damage có UMBRA formula sau discovery; environmental/vanilla source đi qua một matrix tập trung, không patch rải theo feature.
- Death, resistance, absorption, potion, command, gamerule, difficulty/mode, stat/advancement và death message có compatibility scenario.
- Max HP tăng không sinh thêm hàng tim; numerical band cần simulation để tránh precision/UI/save debt.

## 3. Environmental Damage Matrix

Mỗi family khai magnitude model, mitigation/bypass, cadence, cue, attribution, mode/difficulty, death/recovery và fixture:

| Family | Intent giữ |
|---|---|
| mob/projectile/explosion | source/action/counterplay và armor mapping |
| fall/kinetic | height/velocity/landing; Hạ Kình chỉ convert đúng valid impact |
| fire/lava/hot | thoát vùng nguy hiểm và tick/source rõ |
| drowning/oxygen | oxygen warning trước HP consequence |
| suffocation/cramming | anti-stuck/recovery và geometry source |
| hunger/starvation | Minecraft survival/gamerule có nghĩa; Vigor không thay food |
| poison/wither/status | source/duration/dispel/resistance riêng |
| void/admin/scripted lethal | policy theo mode; không tank vô hạn mặc định |

Model có thể `ABSOLUTE / PERCENT_MAX / HYBRID / SOURCE_FORMULA / SCRIPTED_LETHAL`; exact mapping còn discovery. Hạ Kình xóa 100% fall component tại đúng impact nhưng không xóa lava/void/status.

## 4. Vigor truth

- Max/regen/delay canonical là `VIG-MAX/REGEN/DELAY-001`.
- Action cost canonical là `VIG-DODGE/CLIMB/CLIMB-JUMP/GROUNDING/LIGHTNESS-001`.
- `Idle`, `Walk`, `Sneak` cho hồi sau delay; `Sprint`, `Clinging`, `Airborne` không hồi.
- Current/max/reservation/recovery authoritative trên logical server; client chỉ predict/project. Không regen theo FPS, reconnect/equip/max-change không refill.
- Exact rounding/endurance/milestone ledger nằm tại [`QLT-PARAMETERS`](../60-quality/02-parameter-registry.md); resource transaction theo [`CTR-RESOURCE-MODIFIER`](02-resource-and-modifier-contract.md).

## 5. Fixed-width HUD

- **HP:** fixed-width bar với current/max normalized fill, damage preview/lag layer, absorption overlay riêng và low-health state. Numeric là setting/context.
- **Vigor:** fixed-width bar với current/max, reserved overlay, next-action ghost/notch, recovery-delay/recovering reason và low/critical pattern. Từ Level 1 nó là meter ổn định của movement-action system; contextual fade chỉ được dùng nếu comprehension proof tốt hơn always-visible profile.
- **Hunger/oxygen/absorption/status:** Minecraft-owned indicators hoặc adapted cues ở layout priority riêng; không giả thành core bar và không bị HUD che mất.
- **Combat Flask:** icon + charge/unavailable/interrupt state; không là resource bar mới.
- Vanilla hearts được thay/ẩn có chủ đích khi UMBRA HP HUD hoạt động để không có hai health presentations. Missing asset/mod disable dùng safe vanilla/debug fallback.

Vigor low/critical dùng icon/pattern + optional audio/body/haptic, không chỉ màu. GUI scale, safe area, chat/subtitle, boss bar, first/third person, reduced motion, colorblind và `vi_vn/en_us` cần screenshot/comprehension proof.

## 6. Max change, save và migration

- Max tăng: giữ current; chỉ refill bằng event explicit.
- Max giảm: clamp current an toàn, có reason; migration không gây death im lặng.
- Login/reload/resource-pack reload không reset HP/Vigor.
- Vigor current/max/milestone ledger versioned trong world-owned save; runtime contact/action/reservation cleanup theo owner.
- Field Mana/Focus/Fatigue/Posture cũ chỉ được đọc bởi migration/quarantine diagnostic; không tiếp tục serialize hoặc convert ngầm thành Vigor/HP. Compensation cần ADR.
- Integrated/dedicated cho cùng outcome; Fabric/NeoForge adapter không fork semantics/save.

## 7. Skill, food và recovery interop

- Skill combat dùng cooldown/charge/condition/commitment cho tới khi design nêu lý do movement action dùng Vigor; không tự tạo Mana.
- Food giữ hunger/saturation, preparation và Minecraft use timing. Combat Flask là quick recovery riêng; không biến mọi food thành instant use.
- Heal/regen/life-steal/food/potion/flask/command đều phát `HealthChange` có source/operation ID.
- Dodge/Climb/Lightness spend Vigor qua cùng ledger nhưng mỗi input chỉ có một consumer/cost. Hạ Kình valid impact không spend/drain/refund Vigor.

## 8. Proof matrix

- HP: mọi damage family, absorption/heal/DoT same-tick, death/respawn/reconnect/difficulty/mode/command/advancement.
- Vigor: exact cost/regen/delay/rounding, zero/exact-cost/max-change, duplicate/out-of-order, death/reconnect/equip/migration.
- Minecraft: hunger/starvation/food/oxygen/status/ladder/Creative/Hardcore vẫn có behavior và readable presentation.
- HUD: first/third, GUI scale/safe area, locale, missing asset, colorblind/no-audio/reduced-motion và vanilla fallback.
- Performance: no per-frame allocation/duplicate sync; dense hit/status/UI burst trong budget.

## 9. Open decisions

- HP/damage/environment numerical curves và Combat Flask balance.
- Vigor low/critical bands, rounding resolution và exact milestone schedule **bên trong** cap/cost/regen đã khóa.
- HUD always-visible hay contextual-fade profile; không được dùng lựa chọn này để giấu Vigor khi người chơi cần quyết định Dodge.
