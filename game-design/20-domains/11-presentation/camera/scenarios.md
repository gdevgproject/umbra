# SYS-CAMERA — Scenario Matrix

> **Owner:** Camera QA + UX/Input
> **Status:** `DISCOVERY`

## Geometry và movement

| Scenario | Expected invariant |
|---|---|
| tường sát lưng, góc 90°, hành lang một block, trần thấp | camera co/đổi policy ổn định, không xuyên/rung |
| chạy, sprint, crouch, crawl, jump, fall, swim, ladder, elytra | mode/basis/comfort policy rõ; không snap vô cớ |
| cửa/fence/foliage/transparent block/fluid | occlusion theo collision/visibility taxonomy, không heuristic rải |
| teleport/portal/dimension/reload/death/respawn | rig rebind đúng actor, không giữ target/offset ma |
| FPS thấp/cao, tick lag, pause/unpause | smoothing theo render time, gameplay không đổi |

## Minecraft interaction

| Scenario | Expected invariant |
|---|---|
| mine/place block gần chân, trên đầu, qua vai | reticle preview khớp block server chấp nhận |
| chest/door/NPC/entity chồng ray | target priority đọc được, không tương tác xuyên |
| creative reach/spectator | rule theo mode được khai, không leak sang survival |
| item từ creative hoặc `/give` | camera/animation không phụ thuộc unlock UI để item hoạt động |
| inventory/menu/chat mở trong combat | input context không gửi aim/action ngoài ý muốn |

## Combat/aim/target

| Scenario | Expected invariant |
|---|---|
| melee ở sát tường hoặc target rất gần | actor/telegraph vẫn thấy, hit không phụ camera clipping |
| projectile với reticle lệch muzzle | server ray/projectile policy nhất quán và preview được |
| target đi sau vật cản/chết/despawn/teleport | soft/lock target break/reacquire có feedback |
| nhiều target, target cao/thấp/bay | switch/vertical framing không giật hoặc chọn ngoài rule |
| dodge tám hướng/neutral | basis không đổi giữa frame; first/third rule parity |
| boss lớn + adds + Shadow squad | framing ưu tiên threat, không zoom xa làm mất control |

## Accessibility và comfort

Kiểm sensitivity, invert axes, FOV, shake 0–100, smoothing, recenter, shoulder swap, motion reduction, target cue không chỉ màu, subtitle/UI safe region và photosensitivity VFX interaction.
