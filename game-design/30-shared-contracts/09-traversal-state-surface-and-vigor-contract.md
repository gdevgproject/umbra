# CTR-TRAVERSAL — Trạng thái di chuyển, bề mặt và Khí Lực

> **Owner:** Player Traversal + Gameplay Technical Design
> **Approver:** Game Director + Lead Game Designer + Technical Director
> **Reviewers:** Camera, Input, Animation, Combat, World, Progression, Platform, Accessibility, QA, Performance
> **Status:** `PROPOSED`

## 1. Player outcome và quyền sở hữu

Người chơi chinh phục chiều dọc của Minecraft bằng cùng một ngôn ngữ điều khiển có thể học: bám đúng bề mặt, biết còn đủ sức đi tới đâu, hiểu vì sao bị tuột/rơi và chuyển giữa leo–rơi–khinh công–đáp đất mà không xuyên block hoặc bị camera đổi ý định.

Contract này sở hữu luật dùng chung của [`FEAT-TRAVERSAL-FREE-CLIMB`](../20-domains/01-player/traversal/01-free-climbing.md), [`FEAT-AERIAL-GROUNDING-STRIKE`](../20-domains/01-player/traversal/02-aerial-grounding-strike.md) và [`FEAT-TRAVERSAL-LIGHTNESS`](../20-domains/01-player/traversal/03-lightness-art.md):

- topology trạng thái traversal và precedence với Minecraft movement modes;
- resource Khí Lực (`Vigor`) và giao dịch cost;
- phân loại bề mặt/face, collision probe và ledge candidate;
- contact/world revision, external geometry/fluid influence và commit revalidation;
- authority, save/reconnect, Creative/Adventure, future co-op và proof chung.

Feature Cell sở hữu feel/action riêng. Camera, animation, progression, damage và UI chỉ dẫn tới contract này, không tạo state/rule song song.

## 2. Bốn resource không được nhập làm một

| Resource | Horizon | Tiêu bởi | Không tiêu bởi |
|---|---|---|---|
| `Focus` | combat ngắn | Dodge, parry, defensive burst | leo/khinh công/đi/chạy cơ bản |
| `Vigor` / Khí Lực | traversal ngắn | free climb, climb leap, Lightness launch/descent, technique traversal được khai | Dodge/parry, đi/chạy/jump vanilla, ladder/scaffolding baseline |
| `Fatigue` | chuyến đi dài | tích lũy theo activity rule | drain từng tick leo hoặc bay |
| Hunger | survival Minecraft | hoạt động/food rules Minecraft | thay trực tiếp cost của một action traversal |

Không dùng chung Focus–Vigor chỉ vì reference game gọi cả hai là stamina. Tách pool tránh việc combat vừa kết thúc khóa khám phá hoặc một lần leo dài làm người chơi không thể né ngay khi bị phục kích.

### Vigor semantics

- server-authoritative, bounded và hồi nhanh khi actor có support ổn định; không hồi trong active free climb/Lightness descent;
- cost dùng reserve/commit/refund transaction ID theo [`CTR-RESOURCE-MODIFIER`](02-resource-and-modifier-contract.md);
- cost traversal dùng ba thành phần có thể trace độc lập: **thời gian giữ trạng thái có tải**, **effort từ displacement do actor chủ động và thực sự được collision solver chấp nhận**, và **action cost đã commit**. Không tính cost từ raw input bị chặn, route assist, correction của authority hoặc displacement do knockback/current/piston;
- mỗi action có cost riêng thay cho drain của cùng khoảng commit, không cộng cả action cost lẫn tick drain cho một effort. Modifier bề mặt/môi trường phải deterministic, có cap và không được nhân chồng thành ba hình phạt cho cùng một nguyên nhân;
- attach Free Climb baseline không thu entry fee, nhưng có `minimum_reserve_guard` và một settle grace giới hạn một lần mỗi attach episode để tránh vừa bám đã tụt mà không mở vòng lặp zero-Vigor regrab;
- hướng effort giữ quan hệ `up > lateral > down ≥ 0`; idle cling có base drain thấp đủ cho một lần đọc camera/route, không đủ để AFK giữa tường. Exact curve phải được chứng minh bằng route simulation thay vì chỉ đếm số block;
- recovery chỉ bắt đầu sau stable-support dwell trên footprint hợp lệ hoặc profile explicit `RECOVERY_SUPPORT`; một frame quệt ledge, contact giả, ladder transition spam hoặc reconnect không được refill. Ladder/vine/scaffolding không drain Vigor nhưng cũng chỉ hồi khi support profile/dwell cho phép;
- meter chỉ hiện khi Vigor vừa thay đổi, đang bị dùng, recovery bị trì hoãn hoặc action sắp thiếu;
- capacity/recovery/efficiency có progression cap; không upgrade nào tạo leo/bay vô hạn hoặc xóa mọi decision địa hình;
- exact Max, drain, regen, delay và cost thuộc `DB-049–052` + Parameter Registry.

