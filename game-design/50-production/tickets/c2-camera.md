# C2 — Camera / Player Embodiment tickets

> **Pack state:** `BLOCKED_BY_DESIGN`
> **Shared non-goal:** combat hit/damage, skill runtime, final animation assets, third-person-only gameplay truth.

| Ticket | Outcome / in scope | Exact gate | Depends | Risk | Acceptance sketch | Rollback unit |
|---|---|---|---|---|---|---|
| `TKT-C2-001` | versioned Action Catalog, input contexts/remap/conflict diagnostics and vanilla-key parity | `DB-029`, `DB-002` | `TKT-C1-007`, `TKT-C1-008` | `PR-1` | context/remap/duplicate/locale/focus-loss fixtures | input adapter + catalog |
| `TKT-C2-002` | third-person rig, occlusion/collision and camera-room mine/place/interact parity | `DB-004` implementation-ready | `TKT-C2-001` | `PR-2` | tight room/wall/fluid/GUI-scale/low-FPS screenshots + ray parity | camera rig flag |
| `TKT-C2-003` | camera/target/aim-relative movement basis, facing/recenter/transition trace | `DB-048` | `TKT-C2-002` | `PR-2` | held input across orbit/±180°/mode transition never flips unexpectedly | movement/facing policy flag |
| `TKT-C2-004` | reticle/aim ray/soft-target shell, first-person transition/parity; no lock-on content | `DB-037` | `TKT-C2-002`, `TKT-C2-003` | `PR-2` | obstruction/parallax/reach/first-third switch; server never trusts camera hit | aim/target shell flag |
| `TKT-C2-005` | integrate C2 snapshot, settings/accessibility/locale/perf/rollback manifest | C2 proof plan approved | `TKT-C2-001`…`TKT-C2-004` | `PR-2` | new world→camera room→save/reload→toggle rollback, comfort Test Card after automation | whole C2 capability flag |

## Promotion gaps

Exact rig distances/curves, collision response, basis/target state machine, renderer hooks, settings schema, screenshot baselines, performance budget and files remain `OPEN` at stated DBs. Integration row may not absorb a failed owner ticket.
