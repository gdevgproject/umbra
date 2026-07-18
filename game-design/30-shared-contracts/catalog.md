# Shared Contract Catalog

> **DRI:** Technical Designer + Lead Designer
> **Status:** `DISCOVERY`

Shared Contract chỉ tồn tại khi ít nhất hai Feature Cell dùng chung một luật. Chúng không phải package code; chúng là biên ngữ nghĩa cần ổn định.

| ID | Owner đề xuất | Consumers đầu tiên | Câu hỏi phải khóa | Status |
|---|---|---|---|---|
| `CTR-INPUT-ACTION` | UX/Input | attack, dodge, parry, skill, shadow command | versioned action ID, key baseline, context, remap, conflict, buffer | `DISCOVERY` |
| `CTR-ACTION-TIMELINE` | Combat | attack, dodge, parry, item use | phase, commit, cancel, queue, tick clock | `DISCOVERY` |
| `CTR-COMBAT-HIT` | Combat + Gameplay Tech | attack, skill, enemy, shadow | hit ID, cadence, multi-hit, immunity, source/target, anti-spam | `DISCOVERY` |
| `CTR-RESOURCE` | Systems/Balance | combat, skill, shadow, progression | ownership, cost moment, recovery, cap, persistence | `DISCOVERY` |
| `CTR-CAMERA-TARGET` | Camera/UX | movement, dodge, attack, skill, command | first/third view, facing, crosshair, soft/lock target | `DISCOVERY` |
| `CTR-ANIMATION-EVENT` | Animation + Combat | player/enemy/shadow actions | gameplay authority, marker, hitbox, blend, cancel | `DISCOVERY` |
| `CTR-ACTOR-AUTHORITY` | Technical Director | all runtime action | client intent, validation, prediction, correction, latency | `DISCOVERY` |
| `CTR-PERSISTENCE` | Data/Platform | player, shadow, Gate, quest, world | persistent/derived/ephemeral, world ownership, backup/transfer, migration/recovery | `DISCOVERY` |
| `CTR-LOCALIZATION-TERM` | Localization | all UI/content | Minecraft locale, `en_us`/`vi_vn`, string ID, fallback, font/layout | `PROPOSED` |
| `CTR-ACCESSIBILITY` | Accessibility/UX | combat, UI, audio, camera | cue redundancy, motion, timing/input options | `DISCOVERY` |
| `CTR-GATE-LIFECYCLE` | Dungeon | objective, loot, echo, world, save | states/transitions/actors/deadline/cleanup/idempotency | `DISCOVERY` |
| `CTR-CONTENT-DEFINITION` | Technical Design | faction, enemy, skill, item, quest, room | definition/instance, validation, version, reference | `DISCOVERY` |
| `CTR-DEBUG-OBSERVABILITY` | QA/Tools | all systems | event trace, state inspector, replay seed, perf label | `DISCOVERY` |
| `CTR-CAPABILITY-OWNERSHIP` | Platform + Technical Design | all persistent features | availability, owner, lifecycle, death/reconnect/creative/migration | `DISCOVERY` |
| `CTR-MULTIPLAYER-READINESS` | Platform + Security | action, Gate, Shadow, quest, reward | logical server, ownership, payload validation, permission/rate/sync | `DISCOVERY` |
| `CTR-PERFORMANCE-BUDGET` | Performance + Technical Director | all runtime/content features | frame/tick/memory/I/O/network/cardinality budget, tier, degradation, evidence | `DISCOVERY` |
| `CTR-DEATH-RECOVERY` | Systems + Platform | combat, Shadow, Gate, quest, game mode | retain/reset/recall, consequence composition, provenance, re-entry | `PROPOSED` |

Chi tiết chỉ có hiệu lực tại canonical file của contract; catalog dùng để tìm owner và consumer, không lặp luật.

## Canonical contract files

- [Action, authority và time](01-action-authority-and-time.md)
- [Resource và modifier](02-resource-and-modifier-contract.md)
- [Content definition](03-content-definition-contract.md)
- [Localization, accessibility và terminology](04-localization-accessibility-and-terminology.md)
- [Observability và recovery](05-observability-and-recovery.md)
- [Capability state và ownership](06-capability-state-and-ownership.md)
- [Gate lifecycle](../20-domains/06-dungeons/01-gate-lifecycle.md)
- [Combat action/hit](../20-domains/02-combat/01-action-and-hit-model.md)
- [Offline-first multiplayer readiness](../20-domains/12-platform/04-offline-first-multiplayer-readiness.md)
- [Camera system](../20-domains/11-presentation/camera/README.md)
- [Input action/context/key baseline](../20-domains/11-presentation/input/README.md)
- [Save ownership/backup/transfer](../20-domains/12-platform/06-save-ownership-backup-and-transfer.md)
- [Performance Constitution](../60-quality/04-performance-budgets.md)
- [Death và recovery](../20-domains/02-combat/death/README.md)
