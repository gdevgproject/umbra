# SYS-PLAYER-TRAVERSAL — Scenario Matrix

> **Owner:** Traversal QA + Player Controls
> **Status:** `DISCOVERY`
> **Mục đích:** inventory quyết định/oracle; chưa phải expected result cuối cho parameter mở.

## 1. Free Climb — input và surface

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-001` | từ đất đi vào full stone face rồi Jump/precision Climb | hop-attach/precision guard, one consumer, cue/pose |
| `TRV-S-002` | chạm tường khi mining/placing mà không Climb | không auto-cướp input |
| `TRV-S-003` | airborne toward wall; Jump lineage/request/assisted-air-grab | provenance + inhibitor + setting + authority parity |
| `TRV-S-004` | W/S/A/D/diagonal, camera xoay 360° | surface-relative basis, normalize |
| `TRV-S-005` | key repeat/duplicate packet tại attach/leap | một transition/cost |
| `TRV-S-006` | drop/eject/away+jump | consequence và direction predictable |
| `TRV-S-007` | full block dirt/stone/wood/ore/glass/ice | default/tag/profile matrix |
| `TRV-S-008` | slab/stair/fence/wall/door/trapdoor/chest | shape/clearance, không ID heuristic |
| `TRV-S-009` | foliage không collision/fluid-only/fire/lava/cactus/magma | no support/hazard attribution; foliage có collision đi unstable-profile fixture |
| `TRV-S-010` | ladder/vine/scaffolding/water elevator | vanilla owner/value, transition |
| `TRV-S-011` | convex/concave corner | continuous face/clearance/no snap |
| `TRV-S-012` | overhang/ceiling/one-block tunnel | deny baseline/no clip |
| `TRV-S-013` | piston/door/block remove giữa attach | invalidation → safe fall/transition |
| `TRV-S-014` | chunk/world border/claim/activity boundary | no stale face/teleport |
| `TRV-S-015` | top/bottom/double slab; stair mọi facing/half/shape | connected shape patch/seam/sweep, không full-cube giả |
| `TRV-S-016` | glass đầy, leaves, ice/honey | transparency ≠ support; deterministic profile/cue, no random slip |
| `TRV-S-017` | iron bars/fence/wall/lattice/chain | narrow profile explicit; body không treo ngoài contact |
| `TRV-S-018` | waterlogged stair/slab, waterfall qua face, flowing water đổi hướng | collision + fluid revision; external-mode/flow composition |
| `TRV-S-019` | lava flow cạnh/qua contact, immersion threshold | no fluid support; hazard attribution và swim/lava precedence |

## 2. Free Climb — ledge, resource và interruption

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-020` | clear top lip + move up | mantle start/commit/recovery |
| `TRV-S-021` | trapdoor/low ceiling/entity chặn top | reject/return cling/fall |
| `TRV-S-022` | ledge mất giữa mantle | no teleport/duplicate pose |
| `TRV-S-023` | Vigor vừa đủ/cạn trong move/idle/leap | drain, low cue, slip |
| `TRV-S-024` | near-zero Vigor tại valid lip | grace candidate không refill |
| `TRV-S-025` | capacity/equipment/status đổi khi attached | current clamp/no free Vigor |
| `TRV-S-026` | light/heavy/grab/DoT hit | severity/detach/source retention |
| `TRV-S-027` | logout/reconnect để refill | current Vigor preserved/no exploit |
| `TRV-S-028` | death/respawn/portal/dimension mid-climb | cleanup/no ghost contact |
| `TRV-S-029` | first↔third camera mid attach/mantle | same rule, comfort/presentation |
| `TRV-S-030` | Shadow active khi player climbs/mantles | hold/path/rejoin, no loss/clone |
| `TRV-S-031` | supported low lip / chest lip / high pull / outward crest | stable adaptive mantle semantic + correct timing/cost |
| `TRV-S-032` | mantle measurement dao động gần threshold | hysteresis; không flip clip/state mỗi tick |
| `TRV-S-033` | Jump ở cuối attach/climb/mantle recovery | buffer consume once ở tick đầu legal; expiry/reason visible |
| `TRV-S-034` | held axis + key repeat + buffered Jump/Climb | axis không nhân press; sequence idempotent |
| `TRV-S-035` | diagonal toward ledge/corner/gap/hazard | bounded scoring; no hidden route/gap/hazard capture |
| `TRV-S-036` | input đảo hướng trong assist/hysteresis lock | assist release predictable, không đánh nhau với player |
| `TRV-S-037` | block đặt/phá hoặc piston bắt đầu chuyển tại mantle start/commit | current revision wins; return cling/fall, no lock/teleport |
| `TRV-S-038` | light/heavy/DoT/knockback cùng tick Jump hoặc mantle commit | stable event precedence, one hit/cost/cancel reason |
| `TRV-S-039` | contact loss/regrab cùng face lặp | bounded grace/cost/no refill/no net vertical exploit |

