# UMBRA: Shadow Monarch

> An original, large-scale Minecraft Java Edition gameplay-overhaul mod. Fabric is the current target; NeoForge is a required future target after its own parity gate.

UMBRA turns Minecraft Survival into a progression-driven dark-fantasy adventure. Players awaken, explore Gates and dungeons, build an elite Shadow Retinue with persistent identities, master a flexible combat system, and shape a world with lasting consequences—while preserving the sandbox, building, exploration, and creativity that make Minecraft distinctive.

## Project status

The repository is currently in the **pre-production / design foundation** phase. The canonical design system is consolidated and is being refined through Product Director feedback. No playable mod build is available yet.

| Area | Current truth |
|---|---|
| Minecraft | Java Edition `26.2` development baseline |
| Loader | Fabric primary; NeoForge required in the future but **not supported yet** |
| Java | `25` discovery baseline; exact release manifest is owned by `DB-019` |
| Public build | None — the repository is still in Design Discovery |

## Version support

| Minecraft line | Loader | UMBRA status | Download |
|---|---|---|---|
| `26.2` | Fabric | `DEVELOPMENT_BASELINE` — current focus, not a public compatibility claim | No release yet |
| `26.3` snapshots | None | `UPSTREAM_PREVIEW` — research/diff only; do not use an UMBRA world | No artifact |
| `26.2` | NeoForge | `REQUIRED_FUTURE / NOT_SUPPORTED` | No artifact |

UMBRA supports exact `Minecraft × loader × Java × UMBRA schema/content` manifests, never a broad version range inferred from a file name. When a future Minecraft line passes the port and release gates, the previous line receives a final immutable release, remains downloadable, and is clearly marked end-of-life instead of silently disappearing. The canonical lifecycle and branch/release rules live in [`SYS-COMPAT`](game-design/20-domains/12-platform/03-compatibility-and-release-baseline.md).

## Emotional promise

The north star is **self-authored becoming**: the player remembers being vulnerable, understands how they became powerful, and sees their choices persist in the world. Supporting promises include ascendance, agency, embodiment, mastery, triumph, attachment, discovery, consequence, and belonging.

## Repository layout

| Path | Purpose |
|---|---|
| [`game-design/`](game-design/) | Modular studio design system and canonical design work |
| [`game-design/design-assets/`](game-design/design-assets/) | Design-reference diagrams and concept visuals |
| [`.gitignore`](.gitignore) | Fabric, Gradle, IDE, runtime, and secret-file exclusions |

Start with [`game-design/README.md`](game-design/README.md). There is one canonical document tree; superseded text is kept by Git history, not a parallel legacy library.

## Design principles

UMBRA is an original work. References to other games, novels, or films are used for design research only; their names, characters, assets, storylines, and distinctive movesets are not reused. New content must pass the project's reference-and-integration review before entering production.

Performance is a feature: a bounded elite Retinue, intelligent enemies, and stable frame/tick performance are treated as first-class requirements. Systems are designed to be data-driven, testable, and compatible with the verified Fabric baseline without leaking loader semantics into gameplay or saves.

## Development

Gameplay implementation is gated per Feature Cell. A detailed candidate or formula is not sufficient authorization to code. Mainline development must remain playable per completed capability; see [`AGENTS.md`](AGENTS.md) and the design lifecycle.

## License

License terms will be published before public distribution. All rights reserved until then.
