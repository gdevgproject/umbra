# FEAT-COMBAT-DODGE — Dodge / Né chủ động

> **DRI:** Combat Designer
> **Approver:** Lead Game Designer
> **Reviewers:** UX/Input, Camera, Animation, Gameplay Engineering, QA, Accessibility, Balance, Compatibility
> **Status:** `DISCOVERY`
> **Target slice:** Skill/Movement Foundation snapshot

## 1. Contract một câu

Từ Level 1, người chơi kích hoạt một Sprint Burst/Dodge có hướng, trả cost `VIG-DODGE-001` và nhận movement + defensive window đọc được để né bằng timing/vị trí—không có immunity vạn năng hoặc resource riêng.

## 2. Baseline đã khóa

- Capability có từ Level 1, không chiếm skill slot.
- Một accepted activation commit `VIG-DODGE-001`; chain/remainder math nằm duy nhất tại [Parameter Registry](../../../60-quality/02-parameter-registry.md).
- Ordinary Sprint và Dodge dùng cùng movement-action/Vigor owner: Sprint/Burst không hồi Vigor. `VIG-SPRINT-SUSTAIN-001` còn `OPEN`, nên baseline không tự thêm drain/giây.
- Vigor recovery/max/migration/HUD theo [`CTR-VITALS-HUD`](../../../30-shared-contracts/08-vitals-resource-and-hud-contract.md) và [`CTR-TRAVERSAL`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md).
- Mana/Focus/Fatigue/Posture/Primary Attribute/Potential không tham gia eligibility, cost, i-frame hoặc perfect reward.

## 3. Boundary

In scope: semantic intent/remap/context, direction basis, phase/cancel, Vigor transaction, collision, defensive-category window, two-camera presentation, authority, accessibility và proof.

Non-goals: lock-on hoàn chỉnh, dash skill, mount dodge, enemy dodge, final animation asset, fall/lava/void immunity, auto-dodge và Aerial Dodge implementation.

## 4. Eligibility và transaction

Authority accept khi actor alive/controlled, supported locomotion context hợp lệ, không hard-committed/external mode, đủ `VIG-DODGE-001` và input edge chưa có consumer.

```text
AVAILABLE + valid DodgeIntent + reserve(VIG-DODGE-001)
→ STARTUP → COMMIT → ACTIVE → RECOVERY → AVAILABLE
```

- Reject trước commit refund reservation; duplicate/retry/out-of-order không double cost/window.
- Collision/interruption sau commit không refund mặc định; exact phase exceptions cần cancel matrix.
- Khi thiếu Vigor, không animation/displacement/cooldown; cue có cooldown và HUD ghost cost.
- Climb/Mantle deny no cost; Airborne route sang Feature Cell riêng; swimming/riding/Elytra/ladder/screen dùng external owner trừ khi profile explicit.

## 5. Direction, movement và camera

- Third-person free: camera-relative horizontal basis; lock-on: target-relative; precision: aim-relative. Basis snapshot tại accept, xoay camera sau đó không bẻ Dodge.
- Direction vector normalize để diagonal không xa/rẻ hơn. Neutral behavior, sector/blend và collision shorten/slide/stop còn prototype.
- First-person cùng world displacement/timing, giảm roll/FOV/shake theo comfort setting.
- Movement owner dùng collision sweep; không xuyên block, teleport, đổi vertical fall state hoặc coi animation root motion là truth.

## 6. Defensive window và cancel

Exact i-frame/startup/active/recovery vẫn `OPEN`, nhưng window phải phân category: melee, projectile, explosion/wave, persistent field, attached DoT, fall/fire/lava/suffocation/void, grab/scripted hit và repeat từ cùng attack ID. Mỗi category chọn `AVOID / MITIGATE / UNCHANGED / SPECIAL`; không dùng boolean invulnerable.

Dodge có thể hủy recovery thừa chỉ tại cancel edge của action owner. Light/heavy/skill/item/parry phải có matrix startup/commit/active/recovery; một câu “Dodge cancel mọi thứ” không đủ. Perfect Dodge nếu được giữ chỉ thêm feedback hoặc bounded advantage đã proof, không refund resource đã bị xóa hay tạo Mana/Focus.

## 7. Presentation và accessibility

- Start/active/collision/reject/perfect cue dùng ít nhất visual/body + audio/subtitle; không chỉ màu.
- Vigor bar hiện ghost/notch theo `VIG-DODGE-001` và reason khi thiếu; UI không tự tính cost.
- Remap, one-handed/dedicated binding, timing assistance, reduced motion và camera-shake control giữ same authority/cost/window truth.
- Không hard-code double-tap hoặc physical Sprint key làm path duy nhất; action catalog xử lý conflict với vanilla Sprint/Sneak/Use/Attack.

## 8. Minecraft/platform/quality

- Logical server validate state/Vigor/basis/collision/window; client predict/project và reconcile không double-charge.
- Death/portal/reconnect/resource reload cleanup runtime action; current Vigor không refill. Save không ghi nửa Dodge.
- Fabric/NeoForge adapter không sở hữu direction/defense/cost hoặc fork save.
- Risk `PR-2`: movement/collision/camera hot path; no per-tick allocation, stable action/hit IDs và trace raw intent→accept/reject→Vigor→phase→hit result.

## 9. Acceptance

- Boundary values generated quanh `VIG-DODGE-001`, `VIG-MAX-001` cho đúng reject/chain/remainder, không âm.
- Spam key/packet/render FPS không thêm window/displacement/cost; một input edge có một consumer.
- Four-way/diagonal/neutral và basis transition có deterministic result ở first/third person.
- Block/edge/water/ladder/Climb/Airborne/mode boundary không xuyên, không dùng wrong animation hoặc double cost.
- Damage category và same attack ID resolve đúng; fall/lava/void/DoT không bị xóa mặc định.
- Hit/cancel/collision/death/reconnect ở mọi phase cleanup đúng; HUD/cue/locales/reduced-motion vẫn đọc được.

## 10. Open decisions

- Neutral/sector/collision movement curve.
- Defensive category matrix và exact i-frame.
- Cancel matrix với representative attack/skill/item.
- Ordinary sustained Sprint có cần Vigor drain ngoài 18 activation cost không; chỉ quyết sau movement/encounter prototype.
- Perfect Dodge feedback/reward không dùng resource đã bị xóa.

Feature giữ `DISCOVERY`; baseline cost/Level/resource topology không tự cấp quyền code trước khi các open contract và acceptance đạt `IMPLEMENTATION_READY`.
