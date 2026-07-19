# FEAT-TRAVERSAL-FREE-CLIMB — Leo tự do và mantle

> **DRI:** Player Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Controls, Camera, Animation, World, Combat, Gameplay Tech, Accessibility, Platform, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi chủ động yêu cầu bám một contact hợp lệ và còn Khí Lực, nhân vật chuyển sang locomotion theo bề mặt để leo, đổi mặt, bật/rời tường hoặc mantle lên support—với ý định được tôn trọng, hình học voxel được kiểm lại và mọi cost/failure/correction đều đọc được.

Pillar chính: `PIL-EMBODIMENT` + `PIL-MASTERY`. Pillar phụ: `PIL-AGENCY` và `PIL-DISCOVERY` qua việc tái đọc block Minecraft quen thuộc. Failure mode cảm xúc cần test: người chơi thấy game “nuốt nút”, tự lái sai, rung/snap vào grid, hoặc chết vì contact đổi mà không hiểu nguyên nhân.

## 2. Giá trị, phạm vi và nguyên tắc đóng

In scope:

- attach/detach, idle, leo dọc/ngang/chéo bằng vector liên tục;
- contact stabilization, route assist có giới hạn, climb leap, wall eject và corner transfer;
- adaptive mantle theo geometry/approach, motion/pose adaptation và camera hai góc nhìn;
- Vigor, input buffer, momentum, hit/status/fluid/world-mutation interruption;
- full/partial/thin/foliage/transparent/moving/fluid voxel matrix;
- integrated-server authority, prediction/reconciliation seam, save/reconnect, accessibility, debug, performance và test.

Non-goals baseline: ceiling crawl, rope/grapple, wall-run chain, attack/mine/place/use khi attached, enemy climbing implementation, moving-vehicle traversal, procedural handhold simulation vô hạn, multiplayer gameplay và global weather tax.

Các nguyên tắc đóng:

1. **Geometry first, block name last:** collision/support shape và contact continuity quyết affordance; tag/profile sửa nghĩa vật liệu hoặc gameplay. Không hard-code danh sách ngoại lệ theo block ID.
2. **Assist sửa sai số, không chọn hộ route:** stabilization có thể giữ contact; route assist chỉ bẻ nhẹ trong cone ý định và không đi qua gap/hazard/hidden face.
3. **Gameplay chọn đích, animation thích nghi:** state/collision/cost chọn mantle semantic và warp envelope; clip/IK không tự tạo đích hay teleport.
4. **Mọi commit kiểm lại world hiện tại:** candidate cũ không thắng block/entity/fluid mutation mới.
5. **Failure có nguyên nhân hành động được:** cue phải phân biệt thiếu Vigor, surface deny, clearance deny, hit, current, moving geometry và server correction.

## 3. Unlock và onboarding

- Movement owner giữ automatic step-up/vanilla jump trong band đi bộ bình thường; chúng không phải Free Climb và không tốn Vigor.
- Basic grounded low mantle có từ đầu nhưng cần `Jump/Traverse Up` hoặc explicit `Climb` intent; chỉ đi/chạy đâm vào vật cản cao hơn step band không tự mantle.
- Full Free Climb là universal capability mở rất sớm bằng milestone huấn luyện không miss; không là Potential hoặc active-skill slot.
- Tutorial đầu dùng một vách thấp có slab/stair lip và route ladder bên cạnh, dạy: attach → vector move → low Vigor → adaptive mantle → deliberate drop.
- Bài học sau mới thêm corner, dòng nước và block mutation; không dạy bằng lava/piston gây chết.
- Capability chưa mở chỉ cue tại affordance được tác giả đặt; không spam prompt trên mọi tường.
- Creative/debug có grant/refill/probe/latency controls; save migration cấp capability theo approved eligibility.

## 4. Vocabulary và contact model

| Term | Nghĩa | Không được hiểu là |
|---|---|---|
| `ContactPatch` | vùng collision face đủ rộng/liên tục cho body contact trong tick hiện tại | tâm của một block hoặc texture face |
| `ContactCorridor` | chuỗi patch cục bộ có thể đi theo input mà không mất clearance | route toàn cục/auto-path |
| `SurfaceProfile` | nghĩa gameplay data-driven của shape: broad, narrow, unstable, slick, hot, dynamic, deny… | whitelist block ID rải trong code |
| `WorldRevision` | fingerprint của block state, collision/support shape, fluid state và entity blockers liên quan | chỉ số chunk chung cho phép bỏ qua revalidation |
| `ContactStabilization` | hiệu chỉnh rất nhỏ để giữ actor trên corridor đang chọn | auto-steering sang route khác |
| `RouteAssist` | bias có cap tới patch/corner/lip phù hợp vector người chơi | aim-bot traversal hoặc teleport |
| `MantleType` | semantic gameplay được chọn từ delta/approach/clearance/support | tên clip animation |
| `InputIntent` | Action ID/axis có timestamp, sequence và context | raw key hoặc packet tự commit state |
| `IntentLineage` | nguồn gốc chuỗi ý định như explicit Jump, airborne Jump request, auto-jump, walk-off hay external launch | đoán ý định chỉ từ velocity/contact cuối cùng |
| `AirborneProvenance` | nguyên nhân actor rời support và event đã đổi quyền điều khiển sau đó | cờ “đang ở trên không” không có causality |

Contact snapshot mang tối thiểu: patch/normal/tangent basis, shape/profile ID, support width, clearance, fluid overlay, dynamic flag, `WorldRevision`, accepted tick và causality/transition ID. Probe chỉ quét neighborhood cục bộ có cap.

## 5. Input grammar, intent inference và buffering

UMBRA không cần thêm một phím bắt buộc chỉ để leo. Action layer tách **physical binding** khỏi **semantic intent**: default `Jump/Traverse Up` có thể phát `VANILLA_JUMP`, `LOW_MANTLE`, `HOP_ATTACH`, `AIR_GRAB_REQUEST`, `CLIMB_LEAP` hoặc `POST_MANTLE_JUMP` tùy state; `Sneak/Traverse Down` có thể phát vanilla sneak, dismount/swim-descend theo owner tương ứng, hoặc deliberate climb drop. `umbra.action.climb` vẫn tồn tại như precision/accessibility/remap action nhưng không cần default riêng.