## 3. State topology

```text
SUPPORTED
  → ATTACHING → CLIMBING ↔ CLIMB_IDLE
                    ├→ CLIMB_LEAP / WALL_EJECT → AIRBORNE
                    ├→ MANTLE_SELECT → MANTLING → SUPPORTED
                    ├→ REGRAB_CHECK → CLIMBING | AIRBORNE
                    └→ FORCED_RELEASE → AIRBORNE | EXTERNAL_MODE

SUPPORTED → LIGHTNESS_LAUNCH → AIRBORNE_APEX
AIRBORNE/APEX → LIGHTNESS_DESCENT → LANDING | AIRBORNE
AIRBORNE/FALLING → GROUNDING_STRIKE → IMPACT_RECOVERY → SUPPORTED
```

- Mỗi actor ở tối đa một authoritative locomotion mode; animation substate không phải gameplay mode.
- `CREATIVE_FLIGHT`, `SPECTATOR`, `ELYTRA`, `SWIMMING`, `CRAWLING`, `RIDING`, `SLEEPING`, `PORTAL_TRANSIT`, knockback/grab và death là external modes có precedence explicit.
- Chuyển state có `transition_id`, source action, accepted tick, start pose/velocity, resource reservation và cancel reason.
- Airborne/attach transition giữ `IntentLineage` và `AirborneProvenance`: explicit Jump, auto-jump, walk-off, traversal launch, external hit/force và mode transition không được nhập thành cùng một “đang rơi”. Một input edge có tối đa một gameplay consumer.
- Không giữ `CLIMBING`, `GROUNDING_STRIKE` hay `LIGHTNESS_*` qua respawn/portal/reconnect như một animation đang chạy. Unlock/resource state persistent; runtime action được cleanup/rebound an toàn.
- Feature chuyển trực tiếp cho nhau chỉ qua edge được contract khai. Ví dụ Lightness chạm tường không tự bám nếu free-climb eligibility và input policy không chấp nhận.
- Buffered input, coyote/contact-loss grace hoặc presentation blend không phải gameplay mode và không được giữ actor ngoài authoritative locomotion mode.

## 4. Surface và ledge taxonomy

Mỗi face được resolve thành một profile data-driven:

| Profile | Ý nghĩa | Baseline direction |
|---|---|---|
| `VANILLA_CLIMB` | ladder, vine, scaffolding hoặc block có locomotion vanilla riêng | giữ vanilla behavior/value; không mặc định drain Vigor |
| `FREE_CLIMB` | contact patch đủ rộng/liên tục, có collision/support và không bị deny | cho phép attach/move/mantle theo Vigor |
| `LIMITED_CLIMB` | partial/narrow/unstable/slippery/hazard cần modifier hoặc semantic riêng | deny baseline hoặc đổi tốc/drain/pose sau evidence; không random slip |
| `NO_CLIMB` | không có support hợp lệ, technical/invisible, moving/unsafe hoặc content deny rõ | không attach; cue/fallback không nói dối |
| `HAZARDOUS_CONTACT` | fire/hot/damaging surface | damage/source giữ nguyên; attach chỉ khi profile explicit |

Direction cho Minecraft voxel world:

- face đầy của collision shape là candidate `FREE_CLIMB` mặc định; transparency/opacity không quyết support, còn tag/profile có quyền đổi nghĩa;
- air, fluid-only, foliage không support, portal plane và collision quá nhỏ không trở thành handhold giả; foliage có collision phải qua unstable profile thay vì bị coi mặc định là air;
- slab/stair/fence/wall/door/trapdoor/chest/redstone/moving or temporary geometry cần fixture riêng, không suy từ block name;
- iron bars/lattice/chain/thin column không tự kế thừa broad wall-cling chỉ vì có collision; profile narrow/dedicated-grip phải explicit;
- baseline không có ceiling/overhang crawl. Góc convex/concave chỉ chuyển khi probe thấy face kế tiếp liên tục và clearance hợp lệ;
- mantle cần top support, capsule clearance và valid landing footprint; không teleport qua trapdoor/ceiling/claim boundary;
- waterlogged/flowing-fluid context resolve collision shape và fluid state đồng thời; fluid-only không support. Moving-piston/dynamic geometry bị deny baseline và invalidates contact nếu bắt đầu chuyển;
- outline/culling/render shape không là support truth. Context-sensitive collision như scaffolding/powder snow phải được hỏi bằng actor/collision context đúng; vanilla locomotion/hazard owner thắng khi profile tương ứng;
- protected region không cần chặn leo chỉ để bảo vệ block vì traversal không sửa terrain. Activity muốn giới hạn đường đi phải dùng fiction/geometry/ruleset có cue, không dựa invisible wall tùy tiện.

