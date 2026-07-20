# FEAT-AERIAL-GROUNDING-STRIKE — Hạ Kình khi rơi

> **DRI:** Combat Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat, Animation, Camera, Input, VFX/Audio, World, Balance, Accessibility, Platform, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Sau bài combat đầu, người chơi đang Airborne/Falling có thể bấm fresh Primary Attack trong cue hợp lệ để chạy physics `GRD-ARREST/DESCENT-001`, triệt tiêu fall component theo `GRD-FALL-001` và tạo AoE `GRD-RADIUS-001`—không tốn Vigor, không phá block và luôn có animation fallback.

## 2. Player outcome, phạm vi và non-goals

Hạ Kình là `Universal Passive Technique`, không chiếm skill/loadout slot. Nó được onboarding rất sớm để biến một cú hụt chân khi học leo thành cơ hội vào combat, nhưng vẫn cần người chơi chủ động bấm Attack; game không auto-cast.

In scope: input context, time-to-impact, ba phase movement, landing conversion, weapon/unarmed animation adapter, entity AoE, camera/audio/VFX, authority, save cleanup, Minecraft collision/hazard và proof hai góc nhìn.

Non-goals: phá block/crop/redstone/container; platform vô hình/teleport; cứu void/admin/scripted lethal; xóa lava/fire/contact damage; hover; damage/radius vô hạn; dùng animation/root motion làm authority.

## 3. Unlock và onboarding

- Grant ngay sau combat lesson đầu tiên; không phụ thuộc Level ngoài việc new save bắt đầu Level 1.
- Training dùng drop thấp có support rõ, combat dummy và route leo lại; dạy cue → fresh Attack → impact, không dùng lava/void.
- Save cũ đã qua combat eligibility nhận catch-up grant/prompt idempotent. Snapshot implementation dùng capability flag trước Quest Kernel.

## 4. Eligibility và input ownership

Server accept khi capability đã mở, actor alive/controlled, mode `AIRBORNE` hoặc `FALLING`, có predicted landing collision trong loaded simulation và fresh Primary Attack sau `GROUNDING_ARMED` cue.

- Khoảng cách dự đoán theo `GRD-WINDOW-001`; không có design cap chỉ vì độ cao lớn.
- Scan dùng time-to-impact + swept collision với collision/support shape thật; không ray tới full-cube giả, không force-load chunk và không tin payload “gần đất” từ client.
- Held mining/Attack, key repeat, edge đã bị Climb/skill consume, screen/use/channel, `CLIMB_*`, `MANTLE_*`, swim/riding/Elytra/Creative flight/portal/death đều không cast.
- Nếu không có valid landing/cue, normal aerial attack hoặc Minecraft owner giữ Attack. Dedicated binding/accessibility profile luôn có thể thay contextual Attack nhưng dùng cùng legality.
- Attack bị deny trên tường không được sống lại sau Drop/eject; phải có fresh airborne edge.

## 5. Action lifecycle và vật lý

```text
AIRBORNE/FALLING + armed fresh Attack
→ ARREST_ORIENT [GRD-ARREST-001]
→ DESCENT_COMMIT [GRD-DESCENT-001]
→ valid swept contact: IMPACT_COMMIT → RECOVERY → SUPPORTED
→ invalidated/no contact: FALLING với source/provenance cũ
```

- `ARREST_ORIENT` hãm vận tốc Y theo `GRD-ARREST-001` và khóa **candidate corridor**, không khóa world/target entity. Horizontal correction có cap và không kéo xuyên voxel.
- `DESCENT_COMMIT` tăng tốc/giới hạn tới `GRD-DESCENT-001` qua movement owner. Mỗi tick dùng swept collision/sub-step thích hợp để không xuyên slab/thin support.
- World revision được revalidate ở commit; block đặt/phá, piston, fluid, entity blocker hoặc chunk unload có thể làm candidate mất.
- Một action/transition ID commit tối đa một descent, một landing conversion và một AoE hit instance. Retry/out-of-order không double impact.

## 6. Fall conversion và Vigor

Tại `IMPACT_COMMIT` hợp lệ:

Exact zero-fall/zero-Vigor values là `GRD-FALL-001` và `VIG-GROUNDING-001` tại [Parameter Registry](../../../60-quality/02-parameter-registry.md); feature không sở hữu bản sao con số.

Đây là triệt tiêu 100% fall damage của đúng cú đáp, không phải global immunity. Fall component đã convert không làm mất attribution của action. Lava/fire/hot block/status vẫn gây hậu quả riêng; void/no support/interrupt trước commit giữ fall rule bình thường. Water/slime/hay/powder-snow/bed adapter tránh double mitigation hoặc bounce ngoài ý muốn.

## 7. AoE math và target rule

