# SYS-CAMERA-MOVEMENT — Movement basis, actor facing và camera transition

> **DRI:** Camera Designer + Character Controls Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Combat, Animation, Input, Gameplay Engineering, Accessibility, QA
> **Status:** `DISCOVERY`

## 1. Player outcome

Ở góc ba, người chơi có thể xoay camera để quan sát mà không vô tình xoay thân nhân vật; nhấn tiến luôn tạo chuyển động dễ đoán theo context. Khi combat/lock/precision thay đổi facing, game chuyển basis có chủ đích—không đảo hướng vì camera vừa đi qua lưng nhân vật.

## 2. Năm vector/state không được trộn

| State | Nghĩa | Owner |
|---|---|---|
| `ViewForward` | camera đang nhìn đâu | client view rig |
| `MoveInput` | vector WASD/stick thô | input layer |
| `MoveBasis` | frame biến input thành world movement | character controls contract |
| `AimIntent` | action/projectile/tool muốn hướng đâu | aim + server validation |
| `ActorFacing` | thân/pose/weapon đang quay đâu | gameplay locomotion + animation projection |

Camera yaw không được ghi thẳng thành player yaw mỗi frame ở third-person free mode. Gameplay action có thể yêu cầu facing/turn assist, nhưng phải qua state/limit và không làm camera sở hữu transform server.

## 3. Context policy dẫn đầu

| Context | Move basis | Actor facing | Camera/aim policy |
|---|---|---|---|
| Third-person exploration | camera-relative trên mặt phẳng ngang | quay dần theo move vector; camera orbit độc lập khi đứng yên | free orbit/recenter có setting |
| Third-person free combat | camera-relative | move-facing, action có bounded turn assist | soft target chỉ khi action cho phép |
| Lock-on combat | object/target-relative | giữ target-facing trong cone; strafe/backstep | framing + explicit target lifecycle |
| Third-person precision aim | aim/camera-relative | aim-facing, strafe; upper-body/turn-in-place theo rig | shoulder reticle + parallax solution |
| First-person | view/aim coupled như expectation FPS | server pose theo valid aim/action | cùng reach/eligibility/timing |
| Build/mine/tight tunnel | mode hiện tại + precision ray | không auto xoay ngoài interaction need | suggest first-person được; không ép mặc định |
| Swim/climb/elytra/mount | feature-specific basis | theo physics/vehicle owner | không reuse humanoid rule mù |

Direction Product: camera-relative là default cho third-person free movement. Character-relative “tank control” không phải baseline UMBRA. Lock-on/object-relative và precision aim là context riêng, không biến thành exception tùy tiện.

## 4. Transition invariants

- Basis được snapshot tại action acceptance nếu action cần hướng ổn định. Dodge/attack committed không cong theo camera xoay sau đó trừ skill ghi tracking rõ.
- Khi camera recenter/shoulder swap/collision/lock acquire–break đổi frame, held input không được đột ngột đảo world direction. Blend/freeze old basis cho tới neutral/reorientation theo policy prototype.
- Actor turn rate/turn-in-place/strafe/backpedal animation phải đọc được; gameplay hitbox không chờ cosmetic foot alignment nếu contract không yêu cầu.
- Aim/lock loss không snap actor/camera 180° hoặc đổi forward thành backward trong cùng input hold.
- Mode switch không reset cooldown, action, resource, target hoặc movement modifier.

## 5. Ranged/precision view policy

- Không có rule “cầm cung/súng/phép tầm xa = ép first-person”. Third-person shoulder aim là capability cốt lõi cần giải camera-ray ↔ muzzle/projectile parallax và near-wall obstruction.
- First-person là lựa chọn được hỗ trợ cho preference, block precision và một số action/content nếu prototype chứng minh cần; switch có setting `manual / contextual suggestion / allowed auto-transition` với preview rõ.
- Auto-transition nếu tồn tại không bắt đầu giữa committed action, không đổi sensitivity đột ngột và luôn có way-back predictable.
- Reticle preview sai phải fail visibly; không bẻ projectile xuyên block để “khớp” camera.

## 6. Dodge và combat action

- Free mode: Dodge direction dùng camera-relative horizontal `MoveBasis`; neutral behavior vẫn do Dodge ADR quyết.
- Lock-on: Dodge dùng target-relative strafe/backstep/forward sector theo context, nhưng cùng distance/cost/defensive rule nếu content không khai variant.
- Precision aim: Dodge/cancel có policy riêng; không để aim basis đổi giữa input và authority acceptance.
- Actions có root motion/turn assist khai requested facing, maximum correction, target rule, wall/edge behavior và prediction reconciliation.

## 7. Minecraft/vanilla interoperability

- Baseline 26.2 phải được capture/test thay vì suy từ ký ức: first/F5 movement, yaw update, sprint, crouch, crawl, swim, ladder, elytra, boat/mount và mouse orbit.
- Mine/place/use ray giữ server reach/line-of-sight; camera-relative locomotion không đổi block interaction truth.
- Vanilla camera key/profile custom binding được migrate; resource reload/portal/death/respawn rebind basis không giữ yaw/target ma.
- Một compatibility fallback có thể dùng vanilla first-person, nhưng không được âm thầm kích hoạt để che camera bug.

## 8. Accessibility và settings

- camera sensitivity/invert, recenter strength/delay, turn assist, aim assist, shoulder, lock behavior và movement auto-align là setting tách biệt;
- reduced motion không đổi control basis; camera shake/FOV không feed ngược movement;
- input visualizer/debug overlay hiện raw input, basis, world vector, facing request/actual, aim ray và transition reason;
- controller future dùng cùng action/basis contract, không hard-code WASD semantics vào gameplay.

## 9. Proof matrix

- đứng yên orbit 360°, giữ W rồi xoay camera, camera đi qua ±180°, recenter và shoulder swap;
- W/S/A/D/diagonal trong free combat, lock-on target trước/sau/bên/cao/thấp và target loss;
- melee/area/ranged precision, wall gần muzzle, mine/place chân/trần/qua vai;
- Dodge cùng tick camera/lock đổi; attack turn assist; hit/knockback trong transition;
- first↔third mid movement/action, portal/death/reload/lag/FPS thấp–cao;
- keyboard layout/remap/controller harness, motion settings và comfort/comprehension playtest.

## 10. Open decision

- `DB-048`: turn rate/auto-align/recenter, transition frame, lock-relative sectors, precision strafe và animation/root-motion contract qua camera room prototype.
- `DB-004/037`: rig/occlusion/aim/target/reticle và first-person parity.
- `DOD-OQ-01`: neutral dodge + exact direction behavior sau khi `DB-048` có evidence.

