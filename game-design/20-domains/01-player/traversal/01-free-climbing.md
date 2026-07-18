# FEAT-TRAVERSAL-FREE-CLIMB — Leo tự do và mantle

> **DRI:** Player Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Controls, Camera, Animation, World, Gameplay Tech, Accessibility, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi chủ động yêu cầu bám một face hợp lệ và còn Khí Lực, nhân vật chuyển sang locomotion theo bề mặt để leo lên/xuống/ngang, bật khỏi tường hoặc mantle lên đỉnh—với collision, cost và failure đọc được.

## 2. Baseline scope

In scope:

- attach/detach, climb idle, dọc/ngang/chéo;
- climb leap, wall eject candidate, corner continuation;
- ledge detection và mantle;
- Vigor, damage interruption, first/third camera, animation/IK/fallback;
- voxel/partial/hazard/vanilla-climb matrix, authority/save/test.

Non-goals baseline: ceiling crawl, rope/grapple, wall-run chain, mining/placing khi cling, enemy climbing implementation, moving-vehicle surfaces và infinite procedural handhold simulation.

## 3. Unlock và onboarding

- Basic step/mantle candidate có từ đầu.
- Full Free Climb là universal capability mở rất sớm bằng milestone huấn luyện không miss; không phải Potential hoặc active-skill slot.
- Tutorial đầu dùng một vách thấp có route ladder bên cạnh, dạy: attach → move → low Vigor → mantle → deliberate drop.
- Capability chưa mở cho feedback “chưa học” tại bề mặt có affordance, nhưng không spam prompt trên mọi tường.
- Creative/debug có grant/refill/probe commands; save migration cấp capability theo approved eligibility.

## 4. Input grammar đề xuất

| Intent | Candidate semantics | Guardrail |
|---|---|---|
| Attach từ đất/không trung | giữ/nhấn `Climb` hoặc `Jump/Traverse Up` khi move vào face | không auto-bám chỉ vì chạm tường khi mining/building |
| Leo dọc | input được chiếu lên trục up/down của face | W không luôn nghĩa world north |
| Shimmy ngang/chéo | input chiếu lên tangent của face, normalize | không nhanh hơn do diagonal |
| Climb leap | press Jump khi attached | upfront Vigor + clearance; không lặp từ key repeat |
| Eject/drop | direction-away + Jump hoặc Drop/Crouch | consequence/fall cue rõ |
| Mantle | auto khi move lên và ledge valid; manual alternative | auto-mantle setting, không teleport qua ceiling |

Exact binding thuộc `DB-002/050`. Auto-grab khi airborne là setting, không mặc định cướp mọi collision. Không dùng double-tap làm đường duy nhất.

## 5. State machine

```text
SUPPORTED/AIRBORNE
  --intent + valid face + Vigor--> ATTACHING
ATTACHING
  --latch commit--> CLIMB_IDLE/CLIMB_MOVE
CLIMB_*
  --valid top--> MANTLING → SUPPORTED
  --jump/eject--> AIRBORNE
  --Vigor 0 / heavy hit / invalid face--> SLIP → AIRBORNE
  --manual drop--> AIRBORNE
```

- Attach reservation refund nếu face mất trước latch; sau latch cost/drain theo authoritative ticks.
- Contact face snapshot có thể update qua verified continuation; camera xoay không đổi mặt bám.
- Chunk/block/door/piston thay đổi làm contact invalid phải chuyển an toàn, không giữ actor trong block.
- Runtime state không save như animation. Reconnect cleanup theo `CTR-TRAVERSAL`.

## 6. Surface movement

- Up/down speed, lateral speed, diagonal normalization, leap impulse, turn/corner time và drain đều là parameter riêng.
- Actor capsule/box giữ khoảng cách contact có tolerance; không ép center vào block grid khiến snap/rung.
- Convex corner cần face kế liên tục + clearance; concave corner không kẹp actor vào khe.
- Baseline không vượt overhang > policy angle và không bám underside.
- Slippery/fragile/hot/moving surfaces dùng profile; không rải exception theo block ID trong code.
- Nếu player chạm ladder/vine/scaffolding, owner vanilla path thắng trừ explicit transition.

