# SYS-MULTIPLAYER-READINESS — Offline-first, future multiplayer và security seams

> **DRI:** Technical Director + Security Reviewer
> **Status:** `DISCOVERY`

## Scope hiện tại

UMBRA chỉ thiết kế/triển khai single-player offline. Tài liệu này ngăn foundation tự khóa vào single-player-only; nó không tạo lobby, party, co-op, PvP, matchmaking hoặc server economy.

## Invariants ngay từ foundation

- Integrated single-player và dedicated server đi cùng logical-server gameplay path.
- Client chỉ gửi intent; server kiểm actor ownership, permission, state, distance/line-of-sight, resource, cooldown, target và rate.
- Không dùng local player/global singleton làm owner của Gate, quest, Shadow, loot hoặc world effect.
- Persistent identity dùng stable player/world/instance IDs; display name không là key.
- Command/reward/world mutation có idempotency key và audit reason.
- Packet/payload có codec/version, size/range cap, unknown-data handling và rate limit policy.
- Sync theo tracking/relevance; không broadcast toàn roster/world state vô điều kiện.
- Client thiếu/malicious data không crash server hoặc tạo item/damage/reward.
- Feature capability negotiation/fallback được thiết kế khi có consumer thật.

## Ownership questions phải khai dù offline

Mỗi feature trả lời: actor owner; world/instance owner; reward claimant; authority khi owner offline/dead/disconnected; shared vs private visibility; transfer/abandon rule; conflict resolution. Offline mặc định một người không phải lý do bỏ các trường này.

## Security threat seeds cho tương lai

Packet spam/replay, impossible target/range, forged item/component, duplicate reward, command escalation, oversized payload, stale version, entity ID reuse, chunk-unload race và save tampering. Chỉ cần foundation hooks/log/rejection; full anti-cheat/PvP balance chờ multiplayer discovery.

## Điều bị cấm

- Không implement speculative netcode cho feature chưa có.
- Không thêm abstraction chỉ vì “có thể cần” nếu chưa chỉ ra irreversible blocker.
- Không dùng server-authoritative làm lý do khiến local input/camera chậm; prediction/reconciliation được thiết kế theo feature.
- Không tuyên bố multiplayer-ready nếu dedicated smoke, reconnect và ownership tests chưa có.
