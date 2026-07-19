# FEAT-COMBAT-AERIAL-DODGE — Né trên không

> **DRI:** Combat Action Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Traversal, Input, Camera, Animation, Hit/Encounter, Balance, Accessibility, Platform, QA, Performance
> **Status:** `DISCOVERY`
> **Target slice:** future `C6` candidate cùng `DB-057`; không mở lại ground Dodge gate

## 1. Contract một câu

Khi người chơi đã mở Aerial Dodge, còn aerial-dodge use trong `AerialChain` và bấm Dodge ở airborne context hợp lệ, actor né có hướng bằng Focus với defensive window riêng—có thể nối một lần với Aerial Step nhưng không chạy khi bám tường, reset khi wall-touch hoặc trở thành miễn nhiễm rơi/hazard.

## 2. Boundary với ground Dodge

[`FEAT-COMBAT-DODGE`](README.md) tiếp tục sở hữu ground Dodge. Cell này chỉ sở hữu source mode airborne, aerial direction/collision/defense, use budget và chain transitions. Nó không phải một dòng `if airborne` dùng chung ground animation/curve.

- In scope: fresh Dodge intent, 360° horizontal/limited vertical presentation, Focus, defensive categories, collision, Step combo, Grounding/Lightness/Climb conflicts, authority/cue/test.
- Non-goals: wall dodge khi attached, free fall immunity, reset fall damage, repeated air dash, zero-Focus progression, attack hitbox, quyết định unlock trước `DB-057`.

## 3. Eligibility và lifecycle

```text
AIRBORNE + fresh Dodge + use/Focus/control/clearance
  → AIR_DODGE_START
  → AIR_DODGE_ACTIVE
  → AIR_DODGE_RECOVERY
  → ASCENDING | APEX | FALLING
```

- `CLIMB_*`, `MANTLE_*`, Grounding commit, Lightness hard phase, Elytra, swim, riding, grab/knockdown, portal/death và screen context deny no cost.
- Wall-eject/Drop chỉ làm actor airborne; cần fresh Dodge và budget còn. Climb latch/wall contact không refresh use.
- Direction snapshot theo camera/target basis được `FEAT-COMBAT-DODGE` duyệt; diagonal normalized. Collision shorten/slide/stop theo aerial profile, không no-clip.
- Commit trả Focus đúng một lần. Aerial Dodge không rút Vigor, không đặt grounded, không xóa fall attribution và không tự cho lift ngoài collision-safe trajectory profile.
- Defensive window dùng category matrix riêng; fall/lava/fire/void/DoT đã gắn không mặc định bị tránh. Một attack ID resolve tối đa một lần.

## 4. Straight-line feel và gravity shaping

Mục tiêu là một cú né trên không **đọc như đường thẳng có lực**, không phải cùng ground Dodge rồi tiếp tục rơi thành cung. Tuy nhiên xóa gravity/downward velocity vĩnh viễn sẽ biến Dodge thành fall cancel/hover. Baseline direction dùng ba phase:

```text
START(snapshot move basis + incoming velocity)
→ ACTIVE(gravity-shaped straight corridor)
→ GRAVITY_REENTRY(release suspended vertical momentum có cap)
→ normal AIRBORNE
```

- `ACTIVE` dùng authored horizontal speed/curve và capsule sweep; gravity contribution được giảm mạnh hoặc tạm treo trong cửa sổ ngắn, vertical drift bị giữ trong corridor quanh độ cao bắt đầu.
- Incoming vertical velocity không bị xóa. Authority giữ `suspended_vertical_velocity` cùng fall provenance; sau active, `GRAVITY_REENTRY` blend nó trở lại trong bounded duration để không snap camera/body hoặc cứu cú rơi miễn phí.
- Đang đi lên, ở apex và rơi có entry profile riêng nhưng cùng displacement/defense truth. Fast fall không được đổi thành zero-fall; chỉ trì hoãn rất ngắn và trả lại downward danger.
- Neutral aerial Dodge ưu tiên hướng horizontal velocity có nghĩa; nếu dưới dead-zone mới dùng camera-forward candidate. Directional input snapshot camera/target basis theo ground Dodge contract; vertical look không biến Dodge thành bay lên/xuống baseline.
- Ceiling/wall/floor/entity collision shorten/slide/stop corridor; không nudge xuyên voxel. Chạm stable ground chuyển landing/skid recovery nhưng fall damage owner vẫn dùng preserved provenance/velocity rule—Aerial Dodge không tự suppress.
- Gravity shaping chỉ tồn tại trong accepted action ID. Hit interrupt, correction, duplicate packet, pause/reconnect không để gravity scale hoặc suspended velocity “kẹt”.

Exact active duration, gravity scale, corridor tolerance và re-entry curve thuộc `DB-057`; prototype phải so ít nhất `normal gravity`, `reduced gravity`, `suspend+reentry`, với yêu cầu cuối là thẳng/readable mà không tăng time aloft/escape quá budget.

## 5. Combo và conflict