## 7. Ledge và mantle

Một mantle candidate hợp lệ cần:

1. top support đủ rộng và không là hazard bị deny;
2. head/body clearance trong toàn sweep;
3. landing footprint server chấp nhận;
4. region/activity rule cho phép;
5. transition không đi qua closed block/entity collision.

Mantle có `START → COMMIT → RECOVERY`. Gameplay pose chỉ lên top tại commit. Animation marker trình bày, không tự dịch chuyển. Nếu candidate mất trước commit, actor trở lại cling hoặc fall theo reason; không teleport.

Near-zero Vigor ledge assist là candidate phải prototype: có thể cho một grace ngắn để mantle nếu đã chạm valid lip, nhưng không refill hoặc cho leo tiếp miễn phí.

## 8. Vigor và progression

- Drain theo authoritative time + movement profile; idle cling có thể drain chậm hơn move nhưng không miễn phí vô hạn.
- Climb leap trả upfront cost; reject/refund idempotent.
- Vigor không hồi khi attached; supported ground bắt đầu recovery sau delay.
- Capacity/efficiency upgrade giúp chọn route dài hơn nhưng có cap. AGI/Potential không tự đổi attach window/animation timing thành auto-win.
- Equipment/status có thể tạo surface modifier qua tag contract; UI phải preview cost/drain change.

## 9. Combat, hazard và interruption

- Baseline không attack/mine/place/use khi cling. Player có deliberate drop/eject để quay lại combat.
- Light hit candidate tạo flinch/drain; heavy/stagger/grab buộc detach. Exact severity thuộc prototype.
- Fire/lava/hot surface vẫn damage; climbing không cấp i-frame hoặc armor bypass exemption.
- Knockback sau detach giữ source/velocity hợp lệ. Cùng hit ID không interrupt/drain hai lần.
- Enemy unreachable response do dossier/encounter; không aim-read hoặc teleport miễn phí lên tường.

## 10. Camera và presentation

- Third-person chuyển framing để thấy actor, face và lip; collision camera không chui qua tường.
- `MoveBasis` là surface-relative trong climb; camera orbit/pitch chỉ đổi interpretation sau rule, không xoay actor khỏi face.
- First-person có hand/edge cue, sway/FOV giảm và tùy chọn gợi ý third-person; không auto-switch bất ngờ giữa committed transition.
- Animation set tối thiểu: attach thấp/cao, idle, up/down/lateral/diagonal, leap/eject, mantle, low-Vigor, hit/slip/fall và fallback generic.
- IK tay/chân là cosmetic bounded probe. Missing IK/clip dùng fallback silhouette; gameplay contact không biến mất.

## 11. Minecraft, companions và modes

- Ladder/scaffolding/vine/water elevator giữ route không Vigor và tiện cho base/build logistics.
- Doors/trapdoors/chests/redstone không bị climb input tự activate; block change invalidates probe.
- Creative flight/Spectator thắng state; Adventure dùng cùng climbability tags nhưng region rules có thể deny rõ.
- Elytra/swim/crawl/riding không tự chuyển Free Climb ngoài edge explicit.
- Active Shadow dùng follow/hold/rejoin policy; không spawn xuyên tường trước camera hoặc mất identity khi player mantle.

## 12. Performance, debug và acceptance

Risk `PR-2`, snapshot `PR-3`. Debug overlay hiển thị face normal/profile, contact points, ledge sweep, clearance, state, Vigor, predicted/authoritative pose và correction.

Acceptance hypotheses:

- không xuyên/rung/teleport ở full block, corner, slab/stair/fence/door/piston fixture;
- input dọc/ngang/chéo predictable ở camera 360° và hai góc nhìn;
- quit/reconnect, death, portal và block removal không refill/duplicate/kẹt state;
- ladder/scaffolding vẫn có lợi ích rõ;
- người mới phân biệt attach deny, low Vigor, slip và valid mantle bằng ít nhất hai kênh;
- face probe/allocation/correction nằm trong budget của camera-room benchmark.

## 13. Open decisions

`DB-050`: attach input/default auto-grab, climb speeds, idle drain, leap/eject, corner/overhang, mantle grace, hit severity, surface defaults và animation/comfort settings.

