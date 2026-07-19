## Outcome and authority

- Stable IDs / ticket:
- Player or technical outcome:
- Current lifecycle/readiness:
- Scope and non-goals:

## Change surface

- Authoritative owner/state/thread:
- Save/schema/migration:
- Minecraft/loader/adapter/patch:
- Input/render/backend:
- Performance risk (`PR-0`–`PR-3`):
- Direct consumers and rollback:

## Evidence

- Exact commands and results:
- Manifest/matrix targets:
- New or updated regression oracle:
- Diagnostics/known issues:

## Review checklist

- [ ] The Feature/Contract is ready for this change; the PR does not invent a player-visible rule.
- [ ] `main` remains compile/load/save/quit capable for the current baseline.
- [ ] Compatibility is claimed only for exact manifests tested here.
- [ ] No Fabric/NeoForge type escaped its adapter/patch boundary.
- [ ] Old-save backup/migration/downgrade refusal was tested or marked `N/A — reason`.
- [ ] Documentation, release projection, localization/accessibility, and performance evidence are synchronized where relevant.
- [ ] Unrelated user changes, secrets, personal saves, logs, and generated artifacts are absent.
