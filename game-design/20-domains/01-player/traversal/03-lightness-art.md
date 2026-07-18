# FEAT-TRAVERSAL-LIGHTNESS — Khinh Công phóng người và hạ chậm

> **DRI:** Player Traversal Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Controls, Camera, Animation, Combat, World, Progression, VFX/Audio, Accessibility, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi đã học Khinh Công và kích hoạt từ support hợp lệ, nhân vật giậm đất phóng theo một quỹ đạo camera-relative đã commit; tới/qua đỉnh quỹ đạo, người chơi có thể dùng cùng action để vào trạng thái hạ chậm tiêu Khí Lực và điều hướng trong giới hạn cho tới khi đáp, hủy hoặc cạn sức.

## 2. Fantasy và anti-goals

Fantasy: lực phát từ bước giậm và kỹ thuật thân pháp, không từ cánh/jetpack. Người chơi cảm thấy nhẹ, có đà, đọc được đỉnh quỹ đạo và tự chọn lúc chuyển sang hạ chậm.

Không phải:

- Creative flight hoặc Elytra reskin;
- hover, tăng độ cao lặp vô hạn hay đổi hướng 180° không quán tính;
- teleport/dash không collision;
- combat escape miễn phí không resource/recovery;
- active skill chiếm slot 4+1.

## 3. Unlock và progression

- Universal capability mở sớm sau Free Climb + Grounding Strike/training proof, trước khi Gate/exploration lặp nhiều.
- Milestone + tutorial ngắn sở hữu delivery; level có thể là eligibility nhưng không là random drop/Potential.
- Training dạy ba beat: launch theo hướng nhìn → nhận cue apex → hold/toggle hạ chậm → Grounding Strike hoặc đáp thường.
- Upgrade candidate: Vigor capacity/efficiency, steering cap, recovery hoặc one-time route technique. Không mở repeated midair launch/hover baseline.

## 4. Action/state machine

```text
SUPPORTED
  --Lightness press + reserve + clearance--> LAUNCH_WINDUP
LAUNCH_WINDUP
  --impulse commit--> ASCENDING
ASCENDING → APEX → FALLING
APEX/FALLING
  --Lightness hold/toggle + Vigor--> LIGHTNESS_DESCENT
LIGHTNESS_DESCENT
  --release/toggle/Vigor 0/interrupt--> FALLING
  --valid ground--> LIGHT_LANDING → SUPPORTED
FALLING/LIGHTNESS_DESCENT
  --Grounding Attack guard--> GROUNDING_STRIKE
```

- Launch chỉ từ stable support baseline; wall-launch/eject combo là future variant, không tự có.
- Một airborne sequence có tối đa một launch commit. Ground/support reset chỉ khi landing footprint/time đủ hợp lệ; chạm cạnh không refill để chain exploit.
- Same action hỗ trợ `press launch` và `hold/toggle descent` vì contexts loại trừ rõ; exact binding/remap theo Input contract.

## 5. Launch trajectory

- Horizontal direction lấy camera-relative `MoveBasis` và snapshot tại commit; neutral dùng camera forward candidate.
- Vertical/horizontal impulse, windup, steering before apex và collision response là parameter riêng.
- Camera xoay sau commit không bẻ quỹ đạo ngay; limited air steering thay đổi dần theo acceleration cap.
- Ceiling/overhang/collision sweep có thể shorten/reject launch; không phase qua block hoặc sửa bằng teleport.
- Launch tạo sound/visual/noise semantic có thể ảnh hưởng stealth/AI sau content contract.

## 6. Apex và hạ chậm

- Apex cue là visual + optional audio/haptic, không chỉ particle màu.
- Hạ chậm giảm downward acceleration/terminal velocity theo authoritative action; không đóng băng Y hoặc tạo lift.
- Horizontal steering camera-relative có speed/acceleration/turn cap; diagonal normalized.
- Vigor drain theo server clock; không hồi giữa không trung. Cạn Vigor chuyển về normal fall với cue/grace được prototype.
- Release/toggle trả về fall; re-entry descent trong cùng airborne sequence có policy/cost để tránh stutter exploit.
- Wind/updraft/weather/slow-fall effect có composition rule; không cộng modifier làm velocity âm/infinite.