Probe chỉ xét neighborhood cục bộ có cap, decomposition theo connected collision/support shape với actor context thay vì outline/AABB/block cube giả, cache contact và invalidation theo block/fluid/world/profile-reload event; cấm scan volume lớn mỗi frame/tick. Contact/candidate mang `WorldRevision` đủ để revalidate các shape/fluid/entity blockers/profile liên quan tại latch/mantle/landing commit.

### Partial, thin, transparent và foliage shape

- Full broad face, gồm glass có collision đầy, dùng `FREE_CLIMB` mặc định: trong suốt không đồng nghĩa rỗng và “trơn theo hiện thực” không được âm thầm deny nếu game không cue.
- Slab/stair/partial block tạo patch từ mặt biên thật của từng connected collision shape, không từ full-cube/AABB tưởng tượng. Attach và landing footprint có threshold riêng.
- Stair có thể tạo nhiều lip; consumer scoring phải dùng hướng + clean sweep + hysteresis. Hai partial shape chỉ nối corridor khi seam tolerance và capsule sweep thật cho phép.
- Fence/wall/iron bars/lattice cần profile narrow/dedicated-grip explicit; chain/cột rất hẹp là `NO_CLIMB` Free Climb baseline vì rope/pole climb là capability khác.
- Leaves/foliage có collision là unstable-profile candidate với speed/drain/cue deterministic; không random slip. Foliage không collision vẫn `NO_CLIMB`.
- Ice/honey/custom slick hoặc cactus/magma/fire/hot dùng profile/modifier/hazard explicit; material không thay collision truth và hazard attribution không mất.
- Door/trapdoor/fence connection/waterlogging đổi shape/state thì đổi revision; cache cũ không được tiếp tục support.

### Dynamic geometry và fluid overlay

- Moving-piston/falling-block entity/extending block-entity shape hoặc temporary dynamic collision là `NO_CLIMB` baseline. Contact tĩnh bắt đầu chuyển bị invalidated; world collision owner resolve safe separation rồi traversal forced release, giữ velocity/source và không cấp crush/no-clip immunity.
- Khi dynamic block ổn định cần stable-revision dwell + fresh/held-intent policy mới attach lại; stale candidate/packet không auto-latch. Moving vehicle surface vẫn non-goal.
- Waterlogged context resolve cả collision shape lẫn fluid state. Flowing water/lava có height/velocity/state/revision riêng; current là external influence/hazard, không là camera-relative input.
- Actor ngập một phần có thể giữ solid contact nếu external-mode guard chưa chuyển swimming; mọi flow modifier phải deterministic, capped và có cue. Khi swim/lava mode threshold đạt, external mode thắng; `SWIMMING → MANTLE` cần edge explicit.
- Lava/fire/hot giữ Environmental Damage Matrix. Baseline không áp global rain penalty; weather modifier chỉ được mở lại bằng route-agency/cue/avoidance evidence, không buộc player chờ thời tiết.

## 5. Authority, movement và collision

- Client gửi action/move intent có sequence/timestamp/context và có thể predict trong envelope; logical server xác thực capability, mode, Vigor, contact/ledge revision, collision, velocity và transition.
- Camera ray không quyết định attach. Server dùng actor volume + bounded face probe; client debug overlay có thể hiện cả predicted/authoritative candidate.
- Position/velocity cuối do movement owner commit. Animation/root motion không tự teleport, xóa fall damage hoặc gây AoE.
- Reconciliation phân micro/moderate/topology mismatch, ưu tiên giữ ý định và không rubber-band qua tường. Sai khác lớn hoặc stale revision abort về safe contact/pose/fall có reason; không “sửa” bằng no-clip hay smoothing vô hạn.
- Intent duplicate/out-of-order không double cost, double launch, double mantle hoặc double impact.
- Future co-op validate speed/acceleration/face/ground independently; client không được tự khai “đang bám” hoặc “đã gần đất”.
- World/block/fluid/entity mutation không bị khóa bởi traversal. Commit luôn đọc authoritative state hiện tại; candidate/reservation client cũ không thắng block được đặt, piston, hit hoặc external mode cùng tick.

