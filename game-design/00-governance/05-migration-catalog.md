# GOV-MIGRATION — Catalog di trú corpus v4

> **DRI:** Design Operations
> **Status:** `IN_PROGRESS`

Mục tiêu của catalog là bảo đảm không mất ý tưởng nhưng cũng không vô tình tái hợp thức hóa toàn bộ corpus cũ. `Inventory complete` chỉ nghĩa là đã biết nội dung nằm đâu; `Migrated` chỉ được đánh khi statement đã về đúng canonical artifact và được phân loại.

| Legacy | Nội dung chính | Canonical destination | Migration |
|---|---|---|---|
| 00 README | quyết định liên file, emotional pyramid, map | Product Charter, governance, System Map | partial |
| 00.5 case study | research Solo Leveling | `70-research/` theo Research Card | pending |
| 01 vision | promise, audience, anti-goals, success | Product Charter | partial |
| 02 GDD | fantasy, loop, stages, unlock | Product Charter + System Map + domain cells | inventory complete |
| 03 progression | level/stat/rank/class/potential/mastery/strata | `DOM-PLAYER` cells + resource/parameter contracts | pending; conflict A-001/A-003 |
| 04 shadows | Arise/echo/roster/command/identity | `DOM-SHADOWS` cells + Gate/resource/authority contracts | pending |
| 05 combat | action/resource/weapon/damage/camera feel | `DOM-COMBAT` cells + shared contracts | dodge partial |
| 06 skills | tree/rune/loadout/synergy/class | `DOM-SKILLS` cells | pending |
| 07 AI | actor/squad/morale/director/social/family | `DOM-AI` cells | pending |
| 08 dungeon | Gate/generation/Break/Tower | `DOM-DUNGEONS` + Gate contract | pending |
| 09 boss | teaching/phase/roster/capture | `DOM-ENCOUNTERS` + content instances | pending |
| 10 world | vanilla/city/respect/home/event/strata | `DOM-WORLD` cells | pending |
| 11 items | rarity/affix/loadout/crafting/growth gear | `DOM-ITEMS` cells | pending |
| 12 economy | currency/sell/shop/faucet/sink | `DOM-ECONOMY` cells | pending; conflict A-002 |
| 13 balance | PB/TTK/adaptive/power creep | `DOM-QUALITY` balance specs | pending |
| 14 formulas | candidate parameter formulas | Parameter Registry theo owner feature | pending; không còn ưu tiên toàn cục |
| 15 data | candidate schema/save | content/persistence contracts sau feature lifecycle | pending |
| 16 architecture | platform/module/runtime candidates | technical ADR/context map sau design boundary | pending |
| 17 performance | entity/tick/render budgets | `60-quality/performance` | pending |
| 18 testing | pyramid/scenario/playtest | `60-quality/` + acceptance từng cell | pending |
| 19 compatibility | Fabric/version/mod/shader/save | platform/release compatibility spec | pending; baseline unverified |
| 20 roadmap | M0–M8 scope | archive; production được dựng lại sau gates | frozen |
| 21 content/assets | pipeline/art/audio/naming | `40-content/` + creative/pipeline contracts | pending |
| 22 principles | design constitution | Product Charter + governance | partial |
| 23 expansion | future queue | product opportunity backlog sau scope ladder | frozen |
| 24 narrative | lore/prologue/quest/endings/family | `DOM-NARRATIVE` + content graph | pending |
| 25 UI/UX | HUD/screens/onboarding/accessibility | `DOM-PRESENTATION` cells + shared contracts | pending |
| 26 reference framework | research/content cards | `70-research/` + templates/content gate | partial |
| 27 traceability/readiness | R01–R24 và readiness claim | System Map + lifecycle + requirement graph sau migration | readiness revoked |
| 28 bounded contexts | code context candidates | technical architecture sau Feature Cells | frozen candidate |
| 29 M0–M2 backlog | implementation tickets | archive; không active | frozen |
| 30 1.0 backlog | release epics/gates | archive; scope ladder làm lại | frozen |

## Definition of migrated

Một legacy section chỉ được ghi `migrated` khi:

- mọi rule được phân loại và có canonical owner;
- conflict/open question được ghi;
- provenance link tới archive có mặt;
- duplicate canonical statement đã được loại;
- status không cao hơn bằng chứng;
- link consumer trỏ tới ID mới.