| Context + input | Semantic được chọn | Guardrail |
|---|---|---|
| supported, không có obstacle traversal | `Jump → VANILLA_JUMP` | không đổi Minecraft jump chỉ vì feature đã unlock |
| supported, low obstacle có top sạch | `Jump → STEP_UP/LOW_MANTLE` | không attach giả; hazard/unknown landing vẫn revalidate |
| đứng sát tall valid face, hướng vào mặt rồi Jump | `Jump → HOP_ATTACH` | một action lineage; không vừa commit vanilla jump vừa attach |
| đang trong player-authored jump arc và va trực diện valid face | recent Jump lineage → `ATTACH` tự nhiên | approach alignment + expiry + inhibitor; giữ upward/tangent momentum có cap |
| walk-off/fall rồi bấm Jump trên không | `Jump → AIR_GRAB_REQUEST` | không double-jump; chỉ attach khi face/reach/revision/Vigor hợp lệ |
| chỉ đi/chạy/sprint đâm tường | collision/slide/stop | không Jump lineage thì không attach/prompt spam |
| đang attached, Jump + neutral hoặc Up | `CLIMB_LEAP_UP` | neutral có nghĩa lên; upfront cost + destination guard |
| đang attached, Jump + Left/Right/Up-diagonal | `CLIMB_DYNO` theo tangent vector | normalize; candidate trong local envelope, không đổi sang hướng khác khi fail |
| đang attached, Jump + Down | `WALL_EJECT` có directional snapshot | Down thường vẫn leo xuống khi không Jump; không nhầm với drop |
| đang attached, fresh Sneak press | `DELIBERATE_DROP` | miễn cost; giữ source/velocity, không auto regrab cùng face |
| mantle trước commit + fresh Sneak | cancel về cling nếu contact còn hợp lệ, nếu không fall | không teleport về pose cũ đã mất |
| mantle sau commit + Sneak held | hoàn tất landing rồi vào vanilla sneak | không thả ngược khỏi mép vừa lên |
| mantle recovery + buffered Jump | `POST_MANTLE_JUMP` ở tick supported đầu tiên | một press không đồng thời mantle và jump hai lần |

Action layer luôn biểu diễn movement bằng vector chuẩn hóa liên tục. Bàn phím tạo các vector số hóa; thiết bị analog tương lai giữ magnitude/góc sau dead-zone. Gameplay không hard-code `WASD` hoặc tám hướng, nhưng cũng không giả bàn phím có độ phân giải analog.

### Intent inference: bằng chứng và inhibitor

Auto-attach mặc định dùng **evidence có nguồn gốc**, không dùng một cờ auto-grab toàn cục:

```text
eligible geometry/revision
+ recent explicit Jump edge hoặc airborne Jump request
+ movement/approach hướng vào face trong cone
+ player còn quyền điều khiển
- inhibitor đang hiệu lực
→ attach candidate có confidence + expiry
```

Evidence mạnh là explicit Jump press, player-authored jump provenance, forward/approach alignment và face contact trực diện. Camera ray chỉ hỗ trợ scoring, không tự tạo intent. Contact sượt dọc tường ngoài approach cone tiếp tục slide/fall để parkour sát tường không bị hút.

Các inhibitor đóng candidate, không chỉ hạ score:

- vanilla auto-jump, walk-off và passive fall không tự tạo lineage; người chơi vẫn có thể bấm Jump trên không để xin bám;
- knockback/grab/explosion/piston/current hoặc hit impulse vượt threshold làm mất inferred Jump lineage; cần một Jump edge mới sau control-lock để rearm;
- Sneak đã held trước contact biểu thị suppress auto-attach; fresh Sneak sau latch mới là Drop;
- Attack/Destroy hoặc Use/Place đang held/committed—gồm pillar-jump đặt block—thắng inferred attach. Jump lineage đó bị consume/cancel, không sống lại sau khi đặt block;
- input away, grazing angle, hard-committed Dodge/skill, swimming/crawling/riding/Elytra/portal/death và profile deny/hazard policy chặn attach;
- engine key repeat, Space held và duplicate packet không tạo thêm Jump/leap. Mỗi physical edge có một lineage ID và tối đa một gameplay consumer.

Accessibility có thể bật `ASSISTED_AIR_GRAB`, cho phép player-authored airborne movement trực diện thay explicit air-Jump press, nhưng vẫn giữ mọi inhibitor, geometry, Vigor và authority guard. Nó không bao giờ cứu external launch tự động.

### Input buffer

- Buffer lưu **intent đã edge-trigger**, không lưu raw key state: `action_id`, sequence, client sample tick/time, direction snapshot, source context và expiry profile.
- `Jump/Traverse Up`, optional precision Climb và `Sneak/Traverse Down` edge có buffer riêng; axis held được sample như state, không nhân thành nhiều press. Semantic consumer được chọn một lần từ lineage + accepted context.
- Intent chỉ được consume đúng một lần bởi transition đầu tiên thỏa guard; duplicate/reordered packet dùng cùng sequence không tạo cost/action mới.
- Nếu chưa legal ở cuối animation/transition nhưng legal trong cửa sổ kế tiếp, intent chạy ở authoritative tick đầu tiên có thể nhận. Nếu context đổi sang hit-stagger, death, menu, portal, mode khác hoặc expiry, intent bị hủy với reason; không đổi thành action “gần giống”.
- Buffer window, late-input grace và coyote/contact-loss window là parameter theo action, không phụ thuộc FPS/clip frame. Assist setting có thể nới trong range đã test nhưng không bỏ resource/collision guard.
- Debug/Input UI phải hiện `QUEUED → CONSUMED | EXPIRED | CANCELLED(reason)` để phân biệt “game nuốt nút” với input bị từ chối hợp lệ.

Exact binding và window thuộc `DB-002/050`.

### Entry behavior và automation baseline

| Context trước contact | Baseline result | Inhibitor/override | Setting/ghi chú |
|---|---|---|---|
| đi/chạy vào full wall | collision/slide/stop; không attach/prompt | chỉ Jump edge mới mở attach candidate | wall contact không phải intent |
| sprint vào wall | không wall-run/climb; collision owner xử lý | sprint-jump trực diện có thể attach, grazing thì không | sprint kết thúc khi latch; momentum cap |
| đứng sát và hướng về tall wall | Jump tạo `HOP_ATTACH`; precision Climb có thể latch không hop | không input thì không làm gì | dùng Space default, không phí phím leo |
| Jump/fall vào tall wall | player-jump arc trực diện tự attach; airborne Jump request cho deliberate clutch grab | passive fall/walk-off không attach; inhibitor vẫn thắng | `ASSISTED_AIR_GRAB` chỉ nới explicit press |
| Jump/Traverse Up vào obstacle có top trong grounded mantle band | `STEP_UP/LOW_MANTLE` nếu sweep sạch, không vào cling giả | auto-jump không mở Free Climb trên tall wall | precision Climb có thể chọn cùng candidate |
| sprint + Jump vào low obstacle | low mantle/vault có cap, giữ một phần momentum | hazard/unknown landing deny/reject | không biến mọi obstacle thành parkour |
| crouch/sneak gần edge/wall | giữ vanilla edge-safety; held Sneak suppress inferred grab/mantle | release rồi Jump/precision Climb mới attach | fresh Sneak sau latch mới Drop |
| knockback/grab/explosion đẩy vào wall | không attach kể cả `ASSISTED_AIR_GRAB` bật | fresh Jump chỉ xét sau control-lock | không biến enemy hit thành auto-save |
| Dodge/attack/use/mine/place đang committed | action owner thắng; attach queue/reject theo precedence | không cancel ngầm; build lineage bị consume | reason chỉ hiện sau traversal intent |
| lưng quay vào wall hoặc hai face cùng gần | không auto xoay/bám | move/view intent trong cone + hysteresis chọn một patch | không snap actor 180° |

