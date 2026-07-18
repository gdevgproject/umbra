# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer + Producer
> **Status:** `ACTIVE`

Item là câu hỏi cần đóng, không phải ticket code. Priority được phép đổi; ID giữ ổn định.

## Foundation queue hiện tại

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 1 | `DB-021` | Foundation kernel phải sở hữu lifecycle/config/ID/migration/feature flag/diagnostics nào mà không overengineer? | Technical Director | Product invariants | Foundation Architecture Contract |
| 2 | `DB-022` | Test OS tự động hóa được gì; diagnostics bundle/user card hoạt động ra sao? | QA + Tools | DB-021 | Test Architecture + harness backlog |
| 3 | `DB-023` | Offline-first authority/ownership/security seams nào là irreversible? | Tech + Security | DB-021 | multiplayer-readiness threat/contract review |
| 4 | `DB-019` | Baseline Minecraft/Fabric/Java/render APIs nào được pin? | Release Tech | DB-021–023 | Compatibility ADR/matrix |
| 5 | `DB-024` | Persist/reset/copy policy cho death, respawn, reconnect, creative, dimension và save reload? | Platform + Systems + QA | DB-021 | State Ownership Matrix |
| 6 | `DB-004` | Third-person base rig/occlusion/aim/target architecture nào? | Camera + Combat | DB-019/021/022 | Camera Feature Cells + prototype report |
| 7 | `DB-002` | Input context/precedence coexist vanilla, UI, camera, combat và command ra sao? | UX + Combat | DB-004 | context scenarios + ADR |
| 8 | `DB-025` | Animation/render seam nào sống qua version change mà không sở hữu gameplay truth? | Animation + Rendering Tech | DB-019/004 | adapter/marker contract |

## Gameplay queue sau foundation

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 9 | `DB-003` | Light attack chống click/packet spam, cancel và buffer ra sao? | Combat | DB-002/004/025 | Feature Cell + timeline/hit matrix |
| 10 | `DB-005` | Dodge hướng/neutral/resource/i-frame/collision ra sao? | Combat | DB-003/004 | Dodge validation package |
| 11 | `DB-006` | Enemy đầu dạy attack–dodge bằng pattern nào? | AI + Encounter | DB-003–005 | Enemy/Teaching Card |
| 12 | `DB-007` | Gate clock/leave/death/reconnect/recovery chính xác? | Dungeon + Platform | DB-024 + authority | approved contract + state tests |
| 13 | `DB-008` | Arise eligibility/attempt/cost/echo/ownership? | Shadows | Gate + resources | Capture Feature Cell + ADR |
| 14 | `DB-009` | Shadow Identity tối thiểu nào tạo gắn kết lâu dài? | Shadows + Narrative | persistence | state intent + content example |
| 15 | `DB-010` | Summon/shatter/revive không upkeep cân bằng bằng gì? | Shadows + Balance | DB-008–009 | resource experiment |
| 16 | `DB-011` | 5 stat, 3 specialization, Potential/respec tạo lựa chọn nào? | Player | combat proof | build hypotheses + migration rules |
| 17 | `DB-012` | Skill tree/rune/loadout 4+1 có breadth mà không overload? | Skill Designer | DB-011 | two-build test |
| 18 | `DB-013` | Command UX nhỏ nhất điều khiển được là gì? | Shadows + UX | one companion + camera | usability test |
| 19 | `DB-014` | Iron Knight dạy gì; Arise beat có gây bực? | Encounter + Narrative | combat/capture | Boss Card + playtest |
| 20 | `DB-015` | Quest branch/recovery/world effect ra sao? | Quest + Platform | Gate/world state | quest vertical spec |
| 21 | `DB-016` | Có thật sự cần bốn currency? | Economy | reward loop | source-sink simulation |
| 22 | `DB-017` | Home/family/hub xuất hiện thế nào ở first return loop? | World + Narrative | C8 scope | playable return brief |
| 23 | `DB-018` | 40 Shadow + 80 hostile dùng representation tiers nào? | Performance + AI | squad prototype | benchmark result |
| 24 | `DB-020` | Việt/Anh, accessibility và onboarding baseline? | UX + Localization | core mechanic list | communication contract + test |

## Product/content queue không block foundation

| ID | Trạng thái | Câu hỏi tiếp theo |
|---|---|---|
| `DB-001` | `FRAMED` | public 1.0 là full coherent game đã khóa; exact campaign/boss/faction/endgame breadth chờ cost từ C5/C8/C9 |
| `DB-026` | `DISCOVERY` | longevity chia authored/systemic/player-created/expansion thế nào để thực tế? |
| `DB-027` | `DISCOVERY` | living world/NPC/building/mount/vehicle breadth nào thuộc core hay add-on seam? |
| `DB-028` | `DEFERRED` | future social ưu tiên co-op, persistent server society hay PvP để định ownership seam? |

## Quy tắc ưu tiên

Blast radius/irreversibility → save/security/data-loss → control/camera/authority → testability/compatibility → player-visible loop → content breadth. “Nền tảng” phải có consumer/proof; không xây abstraction vô hạn vì sợ tương lai.
