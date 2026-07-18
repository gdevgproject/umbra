# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer + Producer
> **Status:** `ACTIVE`

Item là câu hỏi cần đóng, không phải ticket code. Priority được phép đổi; ID giữ ổn định. User đã khóa full-game/all-in-one direction; breadth content không bị ép vào fixed count, còn Shadow topology đã khóa `5 bonded / 4 active` và backlog chỉ research cách vận hành/chứng minh—không hỏi lại cap.

## Foundation và embodiment queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 1 | `DB-019` | Exact Minecraft 26.2/Fabric/Java/build/render baseline và port train nào được pin? | Release Tech | Product invariants | Compatibility ADR + version matrix |
| 2 | `DB-021` | Foundation kernel sở hữu lifecycle/config/ID/event/feature flag/diagnostics nào mà không overengineer? | Technical Director | DB-019 | Foundation Architecture Contract |
| 3 | `DB-043` | Fabric-first/NeoForge-ready boundary, loader port catalog, import rules, save schema và adapter conformance nào khóa từ foundation? | Compatibility + Tech + QA | DB-019/021 | Loader Portability ADR + architecture/conformance plan |
| 4 | `DB-022` | Test OS tự động hóa claim nào; `PR-0–PR-3`, screenshot/input/human escalation ra sao? | QA + Tools | DB-019/021/043 | Test Architecture + harness backlog |
| 5 | `DB-039` | Hardware/settings profile, hierarchical budget, benchmark scene, profiler và degradation contract nào áp cho mọi capability? | Performance + Tech + QA | DB-019/021/022 | Performance Constitution + benchmark manifest |
| 6 | `DB-023` | Offline-first authority/ownership/security seams nào là irreversible cho M0 và future co-op 2–4/PvP instance? | Tech + Security | DB-021 | threat/contract review |
| 7 | `DB-024` | Persist/reset/copy policy cho death, respawn, reconnect, creative, dimension và reload? | Platform + Systems + QA | DB-021/023/043 | State Ownership Matrix |
| 8 | `DB-040` | Death consequence profile, Creative provenance và Survival/Adventure/Spectator/Hardcore composition chính xác ra sao? | Systems + Platform + UX + QA | DB-024/039 | Death/Game-mode Feature Cells + comparison plan |
| 9 | `DB-038` | World backup/manifest/restore/transfer/migration failure hoạt động thế nào? | Data + Release + QA | DB-019/024/043 | Save Portability Contract + restore fixtures |
| 10 | `DB-030` | `vi_vn`/`en_us`, Minecraft locale reload, key parity/font/layout pipeline ra sao? | Localization + UX | DB-019/021 | Communication Contract + locale tests |
| 11 | `DB-029` | Vanilla key registry/version diff và UMBRA Action Catalog/context/conflict architecture ra sao? | UX/Input + Compatibility | DB-019/022 | Key Baseline + Action Catalog |
| 12 | `DB-031` | UI information architecture, visual direction, tokens/components scale ra sao? | UX + UI Art | DB-030 + product systems | UI Design System + prototype plan |
| 13 | `DB-004` | Third-person base rig/occlusion/context architecture nào đạt mining/building parity? | Camera + Combat | DB-019/021/022/029 | Camera Feature Cells + prototype report |
| 14 | `DB-037` | Soft target/lock/reticle/precision/first-person transition policy nào? | Camera + Combat + UX | DB-004 | Aim/Target validation package |
| 15 | `DB-002` | Default layout theo công thái học, remap và action precedence ra sao? | UX + Combat | DB-029/004/037 | layout experiment + ADR |
| 16 | `DB-025` | Animation/render seam sống qua version/backend/loader change mà không sở hữu gameplay truth? | Animation + Rendering | DB-019/004/039/043 | adapter/marker contract |
| 17 | `DB-033` | Asset registry/provenance/AI/LOD/VFX/audio pipeline scale ra sao? | Art/Audio + Tech Art | DB-019/031/025/039 | Asset Pipeline + exemplar manifest |
| 18 | `DB-035` | Content grammar→kit→instance→variant và interaction test sinh ra sao? | Content + Systems + QA | DB-021/022/033 | Content Instance Contract + exemplars |
| 19 | `DB-036` | Quest Kernel/state/objective/reward-effect dependency nào phải có trước content? | Quest + Platform | DB-021/024/030/035 | Quest Kernel Contract + dependency map |