Baseline đề xuất là **Jump-to-traverse, persistent attach, fresh-Sneak-to-drop**: người chơi không phải giữ thêm một nút suốt vách dài hoặc có một default Climb key riêng. Optional precision Climb và hold-to-cling là accessibility/preference profiles cho cùng server truth.

Chỉ khi confidence vượt preview threshold từ Jump/grab lineage + approach + candidate, client mới nâng probe/cue từ background lên preview/deny feedback. Một lần Space ở giữa đồng trống, đi sát hàng trăm block trong base, mine/place cạnh tường hoặc va vai vào doorframe không làm HUD nhấp nháy hay phát âm thanh “có thể leo”.

## 6. Authoritative state và tick ordering

```text
SUPPORTED/AIRBORNE
  --intent + valid patch + Vigor--> ATTACHING
ATTACHING
  --latch commit + same revision--> CLIMB_IDLE/CLIMB_MOVE
CLIMB_*
  --valid lip + upward intent--> MANTLE_SELECT → MANTLE_START → MANTLE_COMMIT → MANTLE_RECOVERY
  --jump/eject--> AIRBORNE
  --recoverable contact loss + buffered attach--> REGRAB_CHECK → CLIMB_*
  --Vigor 0 / forced hit / invalid contact / external mode--> FORCED_RELEASE → AIRBORNE|EXTERNAL_MODE
```

Tick ordering và race canonical nằm tại [`CTR-TRAVERSAL §5`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md). Với cell này, hệ quả bắt buộc là block placement/break/piston/hit/external mode đã được ordered phải thắng candidate cũ trước latch/mantle commit; cùng tick hit và Jump không dùng frame client để chọn người thắng, và trace giữ cả intent lẫn event/reason.

Attach reservation refund nếu patch mất trước latch; sau latch cost/drain theo authoritative tick. Runtime contact/animation không save; reconnect cleanup theo `CTR-TRAVERSAL`.

## 7. Surface solver cho thế giới voxel

Taxonomy, shape decomposition và luật canonical cho glass/leaves/slab/stair/thin block/piston/fluid nằm duy nhất tại [`CTR-TRAVERSAL §4`](../../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md). Free Climb chỉ tiêu thụ kết quả đó:

- `FREE_CLIMB` cho attach/move/mantle theo các guard của cell này;
- `LIMITED_CLIMB` chỉ chạy semantic/modifier đã được profile và cue khai; không tự đoán từ material name;
- `NO_CLIMB` reject với reason family, không tìm một face xa hơn để “cứu” input;
- `HAZARDOUS_CONTACT` giữ damage/source; cell không cấp immunity;
- `WorldRevision` đổi giữa latch/mantle làm revalidation; còn contact/mode hợp lệ thì recover, nếu không `FORCED_RELEASE`.

Corner/lip scoring dùng các patch/corridor contract trả về và vẫn tuân input cone, clearance, hysteresis và local-probe cap. Free Climb không sở hữu block whitelist, fluid physics hoặc piston collision resolution.

## 8. Surface movement, auto-steering và micro-momentum

- Speed up/down/lateral, diagonal normalization, acceleration, corner time, contact tolerance và drain là parameter riêng.
- Capsule giữ contact offset liên tục; không ép center vào block grid. Cosmetic body/limbs thích nghi quanh capsule.
- `ContactStabilization` luôn bounded: sửa sai số nhỏ vuông góc mặt để tránh rung/seam loss, không tạo tiến triển dọc/ngang.
- `RouteAssist` chấm candidate bằng input alignment, continuity, clearance, distance, stability và hazard penalty. Input alignment là điều kiện đầu; không chọn face sau lưng camera, qua gap, ngoài local probe hoặc qua candidate bị deny.
- Assist có cone, lateral/angular correction cap, hysteresis/lock time và release threshold. Khi người chơi đảo input rõ, assist nhả ngay thay vì “đánh nhau” với họ.
- Auto-mantle, `ASSISTED_AIR_GRAB` và route-assist strength là settings tách. Server vẫn xác thực cùng geometry/resource truth.
- Tangential velocity được giữ có cap qua climb↔corner↔mantle để không “chết vận tốc” ở mỗi state; normal velocity vào tường bị triệt theo collision, không chuyển thành tốc leo miễn phí.
- Climb leap/eject snapshot hướng khi accepted. Contact-loss/coyote grace chỉ giữ cơ hội **reacquire**, không đóng băng actor, không refill Vigor và không xóa downward velocity.
- Regrab cùng support episode có anti-loop: cost bình thường, không tạo net vertical gain miễn phí, có cooldown/use cap; forced exhaustion/heavy hit có thể deny theo interruption profile.

## 9. Adaptive mantle

Mantle không phải một animation duy nhất. `MANTLE_SELECT` phân loại một lần từ vertical delta, approach state/velocity, lip depth, top support, outward angle và body clearance; dùng hysteresis band để số đo gần ngưỡng không đổi type liên tục.

| Semantic | Context | Feel/camera | Gameplay invariant |
|---|---|---|---|
| `STEP_UP` | actor còn supported, delta thấp/shallow | một bước dài, giữ flow và framing | không vào cling giả; sweep/landing vẫn authoritative |
| `LOW_MANTLE` | lip thấp hơn ngực hoặc approach có đà nhỏ | chống tay/đưa chân nhanh | commitment ngắn nhưng vẫn có commit/revalidate |
| `HIGH_PULL` | attached, lip cao/đà thấp | pull-up có anticipation/exposure rõ | cost/timing profile riêng; không animation-cancel teleport |
| `CREST_TRANSFER` | face/lip hơi hướng ra ngoài trong angle policy | rướn qua đỉnh với warp nhỏ | không mở overhang/ceiling crawl; sweep toàn thân sạch |

