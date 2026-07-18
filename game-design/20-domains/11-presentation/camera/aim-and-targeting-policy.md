# SYS-CAMERA-AIM — Aim, reticle và targeting policy

> **DRI:** Camera Designer + Combat Designer
> **Status:** `DISCOVERY`

## 1. Decision frame

UMBRA nhắm tới combat góc ba mượt và thông minh, không phải đưa hồng tâm vào mọi lúc hoặc ép first-person cho mọi projectile. Presentation phải trả lời ba thứ tách biệt: **player nhìn đâu, action định hướng đâu, gameplay target nào hợp lệ**.

Movement/facing không được suy từ reticle; canonical basis và transition nằm tại [Movement basis, actor facing và transition](movement-and-facing-policy.md).

## 2. Candidate mode policy

| Context | Presentation candidate | Không được giả định |
|---|---|---|
| Exploration/melee không target | third-person free camera, facing/soft assist có giới hạn | center screen = target |
| Melee soft target | framing/turn assist nhẹ, cue kín đáo | lock cứng target gần nhất |
| Lock-on encounter | target lifecycle/switch/break rõ | camera giữ target xuyên tường |
| Projectile/precision skill | third-person shoulder + reticle/parallax solution | reticle ray tự là hit result |
| Tight tunnel/build/mining | first-person player-selected hoặc context suggestion | auto-switch bất ngờ giữa action |
| First-person combat | cùng eligibility/timing/range, presentation riêng | phải dùng cùng animation camera |

Context-adaptive là direction ưu tiên để prototype, không phải permission cho camera tự đổi tùy ý. Settings dự kiến: remember-last-mode, contextual suggestion/auto transition, shoulder side, aim hold/toggle, sensitivity/FOV và aim assist strength/off.

## 3. Target lifecycle

```text
candidate sensed → eligibility/visibility scored → soft highlighted
→ optional lock acquired → maintained / switched
→ lost grace → broken with reason → reacquire cooldown
```

Targeting không sở hữu damage. Server xác thực reach, line of sight, ownership và action rule. Projectile phải xử lý camera-ray/muzzle parallax và vật cản gần actor; UI preview sai phải fail visibly, không bẻ projectile xuyên block để khớp reticle.

## 4. Research required before lock

So sánh có capture giữa action RPG lock-on, third-person free aim và Minecraft first/F5 ở: acquisition, facing, area attack, vertical/flying target, ranged precision, close wall, target loss, multi-enemy, mouse sensitivity và mode transition. Mỗi claim ghi platform/build/timecode; không suy từ cảm giác nhớ về game tham khảo.

## 5. Gate

Không khóa Dodge facing, projectile origin, skill target grammar hoặc boss framing trước khi `FEAT-CAMERA-AIM` và `FEAT-CAMERA-TARGETING` có prototype + automated ray/state trace + human comprehension/comfort evidence.
