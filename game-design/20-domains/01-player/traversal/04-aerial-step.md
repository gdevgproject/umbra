# FEAT-TRAVERSAL-AERIAL-STEP — Nhịp Không Trung / Double Jump

> **DRI:** Player Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat/Dodge, Input, Camera, Animation, World, Balance, Progression, Accessibility, Platform, QA, Performance
> **Status:** `DISCOVERY`
> **Target slice:** future `C6` candidate sau core `C3B-AERIAL-MASTERY`; không thuộc exit gate C3B hiện tại

## 1. Contract một câu

Khi người chơi đã mở Nhịp Không Trung, còn một step use trong `AerialChain` và bấm Jump ở airborne context hợp lệ, actor phát một impulse có hướng được collision kiểm soát để sửa quỹ đạo lần thứ hai—có thể nối với Aerial Dodge nhưng không cấp i-frame, reset fall, refresh khi chạm tường hoặc biến thành bay vô hạn.

## 2. Giá trị và ranh giới

- Pillar chính: `PIL-EMBODIMENT` + `PIL-MASTERY`; cho phép sửa sai/biểu đạt quỹ đạo bằng timing và hướng.
- In scope: airborne Jump intent, 360° direction, impulse/collision, Vigor, one-use budget, Aerial Dodge/Grounding/Lightness/Free Climb transitions, camera/animation/cue, authority/save/test.
- Non-goals: triple jump baseline, hover, i-frame, global fall immunity, wall jump thay Free Climb, reset Elytra/Lightness, tự cứu knockback không cần input, quyết định nó là universal hay build unlock trước `DB-057`.
- Success signal: người chơi dự đoán được Space sẽ bám tường hay step, chain với Dodge có nhịp rõ và không tìm được loop tăng độ cao vô hạn.

## 3. Vocabulary

| Term | Nghĩa | Không phải |
|---|---|---|
| `AerialChain` | causality episode từ lúc rời stable support tới stable support tiếp theo | mỗi feature tự reset khi chạm gì đó |
| `step_use` | quyền commit đúng một Aerial Step trong chain baseline | Vigor hoặc số lần bấm Space |
| `AERIAL_STEP` | action impulse đã được authority accept | vanilla double-jump tự phát ở client |
| `stable_support_reset` | footprint + dwell hợp lệ reset budget | wall touch, ladder graze hoặc correction |

## 4. Eligibility và semantic selection

`Jump` airborne đi qua consumer selection đúng một lần:

1. Nếu actor `CLIMB_*`/`MANTLE_*`, Free Climb sở hữu Jump; Aerial Step `DENY_NO_COST`.
2. Nếu có valid wall candidate, input đang hướng vào face và attach confidence thắng, Jump là `AIR_GRAB_REQUEST`.
3. Nếu input away/suppress attach hoặc không có wall candidate, Aerial Step có thể `TRANSITION` khi capability, `step_use`, Vigor, control và clearance hợp lệ.
4. Nếu không feature nào legal, Jump bị consume như denied airborne request có reason; không tạo vanilla double-jump giả.

Player-jump, walk-off, controllable fall, wall-eject/drop và external launch sau control-lock đều có thể mở cơ hội step nếu budget từ stable support còn. Auto-jump, key repeat/held Space, Creative/Spectator, Elytra, swimming, riding, portal, death, grab/knockdown và hard commit bị deny. External force không tự cast; fresh Jump vẫn có thể là deliberate recovery sau control-lock.

Giữ Sneak trước airborne Jump suppress wall attach và có thể giúp chọn Aerial Step, nhưng không bỏ Vigor/collision/budget guard. Controls/onboarding phải dạy đây là precision override, không là chord bắt buộc.

### 4.1. Hai lần Space nhưng không làm chậm cú nhảy đầu