## 3. Grounding Strike

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-040` | attack before/inside/after time-to-impact band | buffer/accept/reject boundary |
| `TRV-S-041` | low/medium/extreme fall speed | eligibility/window/safety |
| `TRV-S-042` | no ground/void/ledge-only candidate | deny; no platform/teleport |
| `TRV-S-043` | flat/slope/slab/stair/low ceiling landing | sweep/footprint/clearance |
| `TRV-S-044` | water/slime/hay/powder snow/bed | damage/bounce composition once |
| `TRV-S-045` | lava/fire/cactus/magma landing | fall conversion only; hazard remains |
| `TRV-S-046` | slip from climb with low/zero Vigor | last-chance policy/cue |
| `TRV-S-047` | enemy knockback/grab/launch | controllability guard/source |
| `TRV-S-048` | key/packet spam | one cost/impact/AoE/hit ID |
| `TRV-S-049` | target group/ally/item/armor stand | hit eligibility/cap/friendly rules |
| `TRV-S-050` | sword/heavy/polearm/ranged-held/unarmed/missing clip | adapter/fallback, same safety |
| `TRV-S-051` | block/crop/redstone/container tại impact | no grief/unintended activation |
| `TRV-S-052` | death/portal/reload before/after commit | reservation/fall immunity cleanup |
| `TRV-S-053` | low/high FPS, TPS pressure, latency | server outcome + prediction tolerance |

## 4. Lightness

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-060` | ground neutral charge rồi đưa neutral/W/S/A/D/diagonal trước commit; wall charge rồi tangent/away aim | ground camera-relative hoặc wall surface-relative snapshot/envelope, outward clearance |
| `TRV-S-061` | slope, ledge, partial support, moving surface | stable support/reset guard |
| `TRV-S-062` | low ceiling/wall at windup/ascending | shorten/reject/collision |
| `TRV-S-063` | rotate camera after commit | trajectory not instantly bent |
| `TRV-S-064` | activate descent before/at/after apex | allowed window/cue |
| `TRV-S-065` | hold/toggle/release/re-enter descent | semantics/cost/no stutter exploit |
| `TRV-S-066` | steer 360°/diagonal/rapid reversal | acceleration/turn cap |
| `TRV-S-067` | Vigor reaches zero midair | cue → fall, no hover |
| `TRV-S-068` | repeated Lightness press/touch wall/edge | no multi-launch/fake ground reset |
| `TRV-S-069` | descent → Grounding Strike | cancel/cost/fall conversion once |
| `TRV-S-070` | descent → Free Climb face | explicit input/face/Vigor guard |
| `TRV-S-071` | wind/slow-fall/levitation/knockback/status | modifier composition/caps |
| `TRV-S-072` | melee/ranged/quick recovery/Shadow command | precedence/cancel/readability |
| `TRV-S-073` | Elytra/Creative/Spectator/swim/mount/portal | external mode precedence |
| `TRV-S-074` | logout/reconnect/death/dimension mid-flight | no refill/ghost flight |