Một candidate hợp lệ cần: top support đủ footprint; full body sweep sạch; landing pose hợp lệ; region/activity cho phép; không qua closed shape/entity blocker; revision ổn định ở start và được kiểm lại tại commit.

Mantle flow:

```text
SELECT(snapshot type/target/profile)
→ START(anticipation, buffer vẫn nhận)
→ COMMIT(revalidate current world, consume cost/position transaction)
→ RECOVERY(blend + next buffered action)
```

- Nếu candidate mất trước commit: quay lại contact cũ nếu còn hợp lệ; nếu không, forced release/fall với reason. Không đổi sang type khác giữa action để cứu animation.
- Nếu block được đặt vào landing footprint hoặc entity/world collision đổi, server revalidate và reject; không có reservation độc quyền cho ledge.
- Hai actor cùng mantle không tự khóa nhau trong M0. Future entity-collision/party rule có thể thêm occupancy policy, nhưng không được tin client reservation.
- Motion/pose warping chỉ hoạt động trong envelope đã test, quanh target authoritative. Ngoài envelope dùng semantic/fallback khác hoặc reject; không kéo skeleton xa capsule.
- Missing clip/IK dùng generic fallback **cùng timing/cost/commit marker** của semantic, không nhập các mantle type thành một luật.
- Near-zero Vigor ledge assist là candidate: chỉ cho hoàn tất nếu lip đã được acquire trước ngưỡng, không refill/leo tiếp miễn phí và phải cue trước khi cạn.

## 10. Vigor cost, route economy và recovery

Mục tiêu không phải mô phỏng calorie/cơ tay theo hiện thực. Vigor tạo **embodied plausibility + route decision**: leo lên tốn hơn dịch ngang, leap nhanh nhưng đắt, nghỉ trên support thật có giá trị; còn va tường, sửa camera, assist hoặc server correction không bị tính như “nỗ lực” của người chơi.

Cost topology canonical nằm tại `CTR-TRAVERSAL`; Free Climb áp như sau:

| Hành vi | Cost direction | Lý do trải nghiệm |
|---|---|---|
| walk/run/jump thường, vanilla step-up, grounded basic low mantle | `0 Vigor` | movement nền không bị thuế; mantle đầu game hoạt động trước full unlock |
| explicit attach | guard cần minimum reserve nhưng không có entry fee baseline; drain bắt đầu sau latch | thử bám không bị phạt bởi probe/latency; zero-Vigor không tạo grab loop |
| one-time settle grace sau latch | không base drain trong grace ngắn, chỉ một lần mỗi attach episode | đủ thời gian đọc mặt/camera/HUD; không reset bằng spam stop–move |
| cling idle sau grace | low base drain theo authoritative time | cho quan sát ngắn nhưng không treo vô hạn |
| đi xuống | base drain + low actor-effort component | route lui hợp lệ nhưng không miễn phí vô hạn |
| shimmy/lateral/corner | base + medium effort theo actual authored displacement | diagonal/corner không có hidden surcharge; blocked input không trả distance cost |
| leo lên | base + high effort theo actual authored displacement | chiều cao/route length là quyết định chính |
| climb leap/eject có lực | high upfront reserve/commit | đổi endurance lấy tốc/độ cao; reject/refund idempotent |
| mantle từ attached | cost theo semantic: low < crest/high pull; reserve trước `START` | không cạn giữa animation; action cost thay tick drain để tránh double-charge |
| stabilization/route-assist/correction/external push | không actor-effort cost; base/profile hazard vẫn có thể chạy | người chơi không trả tiền cho assist/desync/dòng chảy đẩy hộ |

Direction weight là `up > lateral > down ≥ 0`, nhưng exact coefficient/range phải qua route simulation. Drain dùng actual accepted displacement, không raw input: giữ W vào ceiling/wall chỉ trả base cling drain, không mất thêm vì game từ chối chuyển động. Diagonal normalization áp cả speed lẫn effort.

Surface/status/equipment modifier là deterministic composition có cap; không nhân vô hạn leaves + flow + debuff. Global weather không đổi grip baseline. Light hit chỉ được tạo grip/Vigor consequence nếu hit profile cue rõ; không mặc định cộng damage + drain + detach thành ba hình phạt cho một hit.

### Climb leap/dyno như một kỹ thuật có mục tiêu

Jump khi attached không phải “tăng velocity Y”. Solver snapshot input surface-relative và chọn đúng một semantic/target:

| Input tại accepted tick | Technique | Target/cost rule |
|---|---|---|
| dead-zone/neutral hoặc Up | `CLIMB_LEAP_UP` | higher same-face patch hoặc lip; burst cost cao theo positive height |
| Left/Right/Up-diagonal | `CLIMB_DYNO` | patch/corner kế trong local envelope; base burst + vertical/lateral gap component |
| Down | `WALL_EJECT` | rời normal khỏi face với lateral bias có cap; cost thấp hơn upward leap nhưng không miễn phí |
| fresh Sneak | `DELIBERATE_DROP` | không impulse, không Vigor action cost; đường thoát luôn còn nếu người chơi muốn bỏ bám |

- Technique có `target_patch/ledge`, direction snapshot, impulse envelope, Vigor transaction và lineage ID. Invalid target không fallback sang Up hoặc một face “gần đúng”; actor tiếp tục cling và nhận deny cue nhỏ, không mất Vigor.
- Eligibility cần đủ `technique_cost + post_contact_minimum_reserve`; guard không bị tiêu riêng nhưng bảo đảm leap thành công không kết thúc bằng rơi tức thì trước settle grace. Người chơi vẫn luôn có Drop miễn phí.
- Nếu target là lip có mantle sạch, selector tạo composite `LEAP_TO_MANTLE` và reserve tổng cost trước launch. Thiếu tổng cost thì reject target đó; không âm thầm leap tới một patch khác hoặc bắt đầu animation chắc chắn thất bại.
- Impulse commit thay tick drain trong action window. Trước impulse, target/revision mất thì refund; sau impulse, hit/world mutation không refund chuyển động đã xảy ra và regrab/mantle phải qua guard mới.
- Upward/tangential approach momentum được carry có cap; sprint ngang không đổi toàn bộ thành độ cao miễn phí. Steering sau commit chỉ là micro-correction trong envelope, không retarget giữa không trung.
- Mỗi Jump edge tạo tối đa một leap. Recontact cần stable-contact dwell/cadence trước leap kế; buffer có thể nhận press hơi sớm nhưng không tạo bunny-hop vô hạn, double cost hoặc net-height exploit.
- Ở low Vigor, HUD `NEXT_COST` cho target theo hướng hiện tại. Nếu press khi thiếu, nhân vật vẫn bám, phát strain/insufficient cue và không consume resource; base cling drain vẫn tiếp tục bình thường.

