# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer + Producer
> **Status:** `ACTIVE`

`DB-*` đóng câu hỏi/contract trước code; nó không phải ticket implementation. Priority chỉ phá hòa giữa item cùng Ready; dependency mới có quyền chặn. Project Owner đã khóa Level-only, HP+Vigor, skill cadence/preview, traversal milestones, Hạ Kình baseline và NPC upper-tier quota/traits; DB tương ứng chỉ chứng minh/điền phần `OPEN`, không hỏi lại premise.

## Foundation → Camera + Skill Platform

| Priority | ID | Outcome cần đóng | Dependencies | Exit artifact |
|---:|---|---|---|---|
| 1 | `DB-019` | pin exact Minecraft/Fabric/Java/build/render/support baseline | `PROD-UMBRA`, `PD-013`, `PD-029`, `PD-043` | compatibility ADR + manifest |
| 2 | `DB-021` | modular-monolith rings, public surface, writer/thread/transaction/failure và fitness rules | `DB-019` | Foundation Architecture Contract + violation/causal proof |
| 3 | `DB-043` | Fabric-first/NeoForge-ready port/import/save/adapter boundary | `DB-019`, `DB-021` | portability ADR + conformance plan |
| 4 | `DB-022` | automated Test OS và `PR-0–PR-3` routing | `DB-019`, `DB-021`, `DB-043` | harness/evidence architecture |
| 5 | `DB-039` | hardware/settings/performance budgets/scenes/degradation | `DB-019`, `DB-021`, `DB-022` | performance constitution + manifest |
| 6 | `DB-023` | offline authority/security seams cho current + future multiplayer | `DB-021` | threat/authority contract |
| 7 | `DB-024` | persist/reset/copy policy qua lifecycle/mode | `DB-021`, `DB-023`, `DB-043` | State Ownership Matrix |
| 8 | `DB-040` | death/Creative/mode composition | `DB-024`, `DB-039` | Feature Cells + comparison plan |
| 9 | `DB-038` | backup/restore-as-copy/transfer/migration failure | `DB-019`, `DB-024`, `DB-043` | save portability + fixtures |
| 10 | `DB-030` | `vi_vn/en_us`, locale reload, font/key/placeholder pipeline | `DB-019`, `DB-021` | communication contract + tests |
| 11 | `DB-053` | action-RPG cohort quality rubric cho embodiment/mastery/triumph | `PD-040`, `PD-041`, `RES-AUDIENCE`, `DB-022` | cohort/research protocol |
| 12 | `DB-029` | vanilla key baseline + Action Catalog/context/conflict architecture | `DB-019`, `DB-022` | action catalog |
| 13 | `DB-031` | UI information architecture/tokens/components | `DB-030`, `PROD-UMBRA`, `MAP-SYSTEMS` | UI design system + prototype plan |
| 14 | `DB-004` | third-person rig/occlusion/build-mine parity | `DB-019`, `DB-021`, `DB-022`, `DB-029`, `DB-053` | Camera Feature Cells + prototype |
| 15 | `DB-048` | movement/facing basis và root-motion seam | `DB-004`, `DB-029` | movement/facing ADR + trace |
| 16 | `DB-025` | animation/render semantic marker/fallback seam | `DB-019`, `DB-004`, `DB-039`, `DB-043`, `DB-048` | adapter/marker contract |
| 17 | `DB-033` | asset registry/provenance/LOD/VFX/audio pipeline | `DB-019`, `DB-025`, `DB-031`, `DB-039` | asset pipeline + exemplar |
| 18 | `DB-035` | content definition/instance/validation/interactions | `DB-021`, `DB-022`, `DB-033` | content contract + exemplars |
| 19 | `DB-058` | Level-1/mỗi-5 grant ledger, full-future preview và loadout cap nào đạt transparency/input/UI/save | `PD-054`, `DB-029`, `DB-030`, `DB-031`, `DB-035` | `FEAT-SKILL-ACQUISITION` validation + preview/loadout prototype |
| 20 | `DB-012` | Skill Definition/effect boundary/validator/exemplar nào mở rộng mà không DSL vô hạn hoặc resource bar mới | `PD-052`, `DB-021`, `DB-022`, `DB-025`, `DB-035`, `DB-058` | Skill Platform contract + two-exemplar architecture proof |
| 21 | `DB-059` | chứng minh Vigor locked math/HUD/recovery/mastery ledger và anti-AFK/migration | `PD-052`, `PD-053`, `DB-024`, `DB-031`, `DB-039` | Vigor validation package; không mở lại cap/cost/regen |
| 22 | `DB-049` | traversal state/surface/ledge/authority/save/world/debug contract trên Vigor mới | `DB-021`, `DB-022`, `DB-024`, `DB-025`, `DB-029`, `DB-031`, `DB-039`, `DB-048`, `DB-059` | `CTR-TRAVERSAL` proof plan |
| 23 | `DB-050` | Free Climb geometry/input/leap/mantle/collision/two-view feel trên Level-1 baseline | `DB-004`, `DB-025`, `DB-029`, `DB-048`, `DB-049`, `DB-059` | Feature Cell + voxel validation |
| 24 | `DB-037` | aim/reticle/soft-target/lock/first-person transition | `DB-004`, `DB-048` | target validation package |
| 25 | `DB-002` | default layout/remap/precedence cho Dodge/Climb/Lightness/Hạ Kình/skills | `DB-029`, `DB-004`, `DB-037`, `DB-048`, `DB-049`, `DB-050`, `DB-058` | layout experiment + ADR |
| 26 | `DB-036` | Quest Kernel state/objective/reward-effect dependency | `DB-021`, `DB-024`, `DB-030`, `DB-035` | Quest Kernel contract |