## 5. World, progression và modes

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-080` | new save trước/sau early unlock | capability prompt/grant/no hard lock |
| `TRV-S-081` | old save vượt level nhưng chưa quest | migration/pending training/grant |
| `TRV-S-082` | Creative grant/refill/probe → Survival | provenance + valid state/no taint |
| `TRV-S-083` | Adventure/Hardcore/death consequence | mode composition, no illegal respawn |
| `TRV-S-084` | structure/Gate boundary chỉ là tường cao | sequence-break audit, explicit rule/cue |
| `TRV-S-085` | ladder/scaffold route cạnh Free Climb | preparation utility/choice proof |
| `TRV-S-086` | enemy melee-only dưới player | leash/pursuit/ranged/unreachable response |
| `TRV-S-087` | player + 4 Shadow qua vertical route | follower stability/readability/perf |

## 6. Accessibility, localization và performance

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-090` | assisted-air-grab/auto-mantle/precision/hold-toggle/window assist | setting không đổi hidden truth/inhibitor |
| `TRV-S-091` | `vi_vn/en_us`, long labels, GUI scale | meter/prompt/overflow |
| `TRV-S-092` | colorblind/reduced motion/no shake/no haptic | cue redundancy/comfort |
| `TRV-S-093` | input conflict/non-US/one-handed/controller harness | remap/precedence/alternative |
| `TRV-S-094` | repeated wall route 10k transitions | leak/live-set/state cleanup |
| `TRV-S-095` | dense voxel wall + fast camera + particles | probe/frame/allocation budget |
| `TRV-S-096` | dedicated one client + latency/packet adversary | authority/anti-flight parity |
| `TRV-S-097` | keyboard vector vs analog harness cùng góc; dead-zone/noise | same intent cone/outcome trong device tolerance |
| `TRV-S-098` | micro/moderate/topology correction ở low/high FPS/TPS | blend budget/no camera shake/no smoothing through wall |
| `TRV-S-099` | low/critical/exhausted + haptic/audio/reduced-motion off | cue state phân biệt bằng kênh còn lại, không color-only |