### Authoritative tick ordering

Foundation được quyền map sang engine phases nhưng không đảo nghĩa logic sau:

1. nhận/dedupe intent theo sequence;
2. áp world/block/fluid/entity mutations đã tới thứ tự tick;
3. resolve death/portal/Creative/Spectator/swim/riding/grab và forced locomotion/combat state;
4. resolve damage/knockback/status và resource transaction;
5. revalidate contact/landing/mantle bằng `WorldRevision` hiện tại;
6. consume legal buffered intent, solve movement/collision và commit transition;
7. publish authoritative result, correction và presentation semantic.

Cùng-tick conflict không dùng render frame/packet arrival đơn lẻ để quyết outcome. Trace giữ mọi intent/event tham gia, accepted tick, winner/loser reason và causality ID. Feature có thể thêm precedence nội bộ nhưng không được cho client candidate khóa world hoặc làm hit/resource commit hai lần.

## 6. Fall và landing contract

Fall giữ `DamageSource`/height/velocity/context theo [`CTR-VITALS-HUD`](08-vitals-resource-and-hud-contract.md). Traversal có thể **chuyển đổi** hậu quả chỉ khi action được accept và tới commit marker:

- Free Climb detach/slip tạo fall bình thường với velocity/attribution hợp lệ.
- Lightness descent thay velocity theo action contract nhưng không xóa lava/void/contact hazard.
- Grounding Strike chỉ suppress/replace fall damage tại valid impact của đúng transaction; reject/interrupt trước commit dùng fall rule bình thường.
- Water, powder snow, slime/honey, bed, haystack và other landing modifiers vẫn qua Environmental Damage Matrix; không cộng hai lần hoặc mất attribution.
- Không technique traversal nào cứu `VOID`, admin kill hoặc scripted lethal mặc định.

## 7. Input/context invariants

- Stable semantic actions dự kiến gồm `umbra.action.climb` và `umbra.action.lightness`, nhưng semantic không bắt buộc có physical key riêng; exact layout thuộc `DB-002`. Default Free Climb direction dùng contextual `Jump/Traverse Up` và `Sneak/Traverse Down`; optional precision Climb vẫn remap được.
- Đi/chạy/sprint chỉ va tường không sinh `ClimbIntent`. Explicit player Jump lineage + approach alignment + valid face có thể attach tự nhiên; Jump press khi airborne là grab request, không double-jump. Auto-jump, passive walk-off/fall và external launch/knockback không tự attach.
- Use/Place/Destroy đang held/committed, pre-held Sneak, grazing/away input, hard action hoặc external mode là attach inhibitor. Hit/force đủ lớn invalidates inferred lineage; fresh Jump sau control-lock mới rearm. Camera ray/contact/velocity một mình không chứng minh intent.
- Jump/Traverse Up tại obstacle trong grounded mantle band có thể chọn `STEP_UP/LOW_MANTLE`; vanilla step-up/auto-jump không tự mở Free Climb trên tường cao. Khi actor đã attached và tiếp tục giữ hướng lên, auto-mantle mặc định bật; neutral/down/drop không được tự mantle.
- Khi attached, fresh Jump chọn targeted leap từ surface-relative direction: neutral/Up lên, Left/Right/diagonal dyno, Down wall-eject. Invalid target không fallback sang hướng khác hoặc charge; action reserve cost + post-contact minimum, còn duplicate/held Jump không repeat.
- Baseline accessibility là **Jump-to-traverse, bám liên tục, fresh Sneak-to-drop** để không bắt thêm default Climb key hoặc prolonged hold. Sneak pre-held suppress attach; chỉ fresh edge sau latch Drop, mantle pre/post-commit xử lý cancel/sneak-on-landing rõ. Hold-to-cling, assisted-air-grab và auto-mantle là setting tách; external force không được suy ra auto-save kể cả khi assist bật.
- `Primary Attack` có thể được context-transform thành Grounding Strike chỉ khi eligibility/cue deterministic; người chơi luôn có alternative binding nếu context transform gây khó tiếp cận.
- Không dùng double-tap làm đường duy nhất. Auto-grab, auto-mantle, hold/toggle descent và input-window assistance là settings tách.
- Movement intent có representation 2D liên tục; keyboard số hóa vector còn analog future giữ góc/magnitude sau dead-zone. Gameplay không hard-code WASD/tám hướng hoặc yêu cầu controller hiện tại.
- Buffer lưu Action Intent edge + sequence/expiry, consume đúng một lần ở authoritative tick đầu tiên legal và hủy bằng reason khi context đổi; không buffer raw key, packet repeat hoặc animation frame.
- Mining/building/use khi attached bị khóa baseline và có feedback; không auto-detach rồi tương tác. Trước attach, build/pillar intent thắng inferred grab. Ladder/scaffolding, swimming và riding giữ vanilla input owner; Sneak là dismount/swim-descend thay vì climb Drop ở mode đó.
- Mở menu/chat, mất focus, pause, death, portal hoặc mode switch phải release held traversal state để tránh “phím ma”.

