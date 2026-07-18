# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Chưa gameplay ticket nào `READY`. Candidate epics dưới đây chỉ mở sau exit artifacts tương ứng; không phải authorization code.

| Epic theo thứ tự | Slice | Design gate mở |
|---|---|---|
| Pin reproducible 26.2 toolchain + project shell/adapters | C1 | DB-019/021 approved |
| Stable IDs/content validation/config/capability flags | C1 | DB-021 approved |
| Save schema/migration/portable backup/restore fixtures | C1 | DB-021/024/038 approved |
| Authority/payload/ownership/diagnostics kernel | C1 | DB-022/023 approved |
| Integrated + dedicated + lifecycle/client screenshot harness | C1 | DB-022/024 approved |
| Việt/Anh resource skeleton + locale/key parity validation | C1 | DB-030 approved |
| Action registry/key baseline/conflict diagnostics + camera harness room | C2 | DB-029/002/004 approved |
| Camera rig/occlusion/aim + first-person parity | C2 | camera Feature Cells implementation-ready |
| Animation/render adapters + UI token/component baseline | C2 | DB-025/031/033 approved |
| Action/hit/light/Dodge/early-danger enemy slice | C3 | DB-003–006/034/035 implementation-ready |
| Quest Kernel + Gate/objective/typed reward instance slice | C4 | DB-036/007 implementation-ready |
| Arise/identity/one Shadow | C5 | DB-008–010 implementation-ready |
| Progression/build/skills | C6 | DB-011–012 implementation-ready |
| Command/squad/LOD | C7 | DB-013/018 + perf budget approved |
| Rich quest/world/economy/home return loop | C8 | DB-015–017/020/031/033 approved |

Mỗi epic được cắt thành ticket theo [Ticket Standard](04-ticket-standard.md), chạy [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md) và kết thúc bằng playable snapshot gate.