## 7. Data, custom shape và runtime reload

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-100` | surface tag/profile/resource reload khi attached hoặc mantling | revision invalidation/rebind/fall safe; không stale profile/crash |
| `TRV-S-101` | mod block có custom/context-sensitive collision khác outline | actor-context collision/support truth, không full-cube/visual heuristic |
| `TRV-S-102` | falling block hoặc extending block-entity shape chạm/rời actor | dynamic deny + world collision resolution + attributed forced release |

## 8. Free Climb entry, Vigor và HUD closure

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-103` | đi/chạy/sprint thẳng vào tường climbable, không Jump/grab lineage | collision/slide/stop như movement owner; không attach, không prompt/HUD spam |
| `TRV-S-104` | đứng/di chuyển sát tall face rồi Jump; optional precision Climb | Jump chọn `HOP_ATTACH` một consumer; precision action latch không hop; không cần default key riêng |
| `TRV-S-105` | explicit jump arc, passive walk-off/fall, airborne Jump request và assisted-air-grab cùng chạm face | jump arc/request attach; passive fall không; assist chỉ nới press và giữ inhibitor |
| `TRV-S-106` | Jump/Traverse Up vào step, low mantle band và tường cao; vanilla auto-jump on/off | step/low mantle có chủ đích; tường cao không auto climb; auto-jump không mở rộng band |
| `TRV-S-107` | crouch/sneak gần edge/wall rồi Climb/Jump | giữ edge-safety, suppress inferred entry; explicit action có precedence/cue rõ |
| `TRV-S-108` | knockback/explosion/flow đẩy actor vào wall khi `ASSISTED_AIR_GRAB` bật | không attach vì external force; attribution/velocity còn nguyên |
| `TRV-S-109` | lưng quay vào tường, hai mặt gần bằng điểm hoặc camera đảo nhanh | direction/view cone + hysteresis; không snap 180°/đổi mặt liên tục |
| `TRV-S-110` | mine/place/use/attack/dodge đang commit khi chạm/press Climb | không silent-cancel; precedence, denial hoặc buffered transition có reason |
| `TRV-S-111` | cùng route đi lên/ngang/xuống/idle và leap/mantle | cost topology trace được; `up > lateral > down ≥ 0`; action cost không double với tick drain |
| `TRV-S-112` | giữ hướng vào geometry bị chặn, assist kéo nhẹ, server correction hoặc hit/current displacement | chỉ base cling drain khi vẫn attached; không tính actor-effort từ raw input/assist/correction/external motion |
| `TRV-S-113` | nhìn/va tường, explicit preview, attached đầy Vigor, reserve leap, low/critical, recovery/full | đúng lifecycle `HIDDEN→PREVIEW→ACTIVE/RESERVED→…→FULL_FADE`; không flicker ở threshold |
| `TRV-S-114` | Vigor thiếu cho leap/mantle, candidate mất trước/sau reserve/commit | next-cost ghost + insufficient reason; reserve/refund/commit đúng một lần |
| `TRV-S-115` | đứng vững trên lip, quệt lip một tick, nhảy regrab cùng face | chỉ stable footprint + dwell mở recovery; không refill bằng graze/regrab loop |
| `TRV-S-116` | ladder/vine/scaffolding chuyển qua lại với Free Climb | vanilla không drain; chỉ profile `RECOVERY_SUPPORT` + dwell hồi, không instant refill |
| `TRV-S-117` | pause thật, menu không pause server, chat/focus loss | logical pause dừng clock nhất quán; non-pausing UI không hồi miễn phí và held state được release |
| `TRV-S-118` | Vigor zero rồi spam attach/regrab/drop | minimum reserve guard + settle grace một lần/episode; không net height/refill exploit |
| `TRV-S-119` | persistent latch, hold-to-cling, precision Climb và assisted-air-grab profiles với input fatigue/remap | cùng authoritative truth/outcome; Sneak Drop/release/debounce rõ, không bắt prolonged hold/default key mới |
| `TRV-S-120` | vanilla auto-jump on/off vượt step rồi chạm tall wall | auto-jump không tạo Jump lineage/Free Climb attach; explicit Jump vẫn nhất quán |
| `TRV-S-121` | pillar-jump hoặc bridge-jump: Jump + Use/Place held/commit cạnh wall | build intent thắng, lineage bị cancel; không attach sau placement nếu không có Jump edge mới |
| `TRV-S-122` | sprint-jump trực diện, jump lướt song song/grazing và đổi hướng away trước contact | chỉ approach trong cone attach; grazing slide/fall, away cancel, không sticky wall |
| `TRV-S-123` | một Space edge trong grounded wall reach, packet duplicate và Space held | đúng một `HOP_ATTACH` hoặc Jump semantic; không vanilla jump + attach kép, không repeat leap |
| `TRV-S-124` | attached Jump neutral tap/hold, Up/Left/Right/diagonal/Down | tap/leap hoặc eligible wall charge đúng selector; directional `LEAP_UP/DYNO/WALL_EJECT` tức thời, diagonal normalize |
| `TRV-S-125` | directional leap không có patch, patch hazard/deny hoặc ngoài envelope | không fallback Up/face khác, không cost; actor còn cling + reason/cue nhỏ |
| `TRV-S-126` | upward leap có clean lip và đủ/thiếu composite mantle cost | target `LEAP_TO_MANTLE` reserve tổng; thiếu thì reject, không bắt đầu cú chắc chắn rơi |
| `TRV-S-127` | leap vừa đủ technique nhưng thiếu `post_contact_minimum_reserve` | reject trước launch; HUD ghost/notch phần thiếu; Drop vẫn luôn legal |
| `TRV-S-128` | spam Jump, buffer cuối recovery, recontact cùng patch/corner | một leap/edge; stable-contact cadence; không bunny-climb/net-height/double cost |
| `TRV-S-129` | Sneak held trước attach, fresh press sau latch, key repeat và toggle-sneak | pre-held suppress attach; fresh edge Drop một lần; release/repeat không phát Drop mới |
| `TRV-S-130` | Sneak trước mantle commit, sau commit và trong landing recovery | cancel-to-cling/fall trước commit; `SNEAK_ON_LANDING` sau commit; không xuyên/rụng ngược mép |
| `TRV-S-131` | Sneak khi riding/swimming/crawling rồi chuyển gần climb face | dismount/descend/posture owner thắng; không simultaneous climb Drop/auto-attach |
| `TRV-S-132` | inventory/chat/menu non-pausing, true pause, alt-tab/focus return khi attached | non-pausing Vigor tiếp tục có readable cue; true pause dừng clock; không ghost Jump/Drop khi focus lại |
| `TRV-S-133` | arrow/knockback trúng giữa jump-attach window, rồi player bấm Jump lại sau control-lock | impulse invalidates inferred lineage; không auto-save; fresh edge rearm nếu geometry/Vigor hợp lệ |
| `TRV-S-134` | sprint/high fall/tangential momentum vào attach và climb leap | carry trong cap, normal velocity triệt đúng; không đổi tốc ngang/external force thành độ cao miễn phí |
| `TRV-S-135` | Space giữa đồng trống, Jump cạnh non-candidate, jump-to-wall candidate đổi nhanh | HUD chỉ preview khi confidence + candidate vượt threshold; debounce/hysteresis không pop/flicker |
| `TRV-S-136` | Jump/Sneak chuyển Free Climb ↔ ladder/vine/scaffolding | một locomotion owner/consumer; không double move/drop/refill |
| `TRV-S-137` | Attack/Destroy/Use bow-shield-food khi attached hoặc trong inferred attach window | attached deny có cue; pre-attach held/commit inhibits grab; không auto-detach/use |
| `TRV-S-138` | nhảy va doorframe, head-bump dưới ceiling, tiny partial patch | clearance/patch/approach deny; không attach vì collision noise |
| `TRV-S-139` | target patch/lip bị place/break/piston/fluid đổi trước và sau leap impulse | trước commit refund/reject; sau impulse không refund chuyển động, regrab/mantle revalidate hiện tại |
| `TRV-S-140` | Q Drop Item/hotbar/F5 khi attached cạnh Sneak binding remap | item/camera action giữ semantics; không nhầm thành climb Drop hoặc reset state |
| `TRV-S-141` | fire/poison/freeze/DoT vs light/heavy impulse trong climb/leap | source/cadence đúng; không triple punishment; only qualified impulse/interrupt đổi lineage/state |
| `TRV-S-142` | waterfall/bubble column/swim threshold trong jump-attach/leap | fluid/external mode precedence; không cộng player effort từ flow hoặc tạo underwater fake grab |
| `TRV-S-143` | deliberate Drop rồi assist thấy lại cùng face; fresh Jump sau inhibit | short same-face regrab inhibit ngăn hút ngược; fresh deliberate rescue vẫn legal sau window |