## Gameplay và becoming

| Priority | ID | Outcome cần đóng | Dependencies | Exit artifact |
|---:|---|---|---|---|
| 27 | `DB-026` | discovery portfolio transformed-familiar + frontier novelty | `PD-042`, `DB-033`, `DB-035` | portfolio/exemplar matrix |
| 28 | `DB-042` | damage/defense/gear/counter/ruleset semantics không Primary Attribute/Posture meter | `PD-051`, `PD-052`, `DB-031`, `DB-035`, `DB-053` | Balance Constitution + prototype plan |
| 29 | `DB-046` | one HP substrate, environmental matrix, fixed HP/Vigor HUD và hunger compatibility | `PD-052`, `DB-021`, `DB-024`, `DB-031`, `DB-039`, `DB-042`, `DB-059` | vitals/damage-source/lifecycle prototype |
| 30 | `DB-003` | Light Attack cadence/cancel/buffer chống click/packet spam | `DB-002`, `DB-004`, `DB-025`, `DB-048`, `DB-053` | Feature Cell + hit matrix |
| 31 | `DB-005` | Dodge direction/collision/defensive category/cancel trên exact 18-Vigor baseline | `PD-053`, `DB-003`, `DB-037`, `DB-046`, `DB-048`, `DB-053`, `DB-059` | Dodge validation; không mở lại Level/cost/resource |
| 32 | `DB-051` | Hạ Kình input precedence, damage/stagger/weapon/target/occlusion/recovery trong locked fall/radius physics | `PD-055`, `DB-003`, `DB-025`, `DB-046`, `DB-049`, `DB-050` | Feature Cell + fall/AoE/block-safe proof |
| 33 | `DB-052` | Lightness input/charge/trajectory/Vigor/obstruction/combat ở Level 10 | `PD-055`, `DB-002`, `DB-025`, `DB-037`, `DB-048`, `DB-049`, `DB-050`, `DB-051`, `DB-059` | Feature Cell + anti-flight/feel proof |
| 34 | `DB-047` | Combat Flask charge/potency/refill/action/HUD | `DB-002`, `DB-003`, `DB-005`, `DB-031`, `DB-046` | Feature Cell + economy/usability proof |
| 35 | `DB-034` | player–zombie–world pressure giữ agency sau movement mới | `DB-003`, `DB-004`, `DB-005`, `DB-042`, `DB-046`, `DB-047`, `DB-050`, `DB-051`, `DB-052` | early-danger experiment |
| 36 | `DB-006` | enemy đầu dạy attack–dodge–escape–recover/vertical response | `DB-003`, `DB-005`, `DB-034`, `DB-035`, `DB-042`, `DB-047`, `DB-050`, `DB-051`, `DB-052`, `DB-053` | enemy dossier + Teaching Card |
| 37 | `DB-054` | Combat Craft grammar nối camera/action/skill/AI/readability qua mastery bands | `DB-003`, `DB-005`, `DB-006`, `DB-012`, `DB-033`, `DB-037`, `DB-042`, `DB-046`, `DB-053`, `DB-058` | paired combat + expression matrix |
| 38 | `DB-007` | Gate + Quest lifecycle qua leave/death/reconnect/recovery | `DB-023`, `DB-024`, `DB-036`, `DB-040` | activity vertical contract |
| 39 | `DB-056` | reward→EXP/Level/skill milestone→return record, không Rank | `PD-051`, `PD-054`, `DB-007`, `DB-031`, `DB-036`, `DB-058` | Becoming Spine Feature Cells + migration proof |
| 40 | `DB-008` | Arise eligibility/attempt/condition/echo/ownership không Mana/Rank | `DB-007`, `DB-042`, `DB-046`, `DB-056` | Capture Feature Cell + ADR |
| 41 | `DB-009` | Shadow identity tối thiểu tạo gắn kết | `DB-008`, `DB-021`, `DB-024`, `DB-035` | state + content exemplar |
| 42 | `DB-010` | summon/shatter/revive cân bằng bằng cooldown/charge/condition nào, không Mana upkeep | `PD-052`, `DB-008`, `DB-009`, `DB-042`, `DB-046` | resource-free action experiment |
| 43 | `DB-044` | roster 1→8 milestone/full-roster/rotation/home breadth | `DB-008`, `DB-009`, `DB-010`, `DB-031`, `DB-042` | Retinue capacity/usability/save proof |
| 44 | `DB-011` | skill/gear/Retinue/capability mastery tạo build/migration thế nào, không attrs/Potential/Prestige | `PD-051`, `DB-012`, `DB-042`, `DB-046`, `DB-050`, `DB-052`, `DB-054`, `DB-058`, `DB-059` | build expression + migration rules |