### Exhaustion và recovery

- `0 Vigor` sau committed transaction tạo forced release; resource không âm. Action upfront bị reject trước start nếu không reserve đủ.
- Low/critical không chỉ là phần trăm: UI nhận cả normalized band, cost action kế tiếp và projected time-to-zero theo drain hiện tại, có hysteresis để không flicker.
- `SUPPORTED` với footprint/dwell thật bắt đầu recovery sau delay. Chạm mép một tick, mantle chưa commit hoặc graze slab không reset thành “đã nghỉ”.
- Ladder/vine/scaffolding không drain Vigor; chỉ profile được khai `RECOVERY_SUPPORT` và đáp ứng stable dwell mới hồi. Chuyển qua ladder không mặc định refill tức thì.
- Không hồi khi Free Climb attached/mantling, airborne, swimming hoặc trong non-support external mode. Full pause có dừng logical server thì dừng clock; inventory/chat không pause server thì drain/recovery vẫn authoritative và phải cue.
- Sau khi về full, meter giữ một grace ngắn rồi fade. Quit/reconnect/offline không biến thành refill exploit.

### Balance target trước con số

- Baseline full Vigor phải hoàn thành `STANDARD_ROUTE` tutorial từ full resource và còn margin cho một mantle hợp lý nếu không leap/spam; `STRETCH_ROUTE` buộc tìm ledge, ladder hoặc đánh đổi leap.
- Climb leap phải nhanh và expressive nhưng không là lựa chọn hiệu quả nhất trên mọi mét cao.
- Idle drain cho đủ một nhịp quan sát/camera correction; không đủ để AFK hoặc mở non-pausing UI lâu.
- Progression dịch chuyển bounded route class/correction margin, không tạo infinite climb hoặc biến surface/landing guard thành hình thức.
- Tuning so route theo **time, height, lateral detour, required action bundle và escape option**, không chỉ “leo được N block”.

## 11. Combat, action context và interruption

| Event/action khi attached | Baseline result |
|---|---|
| Move/Jump/Sneak/precision Climb | surface move, targeted leap/eject, deliberate drop hoặc buffer theo grammar ở trên |
| Attack/Destroy, Mine, Place, Use | `DENIED_ATTACHED` + cue; không auto-detach rồi làm hành động ngoài ý muốn. Jump+Use/Place trước attach ưu tiên build/pillar và suppress inferred grab |
| Inventory/chat/menu | screen owner thắng; held inputs neutralize nhưng không tự Drop. Nếu logical server không pause, Vigor/time vẫn chạy và meter/cue phải còn đọc được trong screen |
| pause thật/focus loss | logical pause dừng clock; focus loss release held state, không sinh Jump/Drop edge khi focus trở lại |
| hotbar select/camera switch | được phép nếu không mutate world; không reset state/resource |
| Dodge/Quick Recovery/Lightness/Grounding/skill | deny rõ hoặc explicit transition do owner contract; không fallback mơ hồ |
| light hit/DoT | damage luôn áp; flinch/drain chỉ một lần theo hit/severity profile |
| heavy/stagger/grab/explosion/knockback | forced release; giữ source, velocity, hit ID và cancel reason |
| projectile impulse trong jump-attach window | impulse đủ lớn invalidates inferred lineage; fresh Jump sau control-lock mới rearm, không auto-save do bị bắn |
| fire/poison/freeze/DoT không impulse | source/cadence giữ nguyên; không mặc định vừa damage, Vigor spike, flinch và detach cho cùng tick |
| swim/bubble column/water exit | aquatic owner thắng; `SWIM→MANTLE` là edge riêng, không giả Free Climb attach dưới nước |
| ladder/vine/scaffolding | vanilla locomotion owner thắng; chuyển state không refill tức thì hoặc consume Jump hai lần |
| crawling/trapdoor/powder snow/cobweb | external posture/surface rule thắng; không attach nếu capsule/clearance không hợp lệ |
| riding/boat/minecart | Sneak thuộc dismount owner; không phát climb Drop. Dismount cạnh tường không auto-attach nếu không có Jump lineage mới |
| Elytra/Creative flight/Spectator/levitation/portal/death | external mode precedence theo `CTR-TRAVERSAL`; cleanup lineage/contact/buffer |

Baseline deny Mine/Place/Use khi attached là một lựa chọn có chủ đích, không phải bỏ sót Minecraft. Cho thao tác đó sẽ kéo theo one-hand animation, vanilla reach/line-of-sight, block bị phá ngay dưới contact, pillar vô hạn từ tường, container/redstone activation và mutation race trong cùng tick. Hotbar vẫn đổi được để chuẩn bị; người chơi phải mantle/Drop tới support, dùng ladder/scaffold hoặc chờ một future **braced interaction** Feature Cell có cost/pose/reach/world proof riêng. Không mở một exception nửa vời chỉ vì item đang cầm nhìn như dùng được một tay.

Projectile/hit không bị wall-cling cấp i-frame. DoT tick không được lặp animation interrupt gây stun-lock ngoài damage owner. Sau forced release, Grounding Strike/Lightness/regrab chỉ legal qua edge và cost riêng; Free Climb không cấp giảm fall damage ẩn.

“Safety net” baseline là cue sớm + buffer/regrab bounded + các technique đã mở, không phải grace fall immunity. Nếu playtest cho thấy chết oan vẫn cao, thử option regrab/ledge assist trước khi giảm fall damage toàn cục.

### Quy tắc Sneak/Shift chống thao tác oan

- Chỉ **fresh press edge sau authoritative latch** mới là Drop. Sneak đã giữ từ trước contact suppress auto-attach và không làm actor attach rồi rơi trong cùng tick.
- Nhả Sneak không tạo action; key repeat không tạo nhiều Drop. Remap/toggle-sneak profile vẫn phát cùng semantic edge qua Input owner.
- Trong `MANTLE_START` trước commit, fresh Sneak là cancel có kiểm tra contact. Sau `MANTLE_COMMIT`, nó trở thành `SNEAK_ON_LANDING`; không đảo ngược capsule xuyên mép.
- Khi riding/swimming/crawling hoặc screen context sở hữu Sneak, external owner thắng. Chỉ state `CLIMB_*` mới context-transform nó thành Drop.
- Deliberate Drop đặt short same-face regrab inhibit để không bị assist hút trở lại; người chơi có thể bấm Jump edge mới sau inhibit để chủ động cứu lại.

## 12. Camera, animation và feedback đa giác quan

### Camera và animation continuity