## 9. Diagonal, action/skill conflict và future aerial chain

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-144` | attached giữ `W+A`, `W+D`, `S+A`, `S+D` | climb diagonal surface-relative, vector/speed/effort normalized, same first/third outcome |
| `TRV-S-145` | `W+S`, `A+D`, `W+S+A/D` rồi Space | opposing raw input tạo `AMBIGUOUS_DIRECTION`; không leap/eject/cost, không last-packet-wins |
| `TRV-S-146` | xoay camera 180° giữa diagonal climb/leap buffer | contact basis không đảo; accepted direction snapshot giữ nguyên, camera chỉ presentation |
| `TRV-S-147` | Dodge ở climb idle/move/recontact và mantle recovery trước/sau commit | climb deny no Vigor cost/detach; chỉ post-commit recovery short-buffer tới supported Dodge |
| `TRV-S-148` | Primary Attack/Grounding press khi attached, mantle, wall-eject rồi falling | attached/mantle deny no cost và không lưu; wall-eject cần fresh Attack + time-to-impact guard |
| `TRV-S-149` | Double Jump unlocked, airborne Jump gần wall với input toward/away/Sneak suppress | attach hoặc Aerial Step đúng một consumer; confidence/override/reason deterministic |
| `TRV-S-150` | Step→Aerial Dodge và Aerial Dodge→Step | mỗi use/resource/marker một lần; no overlap lift+i-frame, direction/collision trace đúng |
| `TRV-S-151` | Step/Dodge rồi wall latch/leap/drop, ladder/scaffold graze, mantle stable landing | wall/graze không reset; chỉ stable-support dwell reset `AerialChain` |
| `TRV-S-152` | Lightness ascent/apex/descent + Step/Dodge/re-entry | cancel/deny edge đúng; no descent–lift stutter, extra use hoặc hover loop |
| `TRV-S-153` | skill mới không khai locomotion profile được bấm khi attached/airborne | `DENY_NO_COST`; không cooldown/resource/ground animation/fall mutation |
| `TRV-S-154` | skill profile `ALLOW/TRANSITION/SHORT_BUFFER` ở đúng/sai phase | đúng owner/consumer/expiry/cost/refund; unsupported source mode deny |
| `TRV-S-155` | Vigor chỉ đủ cho một action trong Step↔Dodge chain | mỗi action reserve/commit riêng; thiếu thì deny không double-charge/refill action kia |
| `TRV-S-156` | attack buffer trong Step/Dodge startup/active/recovery gần đất | Grounding chỉ consume tại declared edge khi falling; không bấm sớm từ rất cao để auto-cast |
| `TRV-S-157` | external launch/knockback, control-lock kết thúc rồi Jump/Dodge | không auto action; fresh input có thể dùng budget cũ, source attribution còn nguyên |
| `TRV-S-158` | duplicate/reorder Jump+Dodge cùng tick | stable precedence/sequence; tối đa một consumer mỗi edge, không double impulse/window/cost |
| `TRV-S-159` | death/portal/reconnect/Elytra/swim giữa chain | cleanup runtime/budget theo owner; no refill/ghost step/dodge/fall immunity |
| `TRV-S-160` | future skill modifier tăng use/refund/reset trên wall hit | validator/contract reject unbounded refresh, resource cross-refill và infinite aerial loop |
| `TRV-S-161` | grounded chạy + Jump, đứng neutral tap/hold và remap dedicated Lightness | normal Jump không trễ ở moving context; chỉ deliberate hold/action mở charge, một consumer |
| `TRV-S-162` | `CLIMB_IDLE` neutral hold, directional Jump, Sneak và hit/mất anchor | wall charge/leap/drop/forced fall đúng owner; no attached-as-airborne hoặc double drain |
| `TRV-S-163` | Lightness charge dưới ceiling sát/thay đổi bởi piston/place/break trước/sau launch | pre-commit reject/refund hoặc post-commit collision/fall, không clip/snap/ghost reserve |
| `TRV-S-164` | Lightness full charge→apex→descent ở high/low altitude/Vigor 0 | route bounded; low landing không hover, exhausted fall/landing cue đúng |
| `TRV-S-165` | held mining/Attack từ trước rơi, fresh Attack trước/sau Grounding armed cue | mining/normal attack hoặc Grounding đúng một consumer; press cũ không auto-slam |
| `TRV-S-166` | Grounding với weapon families/unarmed/tool trên multi-target/occluded/partial-fluid landing | safety parity; bounded shape/target/occlusion/friendly/block-safe result, one hit ID |
| `TRV-S-167` | Aerial Dodge từ rising/apex/fast fall vào wall/floor/hit/reconnect | straight active corridor; gravity/fall provenance re-entry, không arc xuống/stuck scale/fall cancel |
| `TRV-S-168` | Aerial Step rising/apex/fast fall với neutral/180° redirect/ceiling | phase rebase + total-route cap; no infinite lift, instant reversal hoặc fall erase |

## Exit

Mỗi row cần expected result, owner, parameter profile và automated/human oracle trước `IMPLEMENTATION_READY`. Geometry fixtures phải giữ exact block state/orientation/fluid/dynamic sequence và được lưu thành regression world, không chỉ video playtest. Human Test Card viết tiếng Việt và chỉ hỏi một câu human-only; logic/collision/idempotency/correction trace do máy chứng minh trước.
