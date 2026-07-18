# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer
> **Status:** `ACTIVE`

Đây là backlog đang dùng. Item là câu hỏi cần đóng, không phải ticket code.

| Priority | ID | Câu hỏi/outcome | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 1 | `DB-001` | release đầu nghĩa là gì và fantasy tối thiểu tới đâu? | Game Director | Product Charter | scope ADR + `C8` target |
| 2 | `DB-002` | combat context và input precedence coexist vanilla ra sao? | UX + Combat | action contract | context scenarios + ADR |
| 3 | `DB-003` | nhịp light attack chống spam/cancel/buffer ra sao? | Combat | DB-002 | Feature Cell + timeline matrix |
| 4 | `DB-004` | first/third camera, facing và target model nào? | Camera + Combat | DB-002 | camera prototype plan + ADR |
| 5 | `DB-005` | Dodge hướng/neutral/resource/i-frame/collision ra sao? | Combat | DB-003–004 | Dodge validation package |
| 6 | `DB-006` | enemy đầu tiên dạy attack–dodge bằng pattern nào? | AI + Encounter | DB-003–005 | Enemy/Teaching Card |
| 7 | `DB-007` | Gate state/clock/leave/death/reconnect chính xác? | Dungeon + Platform | authority/persistence | approved contract + state tests |
| 8 | `DB-008` | Arise eligibility/attempt/cost/echo/multiplayer ownership? | Shadows | Gate + resources | Capture Feature Cell + ADR |
| 9 | `DB-009` | Shadow Identity lưu gì tối thiểu để có gắn kết? | Shadows + Narrative | persistence | schema intent + content example |
| 10 | `DB-010` | summon/shatter/revive không upkeep nhưng cân bằng bằng gì? | Shadows + Balance | DB-008–009 | resource/parameter experiment |
| 11 | `DB-011` | 5 stat, 3 specialization, Potential và respec tạo lựa chọn nào? | Player | combat proof | build hypotheses + migration rules |
| 12 | `DB-012` | skill tree/rune/loadout 4+1 có đủ breadth không? | Skill Designer | DB-011 | two-build paper/prototype test |
| 13 | `DB-013` | squad command UX nhỏ nhất điều khiển được là gì? | Shadows + UX | one companion proof | command usability test |
| 14 | `DB-014` | Iron Knight dạy gì và Arise beat có gây bực không? | Encounter + Narrative | combat/capture proof | complete Boss Card + playtest |
| 15 | `DB-015` | quest architecture xử lý branch/recovery/world effect ra sao? | Quest + Platform | Gate/world state | quest vertical spec |
| 16 | `DB-016` | Gold/Essence/Fragments/Merit có thực sự cần bốn currency? | Economy | reward loop | source-sink simulation |
| 17 | `DB-017` | city/home/family xuất hiện ở slice nào để Rootedness có thật? | World + Narrative | scope decision | playable return-loop brief |
| 18 | `DB-018` | performance target 40+80 dùng representation tiers nào? | Performance + AI | squad prototype | benchmark plan/result |
| 19 | `DB-019` | baseline Minecraft/Fabric/Java hiện hành nào được support? | Release Tech | C1 start | compatibility ADR/matrix |
| 20 | `DB-020` | Việt/Anh, accessibility và onboarding baseline nào? | UX + Localization | core mechanic list | communication contract + test |

## Quy tắc ưu tiên

Ưu tiên theo: block nhiều slice hơn → chi phí đảo ngược cao hơn → rủi ro trải nghiệm/IP/save/perf cao hơn → evidence rẻ hơn. Không ưu tiên vì tài liệu nghe hấp dẫn hoặc code dễ.