- Third-person framing giữ actor, contact direction, lip và threat quan trọng trong view; collision camera không chui qua face và correction camera không feed ngược MoveBasis.
- `STEP_UP` không ép camera đổi mode. `HIGH_PULL` có framing/occlusion profile nhưng không snap yaw/shoulder ở commit.
- First-person dùng hand/edge/contact cue, horizon/FOV/sway giảm; không ép đổi góc nhìn giữa committed transition.
- Locomotion animation blend theo semantic, normalized phase, surface tangent và actual movement speed; idle↔move↔corner không cắt cứng theo packet/tick.
- Orientation/pose warping thích nghi analog angle, slab/stair height và hand/foot target trong envelope. IK là cosmetic bounded probe; fallback silhouette vẫn đọc được hướng/trạng thái.
- Held item/shield không bị drop, đổi slot hoặc mất component khi leo. Presentation có thể stow/relax/one-hand fallback theo item/body profile; missing anchor dùng grip pose generic và không đổi eligibility/timing.
- Blend/correction không được giữ pose bám sau khi authoritative state đã fall, hoặc giấu heavy-hit detach.

### Cue ladder

| State/reason | Visual/UI | Audio | Body/camera | Haptic (khi thiết bị hỗ trợ) |
|---|---|---|---|---|
| latch/valid move | contact dust/hand target nhẹ | contact material tick | settle pose nhỏ | optional tap |
| Vigor low | meter pattern/pulse + icon, không chỉ đổi màu | breathing layer tăng, cadence thưa | grip cadence/shoulder effort | pulse thưa, tắt được |
| Vigor critical | pattern/cadence nhanh hơn, route risk rõ | breath/strain khác low, không spam chime | micro-slip cosmetic không đổi collision | pulse gấp khác pattern low |
| exhausted/slip | empty/break state + directional fall cue | release sound + breath break | authoritative detach pose | one-shot distinct |
| deny/cancel | reason family: surface/clearance/resource/context | short differentiated cue có subtitle option | không shake mặc định | optional, không là kênh duy nhất |
| server correction | debug/optional network indicator; không hiện kỹ thuật cho normal micro-correction | chỉ cue khi action bị abort | visual root blend trong budget | N/A baseline |

Critical information luôn có ít nhất visual/pattern + audio hoặc body cue; haptic là kênh cộng thêm vì hardware có thể không tồn tại hoặc bị tắt. Không bật đồng thời mọi kênh ở cường độ cao: cue có priority, cooldown và mix ducking. Reduced motion tắt shake/FOV pulse/micro-slip nhưng không xóa state readability.

### HUD semantics mà feature phát ra

Free Climb phát projection payload; layout canonical thuộc `CTR-VITALS-HUD`:

- `PREVIEW`: chỉ khi Jump/grab lineage + approach + candidate vượt confidence threshold, cho biết current Vigor và candidate/action thiếu resource; không hiện vì Jump giữa đồng trống hoặc chỉ va tường;
- `ACTIVE`: attached/mantling, luôn giữ meter nhìn được kể cả đang full;
- `RESERVED`: overlay phần đã reserve cho leap/mantle; commit/refund animate từ cùng transaction;
- `NEXT_COST`: ghost notch/segment cho legal leap/dyno/eject hoặc mantle candidate theo hướng hiện tại; direction/candidate dùng debounce + hysteresis để không flicker, insufficient dùng pattern/icon, không chỉ đỏ;
- `LOW / CRITICAL`: band + projected exhaustion cue có hysteresis; body/audio escalation đồng bộ;
- `RECOVERY_DELAY / RECOVERING / FULL_FADE`: phân biệt chưa được hồi, đang hồi và sắp ẩn;
- `DENIED(reason family)`: surface/clearance/context/resource, chỉ sau explicit intent và có cooldown chống spam.

HUD không cần hiện số giây hoặc “còn leo chính xác X block” mặc định vì dễ nói dối khi surface/route đổi. Numeric current/max, drain rate và debug reach là setting/debug; người chơi thường đọc fill, reserved/ghost cost và cue cơ thể.

## 13. Prediction, reconciliation và future multiplayer seam

Target hiện tại là M0 offline/integrated server. Client có thể predict pose/contact/movement trong **prediction envelope** từ cùng profile/probe semantics; server giữ capability, state, Vigor, world revision, collision, hit và commit.

- Prediction request mang intent sequence, sampled direction, contact candidate/revision và predicted start pose; đây là hint, không proof.
- Server result trả accepted/rejected tick, authoritative transition/contact revision, pose/velocity, cost transaction và reason.
- Client được preview Vigor reserve/drain để HUD phản hồi ngay nhưng meter reconcile theo authoritative transaction; correction không tạo refill, double drain hoặc nhấp nháy threshold liên tục.
- Micro error: blend presentation root/limbs, không rung capsule/camera. Moderate error: bounded reconciliation giữ hướng intent nếu safe. Topology mismatch, stale revision hoặc xuyên collision: abort về safe pose/contact/fall; không lerp xuyên block.
- Correction có budget theo distance/angle/frequency/abort rate và phải ổn ở low/high FPS, TPS pressure và injected latency. Không che sustained desync bằng smoothing vô hạn.
- Remote actors future dùng interpolation; không tự predict authority của người khác. Race hai player/block placement giải bằng tick ordering + revalidation, không bằng client lock ledge.
- Current code sau này chỉ cần contract/trace/adapter seam cho M0 và dedicated parity; không implement party reservation, lag-compensated PvP hay co-op traversal gameplay trước milestone.

## 14. Minecraft, companion, save và modes

- Ladder/scaffolding/vine/water elevator giữ route không Vigor, logistics và pre-unlock value; transition explicit.
- Door/trapdoor/chest/redstone không bị Climb tự activate. Shape/state update invalidates contact theo revision.
- Creative/Spectator precedence; Adventure dùng cùng surface truth với region rule/cue. Elytra/swim/crawl/riding không tự chuyển ngoài edge explicit.
- Active Shadow dùng follow/hold/rejoin policy; không spawn xuyên tường hoặc mất/clone identity khi mantle.
- Quit/reconnect giữ Vigor theo save contract nhưng không phục hồi nửa mantle. Rebind chỉ vào safe supported/contact policy nếu revision còn legal; còn lại fall/safe pose có trace.
- Chunk unload/world border/portal/death cleanup contact, buffer và prediction state; không giữ “phím ma” hoặc stale ledge.

## 15. Cross-discipline impact map

