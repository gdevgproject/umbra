# FEAT-NPC-LEVEL-TRAITS — Tính cách và tự bảo toàn NPC theo Level

> **DRI:** AI Designer + World Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Combat, Animation, Audio, Narrative, Accessibility, Platform, Performance, QA
> **Status:** `DISCOVERY`

## 1. Contract một câu

NPC có personality ổn định theo Level band: Level 70+ luôn biểu lộ sự kiêu ngạo với actor thấp hơn, một tỷ lệ hiếm trở thành Bully hoặc Guardian, và mọi NPC Level cao rút lui khi HP nguy kịch—bằng facts/action hợp lệ, không gian lận hoặc tốn AI vô hạn.

## 2. Vocabulary và persistence

| Term | Nghĩa |
|---|---|
| `LevelBand` | band rời nhau theo `NPC-DENSITY-*` tại [Parameter Registry](../../60-quality/02-parameter-registry.md) |
| `SocialStance` | cách giữ khoảng cách, thoại, gesture và ưu tiên tương tác; không tự sửa stat |
| `RareArchetype` | `NONE / BULLY / GUARDIAN`, seeded persistent và không reroll khi reload |
| `CriticalHealth` | `HP_current / HP_max ≤ flee_threshold(profile)`; threshold exact còn `OPEN` |
| `RescuePressure` | perceived hostile pressure lên player từ sensor/squad facts có source/expiry |

Mỗi band phải có ít nhất vài authored personality variants trong content population, kể cả band thấp. “Bắt buộc có” là coverage/content-generation invariant toàn population đủ lớn, không buộc mọi làng có mọi variant hoặc reroll entity cho tới khi đủ.

## 3. Level 70+ arrogance

Mọi NPC Level 70+ dùng stance kiêu ngạo/tách biệt khi actor đối diện có Level thấp hơn: khoảng cách, glance/turn-away, ưu tiên thoại, honorific/derision và availability có thể đổi theo context. Arrogance không đồng nghĩa Bully, không đọc private inventory/build và không làm service/quest mất không báo trước.

Actor bằng/cao Level, ally/relationship exception, emergency/combat và authored scene đi qua explicit precedence. Presentation có cooldown/variation để không spam cười/thoại; subtitle `vi_vn/en_us` và non-audio gesture bắt buộc.

## 4. Bully — cảnh cáo không thể kết liễu

Bully là subset hiếm của NPC high-level. Nó chỉ khởi phát khi sensor thấy player thấp Level, context an toàn, cooldown xong và không có hostile/emergency/service/quest protection conflict.

- Clamp authoritative là `NPC-BULLY-001` tại [Parameter Registry](../../60-quality/02-parameter-registry.md): Player luôn còn ít nhất 1 HP; ở ≤1 HP chỉ telegraph/taunt, không health commit.
- Warning action không kèm fire/DoT/fall setup, lethal knockback, chase-to-kill, theft hoặc block grief. Damage type/action tagged `NONLETHAL_WARNING` và không lách clamp qua secondary effect.
- Chỉ một warning transaction trong cooldown; duplicate target/path/action retry không multi-hit.
- Telegraph + laugh/taunt animation/audio/subtitle đi trước/sau, nhưng missing asset dùng fallback và không đổi clamp.
- Creative/Spectator, protected onboarding, menu/dialogue/trade, sleeping/downed và mode/ruleset deny rõ. Future PvP/co-op không dùng player-client truth để commit.

Mục tiêu là tạo động lực tăng trưởng, không grief/soft-lock. Comprehension/sentiment playtest phải xác nhận người chơi hiểu đây là cảnh cáo xã hội và biết đường rút/phản hồi.

## 5. Guardian — cứu viện có giới hạn

Guardian là rare archetype khác, không đồng thời Bully. Khi perceived facts cho thấy player đang bị hostile áp đảo, Guardian có thể chọn `INTERCEPT / DRAW_AGGRO / ATTACK_HOSTILE / OPEN_ESCAPE / ESCORT_OUT` theo capability và relation.

