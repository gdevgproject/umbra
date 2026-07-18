# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Chưa gameplay ticket nào `READY`. Candidate epics dưới đây chỉ mở sau exit artifacts tương ứng; không phải authorization code.

| Epic theo thứ tự | Slice | Design gate mở |
|---|---|---|
| Build/test project shell + adapters | C1 | DB-019/021 approved |
| Stable IDs/content validation/config/capability flags | C1 | DB-021 approved |
| Save schema/migration/backup/recovery fixtures | C1 | DB-021/024 approved |
| Authority/payload/ownership/diagnostics kernel | C1 | DB-022/023 approved |
| Integrated + dedicated + lifecycle GameTest harness | C1 | DB-022/024 approved |
| Input context + camera harness room | C2 | DB-002/004/019 approved |
| Camera rig/occlusion/aim + first-person parity | C2 | camera Feature Cells implementation-ready |
| Animation/render adapters + UI/localization baseline | C2 | DB-020/025 approved |
| Action/hit/light/Dodge/enemy slice | C3 | DB-003–006 implementation-ready |
| Gate/objective/instance slice | C4 | DB-007 implementation-ready |
| Arise/identity/one Shadow | C5 | DB-008–010 implementation-ready |
| Progression/build/skills | C6 | DB-011–012 implementation-ready |
| Command/squad/LOD | C7 | DB-013/018 + perf budget approved |
| Quest/world/economy/home return loop | C8 | DB-015–017/020 approved |

Mỗi epic được cắt thành ticket theo [Ticket Standard](04-ticket-standard.md), chạy [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md) và kết thúc bằng playable snapshot gate.
