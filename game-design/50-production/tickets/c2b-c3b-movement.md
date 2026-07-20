# C2B/C3/C3B — Vigor, movement, combat seam và aerial tickets

> **Pack state:** `BLOCKED_BY_DESIGN`
> **Shared non-goal:** quest implementation, future Aerial Step/Aerial Dodge, final damage catalog or NeoForge artifact.

| Ticket | Outcome / in scope | Exact gate | Depends | Risk | Acceptance sketch | Rollback unit |
|---|---|---|---|---|---|---|
| `TKT-C2B-001` | authoritative Vigor ledger/HUD/recovery/mastery counters theo `VIG-*` | `DB-059`, `DB-046` | C1 + `TKT-C2S-002` Level query | `PR-2` | generated boundary table cho max/spend/delay/state, reload/max-change/anti-AFK | Vigor capability + HUD flag |
| `TKT-C2B-002` | Level-1 ground Dodge movement/collision/`VIG-DODGE-001`; defensive hit window deferred to C3 | `DB-005` movement subset approved | `TKT-C2-003`, `TKT-C2B-001` | `PR-2` | exact-spend edge/basis/collision/Climb-Air deny/lifecycle | ground-Dodge movement flag |
| `TKT-C2B-003` | Level-1 Free Climb attach/move/jump/mantle theo `VIG-CLIMB-*` across voxel profiles | `DB-049`, `DB-050` | C2 snapshot + `TKT-C2B-001` | `PR-3` | full/partial/thin/fluid/piston/input/correction/generated arithmetic boundaries | Free Climb flag |
| `TKT-C3-001` | one Minecraft HP truth + environmental mapping/HUD projection | `DB-042`, `DB-046` | C1 + `TKT-C2B-001` HUD primitive | `PR-3` | source/mitigation/death/reload/hunger/mode matrix | HP/damage pipeline flag |
| `TKT-C3-002` | Light Attack timeline/hit cadence and Dodge defensive-category integration | `DB-003`, `DB-005` | C2 snapshot + `TKT-C3-001` | `PR-2` | click/packet spam, cancel/window/category/same-hit ID | combat-action flag |
| `TKT-C3B-001` | Hạ Kình input/arrest/swept descent/fall conversion theo `GRD-WINDOW/ARREST/DESCENT/FALL-*` | `DB-051` physics/input subset | `TKT-C2B-003`, `TKT-C3-002` | `PR-2` | generated height boundaries, no tunnel, `VIG-GROUNDING-001`, hazard/duplicate/lifecycle | Grounding physics flag |
| `TKT-C3B-002` | Hạ Kình radius/target/occlusion/damage-stagger + weapon/unarmed presentation | `DB-051` full | `TKT-C3B-001` | `PR-2` | `GRD-RADIUS-001` samples/cap, ally/wall/target cap, no block grief, asset fallback/reduced motion | Grounding impact adapter |
| `TKT-C3B-003` | Level-10 Lightness charge→launch→apex→descent/Vigor/collision | `DB-052` | `TKT-C2-004`, `TKT-C2B-003`, `TKT-C3B-001` | `PR-3` | tap/hold/ceiling/wall/Vigor0/no-hover/no-midair reset/two-camera | Lightness flag |
| `TKT-C3B-004` | integrated aerial room + follower/world seam/perf/rollback snapshot | C3B proof plan approved | `TKT-C3B-001`…`TKT-C3B-003` | `PR-3` | Hạ Kình↔Lightness→landing/save/reload/feature toggles, `PERF-S09B` | whole C3B flags |

## Promotion gaps

Exact module boundaries, input mappings, Dodge defense/cancel, HP/damage matrix, Lightness curve/cost, Grounding damage/target cap, animation assets and benchmarks remain owner-gated. Locked values come only from `QLT-PARAMETERS`; ticket text must reference keys, not duplicate implementation constants when promoted.
