# FEAT-COMBAT-DODGE — Dodge / Né chủ động

> **DRI:** Combat Designer
> **Approver:** Lead Game Designer
> **Reviewers:** UX/Input, Camera, Animation, Gameplay Engineering, QA, Accessibility, Balance, Compatibility
> **Status:** `DISCOVERY`
> **Target slice:** Combat Foundation Slice, chưa xếp milestone

## 1. Contract một câu

Khi người chơi nhận ra một mối đe dọa có thể né và bấm action Dodge trong context hợp lệ, game thực hiện một dịch chuyển ngắn có hướng với commitment/cửa sổ phòng thủ đọc được, giúp họ tránh đòn nhờ timing và vị trí chứ không tạo nút miễn nhiễm vạn năng.

## 2. Giá trị và ranh giới

- **Pillar chính:** `PIL-MASTERY`.
- **Pillar phụ:** `PIL-ASCENDANCE` khi mastery về cuối game vẫn còn giá trị.
- **In scope:** eligibility, hướng, phase/cancel, movement/collision, defensive window, cost, feedback, first/third view, authority và acceptance.
- **Non-goals:** lock-on system hoàn chỉnh, dash skill, mount dodge, enemy dodge, toàn bộ locomotion rework, final animation asset.
- **Success signal:** người chơi có thể giải thích vì sao một cú né thành công/thất bại; spam né không vượt qua positioning/resource/encounter rule.

## 3. Candidate hiện hành và trạng thái

| Candidate | Canonical owner | Nhãn |
|---|---|---|
| action remappable, không hardcode phím | Presentation/Input | `DECIDED` ở mức nguyên tắc, contract input chưa duyệt |
| camera-relative trong third-person free; target-relative khi lock | Camera Movement + Dodge | `DECIDED` ở basis; neutral/sector/transition còn `CANDIDATE` |
| dodge ưu tiên hơn recovery chung | Combat Action | `CANDIDATE`, cần cancel matrix |
| chỉ thay horizontal velocity khi ở trên không | Dodge | `CANDIDATE` |
| Focus cost 25, tổng chuyển động 0.35s, i-frame ≤0.40s | Parameter Registry 14.18–19 | `CANDIDATE PARAMETER`, chưa có evidence |
| perfect dodge tick 0–1, hoàn Fatigue/hồi Mana | Parameter Registry 14.19 | `CANDIDATE`, phụ thuộc resource philosophy |
| client intent/server authority | Platform/Action Authority | `DECIDED` ở mức platform principle; prediction còn mở |

Không con số candidate nào được dùng làm acceptance final.

## 4. Vocabulary

| Term | Nghĩa | Không phải |
|---|---|---|
| `DodgeIntent` | yêu cầu có hướng từ input layer | bằng chứng dodge đã xảy ra |
| `DodgeAction` | action đã được authority chấp nhận | animation client tự phát |
| `defensive window` | khoảng rule cho phép tránh một số hit category | bất tử toàn diện |
| `perfect dodge` | timing subset có feedback/reward nếu được duyệt | điều kiện để dodge thường có tác dụng |
| `neutral dodge` | Dodge khi vector di chuyển dưới deadzone | mặc định là backstep cho tới khi ADR chọn |

## 5. Preconditions và postconditions đề xuất

| Loại | Rule hiện tại |
|---|---|
| Có thể bắt đầu khi | actor sống, có quyền điều khiển, context cho phép, không trong hard-lock, resource hợp lệ |
| Bị từ chối khi | spectator, sleeping, riding nếu mount contract không hỗ trợ, action hard-committed, authority không xác nhận |
| Khi thành công | action ID duy nhất, resource trả đúng một lần, phase chạy, movement/defense/feedback đồng bộ |
| Khi bị collision | không xuyên block; kết thúc/slide/shorten theo policy cần quyết định |
| Khi interrupted | rule theo phase và interrupt category; không mặc định hoàn toàn bộ cost |
| Không được đổi | vertical physics/vanilla state nếu contract scenario không cho phép |

## 6. Action model cần thiết

