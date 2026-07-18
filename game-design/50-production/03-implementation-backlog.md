# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Hiện chưa có gameplay ticket `READY`. Đây là kết quả đúng: corpus đã có tham vọng và candidate, chưa có đủ Feature Cell qua validation.

## Candidate epics theo thứ tự

| Epic | Slice | Chỉ được mở khi |
|---|---|---|
| Platform shell/data/migration/observability | C1 | compatibility + data/authority contracts approved |
| Input/action/hit/arena harness | C2 | DB-002–004 approved |
| Light attack/Dodge/enemy teaching slice | C2 | DB-003–006 `IMPLEMENTATION_READY` |
| Gate/objective/instance vertical slice | C3 | DB-007 approved + state tests specified |
| Arise/identity/one shadow | C4 | DB-008–010 approved |
| Progression/build/skills | C5 | DB-011–012 approved |
| Command/squad/LOD | C6 | DB-013 + perf budget approved |
| Quest/world/economy return loop | C7 | DB-015–017 approved |

Khi một epic mở, nó được chia thành ticket theo [Ticket Standard](04-ticket-standard.md). Không copy danh sách ticket lịch sử vì tên cụ thể không biến design chưa khóa thành việc an toàn.
