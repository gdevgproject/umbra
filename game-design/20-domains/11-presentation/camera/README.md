# SYS-CAMERA — Camera, aim và target presentation

> **DRI:** Camera Designer + Gameplay/Rendering Engineer
> **Approver:** Game Director + Technical Director
> **Reviewers:** Combat, Animation, UX/Input, Accessibility, Compatibility, QA
> **Status:** `DISCOVERY`

## 1. Contract

Camera góc ba của UMBRA phải biến Minecraft thành một action-adventure có embodiment chuyên nghiệp: người chơi luôn hiểu mình đang nhìn, nhắm, di chuyển và tương tác theo cơ sở nào; camera tránh vật cản, chuyển context ổn định và không tạo hit/aim khác luật. Góc một vẫn là mode được hỗ trợ, không phải casualty của overhaul.

## 2. Vì sao là foundation

Camera ảnh hưởng hướng Dodge, facing, projectile ray, mining/building, interaction reach, animation/root motion, target UI, enemy telegraph, command, mount/vehicle, accessibility và screenshot/readability. Nếu combat được khóa trước camera basis, gần như mọi action sẽ phải sửa contract sau.

## 3. Tách năm lớp state

| Lớp | Owner | Không được sở hữu |
|---|---|---|
| Player transform/pose | logical server gameplay | camera smoothing/FOV |
| Aim/interaction intent | input + server validation | kết quả hit client tự quyết |
| Target selection | gameplay target contract | camera tự gắn target không hợp lệ |
| View rig | client camera adapter | gameplay position/teleport |
| Camera effects | presentation/accessibility | thay đổi rule/timing |

Camera có thể dự đoán/hiển thị aim nhưng server resolve interaction/hit bằng intent đã validate. Reticle không phải bằng chứng mục tiêu hợp lệ.

## 4. Mode family cần discovery

| Mode | Mục tiêu | Câu hỏi chính |
|---|---|---|
| First-person | vanilla/build precision và immersion | animation/hands, aim parity, motion comfort |
| Third-person exploration | di chuyển/xây/khám phá mở | centered hay shoulder, interaction precision |
| Third-person combat | đọc actor/địch/arena | distance, pitch/yaw ownership, target framing |
| Third-person aim | projectile/tool precision | shoulder swap, reticle ray, occlusion/parallax |
| Lock-on | giữ target trong encounter | acquisition/switch/break/verticality/multi-target |
| Spectator/debug/photo future | quan sát không gameplay | tách khỏi player authority |

Lock-on và aim là Feature Cell riêng. Không gắn chúng vào Dodge hoặc camera base như boolean.

## 5. Invariants

- Third-person là core; không được fallback vĩnh viễn về offset F5.
- First/third-person khác presentation nhưng cùng gameplay eligibility, reach, target và action timing.
- Camera không xuyên block để tiết lộ/nhắm hợp lệ qua vật cản.
- Camera collision co ngắn/đổi vai mượt, không teleport player hoặc rung liên tục ở góc hẹp.
- Character, reticle, target cue và telegraph trọng yếu không che nhau kéo dài.
- Movement-relative/camera-relative/facing-relative basis được khai rõ theo context.
- Chuyển mode không reset cooldown, duplicate action, đổi target bất hợp lệ hoặc bypass recovery.
- Camera effect có intensity cap, reduced-motion và disable options.
- Render/API hook nằm sau adapter có version/compatibility tests.

## 6. Feature decomposition

| ID | Outcome | Blocker |
|---|---|---|
| `FEAT-CAMERA-BASE-RIG` | orbit/recenter/distance ổn định quanh player | render/camera adapter |
| `FEAT-CAMERA-OCCLUSION` | không clip/rung/ẩn actor trong geometry | block ray/shape policy |
| `FEAT-CAMERA-CONTEXT` | exploration/combat/aim/first-person chuyển rõ | input/action context |
| `FEAT-CAMERA-AIM` | reticle/intended ray khớp server-validated interaction | aim/authority contract |
| `FEAT-CAMERA-TARGETING` | soft target/lock lifecycle đọc được | encounter/target contract |
| `FEAT-CAMERA-FRAMING` | boss/squad/arena giữ readability | encounter + performance |
| `FEAT-CAMERA-COMFORT` | shake/FOV/smoothing/motion options | accessibility |

## 7. Gate trước combat polish

Base rig + occlusion + context + aim ray phải được prototype cùng mining/building và một light attack. Dodge/lock-on/boss camera chỉ qua `PROPOSED` sau khi basis này có evidence ở first/third-person.

## 8. Tài liệu con

- [Scenario Matrix](scenarios.md)
- [Research và Prototype Plan](research-plan.md)