| Source/next | Result direction |
|---|---|
| Aerial Step → Dodge | accept sau step impulse marker nếu use/Focus còn; Dodge tiếp quản movement/defense |
| Dodge → Aerial Step | accept sau active/cancel marker nếu step use/Vigor còn; không overlap lift với defensive active |
| Free Climb/mantle | `DENY_NO_COST`; không biến Dodge thành wall roll/eject baseline |
| Grounding Strike | Primary Attack chỉ được xét sau Dodge recovery khi actor falling + time-to-impact; fresh/short buffer có expiry |
| Lightness | exact cancel edge thuộc `DB-057`; Dodge accept phải kết thúc controlled descent và vào gravity-reentry/fall, không tự resume để tạo stutter-flight |
| Attack/skill tương lai | phải khai cancel/result profile; default deny no cost trong active/recovery |

Baseline candidate cho phép một Step và một Aerial Dodge theo cả hai thứ tự trong cùng chain, nhưng mỗi use chỉ một lần và chỉ stable-support dwell reset. Resource, cooldown, perfect-dodge reward hoặc modifier không được refill use giữa không trung.

## 6. Animation, camera và feedback

- Animation có `air-brace → directional burst → recovery/reacquire gravity`; body axis/limb trail theo displacement, không dùng ground roll giữa không trung.
- Upward/apex/falling entry blend giữ silhouette khác nhau nhưng active marker/defense/cost không lệch vì clip. Missing clip dùng generic air-brace cùng timing.
- Third-person framing nới theo direction corridor, không snap yaw. First-person giảm roll/FOV kick; collision/re-entry không gây hai camera impulses.
- Start/active/end và Focus insufficient/collision có visual + audio/body cue; gravity shaping không cần HUD riêng. Reduced motion bỏ trail/shake nhưng giữ direction/window đọc được.

## 7. Scenario seed

| ID | Scenario | Oracle |
|---|---|---|
| `ADO-S-001` | jump/fall/wall-eject → Dodge neutral/4 hướng/diagonal | one action/Focus cost, basis snapshot, collision-safe |
| `ADO-S-002` | attached/mantling + Dodge | deny no cost/no detach/no ground animation |
| `ADO-S-003` | Step→Dodge→Step/Dodge spam | one use each; invalid repeat no cost/window |
| `ADO-S-004` | melee/projectile/AoE/DoT/fall/lava during active | category result đúng; no universal immunity |
| `ADO-S-005` | Attack before/after recovery near ground | Grounding only at legal falling window, one consumer |
| `ADO-S-006` | wall/ceiling/corner/entity collision | shorten/slide/stop, no clip/camera snap |
| `ADO-S-007` | wall touch/ladder graze/reconnect | no budget reset/refill |
| `ADO-S-008` | first/third, latency, duplicate packet, reduced motion | authority/cost/window parity và cue còn đọc được |
| `ADO-S-009` | ascending/apex/fast-fall entry | active corridor gần thẳng; suspended vertical velocity preserved + bounded re-entry |
| `ADO-S-010` | hit/collision/pause/reconnect trong active/re-entry | no stuck gravity scale, ghost defense, fall reset hoặc double camera impulse |

## 8. Dependencies, evidence và gate

Depends on [`Dodge`](README.md), [`CTR-TRAVERSAL`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md), [`Aerial Step`](../../01-player/traversal/04-aerial-step.md), `CTR-ACTION-AUTHORITY`, Vitals/HUD, camera basis, hit taxonomy và `DB-057`.

Risk `PR-2`; automated proof cần direction/collision/gravity-reentry/fall-attribution/one-use/resource/attack-category/chain/latency/lifecycle fixtures trước one-question human feel card. Exact displacement, gravity curve, window, Focus cost, cancel markers, perfect reward và unlock đều `OPEN`; Feature giữ `DISCOVERY`, không cho phép implementation.

Cross-discipline closure bắt buộc:

| Discipline | Direction |
|---|---|
| Input/UI/localization | remapped Dodge + direction, Focus cost/spent/denied cue và subtitle keys; không hard-code phím hoặc chỉ dùng màu |
| Camera/animation/audio-VFX | two-view parity, brace–burst–re-entry markers, reduced-motion fallback; presentation không sở hữu displacement/window |
| Accessibility | timing assist/remap/reduced camera impulse; không auto-dodge hoặc kéo dài defense truth ngoài profile đã duyệt |
| Authority/future multiplayer | logical-server use/cost/window/collision/gravity state; duplicate/reorder/correction idempotent. Current offline, netcode gameplay là future seam |
| Save/migration/platform | unlock/input profile versioned; active/re-entry/chain ephemeral, reconnect no refill/stuck gravity; no loader-specific semantics/save fork |
| Performance/compatibility | `PR-2`, bounded sweep/no per-frame allocation; external gravity/status modifier composition có cap và debug trace |
| Economy/content | runtime N/A; unlock/tutorial chỉ mở sau `DB-057`, không tự thêm currency hoặc loot rule |