## 7. Combat và action interaction

| Action/context | Direction |
|---|---|
| Grounding Strike | được phép cancel descent khi guard/transaction hợp lệ |
| Dodge | không dùng trên không baseline; aerial dodge là Feature Cell khác |
| Light/heavy melee | deny hoặc aerial variant theo weapon contract; không tự reuse ground animation |
| Ranged/aim | prototype riêng; nếu cho phép phải giữ parallax/turn/steering readable |
| Hit/knockback/grab | severity có thể break descent và giữ attacker attribution |
| Shadow command/quick recovery | precedence/cancel explicit; không dùng giữa hard-committed launch |

Khinh Công không cấp i-frame. Enemy counterplay đến từ ranged threat, vertical pursuer, landing pressure và route design—không từ đọc nút người chơi.

## 8. Camera, animation và presentation

- Third-person framing mở đủ thấy actor, quỹ đạo và landing space; FOV/zoom/shake có cap và reduced-motion.
- First-person giữ horizon ổn định, giảm roll/bob; không buộc auto-switch nếu comfort profile chưa yêu cầu.
- Animation set: grounded load/step, launch commit, ascending, apex transition, controlled descent, steering lean, light landing, exhausted fall, collision/interrupt và fallback.
- Actor có thể xoay presentation theo velocity/steer nhưng gameplay direction/velocity không do bone/root motion sở hữu.
- Không thêm cánh. VFX dùng pressure trail/khí/cloth-shadow abstraction nguyên bản, budgeted và shader/backend-safe.
- Vigor meter contextual + trajectory/apex/low-resource cues; không giữ thêm HUD bar thường trực ngoài traversal.

## 9. Minecraft/world interaction

- Không phá/đặt block, giẫm crop hay kích redstone từ xa. Landing dùng vanilla collision/support truth.
- Elytra/Creative flight/mount/swim/portal có precedence; không stack Lightness modifiers.
- Người chơi có thể chuyển từ descent sang Free Climb khi va face chỉ qua explicit input/eligibility và còn Vigor.
- Height/route design của Gate/structure xét launch envelope; hard boundary không dựa tường cao duy nhất.
- Ladder/scaffolding/bridge vẫn tiết kiệm Vigor, vận chuyển Shadow/mob/item và hoạt động trước unlock.
- Active Shadow dùng off-screen safe rejoin/hold policy trước khi có traversal animation tương đương.

## 10. Authority, save, security và performance

- Server validate stable support, clearance, capability, Vigor, action state, impulse envelope và state transitions.
- Client prediction được reconcile; forged flight/velocity/ground-reset payload bị reject/rate-limit/trace.
- Unlock/Vigor/cooldown versioned; airborne state ephemeral. Quit/reconnect không refill hoặc khôi phục một launch giữa animation.
- Risk `PR-2`; full traversal/companion snapshot `PR-3`. Bounded collision query, no trail allocation per frame, correction/velocity counters và backend profiles bắt buộc.
- Degrade trail/cloth/ambient sound trước; không degrade collision, apex/low-Vigor cue hoặc authoritative velocity.

## 11. Acceptance hypotheses

- launch direction predictable ở 360°, diagonal, slope, low ceiling, ledge và two-camera modes;
- không hover, repeated launch, wall-touch refill, logout refill hoặc modifier-stack infinite flight;
- Vigor 0/release/hit/collision chuyển về fall có cue và không kẹt state;
- Grounding Strike/Free Climb/landing transitions không double cost/damage/fall suppression;
- người mới hiểu apex và hạ chậm sau tutorial; expert có đường steering/mastery thật;
- world route mở rộng đáng kể nhưng ladder/building và danger vẫn hữu ích;
- low/high FPS, lag, portal/death/reload và future server validation giữ cùng outcome.

## 12. Open decisions

`DB-052`: launch input/windup/impulse envelope, apex cue, descent activation/re-entry, terminal velocity/steering, Vigor drain, collision/wind/status composition, combat actions, upgrades và accessibility/comfort profile.

