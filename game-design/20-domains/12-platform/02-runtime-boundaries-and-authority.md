# SYS-RUNTIME — Boundary, event và authority

> **DRI:** Technical Director
> **Status:** `DISCOVERY`

Các bounded capabilities dự kiến: Player Progression, Combat Action/Hit, Skills, Shadows, Actor AI, Gate/Dungeon, Quest/Narrative, Items/Economy, World, Presentation adapter và Platform services. Chúng giao tiếp bằng command/query/event có owner; không đọc chéo database/object graph tùy tiện.

Event là sự kiện đã xảy ra, không là RPC ngụy trang. Command có intent/idempotency/authorization. Tick scheduler phân ngân sách và cadence; heavy generation/pathfinding/simulation có work queue và backpressure.

Dimension/instance pool quản lý allocation, reservation, load, cleanup và crash recovery. Observability cung cấp state inspector, event trace, content validation, seed reproduction, performance labels và safe admin recovery.