- Không đọc HP/input/target xuyên LOS/range ngoài sensor contract; không teleport/force-load chunk.
- Chỉ commit legal movement/action/hit; reservation/cooldown/target cap ngăn cả hub lao vào một trận.
- Rescue không xóa player agency, tự nhận loot/kill/quest credit hoặc kéo hostile vào làng mà không có consequence contract.
- Nếu path/target invalid, dùng visible fallback/abort reason; không path storm.

## 6. Self-preservation của NPC Level cao

Mọi NPC Level ≥70 kiểm `CriticalHealth` theo event/damage response và cadence có cap. Khi threshold đạt:

```text
COMBAT → DISENGAGE_REQUEST → RELEASE_TARGET/RESERVATION
→ SEEK_SAFE_ROUTE → RETREATING → SAFE/RECOVERING
```

- Rút lui thắng taunt/bully/rescue intent mới. Action đã tới lethal/atomic commit không bị rewind; owner interrupt theo cancel matrix.
- Safe route dựa cover/home/ally/threat facts hợp lệ; không teleport, no-clip, heal miễn phí hoặc despawn để né hậu quả.
- Không có path: giữ phòng thủ tối thiểu/seek-nearest legal cover và backoff có reason, không chạy vào lava/void/unloaded chunk.
- Boss/monster không tự kế thừa rule; feature áp cho NPC society Level cao. Authored scene chỉ defer retreat trong bounded phase nếu vẫn bảo toàn “không đứng đánh tới chết” và có ADR.

## 7. AI/animation/audio/UI/accessibility

- Personality chỉ bias candidate intent hợp lệ; không tự sửa raw HP/damage/cooldown.
- Arrogance/Bully/Guardian/Flee có semantic animation/audio events với arbitration; combat/safety cue thắng emote.
- Cue nguy hiểm và nonlethal clamp có visual + subtitle/body channel; reduced motion bỏ flourish nhưng giữ intent.
- Player có setting giảm social-taunt repetition/camera impulse, không vô hiệu gameplay warning clamp/Guardian action truth.

## 8. Authority, lifecycle và performance

- Level/archetype/profile persistent, versioned; current goal/path/reservation runtime và cleanup khi unload/death/dimension/resource reload.
- Logical server chọn intent/target/damage/retreat; client project cue. Fabric/NeoForge adapter không fork traits/save.
- Risk `PR-2`, hub stress có thể `PR-3`: event-driven health/rescue facts, spatial query cap, LOD/cadence/hysteresis và at most bounded candidate actors per incident.
- Far tiers giữ identity/archetype nhưng không chạy social/combat brain chi tiết; aggregate không được tạo unseen bully damage hoặc rescue reward.

## 9. Acceptance

- L70 vs L69/equal/higher và relationship/emergency precedence cho stance đúng, không spam.
- Bully qua các boundary sinh từ `NPC-BULLY-001`, gồm HP trên/dưới ngưỡng sống tối thiểu, duplicate/multi-hit và secondary effect, luôn giữ player ≥1 HP.
- Guardian pressure/LOS/path/target unload/multiple Guardian cho bounded, fair rescue và reward ownership đúng.
- NPC L70+ qua exact critical threshold, no-path, hit interrupt, reload/unload đều rút lui/cleanup đúng.
- Variant seed/save/migration không reroll; mỗi Level band qua content coverage validator có personality variety.
- Hub stress/LOD không scan toàn population mỗi tick, path storm hoặc làm mất legal committed action.

## 10. Open decisions

- Rare incidence/seed distribution và minimum content-population sample cho mỗi band.
- Relative-Level gap/context/cooldown của Bully; `warning_damage_profile` trong nonlethal clamp.
- Guardian `RescuePressure` threshold/role selection và reward/aggro policy.
- Flee HP threshold/safe-node scoring/recovery profile. Các parameter này không được mở lại nonlethal/flee invariants.