- `Space #1` trên stable support đi vào normal Jump owner ngay khi press, trừ neutral hold đang được Lightness selector khai rõ; Aerial Step không được tự chờ lần bấm thứ hai. Chỉ sau một actual `TAKEOFF_COMMIT` mới có press #2.
- Sau `TAKEOFF_COMMIT`, một **fresh press edge** `Space #2` mới có thể tạo `AerialStepIntent`. Held Space, key-repeat, packet duplicate hoặc auto-jump continuation không phải press thứ hai.
- Press thứ hai quá sớm có thể vào `SHORT_BUFFER`, nhưng chỉ sống trong một cửa sổ ngắn và chỉ phát ở earliest legal marker. Nó không được giữ tới apex/rơi rồi tự phát ngoài ý định.
- Press sau khi use đã commit trả cue `STEP_SPENT`; không rút Vigor, không restart animation và không làm mất normal air steering.
- Profile accessibility có thể map `Aerial Step` thành action riêng/remappable hoặc dùng “press lại trong cửa sổ rộng hơn”; cả hai vẫn đi qua cùng eligibility/use/cost. Không có profile nào auto-cast ở apex.

## 5. Direction, impulse và lifecycle

```text
AIRBORNE + fresh Jump + guard + reserve
  → STEP_START
  → STEP_IMPULSE_COMMIT
  → STEP_RECOVERY
  → ASCENDING | APEX | FALLING
```

- Horizontal direction dùng camera-relative movement basis snapshot tại accept; neutral giữ horizontal momentum hiện tại và thêm lift profile, diagonal normalized.
- Input 180° có acceleration/redirect cap; không xóa momentum rồi teleport sang hướng đối diện. Ceiling/body sweep có thể shorten/reject.
- Một action ID commit một impulse và một Vigor cost. Reject trước impulse refund; sau impulse không refund vì hit/collision/world mutation đã thay outcome.
- Aerial Step không đặt grounded, không reset fall attribution/height, không cấp i-frame và không refresh `step_use`.
- Stable ground/support dwell reset chain. Climb latch/leap, mantle chưa commit, ladder/scaffold touch, slime bounce, water contact không đủ reset nếu owner chưa xác nhận stable support.

### 5.1. Quỹ đạo theo pha — sửa đường bay, không xóa lịch sử rơi

Aerial Step dùng một **hybrid velocity rebase có cap**, không cộng một vector cố định vào mọi vận tốc và cũng không đặt velocity Y về cùng một số. Authority snapshot `incoming_velocity`, phase và fall provenance tại accept:

| Entry phase | Xử lý trục dọc | Cảm giác/giới hạn |
|---|---|---|
| `RISING` | giữ một phần upward velocity trong band rồi thêm lift tới cap | nối nhịp cao, không nhân đôi vô hạn vận tốc đi lên |
| `APEX` | authored lift impulse đầy đủ | beat rõ và dễ học nhất |
| `FALLING` | hãm downward velocity tối đa một arrest cap rồi thêm lift | cứu chỉnh sai vừa phải; fast fall vẫn giữ nguy hiểm và fall provenance |

- Horizontal neutral giữ momentum hiện tại; có input thì blend về direction snapshot với redirect/acceleration cap. Quay 180° là một correction có lực, không instant reversal.
- Early/apex/late timing có expression khác nhau nhưng phải nằm trong **một total-route envelope**. Không timing nào vừa cho độ cao tối đa vừa cho tầm ngang tối đa.
- Ceiling/body sweep trước commit có thể reject/refund; collision sau commit shorten/stop và giữ cost. Không “snap xuống” để tìm khoảng trống.
- Gravity tiếp tục hoạt động theo authored step curve; feature không treo trọng lực như Aerial Dodge. Điều này giúp silhouette và vai trò hai kỹ thuật khác nhau.

### 5.2. Animation, camera và cảm giác lực

