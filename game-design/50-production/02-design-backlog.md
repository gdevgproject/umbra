# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer + Producer
> **Status:** `ACTIVE`

Item là câu hỏi cần đóng, không phải ticket code. Priority được phép đổi; ID giữ ổn định. User đã khóa full-game/all-in-one direction nên backlog không hỏi lại roster count hoặc “có nên làm lớn không”.

## Foundation và embodiment queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 1 | `DB-019` | Exact Minecraft 26.2/Fabric/Java/build/render baseline và port train nào được pin? | Release Tech | Product invariants | Compatibility ADR + version matrix |
| 2 | `DB-021` | Foundation kernel sở hữu lifecycle/config/ID/event/feature flag/diagnostics nào mà không overengineer? | Technical Director | DB-019 | Foundation Architecture Contract |
| 3 | `DB-022` | Test OS tự động hóa claim nào; screenshot/input/human escalation ra sao? | QA + Tools | DB-019/021 | Test Architecture + harness backlog |
| 4 | `DB-023` | Offline-first authority/ownership/security seams nào là irreversible? | Tech + Security | DB-021 | threat/contract review |
| 5 | `DB-024` | Persist/reset/copy policy cho death, respawn, reconnect, creative, dimension và reload? | Platform + Systems + QA | DB-021/023 | State Ownership Matrix |
| 6 | `DB-038` | World backup/manifest/restore/transfer/migration failure hoạt động thế nào? | Data + Release + QA | DB-019/024 | Save Portability Contract + restore fixtures |
| 7 | `DB-030` | `vi_vn`/`en_us`, Minecraft locale reload, key parity/font/layout pipeline ra sao? | Localization + UX | DB-019/021 | Communication Contract + locale tests |
| 8 | `DB-029` | Vanilla key registry/version diff và UMBRA Action Catalog/context/conflict architecture ra sao? | UX/Input + Compatibility | DB-019/022 | Key Baseline + Action Catalog |
| 9 | `DB-031` | UI information architecture, visual direction, tokens/components scale ra sao? | UX + UI Art | DB-030 + product systems | UI Design System + prototype plan |
| 10 | `DB-004` | Third-person base rig/occlusion/context architecture nào đạt mining/building parity? | Camera + Combat | DB-019/021/022/029 | Camera Feature Cells + prototype report |
| 11 | `DB-037` | Soft target/lock/reticle/precision/first-person transition policy nào? | Camera + Combat + UX | DB-004 | Aim/Target validation package |
| 12 | `DB-002` | Default layout theo công thái học, remap và action precedence ra sao? | UX + Combat | DB-029/004/037 | layout experiment + ADR |
| 13 | `DB-025` | Animation/render seam sống qua version/backend change mà không sở hữu gameplay truth? | Animation + Rendering | DB-019/004 | adapter/marker contract |
| 14 | `DB-033` | Asset registry/provenance/AI/LOD/VFX/audio pipeline scale ra sao? | Art/Audio + Tech Art | DB-019/031/025 | Asset Pipeline + exemplar manifest |
| 15 | `DB-035` | Content grammar→kit→instance→variant và interaction test sinh ra sao? | Content + Systems + QA | DB-021/022/033 | Content Instance Contract + exemplars |
| 16 | `DB-036` | Quest Kernel/state/objective/reward-effect dependency nào phải có trước content? | Quest + Platform | DB-021/024/030/035 | Quest Kernel Contract + dependency map |

## Gameplay và vertical queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 17 | `DB-003` | Light attack chống click/packet spam, cancel và buffer ra sao? | Combat | DB-002/004/025 | Feature Cell + timeline/hit matrix |
| 18 | `DB-005` | Dodge hướng/neutral/resource/i-frame/collision ra sao? | Combat | DB-003/004/037 | Dodge validation package |
| 19 | `DB-034` | Player–zombie–world levers nào tạo sợ đầu game nhưng giữ agency? | Combat + World + AI | DB-003–005 | Early Danger experiment report |
| 20 | `DB-006` | Enemy đầu dạy attack–dodge–escape bằng pattern nào? | AI + Encounter | DB-003–005/034/035 | Enemy Content Dossier + Teaching Card |
| 21 | `DB-007` | Gate + Quest Kernel clock/leave/death/reconnect/recovery chính xác? | Dungeon + Quest + Platform | DB-024/036 + authority | activity vertical contract + tests |
| 22 | `DB-008` | Arise eligibility/attempt/cost/echo/ownership? | Shadows | DB-007 + resources | Capture Feature Cell + ADR |
| 23 | `DB-009` | Shadow Identity tối thiểu nào tạo gắn kết lâu dài? | Shadows + Narrative | persistence/content instance | state intent + content exemplar |
| 24 | `DB-010` | Summon/shatter/revive không upkeep cân bằng bằng gì? | Shadows + Balance | DB-008–009 | resource experiment |
| 25 | `DB-011` | 5 stat, 3 specialization, Potential/respec tạo lựa chọn nào? | Player | combat proof | build hypotheses + migration rules |
| 26 | `DB-012` | Skill tree/rune/loadout 4+1 có breadth mà không overload input/UI? | Skill + UX | DB-002/011/031/035 | two-build/input test |
| 27 | `DB-013` | Command UX nhỏ nhất điều khiển được là gì? | Shadows + UX | companion + camera/input | usability test |
| 28 | `DB-014` | Iron Knight dạy gì; Arise beat có gây bực? | Encounter + Narrative | combat/capture | Boss Card + playtest |
| 29 | `DB-016` | Currency/shop/item reward contracts và source/sink nào cần cho quest production? | Economy | reward loop + C4 typed reward | source-sink simulation |
| 30 | `DB-015` | Một rich quest vertical có branch/recovery/reward/world effect/pacing ra sao? | Quest + World | DB-007/016/031 + world state | quest content dossier + playable proof |
| 31 | `DB-017` | Home/family/hub xuất hiện thế nào ở first return loop? | World + Narrative | C8 scope + quest vertical | playable return brief |
| 32 | `DB-018` | 40 Shadow + 80 hostile dùng representation tiers nào? | Performance + AI | squad/content prototypes | benchmark result |
| 33 | `DB-020` | Accessibility/onboarding baseline hoàn thiện theo core mechanics nào? | UX + Localization | core list + DB-030/031 | communication/onboarding contract |

## Product/content direction đã framed

| ID | Trạng thái | Câu hỏi nội bộ tiếp theo |
|---|---|---|
| `DB-001` | `DECIDED` | full coherent all-in-one game; release manifest do quality/coherence gate, không hỏi user fixed count |
| `DB-026` | `DISCOVERY` | authored/systemic/player-created layers phối hợp và kiểm chất lượng ra sao, không tìm tỷ lệ vì thiếu nguồn lực |
| `DB-027` | `DISCOVERY` | first-party living world/NPC/building/mount/vehicle capability dependency graph và exemplar order |
| `DB-028` | `DEFERRED` | future social ưu tiên co-op, persistent society hay PvP để định ownership seam |

## Quy tắc ưu tiên

Baseline/irreversibility → save/security/data-loss → observability/test → control/camera/input → communication/UI/assets/content grammar → player-visible loop → cross-system content breadth. Content lớn/khó làm muộn khi dependency interaction chưa ổn định; không phải vì giới hạn tham vọng. “Nền tảng” phải có consumer/proof; không xây abstraction vô hạn.
