# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi ticket triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Đây là backlog implementation thật, không phải design queue. Ticket `DRAFT/BLOCKED_BY_DESIGN` chia outcome/rollback/evidence unit để dự án không mất phương hướng; nó **không** cho phép code. Chỉ `READY` sau Feature/Contract/Parameter gate và mandatory ticket audit mới được Ticket Autopilot chọn.

## Thứ tự phase và ticket packs

| Order | Phase | Ticket pack | Snapshot |
|---:|---|---|---|
| 1 | `C1-FOUNDATION-KERNEL` | [TKT-C1-001…008](tickets/c1-foundation.md) | Fabric shell + stable kernel/save/test/locale |
| 2A | `C2-PLAYER-EMBODIMENT` | [TKT-C2-001…005](tickets/c2-camera.md) | Camera mod-equivalent snapshot |
| 2B | `C2S-SKILL-PLATFORM` | [TKT-C2S-001…006](tickets/c2s-skills.md) | Skill Library/grant/equip sandbox snapshot |
| 3 | `C2B/C3/C3B` | [Vigor, Dodge, Climb, combat seam, Hạ Kình, Lightness](tickets/c2b-c3b-movement.md) | movement/action/aerial snapshots |
| 4 | `C8-RETURNING-WORLD` | [Village Hub/NPC traits](tickets/c8-npc-society.md) | living-hub snapshot |

`C2` và `C2S` có thể song song sau C1 khi gates riêng xanh. C2B chỉ bắt đầu từ public surfaces đã chứng minh của hai train; không import internals. C4–C7/C9–C10 giữ epic-level planning tại Roadmap cho tới khi near-term proof làm rõ decomposition; không tạo hàng trăm draft ticket giả chính xác.

## Current selection

```text
READY tickets: 0
NEXT_ELIGIBLE: NONE
first blocking gate: DB-019 exact baseline
then: DB-021 kernel contract
```

Draft ticket không có `design_baseline_commit`, exact file/module map, full acceptance oracle hoặc approval; các field này được điền trong chính artifact khi promote, không copy row sang ticket mới.

## Decomposition invariants

- một authoritative writer/lifecycle + một rollback/evidence story mỗi ticket;
- schema, adapter, UI projection và gameplay rule tách khi có gate/risk/rollback độc lập;
- integration ticket chỉ nối public surfaces đã xanh, không phát minh rule;
- `PR-*`, save/migration, loader boundary, accessibility/localization và Minecraft lifecycle không được bỏ chỉ vì ticket đang `DRAFT`;
- NeoForge adapter/artifact chưa là ticket current; C1 chỉ khóa common boundary/Fabric conformance.