- Beat tối thiểu: `air brace/compress → directional impulse/extension → recovery/reacquire fall`. Silhouette phải phân biệt với normal jump và Aerial Dodge.
- Rising/apex/falling dùng entry blend khác nhau nhưng cùng commit marker/collision truth; weapon/item đang cầm có upper-body additive hoặc fallback an toàn, không làm lệch hitbox.
- Third-person camera nới framing theo projected route, không snap yaw/lock target. First-person giảm roll/bob và không dùng full-body flip bắt buộc.
- Audio/body/VFX có ba semantic: available window, impulse commit, spent/denied. Reduced-motion bỏ trail/shake nhưng giữ âm thanh/body cue; thiếu clip/VFX dùng fallback mà không đổi timing.
- Không có HUD icon thường trực cho một use. Vigor HUD wake khi cost có liên quan; optional reticle/body cue báo `step_use` còn/hết phải phân biệt được mà không chỉ dựa màu.

## 6. Aerial Dodge, Grounding, Lightness và Free Climb

| Source/next action | Result direction |
|---|---|
| Aerial Step → Aerial Dodge | `SHORT_BUFFER/TRANSITION` sau step impulse commit nếu dodge use + Focus còn; Dodge sở hữu defense/movement tiếp theo |
| Aerial Dodge → Aerial Step | `SHORT_BUFFER/TRANSITION` sau dodge active/cancel marker nếu step use + Vigor còn; không overlap i-frame và lift |
| Step → Grounding Strike | chỉ sau step commit khi actor thật sự `FALLING`, ground/time-to-impact guard hợp lệ và có fresh/short-buffered Attack |
| Free Climb attached/mantling | `DENY_NO_COST`; Jump là climb leap/mantle. Wall contact không reset step use |
| Wall-eject/Drop → Step | legal bằng fresh Jump nếu budget cũ còn; không cấp use mới từ wall |
| Lightness ascent/apex/fall | chỉ `TRANSITION` tại cancel edge do Lightness khai và dùng cùng chain; exact composition thuộc `DB-057` |
| Lightness descent | `DENY_NO_COST` baseline để tránh lift–descent stutter/flight loop |
| Grounding committed | deny; impact/recovery owner thắng |

Hai thứ tự Step→Dodge và Dodge→Step đều là candidate direction để tăng expression, nhưng baseline tối đa một use mỗi loại/chain. Focus và Vigor không rút/hoàn chéo; progression không được biến một action thành reset cho action kia.

## 7. Interaction và failure

- Attack/Use/Place/Mine hard commit, item screen, mount/swim/Elytra và external mode dùng result contract tại `CTR-TRAVERSAL`; default `DENY_NO_COST`.
- Hit trước impulse có thể cancel/refund theo severity; sau impulse giữ cost, hit attribution và velocity composition có cap.
- Block/piston/entity xuất hiện trong sweep làm shorten/collision/fall, không phase/teleport. Void không tạo invisible support.
- Quit/reconnect/death/portal cleanup runtime action/chain; không relog để lấy step use hoặc phục hồi giữa impulse.
- First/third person cùng trajectory; animation/VFX không sở hữu impulse. Cue phân biệt step available/used/denied nhưng không thêm bar thường trực; Vigor HUD chỉ wake theo action context.

## 8. Scenario matrix seed

