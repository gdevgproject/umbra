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
- meter chỉ hiện khi Vigor vừa thay đổi, đang bị dùng, recovery bị trì hoãn hoặc action sắp thiếu;
- capacity/recovery/efficiency có progression cap; không upgrade nào tạo leo/bay vô hạn hoặc xóa mọi decision địa hình;
- exact Max, drain, regen, delay và cost thuộc `DB-049–052` + Parameter Registry.

## 3. State topology

```text
SUPPORTED
  → ATTACHING → CLIMBING ↔ CLIMB_IDLE
                    ├→ CLIMB_LEAP / WALL_EJECT → AIRBORNE
                    ├→ MANTLING → SUPPORTED
                    └→ FORCED_FALL → AIRBORNE

SUPPORTED → LIGHTNESS_LAUNCH → AIRBORNE_APEX
AIRBORNE/APEX → LIGHTNESS_DESCENT → LANDING | AIRBORNE
AIRBORNE/FALLING → GROUNDING_STRIKE → IMPACT_RECOVERY → SUPPORTED
```

- Mỗi actor ở tối đa một authoritative locomotion mode; animation substate không phải gameplay mode.
- `CREATIVE_FLIGHT`, `SPECTATOR`, `ELYTRA`, `SWIMMING`, `CRAWLING`, `RIDING`, `SLEEPING`, `PORTAL_TRANSIT`, knockback/grab và death là external modes có precedence explicit.
- Chuyển state có `transition_id`, source action, accepted tick, start pose/velocity, resource reservation và cancel reason.
- Không giữ `CLIMBING`, `GROUNDING_STRIKE` hay `LIGHTNESS_*` qua respawn/portal/reconnect như một animation đang chạy. Unlock/resource state persistent; runtime action được cleanup/rebound an toàn.
- Feature chuyển trực tiếp cho nhau chỉ qua edge được contract khai. Ví dụ Lightness chạm tường không tự bám nếu free-climb eligibility và input policy không chấp nhận.

## 4. Surface và ledge taxonomy

Mỗi face được resolve thành một profile data-driven:

| Profile | Ý nghĩa | Baseline direction |
|---|---|---|
| `VANILLA_CLIMB` | ladder, vine, scaffolding hoặc block có locomotion vanilla riêng | giữ vanilla behavior/value; không mặc định drain Vigor |
| `FREE_CLIMB` | face rắn đủ rộng, có collision và không bị deny | cho phép attach/move/mantle theo Vigor |
| `LIMITED_CLIMB` | partial/irregular/slippery/hazard cần modifier hoặc rule riêng | deny baseline hoặc giảm tốc/tăng drain sau evidence |
| `NO_CLIMB` | không có support hợp lệ, technical/invisible, moving/unsafe hoặc content deny rõ | không attach; cue/fallback không nói dối |
| `HAZARDOUS_CONTACT` | fire/hot/damaging surface | damage/source giữ nguyên; attach chỉ khi profile explicit |

Direction cho Minecraft voxel world:

- face đầy của solid block là candidate `FREE_CLIMB` mặc định; tag/shape/profile override có quyền deny;
- air, fluid, foliage không support, portal plane và collision quá nhỏ không trở thành handhold giả;
- slab/stair/fence/wall/door/trapdoor/chest/redstone/moving or temporary geometry cần fixture riêng, không suy từ block name;
- baseline không có ceiling/overhang crawl. Góc convex/concave chỉ chuyển khi probe thấy face kế tiếp liên tục và clearance hợp lệ;
- mantle cần top support, capsule clearance và valid landing footprint; không teleport qua trapdoor/ceiling/claim boundary;
- protected region không cần chặn leo chỉ để bảo vệ block vì traversal không sửa terrain. Activity muốn giới hạn đường đi phải dùng fiction/geometry/ruleset có cue, không dựa invisible wall tùy tiện.

Probe chỉ xét neighborhood cục bộ có cap, cache contact face và invalidation theo block/world event; cấm scan volume lớn mỗi frame/tick.

## 5. Authority, movement và collision

- Client gửi action/move intent và có thể predict presentation; logical server xác thực capability, mode, Vigor, face/ledge, collision, velocity và transition.
- Camera ray không quyết định attach. Server dùng actor volume + bounded face probe; client debug overlay có thể hiện cả predicted/authoritative candidate.
- Position/velocity cuối do movement owner commit. Animation/root motion không tự teleport, xóa fall damage hoặc gây AoE.
- Reconciliation ưu tiên giữ ý định và không rubber-band qua tường. Sai khác lớn abort về một safe pose có reason; không “sửa” bằng no-clip.
- Intent duplicate/out-of-order không double cost, double launch, double mantle hoặc double impact.
- Future co-op validate speed/acceleration/face/ground independently; client không được tự khai “đang bám” hoặc “đã gần đất”.

## 6. Fall và landing contract

Fall giữ `DamageSource`/height/velocity/context theo [`CTR-VITALS-HUD`](08-vitals-resource-and-hud-contract.md). Traversal có thể **chuyển đổi** hậu quả chỉ khi action được accept và tới commit marker:

- Free Climb detach/slip tạo fall bình thường với velocity/attribution hợp lệ.
- Lightness descent thay velocity theo action contract nhưng không xóa lava/void/contact hazard.
- Grounding Strike chỉ suppress/replace fall damage tại valid impact của đúng transaction; reject/interrupt trước commit dùng fall rule bình thường.
- Water, powder snow, slime/honey, bed, haystack và other landing modifiers vẫn qua Environmental Damage Matrix; không cộng hai lần hoặc mất attribution.
- Không technique traversal nào cứu `VOID`, admin kill hoặc scripted lethal mặc định.

## 7. Input/context invariants

- Stable actions dự kiến: `umbra.action.climb` và `umbra.action.lightness`; exact key/default layout thuộc `DB-002`.
- `Primary Attack` có thể được context-transform thành Grounding Strike chỉ khi eligibility/cue deterministic; người chơi luôn có alternative binding nếu context transform gây khó tiếp cận.
- Không dùng double-tap làm đường duy nhất. Auto-grab, auto-mantle, hold/toggle descent và input-window assistance là settings tách.
- Mining/building/use khi attached bị khóa baseline và có feedback; detach về state hợp lệ trước interaction. Ladder/scaffolding giữ vanilla interaction path.
- Mở menu/chat, mất focus, pause, death, portal hoặc mode switch phải release held traversal state để tránh “phím ma”.

## 8. HUD, save và progression

- Vigor là meter contextual fixed-width, khác icon/pattern với Focus và Hunger; threshold cue có visual + optional audio/haptic.
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
- Counters: probes/tick, shape tests, correction distance/rate, allocation, stuck/abort, transition count và Vigor spend/refund.
- Degradation chỉ giảm cosmetic IK/dust/trails; không giảm collision probe, resource truth, landing cue hoặc damage commit.

## 11. Open decisions

- `DB-049`: state topology, Vigor band/recovery, surface taxonomy, unlock delivery và world rule.
- `DB-050`: exact free-climb input, speed, ledge/corner/leap/collision và animation grammar.
- `DB-051`: Grounding Strike eligibility window, Vigor/overdraw, weapon adapters, fall conversion và AoE.
- `DB-052`: Lightness launch arc, apex/descent control, steering, Vigor drain, combat interaction và progression.

