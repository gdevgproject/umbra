# C8 — Village Hub và NPC society tickets

> **Pack state:** `BLOCKED_BY_DESIGN`
> **Shared non-goal:** settlement/faction simulation đầy đủ, full-world brain tick, deleting/demoting overflow NPC or guaranteed upper-tier spawn.

| Ticket | Outcome / in scope | Exact gate | Depends | Risk | Acceptance sketch | Rollback unit |
|---|---|---|---|---|---|---|
| `TKT-C8-001` | stable Village Hub/POI revision/residency ledger + hydrate/dehydrate/merge-split transaction | `DB-060` | C1 save/spatial/diagnostic + Quest Kernel hub consumer | `PR-3` | POI mutation/unload/restore/merge/split no duplicate/delete | Hub identity capability |
| `TKT-C8-002` | disjoint `NPC-DENSITY-*`, lower weight validator, strict base HP/damage and nondecreasing visual tiers | `DB-060` | `TKT-C8-001`, `TKT-C3-001` | `PR-3` | generated quota/overflow/monotonic property/visual fallback | density/power policy flag |
| `TKT-C8-003` | persistent LevelBand personality/arrogance stance + content coverage validator/LOD | `DB-061` personality subset | `TKT-C8-001`, `TKT-C8-002` | `PR-2` | L69/70/equal/higher, reload seed, cooldown/locale/LOD | personality policy flag |
| `TKT-C8-004` | Bully nonlethal warning action/taunt/cue | `DB-061` Bully subset | `TKT-C8-003`, `TKT-C3-001`, `TKT-C3-002` | `PR-2` | HP20/2/1/0,5 + duplicate/secondary hazard always ≥1 HP | Bully behavior flag |
| `TKT-C8-005` | Guardian rescue perception/reservation/path/action/reward ownership | `DB-061` Guardian subset | `TKT-C8-003`, enemy AI/action owner | `PR-3` | pressure/LOS/multi-Guardian/path fail/unload no storm/kill theft | Guardian behavior flag |
| `TKT-C8-006` | every L70+ NPC critical-HP disengage/retreat/safe fallback | `DB-061` flee subset | `TKT-C8-003`, combat/path owner | `PR-3` | threshold/no-path/hit/unload/reload no teleport/heal/despawn cheat | flee policy flag |
| `TKT-C8-007` | integrated hub snapshot with services, traits, density, save, locale, accessibility and `PERF-S01` | `DB-041`, `DB-060`, `DB-061` proof plans | `TKT-C8-001`…`TKT-C8-006` | `PR-3` | enter/interact/combat/rescue/retreat/merge/reload/rollback; one human comprehension card | whole hub/society flags |

## Promotion gaps

Hub capacity/visitor/dwell/relocation UX, Level→HP/damage curves, visual tiers/assets, rare incidence, Bully gap/damage/cooldown, Guardian pressure/credit, flee threshold/safe scoring, exact Minecraft villager/raid/golem adapters and performance budgets remain `OPEN` at `DB-060/061/041`.