## Gameplay và vertical queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 20 | `DB-042` | Attribute topology, power budget, damage/defense, hệ/counterplay, damage UI và ruleset separation nào đúng fantasy? | Balance + Player + Combat + UX | product feedback + DB-031/035 | Balance Constitution + research/prototype plan |
| 21 | `DB-003` | Light attack chống click/packet spam, cancel và buffer ra sao? | Combat | DB-002/004/025 | Feature Cell + timeline/hit matrix |
| 22 | `DB-005` | Dodge hướng/neutral/resource/i-frame/collision ra sao? | Combat | DB-003/004/037 | Dodge validation package |
| 23 | `DB-034` | Player–zombie–world levers nào tạo sợ đầu game nhưng giữ agency? | Combat + World + AI | DB-003–005/042 | Early Danger experiment report |
| 24 | `DB-006` | Enemy đầu dạy attack–dodge–escape bằng pattern nào? | AI + Encounter | DB-003–005/034/035/042 | Enemy Content Dossier + Teaching Card |
| 25 | `DB-007` | Gate + Quest Kernel clock/leave/death/reconnect/recovery chính xác? | Dungeon + Quest + Platform | DB-024/036/040 + authority | activity vertical contract + tests |
| 26 | `DB-008` | Arise eligibility/attempt/cost/echo/ownership? | Shadows | DB-007 + resources | Capture Feature Cell + ADR |
| 27 | `DB-009` | Shadow Identity tối thiểu nào tạo gắn kết lâu dài? | Shadows + Narrative | persistence/content instance | state intent + content exemplar |
| 28 | `DB-010` | Summon/shatter/revive không upkeep cân bằng bằng gì? | Shadows + Balance | DB-008–009/042 | resource experiment |
| 29 | `DB-044` | Slot 1→5 mở bằng milestone nào; pending claim/full-roster/parting/reserve swap và active cap 4 tạo lựa chọn mà không thành power tax ra sao? | Shadows + Balance + UX + Platform | DB-008–010/031/042 | Retinue Capacity prototype + membership/save/usability matrix |
| 30 | `DB-011` | Candidate stat/specialization/Potential nào qua combat proof và migration/respec test? | Player + Balance | DB-042 + combat proof | approved build parameters + migration rules |
| 31 | `DB-012` | Skill tree/rune/loadout 4+1 có breadth mà không overload input/UI? | Skill + UX | DB-002/011/031/035 | two-build/input test |
| 32 | `DB-013` | Command UX nhỏ nhất cho tối đa bốn active Shadow là gì? | Shadows + UX | DB-044 + camera/input | usability test |
| 33 | `DB-045` | Quỳ/cúi/acknowledgement/ritual/idle social được chọn, phối hợp và fallback theo personality thế nào mà không spam/cắt combat? | AI + Narrative + Animation + UX | DB-009/013/025/033/044 | Expression semantic registry + exemplar/playtest plan |
| 34 | `DB-014` | Iron Knight dạy gì; Arise beat có gây bực? | Encounter + Narrative | combat/capture | Boss Card + playtest |
| 35 | `DB-016` | Currency/shop/item reward contracts và source/sink nào cần cho quest production? | Economy | reward loop + C4 typed reward | source-sink simulation |
| 36 | `DB-015` | Một rich quest vertical có branch/recovery/reward/world effect/pacing ra sao? | Quest + World | DB-007/016/031 + world state | quest content dossier + playable proof |
| 37 | `DB-041` | Living society identity/ledger, hub behavior, relationship, settlement/faction layers và simulation tier scale ra sao? | World + AI + Quest + Performance | DB-024/035/036/039 | Living Society Contract + hub exemplar plan |
| 38 | `DB-017` | Home/family/hub xuất hiện thế nào ở first return loop? | World + Narrative | DB-015/041 + C8 scope | playable return brief |
| 39 | `DB-018` | Player + 4 active Shadow và hostile mix/crowd dùng composition, representation tier và cue nào cho `PERF-S02A/B`? | Performance + AI + Encounter | DB-039/044 + squad/content prototypes | encounter + spectacle benchmark results |
| 40 | `DB-020` | Accessibility/onboarding baseline hoàn thiện theo core mechanics nào? | UX + Localization | core list + DB-030/031 | communication/onboarding contract |

## Product/content direction đã framed

| ID | Trạng thái | Câu hỏi nội bộ tiếp theo |
|---|---|---|
| `DB-001` | `DECIDED` | full coherent all-in-one game; release manifest do quality/coherence gate, không hỏi user fixed count |
| `DB-026` | `DISCOVERY` | authored/systemic/player-created layers phối hợp và kiểm chất lượng ra sao, không tìm tỷ lệ vì thiếu nguồn lực |
| `DB-027` | `DISCOVERY` | first-party living world/building/mount/vehicle capability dependency graph và exemplar order; society chi tiết do DB-041 |
| `DB-028` | `FRAMED` | M1 co-op 2–4; M2 PvP 1v1/3v3; M3 ranking/event — hiện chỉ giữ seam và threat model |

## Quy tắc ưu tiên

Baseline/irreversibility → loader/domain/save boundary → save/security/data-loss → observability/test/performance risk → control/camera/input → communication/UI/assets/content grammar → player-visible loop → cross-system content breadth. Content lớn/khó làm muộn khi dependency interaction chưa ổn định; không phải vì giới hạn tham vọng. “Nền tảng” phải có consumer/proof; không xây abstraction vô hạn hoặc NeoForge code giả trước matching port spike.