| Producer/owner | Contract/consumer | Requirement |
|---|---|---|
| Input | `SYS-INPUT` → Free Climb | Jump/Sneak context, lineage/inhibitor, one-edge-one-consumer, continuous axis, buffer, remap/conflict diagnostics |
| World/blocks | `CTR-TRAVERSAL` → surface solver | collision/support/fluid/dynamic revision; tags override nghĩa, không thay shape truth |
| Combat/vitals | hit/status/environment → interruption/fall | stable hit/source/velocity/precedence; no double interrupt/damage |
| Camera/Animation | semantic state → two-view projection | warp/blend/fallback trong envelope; không sở hữu movement truth |
| UI/Audio/Accessibility | state/reason/Vigor → cues/settings | cue ladder, pattern không color-only, haptic optional, reduced motion |
| Platform | logical server/save/reconnect | authority, idempotency, revision race, prediction result, M0 dedicated parity |
| QA/Performance | trace/fixtures/benchmarks | state/shape/action/failure oracle, hot-path cap và correction budget |

Localization: mọi action/deny/setting/help dùng key `vi_vn`/`en_us`; runtime reason dùng stable enum rồi projection thành text/audio, không gửi chuỗi tự do từ server. Economy N/A — Free Climb không tiêu item/currency baseline. Multiplayer gameplay N/A — chỉ M0 authority seam theo Product; M1+ là future milestone.

## 16. Performance, observability và validation

Runtime risk `PR-2`; capability snapshot và dedicated/soak là `PR-3`.

Steady work: local patch probe, clearance sweep, input projection, state/resource update và optional client presentation. Burst: contact invalidation, multi-lip mantle scoring, correction, chunk/shape reload. Cardinality cap theo actor × bounded local candidates; cấm scan volume lớn hoặc allocate shape lists mỗi frame/tick.

Degradation chỉ giảm cosmetic IK, contact dust, trail, remote animation detail hoặc audio variation. Không giảm collision/revision revalidation, buffer/dedupe, Vigor truth, critical cue hoặc commit guard.

Debug overlay/trace hiển thị:

- raw/normalized input, queued intent lifecycle và context precedence;
- patch/corridor/normal/profile/shape component/fluid/dynamic flag + `WorldRevision`;
- mantle candidates, score/type/warp envelope/sweep/deny reason;
- state, phase, Vigor transaction, hit/status/external-mode event;
- predicted/authoritative pose, correction class/distance/angle/abort;
- probes/shape tests/cache hit/allocation/stuck/transition/cost counters.

### Quy trình studio để không bỏ sót case

Mọi thay đổi Free Climb phải đi qua cùng pipeline, không review chỉ bằng happy-path animation:

1. **Input/UX:** xác định physical edge, `IntentLineage`, pre-held state, buffer và đúng một semantic consumer.
2. **Traversal/Physics:** resolve locomotion owner, direction basis, contact/target, momentum và collision outcome.
3. **World/Compatibility:** resolve collision shape/profile/fluid/dynamic revision và vanilla/mod interaction owner.
4. **Combat/Vitals:** đặt action/hit/status/external-force precedence, Vigor reserve/commit/refund và fall attribution.
5. **Animation/Camera/Audio/UI:** project đúng semantic/result ở first/third person; failure reason có cue nhưng không sở hữu truth.
6. **Platform/Save/Authority:** kiểm tick ordering, duplicate/reorder, pause/focus/screen, reconnect/chunk/portal và future server seam.
7. **QA/Accessibility/Performance:** sinh automated oracle trước human feel card, chạy remap/hold-toggle/reduced-cue và hot-path/cardinality lane.

Scenario generation lấy ít nhất một representative từ mỗi trục sau rồi pairwise/adversarial-combine các trục có tương tác, thay vì Cartesian mù:

| Trục | Partition bắt buộc |
|---|---|
| actor state | supported, jump arc, passive fall, attaching, cling idle/move, leap, mantle pre/post commit, forced release, external mode |
| input lineage | explicit Jump, airborne request, auto-jump, Space held/repeat, precision action, pre-held/fresh Sneak, remap/toggle |
| control provenance | player-authored, walk-off, hit/knockback/grab, piston/current, mode transition |
| geometry | full/partial/thin/foliage/glass, corner/lip/ceiling, fluid overlay, dynamic/custom shape |
| concurrent intent | build/place, mine/attack/use, Dodge/skill, inventory/chat, hotbar/camera, dismount/swim/crawl |
| Vigor | full, exact reserve, below post-contact guard, low/critical, zero, capacity/modifier change |
| mutation timing | before candidate, before reserve, before impulse/commit, after impulse, before landing/recontact |
| presentation/lifecycle | first/third, GUI scale/cue channel off, FPS/TPS/latency, pause/focus, death/portal/reconnect/reload |

Một case chỉ được coi là đóng khi có: expected state + pose/velocity/contact, resource transaction, input-consumer/lineage result, world revision, cue/reason, automated oracle và owner. Human playtest chỉ đánh giá intent/readability/comfort sau khi logic pack xanh.

### Automated geometry and lifecycle fixtures

- full block: stone/wood/ore/glass/ice/honey/leaves;
- slab/snow-layer/carpet/farmland/path/bed/cauldron; stairs mọi facing/half/shape; seam/mixed height;
- fence/fence-gate/wall/iron bars/chain, door/trapdoor open–close, chest/shulker/redstone/container;
- waterlogged partial block, still/flowing water, waterfall over face, lava/hot contact;
- piston extend/retract, falling block/extending shape, block moved into/away from contact, break/place/profile reload tại mantle footprint;
- ladder/vine/scaffolding/powder snow/cobweb/bubble column và mod block có context-sensitive/custom collision;
- convex/concave corner, ceiling/overhang/tunnel, entity blocker, chunk/border/portal;
- hit/DoT/knockback/status cùng tick với Jump/mantle commit;
- duplicate/out-of-order intent, relog/death/dimension, first↔third, low FPS/TPS/latency.

### Human-only proof questions

Sau automated green, paired playtest chỉ hỏi từng card một câu:

1. “Khi game hỗ trợ bạn bo góc hoặc lên mép, bạn còn cảm thấy chính mình đã chọn hướng không?”
2. “Khi một lần bám/mantle thất bại, bạn có nói được nguyên nhân trước khi xem debug không?”
3. “Chuyển idle→move→corner→mantle có khoảnh khắc nào nuốt nút, snap camera hoặc làm mất đà vô lý không?”

## 17. Parameter hypotheses

Exact số không được khóa từ reference hoặc prose. Registry chỉ nhận số sau prototype; Feature Cell giữ các band cần đo:

