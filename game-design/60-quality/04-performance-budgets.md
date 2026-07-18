# QLT-PERFORMANCE — Ngân sách và chiến lược hiệu năng

> **DRI:** Performance Lead
> **Status:** `DISCOVERY`

## Target scene hypothesis

Fantasy cần cảnh player + khoảng 40 shadow materialized + 80 hostile actors có thể quan sát. Đây là stress target, không là lời hứa full AI/animation cho 120 entity. Scene có representation tiers và benchmark hardware/server profile được khóa theo release.

## Server tick budget candidate

| Nhóm | Budget/tick |
|---|---:|
| AI/perception/path decisions | ≤ 8 ms |
| Shadow command/representation | ≤ 2 ms |
| Dungeon/Gate work | ≤ 2 ms |
| Mỗi system khác | ≤ 1 ms hoặc khai budget riêng |

Tổng phải nằm trong 50 ms tick cùng vanilla/headroom; các budget trên chưa approved cho tới benchmark.

## Chiến lược

LOD theo relevance, staggered sensing/decision cadence, spatial index, path reservation/cache, aggregate far simulation, entity/particle/audio caps, async generation chỉ với dữ liệu thread-safe, work queue/backpressure và load shedding có thứ tự. Không “async hóa” mutation world/server state.

## Gates

Mỗi Feature Cell khai steady/spike allocation, tick work, network, save size và worst-case cardinality. Content instance khai actor/VFX/audio/room budget. Benchmark có median/p95/p99, không chỉ average.
