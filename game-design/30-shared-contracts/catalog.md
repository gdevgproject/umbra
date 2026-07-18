# Shared Contract Catalog

> **DRI:** Technical Designer + Lead Designer
> **Status:** `DISCOVERY`

Shared Contract chỉ tồn tại khi ít nhất hai Feature Cell dùng chung một luật. Chúng không phải package code; chúng là biên ngữ nghĩa cần ổn định.

| ID | Owner đề xuất | Consumers đầu tiên | Câu hỏi phải khóa | Status |
|---|---|---|---|---|
| `CTR-INPUT-ACTION` | UX/Input | attack, dodge, parry, skill, shadow command | context, remap, conflict, buffer, intent vocabulary | `DISCOVERY` |
| `CTR-ACTION-TIMELINE` | Combat | attack, dodge, parry, item use | phase, commit, cancel, queue, tick clock | `DISCOVERY` |
| `CTR-COMBAT-HIT` | Combat + Gameplay Tech | attack, skill, enemy, shadow | hit ID, cadence, multi-hit, immunity, source/target, anti-spam | `DISCOVERY` |
| `CTR-RESOURCE` | Systems/Balance | combat, skill, shadow, progression | ownership, cost moment, recovery, cap, persistence | `DISCOVERY` |
| `CTR-CAMERA-TARGET` | Camera/UX | movement, dodge, attack, skill, command | first/third view, facing, crosshair, soft/lock target | `DISCOVERY` |
| `CTR-ANIMATION-EVENT` | Animation + Combat | player/enemy/shadow actions | gameplay authority, marker, hitbox, blend, cancel | `DISCOVERY` |
| `CTR-ACTOR-AUTHORITY` | Technical Director | all runtime action | client intent, validation, prediction, correction, latency | `DISCOVERY` |
| `CTR-PERSISTENCE` | Data/Platform | player, shadow, Gate, quest, world | persistent/derived/ephemeral, migration, rollback | `DISCOVERY` |
| `CTR-LOCALIZATION-TERM` | Localization | all UI/content | string ID, source locale, terminology, fallback, font | `DISCOVERY` |
| `CTR-ACCESSIBILITY` | Accessibility/UX | combat, UI, audio, camera | cue redundancy, motion, timing/input options | `DISCOVERY` |
| `CTR-GATE-LIFECYCLE` | Dungeon | objective, loot, echo, world, save | states/transitions/actors/deadline/cleanup/idempotency | `PROPOSED_FROM_ARCHIVE` |
| `CTR-CONTENT-DEFINITION` | Technical Design | faction, enemy, skill, item, quest, room | definition/instance, validation, version, reference | `DISCOVERY` |
| `CTR-DEBUG-OBSERVABILITY` | QA/Tools | all systems | event trace, state inspector, replay seed, perf label | `DISCOVERY` |

`PROPOSED_FROM_ARCHIVE` nghĩa là có candidate khá chi tiết nhưng vẫn phải review theo lifecycle mới.