`h` là vertical loss tính từ stable support gần nhất trong cùng airborne lineage tới impact, tính cả đoạn rơi trước lúc bấm Attack. Formula, samples, quantization và cap canonical là `GRD-RADIUS-001` tại [Parameter Registry](../../../60-quality/02-parameter-registry.md). Height trên cap vẫn được cast/safe-land nhưng không tăng radius; UI/debug đọc cùng resolved value, không round khác server.

- AoE chỉ tác động entity hợp lệ theo combat relation/ruleset; baseline ưu tiên hostile, loại player ally/Shadow/tame/neutral ngoài contract. Có vertical band, line-of-effect/occlusion và target cap.
- Quái thường trong envelope có thể bị stagger hoặc launch; đây là action result rời rạc có immunity/resistance/recovery, **không** có Posture meter.
- Damage/intensity có cap theo action + weapon family + Level/content balance. Height có thể chọn bounded tier nhưng không nhân damage vô hạn; exact curve/target cap/recovery còn `OPEN` tại `DB-051`.
- Impact không mutate block state, hardness, crop, container, redstone, fire hoặc durability tool. Surface chỉ chọn dust/decal/SFX có budget.

## 8. Weapon-shaped presentation

| Family | Presentation direction | Gameplay guard |
|---|---|---|
| unarmed/unknown/tool | palm strike hoặc two-foot stomp | fallback luôn tồn tại; không đào/dùng durability |
| blade | chém/cắm thẳng xuống + shock arc | VFX không xuyên tường thành hit |
| heavy | nện tâm mạnh, recovery đọc được | không đồng thời best radius, damage và recovery |
| polearm | mũi đâm tâm + ring phụ | không target-lock/teleport vào mob |
| ranged-held/catalyst | brace/staff/palm fallback cùng physical landing | không tự bắn ammo hoặc tạo field chưa có owner |

`ARREST_ORIENT` có anticipation; `DESCENT_COMMIT` có trail/silhouette; `IMPACT_COMMIT` có dust, bass/transient, camera impulse ngắn và presentation hit-stop `GRD-HITSTOP-001`. Hit-stop không dừng logical server/world tick. Camera shake có intensity cap, reduced-motion/zero-shake option; first-person giảm roll/pitch nhưng giữ cue. Missing clip/VFX/audio dùng fallback và không đổi collision, safety hoặc hit.

## 9. Minecraft/platform/authority

- `LivingEntity`/movement owner và logical server commit position, velocity, damage và target hit. Client chỉ predict/project.
- Collision dùng block collision/support shape theo actor context; partial/thin/fluid/dynamic cases có fixture. Không dùng opacity, outline hoặc block-name whitelist làm ground truth.
- Runtime armed/action/camera state ephemeral và bị cleanup khi death, portal, reconnect, resource reload hoặc capability disable; unlock là persistent/versioned. Reconnect không khôi phục fall immunity.
- Fabric adapter chỉ chuyển input/movement/hit/render hooks. NeoForge future phải dùng cùng formula, stable IDs và save; chưa claim support trước parity gate.
- Risk `PR-2`, nâng `PR-3` nếu target query/cardinality hoặc world-sweep profiling vượt trigger. Bounded local sweep, target cap và no per-frame allocation bắt buộc.

## 10. Acceptance matrix

| ID | Scenario | Oracle |
|---|---|---|
| `GRD-S-001` | generated height boundaries/samples của `GRD-WINDOW/RADIUS-001` | cast/sweep hợp lệ; resolved radius/cap đúng; no tunnel |
| `GRD-S-002` | held mining, key repeat, wall Attack rồi Drop, normal aerial attack | đúng một consumer; không slam bất ngờ |
| `GRD-S-003` | block/piston/fluid/chunk revision đổi giữa phases | revalidate; impact hợp lệ hoặc fall tiếp, không phantom AoE |
| `GRD-S-004` | valid impact trên normal/slab/stair/thin support | đúng một `fall_damage_final=0`, Vigor không đổi |
| `GRD-S-005` | lava/void/water/slime/hay/powder snow/status | chỉ valid fall component được convert; hazard adapter đúng |
| `GRD-S-006` | nhiều target, ally/Shadow/tame, sau tường/khác cao độ | relation/occlusion/vertical/target cap; one hit ID |
| `GRD-S-007` | mọi weapon family + missing asset/reduced motion | safety parity; fallback/cue/comfort đúng |
| `GRD-S-008` | duplicate packet, hit/grab/death/portal/reconnect giữa phase | cleanup/idempotent; no ghost immunity/double damage |
| `GRD-S-009` | 20 TPS/low FPS/tick pressure, first/third person | authority outcome giữ nguyên; presentation có fallback |
| `GRD-S-010` | block/crop/container/redstone dưới impact | không block mutation hoặc durability side effect |

## 11. Open decisions có owner

`DB-051` chỉ còn khóa armed time-to-impact/buffer, correction/recovery, damage/stagger/launch envelope, weapon trade-off, vertical/occlusion/target cap và accessibility window. Các `GRD-*`/`VIG-GROUNDING-001`, unlock và no-block-grief không được mở lại.