| ID | Given/When | Then/oracle |
|---|---|---|
| `AST-S-001` | ground jump → fresh airborne Jump neutral/W/A/D/diagonal | một step, direction snapshot/normalize, một Vigor commit |
| `AST-S-002` | walk-off/external knockback rồi fresh Jump sau control-lock | deliberate step legal theo budget; không auto-cast |
| `AST-S-003` | near wall input toward/away/Sneak-suppress + Jump | attach hoặc step đúng một consumer, reason trace được |
| `AST-S-004` | attached/mantling + Jump | Free Climb owns; no step use/cost |
| `AST-S-005` | Step→Dodge và Dodge→Step | mỗi use/cost một lần, marker/defense không overlap sai |
| `AST-S-006` | repeated Space/packet/recontact wall/ladder/graze | không refresh/repeat/infinite height |
| `AST-S-007` | low ceiling/corner/piston/block mutation trước/sau commit | reject/refund hoặc collision sau commit, no clip |
| `AST-S-008` | Step rồi Attack sớm/đúng Grounding window | không ground-strike khi ascending/committed; legal khi falling + guard |
| `AST-S-009` | Lightness ascent/descent/re-entry | đúng cancel/deny, một chain, không hover loop |
| `AST-S-010` | death/portal/reconnect/Creative/Elytra/swim | cleanup/no refill/owner precedence |
| `AST-S-011` | Space #1 held/repeat rồi Space #2 fresh quá sớm/đúng marker/quá muộn | normal Jump không trễ; chỉ fresh edge hợp lệ buffer/commit một lần |
| `AST-S-012` | Step lúc rising/apex/normal fall/fast fall | phase profile đúng, route envelope bounded, fast fall không bị xóa |
| `AST-S-013` | neutral/90°/180° redirect với nhiều incoming speed | preserve/blend/cap đúng, không teleport hoặc tăng tốc vô hạn |
| `AST-S-014` | first/third person, weapon/item, missing clip, reduced motion | trajectory/cost parity; cue và silhouette còn đọc được |

## 9. Cross-discipline và dependencies

Canonical state/resource/result tại [`CTR-TRAVERSAL`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md); action authority tại [`CTR-ACTION-AUTHORITY`](../../../30-shared-contracts/01-action-authority-and-time.md). Direct peers: [`Free Climb`](01-free-climbing.md), [`Grounding Strike`](02-aerial-grounding-strike.md), [`Lightness`](03-lightness-art.md), [`Dodge`](../../02-combat/dodge/README.md) và [`Aerial Dodge`](../../02-combat/dodge/aerial-dodge.md).

Input/remap/context, two-camera direction, animation markers, Vigor HUD, progression delivery, collision/world mutation, server prediction, save cleanup, accessibility/localization và `PR-2` trajectory/collision hot-path proof đều bắt buộc. Economy/content N/A cho runtime action; unlock source còn `OPEN` tại `DB-057`.

| Discipline | Closure direction |
|---|---|
| UI/UX + localization | contextual Vigor/spent/denied cue, remapped action names và subtitles; không icon thường trực/hard-code `Space` |
| Accessibility | dedicated action/wider buffer alternative, reduced motion và two-view comfort; không auto-apex cast |
| Authority + multiplayer seam | logical server accept/cost/impulse; sequence/reorder/correction idempotent. Current offline, chưa implement multiplayer gameplay |
| Save/migration/platform | unlock/input profile versioned; runtime chain/action ephemeral; reconnect no refill; no Fabric/NeoForge semantic/save fork |
| Performance/compatibility | `PR-2`, bounded sweep/no per-frame allocation; voxel/modded shape qua contract và visual degrade không đổi trajectory |
| Content/economy | runtime N/A; chỉ unlock/tutorial route thuộc progression, không thêm currency/sink ở cell này |

## 10. Open decisions và gate

| ID | Câu hỏi | Owner/cách đóng |
|---|---|---|
| `AST-OQ-01` | rising/apex/falling lift–arrest–redirect/collision envelope nào expressive nhưng không thay Lightness? | Traversal + Camera voxel-air room |
| `AST-OQ-02` | Vigor cost, one-use reset và external-launch recovery band? | Balance + QA route/exploit simulation |
| `AST-OQ-03` | Step↔Dodge cancel markers/i-frame separation và hai thứ tự chain? | Combat + Animation paired prototype |
| `AST-OQ-04` | wall attach vs step confidence/override có dự đoán được? | Input + Accessibility blind test |
| `AST-OQ-05` | universal/passive skill/rune delivery nào không hard-lock world route? | Progression + Skills `DB-057` |
| `AST-OQ-06` | press-2 buffer/dead-zone và accessibility binding nào rộng lượng mà không auto-cast? | Input + Accessibility timing study |

Feature giữ `DISCOVERY`; chưa có parameter, prototype, approver record hoặc permission implementation.
