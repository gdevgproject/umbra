# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Chưa gameplay ticket nào `READY`. Candidate epics dưới đây chỉ mở sau exit artifacts tương ứng; không phải authorization code.

| Epic theo thứ tự | Slice | Design gate mở |
|---|---|---|
| Pin reproducible Fabric 26.2 toolchain + project shell; bounded capability/layer/public-surface fitness rules, common/loader dependency guard + Fabric adapter conformance | C1 | DB-019/021/043 approved |
| Stable IDs/content validation/config/capability flags | C1 | DB-021 approved |
| Save schema/migration/portable backup/restore fixtures | C1 | DB-021/024/038 approved |
| Authority/payload/ownership/typed failure + causal trace/inspector/recovery diagnostics kernel | C1 | DB-021/022/023 approved |
| Integrated + dedicated + lifecycle/client screenshot/performance-risk harness | C1 | DB-022/024/039 approved |
| Việt/Anh resource skeleton + locale/key parity validation | C1 | DB-030 approved |
| Action registry/key baseline/conflict diagnostics + camera harness room | C2 | DB-029/002/004 approved |
| Camera rig/occlusion + camera-relative movement/facing/aim + first-person parity | C2 | DB-004/048/037 Feature Cells implementation-ready |
| Animation/render adapters + UI token/component/fixed-width meter primitives | C2 | DB-025/031/033 approved |
| Traversal state/surface/Vigor + Free Climb/mantle + voxel room/debug overlay | C2B | DB-049/050 implementation-ready |
| Authoritative health/environment adapter + Mana/Focus transactions | C3 | DB-042/046 implementation-ready |
| Action/hit/light/Dodge/one-charge Combat Flask/early-danger enemy slice | C3 | DB-003–006/034/035/047/053/054 implementation-ready |
| Grounding Strike + Lightness launch/apex/descent + vertical enemy/follower seams | C3B | DB-051/052 implementation-ready; DB-049/050 proof green |
| Quest Kernel + Gate/objective/typed reward instance slice | C4 | DB-036/007 implementation-ready |
| Arise/identity/one Shadow + first bonded slot | C5 | DB-008–010 implementation-ready; `CTR-SHADOW-RETINUE` approved cho identity/membership baseline |
| Progression/build/skills + bounded vitals/Flask upgrades | C6 | DB-011–012/046/047 implementation-ready |
| Slot 2→8/full-roster claim/reserve rotation/home + command/Retinue AI/expression | C7 | DB-013/018/044/045 + perf/balance budget approved |
| Rich quest/world/economy/home return loop | C8 | DB-015–017/020/031/033 approved |
| Gate boss teaching vertical: move kit/AI pattern/phase/camera–target/animation–hit/audio-VFX/difficulty–assist/retry/reward | C9 | DB-055 + boss-specific Teaching Card (Iron Knight: DB-014) implementation-ready |

Mỗi epic được cắt thành ticket theo [Ticket Standard](04-ticket-standard.md), chạy [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md) và kết thúc bằng playable snapshot gate.

NeoForge adapter/artifact **không** nằm trong current implementation backlog. Nó chỉ được mở sau `DB-043` và rollout gate `L1`, trên matching Minecraft baseline, bằng portability spike riêng; không sửa domain rule để vượt port.