| Parameter family | Candidate band | Hypothesis | Evidence/owner |
|---|---|---|---|
| patch span/contact offset/seam tolerance | theo tỉ lệ actor volume/limb reach, nhỏ hơn một voxel và có cap | đủ tha thứ shape seam nhưng không bám contact nhìn như rỗng | shape sweep/property fixtures + visual comprehension; Gameplay Tech |
| Jump-lineage/attach/buffer/contact-loss window | ngắn theo authoritative time, độc lập FPS/clip | jump arc trực diện tự bám nhưng passive fall/grazing/build không bị hút | provenance/inhibitor + latency/FPS boundary sweep; Input/Traversal |
| assist cone/lateral-angular cap/hysteresis | từ stabilization-only tới low/medium assist setting | giảm jitter/miss nhưng người chơi đảo hướng vẫn thắng ngay | paired blind route test + correction trace; Controls/Accessibility |
| move/leap/dyno/eject acceleration, target envelope và momentum cap | profile riêng vertical/lateral/tangential | đúng hướng input, không chết đà hoặc biến sprint/impact/fluid force thành tốc leo miễn phí | target/trajectory/cost trace + comfort; Traversal/Camera |
| climb-leap burst/post-contact reserve/cadence | theo target height/gap và semantic, không raw key rate | expressive nhưng không spam vô hạn hoặc thành công rồi rơi tức thì vì zero reserve | route simulation + adversarial repeat/regrab; Balance/QA |
| mantle delta/approach/crest band | theo body-relative low/chest/high + angle policy | semantic ổn định qua slab/stair/custom shape và đọc được bằng pose | voxel-room coverage + threshold hysteresis sweep; Animation/Traversal |
| mantle timing/cost/warp envelope | semantic-specific, generic fallback giữ cùng profile | high pull có exposure nhưng không thành animation lock; warp không tách skeleton khỏi capsule | cancel/hit/mutation matrix + two-view capture; Animation/Combat |
| surface/flow/status modifier cap | deterministic bounded composition | leaves/water/hazard tạo quyết định nhưng không RNG/death spiral | route comparison + modifier property tests; World/Balance |
| Vigor low/critical thresholds và cue cadence | hai band trước exhaustion, có hysteresis/cooldown | đủ sớm để chọn mantle/drop/recovery, không alarm fatigue | no-audio/no-color/reduced-motion comprehension; UI/Audio/Accessibility |
| correction micro/moderate/abort budget | theo pose error + topology class, không chỉ distance | micro invisible, moderate giữ intent, topology mismatch fail safe thay vì smear | injected latency/TPS/FPS benchmark; Platform/QA |
| regrab/ledge assist use/cooldown/cost | tối đa bounded per support episode | cứu seam/input timing nhưng không infinite climb/refill | adversarial loop/property test; Traversal/QA |

## 18. Research, options và quyết định đề xuất

Research canonical: [`RES-TRAVERSAL`](../../../70-research/09-open-world-traversal-climb-breakfall-lightness.md). Rationale: [`ADR-0004`](decisions/ADR-0004-free-climb-geometry-intent-and-revalidation.md).

Các lựa chọn đã so:

| Vấn đề | Option bị loại/giữ | Lý do |
|---|---|---|
| block handling | whitelist tên block | nhanh lúc đầu nhưng vỡ với state/mod block/shape |
| surface truth | geometry-only tuyệt đối | scale tốt nhưng không biểu đạt hot/unstable/dynamic/content deny |
| direction assist | sticky auto-route | mượt khi đúng nhưng cướp agency và gây sai route trong build/combat |
| entry | mọi collision auto-attach | ít nút nhưng cướp mining/building/combat và biến knockback thành auto-save — loại |
| entry | dedicated Climb bắt buộc cho mọi attach | intent tuyệt đối nhưng tốn phím/muscle memory — giữ làm precision option, không default |
| entry | Jump lineage + approach + inhibitor | dùng muscle memory Minecraft, nhận jump-to-wall nhưng loại passive/external/build contact — direction UMBRA |
| cling control | hold-to-cling bắt buộc | release trực tiếp nhưng gây mỏi; giữ làm optional profile, baseline persistent latch + fresh Sneak Drop |
| mantle | một clip/root-motion | dễ author nhưng sai nhiều delta/shape và đặt animation lên authority |
| Vigor cost | chỉ theo thời gian hoặc chỉ theo quãng | một phía phạt đọc route, phía kia cho AFK; dùng base time + accepted effort + committed action |
| HUD | luôn hiện hoặc world-space-only | clutter hoặc mất truth theo camera/occlusion; dùng contextual fixed meter + cue phụ |
| wet weather | rain global làm trượt | tạo route drama nhưng thời gian chờ ngoài kiểm soát, kém Minecraft-native baseline |
| fall recovery | free grace damage reduction | giảm bực nhưng xóa hazard/technique mastery và khó đọc |

Recommendation hypothesis: geometry + profile + revision solver; contextual Jump/Sneak grammar với lineage/inhibitor; targeted climb leap; stabilization luôn bounded, route assist tùy chỉnh; adaptive mantle semantic; deterministic local environment modifier; buffered action intents; server revalidation + bounded reconciliation.

## 19. Open decisions và gate

| ID | Câu hỏi | Owner/cách đóng | Blocks |
|---|---|---|---|
| `FC-OQ-01` | exact patch span, seam tolerance, assist cone/hysteresis và correction budget? | Gameplay Tech + voxel-room benchmark/feel test | Validation → Approved |
| `FC-OQ-02` | exact Jump-lineage/approach/inhibitor windows, binding conflict và Jump/Sneak contextual grammar có qua build/pillar, parkour-graze, fatigue, accidental-entry và accessibility proof? | Input/Accessibility; `DB-002/050` experiment | Validation → Approved |
| `FC-OQ-07` | leap/dyno/eject target envelope, directional cost, post-contact reserve và cadence nào expressive nhưng không thành infinite bunny-climb? | Traversal + Balance + QA route/adversarial simulation | Validation → Approved |
| `FC-OQ-03` | mantle type thresholds/timing/cost/warp envelope và near-zero grace? | Traversal + Animation + Camera paired prototype | Validation → Approved |
| `FC-OQ-04` | leaves/narrow lattice/local flowing-water profile nào vui và dễ đọc? | World + Traversal route comparison | Validation → Approved |
| `FC-OQ-05` | light hit/DoT/heavy hit/regrab severity và fall-technique edge? | Combat + Vitals + Traversal adversarial matrix | Validation → Approved |
| `FC-OQ-06` | first-person comfort và cue mix threshold? | Camera + Audio/UI + Accessibility playtest | Validation → Approved |

`DB-050` sở hữu closure. Feature giữ `DISCOVERY`: spec đã chỉ rõ contract/options/oracle nhưng chưa có pinned Minecraft 26.2 fixture capture, voxel-room prototype, parameter evidence, approver record hoặc human feel/comfort proof; vì vậy chưa `VALIDATION`, `APPROVED` hay `IMPLEMENTATION_READY`.
