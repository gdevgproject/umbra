# UMBRA: Shadow Monarch

> An original, large-scale Minecraft Java Edition gameplay-overhaul mod built for Fabric.

UMBRA turns Minecraft Survival into a progression-driven dark-fantasy adventure. Players awaken, explore Gates and dungeons, build a living Shadow Legion, master a flexible combat system, and shape a world with persistent consequences—while preserving the sandbox, building, exploration, and creativity that make Minecraft distinctive.

## Project status

The repository is currently in the **pre-production / design foundation** phase. The game-design corpus is being consolidated before implementation begins. No playable mod build is available yet.

| Area | Current target |
|---|---|
| Platform | Minecraft Java Edition; release baseline chưa khóa |
| Mod loader | Fabric candidate; cần compatibility proof |
| Development baseline | Java / Gradle / data-driven content candidate |
| Current milestone | Design-system rebuild / discovery |

Version support, loader/API versions, Java requirements, dependencies, and save migration guarantees will be published with each release. Compatibility with older Minecraft versions is not assumed.

## Core pillars

- **Power:** rise from an unknown survivor to the Shadow Monarch.
- **Attachment:** shadows are a persistent legion and trusted companions.
- **Discovery:** every Gate, dungeon, boss, and parallel world reveals something new.
- **Mastery:** combat, builds, AI, economy, and progression reward deliberate play.
- **Rootedness:** a home, family, and living society give the journey meaning.

## Repository layout

| Path | Purpose |
|---|---|
| [`game-design/`](game-design/) | Modular studio design system and canonical design work |
| [`game-design/design-assets/`](game-design/design-assets/) | Design-reference diagrams and concept visuals |
| [`.gitignore`](.gitignore) | Fabric, Gradle, IDE, runtime, and secret-file exclusions |

Start with [`game-design/README.md`](game-design/README.md). There is one canonical document tree; superseded text is kept by Git history, not a parallel legacy library.

## Design principles

UMBRA is an original work. References to other games, novels, or films are used for design research only; their names, characters, assets, storylines, and distinctive movesets are not reused. New content must pass the project's reference-and-integration review before entering production.

Performance is a feature: large shadow armies, intelligent enemies, and stable frame/tick performance are treated as first-class requirements. Systems are designed to be data-driven, testable, and compatible with the Fabric ecosystem.

## Development

Gameplay implementation is gated per Feature Cell. A legacy ticket or formula is not sufficient authorization to code; see [`AGENTS.md`](AGENTS.md) and the design lifecycle.

## License

License terms will be published before public distribution. All rights reserved until then.