## Retinue, NPC society và full loop

| Priority | ID | Outcome cần đóng | Dependencies | Exit artifact |
|---:|---|---|---|---|
| 45 | `DB-013` | command UX cho tối đa 4 active/roster 8 | `DB-002`, `DB-037`, `DB-044`, `DB-049`, `DB-050`, `DB-052` | usability proof |
| 46 | `DB-045` | Shadow expression/ritual arbitration không spam/cắt combat | `DB-009`, `DB-013`, `DB-025`, `DB-033`, `DB-044` | semantic registry + playtest |
| 47 | `DB-055` | boss lesson/moveset/AI/phase/difficulty/retry/camera/animation-hit framework | `DB-003`, `DB-005`, `DB-006`, `DB-007`, `DB-033`, `DB-035`, `DB-037`, `DB-042`, `DB-046`, `DB-053`, `DB-054` | boss framework + validation plan |
| 48 | `DB-014` | Iron Knight teaching/Arise beat | `DB-008`, `DB-055` | Boss Card + playtest |
| 49 | `DB-016` | currency/shop/item/Flask source–sink | `DB-007`, `DB-035`, `DB-036`, `DB-047` | economy simulation |
| 50 | `DB-060` | Village Hub identity/residency/merge-split, strict Level power curve, upper quota và lower distribution | `PD-056`, `DB-021`, `DB-024`, `DB-035`, `DB-039`, `DB-042` | density/power Feature validation + hub fixtures |
| 51 | `DB-061` | Level personality incidence, Bully/Guardian/flee thresholds/action/LOD | `PD-057`, `DB-003`, `DB-006`, `DB-025`, `DB-035`, `DB-039`, `DB-046`, `DB-060` | trait Feature validation + nonlethal/rescue/flee proof |
| 52 | `DB-041` | society identity/ledger→hub→relationship→settlement→faction staging | `DB-024`, `DB-035`, `DB-036`, `DB-039`, `DB-060`, `DB-061` | living-society contract + hub plan |
| 53 | `DB-015` | rich quest branch/recovery/reward/world-effect vertical | `DB-007`, `DB-016`, `DB-031`, `DB-041` | quest dossier + proof |
| 54 | `DB-017` | home/family/hub in first returning-world loop | `DB-015`, `DB-041`, `C8-RETURNING-WORLD` | playable return brief |
| 55 | `DB-018` | Retinue/hostile/hub composition tiers cho `PERF-S01/S02A/B` | `DB-006`, `DB-013`, `DB-035`, `DB-039`, `DB-044`, `DB-045`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-055`, `DB-060`, `DB-061` | benchmark results |
| 56 | `DB-020` | accessibility/onboarding baseline cho core mechanics | `MAP-SYSTEMS`, `DB-030`, `DB-031`, `DB-046`, `DB-047`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-053`, `DB-058`, `DB-061` | communication/onboarding contract |
| 57 | `DB-057` | future Aerial Step/Aerial Dodge chain/use/Vigor/collision/defense/cancel | `PD-047`, `PD-052`, `DB-002`, `DB-005`, `DB-012`, `DB-025`, `DB-037`, `DB-048`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-054` | paired Feature Cells + anti-loop proof |

## Product/future framed

| ID | State | Boundary |
|---|---|---|
| `DB-001` | `DECIDED` | full coherent all-in-one product; no fixed-count shortcut |
| `DB-027` | `DISCOVERY` | future first-party world/building/mount/vehicle graph |
| `DB-028` | `FRAMED` | co-op 2–4 → PvP 1v1/3v3 → ranking/event; current only seams |

## Critical paths

```text
Foundation: DB-019 → DB-021 → {DB-043,DB-022,DB-023} → {DB-024,DB-039,DB-038}
Camera: DB-029 → DB-004 → DB-048 → {DB-025,DB-037}
Skills: DB-033 → DB-035 → DB-058 → DB-012
Movement: DB-059 → DB-049 → DB-050 → {DB-005,DB-051} → DB-052
Combat: {DB-042,DB-046,DB-003,DB-012} → {DB-005,DB-051} → DB-054
Activity: DB-036 → DB-007 → DB-056 → DB-008
Society: DB-060 → DB-061 → DB-041 → {DB-015,DB-017}
```

DB integrator không được copy nguyên thành ticket. Draft `TKT-*` có thể tồn tại trước gate để chia rollback/evidence unit, nhưng chỉ chuyển `READY` sau exact Feature/Contract/Parameter output ở đây đạt lifecycle và mandatory ticket fields.