```text
AVAILABLE
  --intent + valid guard--> STARTUP
STARTUP
  --commit marker--> ACTIVE
ACTIVE
  --defense/movement window ends--> RECOVERY
RECOVERY
  --recovery ends--> AVAILABLE
any phase
  --valid hard interrupt--> INTERRUPTED → context-dependent recovery
```

Mỗi phase phải có:

- gameplay clock và owner;
- movement curve;
- animation marker;
- hurt/hit response;
- cancel-in/cancel-out rule;
- resource payment/refund rule;
- first/third-person feedback.

Không dùng một câu “Dodge hủy recovery” thay cancel matrix của Light/Heavy/Skill/Parry/Item Use.

## 7. Hướng và camera

Product direction và canonical vector policy nằm tại [Movement basis và actor facing](../../11-presentation/camera/movement-and-facing-policy.md): third-person free dùng camera-relative horizontal basis; lock-on dùng target-relative; precision aim dùng aim-relative. Basis được snapshot khi action được authority chấp nhận để xoay camera sau đó không bẻ cong cú né.

Phần còn phải prototype:

| Quyết định | Candidate | Rủi ro cần chứng minh |
|---|---|---|
| neutral Dodge | backstep trong combat; hướng nhìn trong exploration | hành động bất ngờ khi không có target |
| sector/animation | 8 sector normalized hoặc blend | diagonal distance, foot sliding, turn cost |
| first-person basis | view-relative với comfort policy | mất phương hướng/đảo input |
| basis transition | freeze/blend tới neutral | held input đảo hướng khi acquire/break lock |

`DOD-OQ-01` chỉ còn khóa neutral/sector/transition, không mở lại camera-relative baseline.

## 8. Defensive window — câu hỏi category

Không được dùng boolean “invulnerable”. Cần ma trận ít nhất:

- melee contact/hitbox;
- projectile direct hit;
- explosion/AoE wave;
- persistent hazard/ground field;
- damage-over-time tick đã gắn;
- fall/lava/fire/suffocation/void;
- grab/pin/uncounterable scripted hit;
- friendly/environmental collision;
- repeated hit từ cùng attack ID.

Mỗi category chọn `avoid`, `mitigate`, `unchanged` hoặc `special rule` cùng feedback. Encounter designer không được tạo “đòn đọc dodge” bằng input peeking; counter phải đến từ timing lệch, tracking có telegraph, vùng kéo dài hoặc vị trí.

## 9. Resource — topology đã định hướng, con số chưa chốt

Focus là bar phòng thủ hồi nhanh, tách khỏi locomotion và hiển thị notch/ghost cost theo [`CTR-VITALS-HUD`](../../../30-shared-contracts/08-vitals-resource-and-hud-contract.md). Fatigue vẫn là áp lực dài hạn. Exact Focus cap/cost/regen, số Dodge liên tiếp và perfect reward còn cần trả lời:

1. Dodge thường có nên tăng Fatigue hay chỉ action burst đặc biệt?
2. Focus có tạo nhịp ra quyết định hay chỉ là cooldown trá hình?
3. Perfect dodge nên thưởng resource, ưu thế vị trí, combo preservation hay chỉ feedback?
4. AGI/PER/Potential ảnh hưởng timing ra sao mà không biến stat thành auto-win?
5. Resource trả ở intent, commit hay active marker; refund khi collision/server reject thế nào?

Không đưa Dodge vào cây Potential cho tới khi base action đã vui mà không cần progression modifier.

## 10. Cross-discipline checklist

