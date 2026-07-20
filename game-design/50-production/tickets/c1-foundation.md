# C1 — Foundation Kernel tickets

> **Pack state:** `BLOCKED_BY_DESIGN`
> **Shared non-goal:** gameplay/camera/skill/AI rule; NeoForge artifact; abstraction không có consumer.

| Ticket | Outcome / in scope | Exact gate | Depends | Risk | Acceptance sketch | Rollback unit |
|---|---|---|---|---|---|---|
| `TKT-C1-001` | materialize exact pinned baseline manifest, dependency verification và reproducible toolchain contract | `DB-019` approved | none | `PR-1` | clean clone/build metadata/version mismatch fails clearly | manifest/toolchain diff |
| `TKT-C1-002` | Fabric project shell, integrated + dedicated launch, artifact/CI smoke | `DB-019` | `TKT-C1-001` | `PR-2` | build/run/quit on both server modes; no gameplay content | shell/build files |
| `TKT-C1-003` | physical modules/source sets + forbidden-import/cycle/internal-access fitness fixtures | `DB-021`, `DB-043` | `TKT-C1-002` | `PR-2` | positive architecture report + intentional violation failures | module/rule set |
| `TKT-C1-004` | stable-ID registry, capability manifest và feature-flag lifecycle | `DB-021`, `DB-035` | `TKT-C1-003` | `PR-2` | duplicate/missing dependency/disable/reload fixtures | registry/manifest capability |
| `TKT-C1-005` | logical-server command/query/event, operation/causation, clock và typed failure primitives | `DB-021`, `DB-023` | `TKT-C1-003`, `TKT-C1-004` | `PR-2` | one happy + reject + duplicate causal vertical; no listener-order rule | authority primitive module |
| `TKT-C1-006` | save envelope, schema/migration journal, backup manifest và restore-as-copy fixture | `DB-024`, `DB-038`, `DB-043` | `TKT-C1-004`, `TKT-C1-005` | `PR-3` | save/reload/corrupt/migrate/restore fixture; canonical loader-neutral data | persistence capability |
| `TKT-C1-007` | diagnostic export, architecture/test harness, lifecycle fault injection và perf control scene | `DB-022`, `DB-039` | `TKT-C1-005`, `TKT-C1-006` | `PR-2` | causal trace + test manifest + unload/duplicate/queue failure oracles | diagnostics/harness |
| `TKT-C1-008` | `vi_vn/en_us` resource skeleton, runtime locale reload và placeholder/key parity validator | `DB-030` | `TKT-C1-002`, `TKT-C1-004` | `PR-1` | locale swap/missing key/font fallback on integrated/dedicated client paths | localization resources |

## Promotion gaps chung

Exact modules/files/public surfaces, baseline commands/results, save keys, lifecycle IDs, before-state, full Change Surface, performance budget, branch policy và `design_baseline_commit` đều `OPEN — respective DB gate`. Không row nào được chuyển `READY` theo mô tả table một mình.
