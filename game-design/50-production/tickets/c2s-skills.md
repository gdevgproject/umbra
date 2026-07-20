# C2S — Skill Platform tickets

> **Pack state:** `BLOCKED_BY_DESIGN`
> **Shared non-goal:** final combat balance, quest delivery, Rank/attributes/Potential, Mana/Focus or one class per skill.

| Ticket | Outcome / in scope | Exact gate | Depends | Risk | Acceptance sketch | Rollback unit |
|---|---|---|---|---|---|---|
| `TKT-C2S-001` | Skill Definition/schema/stable refs + validator for requirement/effect/presentation/migration | `DB-012`, `DB-035` | `TKT-C1-004`, `TKT-C1-007` | `PR-1` | valid/missing/cycle/conflict/version fixtures; no arbitrary script | definition registry |
| `TKT-C2S-002` | Level 1 + every-5 idempotent grant ledger and catch-up/multi-level migration | `DB-058` | `TKT-C1-005`, `TKT-C1-006`, `TKT-C2S-001` | `PR-2` | L1/4→5/9→10/100/retry/reload exact formula | grant ledger |
| `TKT-C2S-003` | full-future Library/Tree preview reading authoritative definition, animation/static fallback | `DB-031`, `DB-058`, `DB-025` | `TKT-C1-008`, `TKT-C2S-001` | `PR-2` | all required fields, `vi_vn/en_us`, reduced motion, 100-card stress | preview projection/screen |
| `TKT-C2S-004` | known/equipped loadout state, slot/conflict/reselection/missing-content recovery | `DB-058` | `TKT-C2S-002`, `TKT-C2S-003` | `PR-2` | equip/full/duplicate/remove/reload/migrate no lost grant | loadout state capability |
| `TKT-C2S-005` | one harmless exemplar intent→cooldown/charge→typed result→cue through public action seam | `DB-012` | `TKT-C1-005`, `TKT-C2S-001`, `TKT-C2S-004` | `PR-2` | accept/reject/duplicate/cancel/save cleanup; no damage or new resource | exemplar + execution adapter |
| `TKT-C2S-006` | integrate Skill Platform snapshot, author/debug grant, manifest/perf/rollback | C2S proof plan approved | `TKT-C2S-001`…`TKT-C2S-005` | `PR-2` | new world→preview→grant→equip→use→reload/missing content→rollback | whole C2S flag |

## Promotion gaps

Exact schema/effect primitives, loadout cap, two representative future consumers, UI layout/assets, public action contract, save keys, stress budget and full lifecycle commands remain `OPEN`. The harmless exemplar cannot smuggle final damage, resource or movement semantics into foundation.