| Discipline | Requirement hiện tại | Status |
|---|---|---|
| Input | remappable, conflict-aware, context rõ, direction/deadzone | `OPEN` |
| Combat timing | phase + cancel matrix với light/heavy/parry/skill/item | `OPEN` |
| Hit rhythm | cùng attack ID không được damage lại do click/tick spam | dependency `OPEN` |
| Camera/target | parity góc 1/3, camera-relative basis, crosshair/lock policy | `OPEN` |
| Animation | first-person arms + third-person body; markers/cancel/blend/root motion policy | `OPEN` |
| VFX/SFX | start/active/perfect/collision/reject cues; reduced-motion variant | `OPEN` |
| UI/UX | Focus fixed bar + cost notch/ghost preview; reject reason không spam | `OPEN` |
| Accessibility | toggle double-tap nếu có, hold/toggle N/A, timing assist policy, motion/camera shake | `OPEN` |
| Localization | “Dodge/Né/Lăn/Bước né”, perfect timing terminology | `OPEN` |
| AI/encounter | telegraph đủ, fair anti-dodge pattern | `OPEN` |
| Progression/balance | unlock mặc định hay tutorial; stat modifiers/caps | `OPEN` |
| Vanilla/world | mining, shield/item use, sprint, crouch, crawl, swim, ladder, elytra, vehicle, fall, edge | `OPEN` |
| Authority/network | intent validation, prediction, reconciliation, latency window, duplicate packet | `OPEN` |
| Save | resource persistence; action runtime không save giữa tick trừ khi cần | `OPEN` |
| Performance/compat | no per-tick allocation; key/mod conflict; animation/render compatibility | `OPEN` |
| Test/debug | action trace, phase overlay, hit category log, deterministic scenario | `OPEN` |

## 11. Dependencies

| ID | Quan hệ | Điều Dodge cần |
|---|---|---|
| `CTR-INPUT-ACTION` | blocker | context/remap/intent/deadzone |
| `CTR-ACTION-TIMELINE` | blocker | phase/cancel/queue clock |
| `CTR-COMBAT-HIT` | blocker | attack ID, damage category, immunity semantics |
| `CTR-CAMERA-TARGET` | blocker | direction basis và camera parity |
| `CTR-ANIMATION-EVENT` | blocker | marker/gameplay authority |
| `CTR-ACTOR-AUTHORITY` | blocker | prediction/correction/duplicate intent |
| `CTR-RESOURCE` + `CTR-VITALS-HUD` | blocker trước Approved | cost transaction, Focus semantics/HUD/recovery/persistence |
| `FEAT-COMBAT-LIGHT-ATTACK` | paired prototype | cancel interaction và click rhythm |

## 12. Acceptance hypothesis

- Một click spammer không nhận thêm defensive windows ngoài action cadence hợp lệ.
- Bốn hướng và chéo đi cùng quãng đường hiệu dụng trong mặt phẳng mở, trừ policy địa hình được nêu.
- Neutral input cho kết quả nhất quán theo camera mode đã chọn.
- Block collision không xuyên/tạo teleport; edge/wall outcome đọc được.
- Một attack ID chỉ bị tránh/resolve một lần theo defensive policy.
- First-person và third-person có cùng rule/timing.
- Client prediction sai được sửa mà không double-charge resource/double-damage.
- Người test mới sau tutorial phân biệt được normal/perfect/failure bằng ít nhất hai kênh cue.
- Reduced-motion không làm mất thông tin timing.

Đây là hypothesis để thiết kế scenario, chưa phải gate đạt.

## 13. Open questions chặn Proposed

| ID | Câu hỏi | Owner | Cách đóng |
|---|---|---|---|
| `DOD-OQ-01` | direction basis và neutral behavior | Camera + Combat | prototype 2 camera mode, 3 option |
| `DOD-OQ-02` | damage category nào defensive window tránh | Combat + Encounter | threat taxonomy + scenario review |
| `DOD-OQ-03` | cancel matrix theo action phase | Combat + Animation | paired light/heavy prototype |
| `DOD-OQ-04` | movement/collision trên wall/edge/air/water | Gameplay Tech + Combat | physics spike + test grid |
| `DOD-OQ-05` | Focus/Fatigue/perfect reward | Systems + Balance | resource option playtest |
| `DOD-OQ-06` | prediction/latency policy | Technical Director | local/dedicated latency harness |
| `DOD-OQ-07` | terminology và tutorial | UX + Localization | comprehension test VI/EN |

## 14. Gate verdict

`FEAT-COMBAT-DODGE` ở `DISCOVERY`. Không được bắt đầu code từ độ chi tiết của candidate. Bước hợp lệ tiếp theo là research/prototype plan trong `research-plan.md` và hoàn thành scenario matrix.
