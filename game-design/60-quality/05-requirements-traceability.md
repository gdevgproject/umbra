# QLT-TRACE — Ma trận ý định → canonical owner → proof

> **DRI:** Producer + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

| ID | Ý định được bảo tồn | Canonical owner | Proof cần có |
|---|---|---|---|
| R01–02 | Gate đóng đúng luật; leave/deadline có hậu quả | Dungeon/Gate | transition + reload/Break tests |
| R03–04 | Corpse/Echo và ba Arise công bằng, boss không gacha | Shadows/Capture | expiry/idempotency/UI probability tests |
| R05 | Retinue tối đa tám identity sâu, không upkeep; tối đa bốn active có command và tối đa bốn reserve/home/revive | Shadows + `CTR-SHADOW-RETINUE` | slot/membership/claim/deployment/identity/LOD tests |
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
| R25 | Tệp cày cuốc, shōnen, action góc ba, sandbox và living world được hiểu bằng động lực–hành vi–quality proof; action cohort cần embodiment, luyện phản xạ, skill/build expression và worthy boss challenge—not copy feature | Product + Research | `DB-053`, audience/reference cards, learning–competent–expert cohort playtest + failure attribution |
| R26 | Third-person overhaul là core; aim/target/obstruction/first-person được thiết kế trước combat polish | Camera + Presentation | camera room, ray/target oracle, comfort/readability playtest |
| R27 | Public goal là full game nhưng mọi phase nội bộ luôn chơi được | Scope + Production + Git | playable snapshot manifest + mainline smoke |
| R28 | User test ít; máy tự test lifecycle/logic/render có thể tự động | Quality + Observability | unit/server/client GameTest + Test Card/diagnostics bundle |
| R29 | Một người + Agent không mất context qua chat; user chỉ báo pass/next và làm human Test Card khi cần | Governance + Ticket Autopilot + Execution Ledger + Git | cold-start reconcile, change-surface/read set, exact test/commit/handoff/next-action records |
| R30 | Offline hiện tại, multiplayer-ready về authority/ownership/security | Platform | integrated/dedicated parity, packet/reconnect/ownership tests |
| R31 | Death/respawn/reload/creative/`/give`/dimension/chunk/crash không làm mất hoặc nhân state | Platform + QA + domains | lifecycle matrix + migration/recovery fixtures |
| R32 | UMBRA all-in-one first-party; external overhaul không làm méo core và có support tier rõ | Scope + Content + Platform | capability contract, compatibility tier/matrix |
| R33 | Keybind không dựa vào ký ức: audit 26.2, action/context/remap/conflict và ergonomics | Input + Compatibility | registry diff, Action Catalog, layout experiment, stuck/duplicate tests |
| R34 | Mọi player text có Việt/Anh và tự theo Minecraft locale | Localization + UI | key/placeholder parity, runtime locale reload, glyph/overflow screenshots |
| R35 | Minecraft update không âm thầm break UMBRA hoặc làm người dùng mất dấu bản cuối của line cũ | Platform + Release | pinned manifest, support-line state, README/release projection, adapter/mixin inventory, port train, old/new save/render matrix, immutable final EOL artifact |
| R36 | Copy backup/world sang USB/máy khác giữ toàn bộ gameplay state | Data + Release + QA | backup manifest/checksum, restore-as-copy, clean-path load/save test |
| R37 | UI phức tạp vẫn nhất quán, dễ tìm và scale | UI/UX + Art + Accessibility | task graph, token/component states, Việt/Anh interactive prototypes |
| R38 | Phàm Nhân đầu game sợ hostile nhưng còn agency và học được | World + Combat + AI | player–zombie–world exemplar, escape/readability/growth playtest |
| R39 | Từng enemy/skill/item/quest có chiều sâu mà engine vẫn scale | Content + Domains + QA | dossiers, provides/requires tags, validators, representative/stress sets |
| R40 | Asset/audio/VFX nguyên bản, có provenance, budget và fallback | Art/Audio + Tech Art | registry manifest, IP review, two-camera/perf/accessibility evidence |
| R41 | Quest Kernel sớm; rich quest chỉ làm khi reward/world dependencies Ready | Quest + Platform + Production | C4 lifecycle vertical, dependency audit, C8 content dossier/continuity proof |
| R42 | Third-person default sau C2; aim/reticle/lock/first-person không auto-switch mơ hồ | Camera + Input + Combat | mode/transition/ray tests + comfort/comprehension playtest |
| R43 | World dài, AI/combat đông vẫn mượt và không crash/lag tích lũy | Performance + Platform + all domains | frame/tick/memory/I/O/cardinality profiles, soak, degradation and crash-recovery gates |
| R44 | Death có giá nhưng không xóa progression/Shadow identity hoặc gây death spiral; mode vanilla vẫn có nghĩa | Death/Recovery + Platform + Shadows | state matrix, mode/activity/death lifecycle + consequence playtest |
| R45 | Creative là author/debug sandbox đầy đủ, state có provenance thay vì taint cả save | Platform + Death/Recovery + QA | Creative↔Survival/reload/grant/eligibility tests |
| R46 | Living society có NPC sâu nhưng scale bằng identity/event/aggregate tiers | World + AI + Data + Performance | hub exemplar, hydrate/dehydrate continuity, ledger compaction/soak |
| R47 | Future multiplayer ưu tiên co-op 2–4 rồi PvP 1v1/3v3/ranking mà không bóp PvE/solo | Platform + Security + Balance | ownership/threat/ruleset contracts; future dedicated multi-client evidence |
| R48 | Attribute, Potential, damage, hệ/counter và display được quyết từ fantasy/evidence, không từ công thức cũ | Player + Balance + Combat + UX | DB-042 research, simulations, multi-build/mastery playtests, migration |
| R49 | Agent tự nhận diện feature cần performance test, không benchmark mọi thay đổi hoặc bỏ sót hot path | Test Architecture + Performance + Production | `PR-0–PR-3`, ticket trigger, targeted/stress/soak evidence và regression routing |
| R50 | Fabric tối ưu hiện tại nhưng UMBRA có thể trở thành first-class NeoForge build mà không fork gameplay/save | Platform + Compatibility + QA + Release | import guard, Fabric conformance, loader port catalog; future cross-loader save/parity/perf matrix |
| R51 | Shadow roster bounded để identity/AI/relationship sâu: slot 1→8, active cap 4, tối đa bốn reserve/home, sparse relationship, không army archive | Shadows + Balance + UX + Platform | `DB-044`, full-roster claim/parting/rotation/home, 0/1/2/4 balance, eight-member save/command/usability proof |
| R52 | Shadow quỳ/cúi/biểu cảm theo context/personality mà không spam hoặc cắt gameplay | AI + Narrative + Animation + Accessibility | `DB-045`, semantic/priority/reservation/fallback tests + attachment playtest |
| R53 | Max HP scale nhưng chỉ có một Minecraft-compatible health truth; HUD thanh cố định và mọi damage source giữ attribution | `CTR-VITALS-HUD` + Combat + Platform + UI | `DB-046`, environmental/mode/lifecycle matrix, HUD fallback/screenshot, save/death parity |
| R54 | Mana và Focus tách nghĩa; Focus hồi nhanh cho phòng thủ, không phạt traversal; progression không tạo refill/infinite Dodge | `CTR-VITALS-HUD` + Resource + Dodge + Balance | transaction/property tests, notch/readability, capacity/cost/regen simulation và migration |
| R55 | Combat Flask cho heal quick-use có commitment/charge/interrupt; food vẫn có giá trị survival | Items + Combat + Economy + Input + UI | `DB-047`, action idempotency/cancel/hit matrix, source-sink simulation, comprehension playtest |
| R56 | Góc ba dùng camera-relative movement với facing tách; lock/aim transition không đảo hướng và ranged không mặc định ép góc một | Camera Movement + Aim + Input + Animation | `DB-048`, `DB-037`, basis trace, held-input/±180°/parallax/two-view comfort tests |
| R57 | Vertical freedom là core nhưng không phá Minecraft: Free Climb dùng face contract, ladder/building vẫn có lợi ích và boundary có sequence-break audit | `SYS-PLAYER-TRAVERSAL` + `CTR-TRAVERSAL` + World | `DB-049`, `DB-050`, voxel surface/mantle fixtures, route comparison, world/Gate audit |
| R58 | Khí Lực tách Focus/Fatigue/Hunger và không bị relog/refill/cost exploit | `CTR-TRAVERSAL` + Resource + UI + Platform | transaction/property/save/reconnect tests, contextual meter comprehension |
| R59 | Hạ Kình là fresh-Attack phản xạ có armed window: valid landing mới chuyển đúng fall component và commit bounded weapon-shaped AoE mạnh, không cướp mining/attack trên wall, auto-save, hazard immunity hoặc block grief | Grounding Strike + Combat Hit + Input + World + Vitals | `DB-051`, input-owner/time-to-impact/fall-source/weapon/occlusion/target-cap/block-safe/idempotency matrix + feel test |
| R60 | Khinh Công là bounded charge từ stable ground/Climb Idle→high launch→apex→controlled long descent; hold Jump không làm chậm running/directional Jump, có accessible alternative và không cánh/hover/infinite flight | Lightness + Input + Accessibility + Progression + Camera + World | `DB-052`, tap/hold/wall-contact/charge/trajectory/Vigor/obstruction/security/migration tests + traversal/world playtest |
| R61 | Kiến trúc modular monolith khoanh blast radius và truy nguyên nhân khi game scale: owner/layer/dependency/state-thread-transaction/failure/causality đều kiểm được, không dựa diagram/comment | `SYS-RUNTIME` + `CTR-DEBUG-OBSERVABILITY` + Foundation + Test Architecture | `DB-021`, `DB-022`, State/Public-Surface/Dependency matrix schema + fixture rows, architecture fitness + violation fixtures, intent→mutation→projection trace, cold-agent Change Surface proof |
| R62 | Discovery tạo cả frontier novelty và transformed familiarity: sinh vật/sinh thái/cơ chế/nơi chốn mới hoặc Minecraft quen đổi affordance phải làm người chơi hình thành model rồi đổi route/công cụ/chuẩn bị/tham vọng | `PIL-DISCOVERY` + Experience + World + Content | `DB-026`, Discovery Portfolio/exemplar matrix, recall/hypothesis/revisit playtest và content-batch novelty debt review |
| R63 | Free Climb trong voxel giữ ý định và game feel khi geometry/input/world đổi: contextual Jump/Sneak nhận jump-to-wall/leap/drop nhưng không biến passive/external/build contact thành auto-save; mantle/buffer/assist/momentum/Vigor-HUD/prediction không cướp route, nuốt nút, double-charge, xuyên block hoặc che fail | `FEAT-TRAVERSAL-FREE-CLIMB` + `CTR-TRAVERSAL` + `CTR-VITALS-HUD` + Input/Camera/Animation/World/Platform | `DB-050`, intent-lineage/inhibitor + one-edge-one-consumer traces, directional leap/Sneak phase/Vigor-HUD lifecycle, full partial/thin/foliage/glass/fluid/piston fixtures, mutation-race/correction, two-view feel/comfort tests |
| R64 | Skill/action tương lai không phá locomotion truth: Climb/Mantle không bị gọi là airborne; Double Jump/Aerial Dodge chain được nhưng bounded, resource riêng và không wall-touch/reconnect reset; Grounding chỉ từ falling legal window | `CTR-TRAVERSAL` + Aerial Step + Aerial Dodge + Free Climb + Grounding + Lightness + Dodge + Skills | `DB-057`, locomotion-result/default-deny conformance, diagonal/opposing-input, Step↔Dodge order, wall/Lightness/Grounding/resource/lifecycle/loop fixtures |
| R65 | Phát triển cuốn chiếu không tạo design drift: feedback giữa ticket được giữ như observation/outcome, có owner/disposition, canonical sync, ticket/test rebaseline và downstream evidence invalidation; hotfix không bypass design | `PD-050` + `GOV-ROUTING` + Ticket Autopilot + Engineering + Ledger | cold-agent CR replay; fixture cho conformance/amend/follow-up/needs-design/incident; validator + design-baseline/stale-evidence/ledger reconciliation audit |

## Ý định mở rộng được giữ nhưng chưa thuộc 1.0

Dungeon nước/thủy tộc, mount nước/bay, boss 7–12, đầy đủ Cửu Vương, Tower 26–100, multiplayer gameplay, controller, streamer mode và social routes mở rộng đều nằm trong release strategy. Multiplayer **foundation seams** đã framed theo `M1–M3`; gameplay/service vẫn future. NeoForge là future loader target bắt buộc nhưng adapter/artifact chưa nằm current implementation backlog; C1 chỉ đạt portability `L0`.
