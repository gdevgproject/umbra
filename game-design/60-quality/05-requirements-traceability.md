# QLT-TRACE — Ma trận ý định → canonical owner → proof

> **DRI:** Producer + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

| ID | Ý định được bảo tồn | Canonical owner | Proof cần có |
|---|---|---|---|
| R01–02 | Gate đóng đúng luật; leave/deadline có hậu quả | Dungeon/Gate | transition + reload/Break tests |
| R03–04 | Corpse/Echo và ba Arise công bằng, boss không gacha | Shadows/Capture | expiry/idempotency/UI probability tests |
| R05 | Quân đoàn sâu, không upkeep, có command/garrison/revive | Shadows | identity/deployment/LOD tests |
| R06 | Combat mastery, chống spam, Focus/dodge/parry có cap | Combat + Contracts | action/hit/latency/feel tests |
| R07–09 | Tự build, rank đầy đủ, endgame giữ world cũ | Player + World | migration/build/Strata snapshot |
| R10–11 | Boss dạy; faction/AI khác định tính | Encounter + AI + Content | teaching/fairness/distinctness playtests |
| R12 | Mount là capability, không bắt buộc | Future scope | collision/dismount/content card trước mở scope |
| R13–14 | City/NPC/respect/family có phẩm giá, không chore | World + Narrative | behavior/continuity/UX tests |
| R15–16 | Gear/crafting/economy sâu, không daily/FOMO | Items/Economy | source-sink/build/economy simulation |
| R17 | Nội dung nước được làm sâu hoặc deferred rõ | Scope strategy | capability/perf/content gate |
| R18 | Art/audio đẹp, Minecraft-native/shader-safe | Presentation + Asset Bible | readability/compat/perf/originality review |
| R19–20 | Fabric baseline kiểm chứng, offline-first, server-authoritative | Platform | release matrix/dedicated server/authority tests |
| R21 | Remap/context/camera/UI rõ | Presentation | conflict/input/camera/accessibility matrix |
| R22 | Research rộng nhưng sản phẩm nguyên bản | Research + Content | Reference Card/transformation review |
| R23 | Scale không phá TPS/save | Platform + Performance | p95/p99 benchmark, migration, soak |
| R24 | Phát triển theo slice chơi/test được | Production | capability exit evidence |
| R25 | Tệp cày cuốc, shōnen, action góc ba, sandbox và living world cùng được hiểu bằng nhu cầu, không copy feature | Product + Research | audience/research cards + cohort playtest |
| R26 | Third-person overhaul là core; aim/target/obstruction/first-person được thiết kế trước combat polish | Camera + Presentation | camera room, ray/target oracle, comfort/readability playtest |
| R27 | Public goal là full game nhưng mọi phase nội bộ luôn chơi được | Scope + Production + Git | playable snapshot manifest + mainline smoke |
| R28 | User test ít; máy tự test lifecycle/logic/render có thể tự động | Quality + Observability | unit/server/client GameTest + Test Card/diagnostics bundle |
| R29 | Một người + Agent không mất context qua chat | Governance + Git + Ticket | read set/handoff/test/commit records |
| R30 | Offline hiện tại, multiplayer-ready về authority/ownership/security | Platform | integrated/dedicated parity, packet/reconnect/ownership tests |
| R31 | Death/respawn/reload/creative/`/give`/dimension/chunk/crash không làm mất hoặc nhân state | Platform + QA + domains | lifecycle matrix + migration/recovery fixtures |
| R32 | UMBRA all-in-one nhưng add-on/vehicle/mount/world breadth không phá boundary | Scope + Content + Platform | capability contract, two-consumer proof, compatibility matrix |

## Ý định mở rộng được giữ nhưng chưa thuộc 1.0

Dungeon nước/thủy tộc, mount nước/bay, boss 7–12, đầy đủ Cửu Vương, Tower 26–100, multiplayer gameplay, controller, streamer mode và social routes mở rộng đều nằm trong release strategy. Multiplayer **foundation seams** không deferred; chỉ gameplay/social feature deferred.