## 8. HUD, save và progression

- Vigor xuất semantic state `HIDDEN / PREVIEW / ACTIVE / RESERVED / LOW / CRITICAL / RECOVERY_DELAY / RECOVERING / FULL_FADE`. `PREVIEW` chỉ xuất khi Jump/grab lineage + approach + candidate vượt confidence threshold; chỉ va tường hoặc Jump giữa đồng trống không làm HUD bật. Khi attached, `ACTIVE` luôn hiện kể cả đang đầy; full chỉ fade sau grace.
- Snapshot gồm current/max, reserved amount, next-action projected cost/insufficient reason, drain/recovery state và threshold band có hysteresis. Client không tự tính quãng/giây còn lại hoặc final cost; debug/numeric là option, không là mặc định.
- Vigor là meter contextual fixed-width, khác icon/pattern với Focus và Hunger; low/critical/exhausted dùng pattern/cadence khác nhau qua visual + audio/body cue. Haptic chỉ là kênh cộng thêm, tắt được và không bao giờ là kênh duy nhất.
- Unlock của ba capability là persistent versioned state. Current Vigor/cooldown được save đủ để quit/reconnect không refill exploit; offline time không tự hồi trừ khi recovery contract cho phép.
- Runtime contact/animation/transition là ephemeral. Reconnect giữa tường/không trung dùng safe rebind/fall policy, không phục hồi nửa animation.
- Creative flight có precedence; debug có thể force unlock/refill/show probes. Survival/Adventure/Hardcore dùng cùng traversal truth nhưng death/consequence theo mode contract.
- Core traversal unlock không nằm trong Potential. Level có thể là eligibility; một early training/milestone grant là delivery. Migration/admin grant không được buộc replay quest để save cũ hoạt động.

## 9. World, encounter và companion seams

- Ladders, vines, scaffolding, water elevator, bridge và player construction vẫn có giá trị: không tốn Vigor, tạo route an toàn, vận chuyển companion/mob/item hoặc hoạt động trước unlock.
- Gate/quest/structure sau unlock không dùng “tường cao” như hard lock duy nhất. Boundary thật cần rule/cue; shortcut/sequence break được đánh giá có chủ đích.
- Enemy không đọc input để bắn người leo. Dossier khai `can_pursue_vertical`, ranged pressure, leash và unreachable-target response để tránh cheese.
- Active Shadow không được mất/nhân bản khi player leo/khinh công. Trước animation traversal riêng, follower policy dùng path/hold/recall/off-screen rejoin có cue và cấm teleport đang combat/visible qua geometry.
- Mount/Elytra/aquatic traversal là external capability; không reuse Vigor/state mù.

## 10. Performance và observability

- Runtime risk tối thiểu `PR-2`: movement/collision/camera/animation hot path. Slice traversal hoàn chỉnh hoặc companion/future multi-client lên `PR-3`.
- Trace bắt buộc: raw input, capability, mode, face/ledge ID, Vigor transaction, predicted/authoritative pose, velocity, transition/cancel reason, fall conversion và hit ID.
- Trace bổ sung intent buffer lifecycle/sequence, collision component/profile/fluid/dynamic flag, `WorldRevision`, mantle semantic/candidate score/warp envelope và correction class.
- Counters: probes/tick, shape tests/cache/invalidation, correction distance/angle/rate, allocation, stuck/abort, transition count và Vigor spend/refund.
- Degradation chỉ giảm cosmetic IK/dust/trails; không giảm collision probe, resource truth, landing cue hoặc damage commit.

## 11. Open decisions

- `DB-049`: state topology, Vigor band/recovery, surface taxonomy, unlock delivery và world rule.
- `DB-050`: exact free-climb input, speed, ledge/corner/leap/collision và animation grammar.
- `DB-051`: Grounding Strike eligibility window, Vigor/overdraw, weapon adapters, fall conversion và AoE.
- `DB-052`: Lightness launch arc, apex/descent control, steering, Vigor drain, combat interaction và progression.
