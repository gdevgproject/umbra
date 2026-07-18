# SYS-PLAYER-TRAVERSAL — Scenario Matrix

> **Owner:** Traversal QA + Player Controls
> **Status:** `DISCOVERY`
> **Mục đích:** inventory quyết định/oracle; chưa phải expected result cuối cho parameter mở.

## 1. Free Climb — input và surface

| ID | Scenario | Quyết định/oracle cần có |
|---|---|---|
| `TRV-S-001` | từ đất đi vào full stone face + Climb | attach guard/cue/pose |
| `TRV-S-002` | chạm tường khi mining/placing mà không Climb | không auto-cướp input |
| `TRV-S-003` | airborne toward wall; auto-grab on/off | setting + authority parity |
| `TRV-S-004` | W/S/A/D/diagonal, camera xoay 360° | surface-relative basis, normalize |
| `TRV-S-005` | key repeat/duplicate packet tại attach/leap | một transition/cost |
| `TRV-S-006` | drop/eject/away+jump | consequence và direction predictable |
| `TRV-S-007` | full block dirt/stone/wood/ore/glass/ice | default/tag/profile matrix |
| `TRV-S-008` | slab/stair/fence/wall/door/trapdoor/chest | shape/clearance, không ID heuristic |
| `TRV-S-009` | foliage/fluid/fire/lava/cactus/magma | no support/hazard attribution |
| `TRV-S-010` | ladder/vine/scaffolding/water elevator | vanilla owner/value, transition |
| `TRV-S-011` | convex/concave corner | continuous face/clearance/no snap |
| `TRV-S-012` | overhang/ceiling/one-block tunnel | deny baseline/no clip |
| `TRV-S-013` | piston/door/block remove giữa attach | invalidation → safe fall/transition |
| `TRV-S-014` | chunk/world border/claim/activity boundary | no stale face/teleport |

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
| `TRV-S-060` | neutral/W/S/A/D/diagonal launch | camera-relative snapshot/envelope |
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
| `TRV-S-090` | auto-grab/auto-mantle/hold-toggle/window assist | setting không đổi hidden truth |
| `TRV-S-091` | `vi_vn/en_us`, long labels, GUI scale | meter/prompt/overflow |
| `TRV-S-092` | colorblind/reduced motion/no shake/no haptic | cue redundancy/comfort |
| `TRV-S-093` | input conflict/non-US/one-handed/controller harness | remap/precedence/alternative |
| `TRV-S-094` | repeated wall route 10k transitions | leak/live-set/state cleanup |
| `TRV-S-095` | dense voxel wall + fast camera + particles | probe/frame/allocation budget |
| `TRV-S-096` | dedicated one client + latency/packet adversary | authority/anti-flight parity |

## Exit

Mỗi row cần expected result, owner, parameter profile và automated/human oracle trước `IMPLEMENTATION_READY`. Geometry fixtures phải được giữ làm regression world, không chỉ video playtest.

