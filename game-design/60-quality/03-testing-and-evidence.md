# QLT-TEST — Chiến lược kiểm thử và evidence

> **DRI:** QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Test pyramid theo design

- **Static:** Markdown links/status, content schema/ref/budget, localization, asset license.
- **Unit/model:** formula, state transition, idempotency, modifier stacking, deterministic seed.
- **Integration:** action→hit→damage, Gate→objective→exit, Arise→identity, quest→world effect, save migration.
- **Simulation:** economy, progression, TTK/PB, build profiles, legion capacity, dungeon generation.
- **Bot/scenario:** reconnect, spam packet, unload/reload, pathing/LOD, long-run save.
- **Human playtest:** feel/readability/learning/attachment/accessibility; không thể thay bằng test tự động.
- **Compatibility/performance:** dedicated server, client modes, mod/shader matrix, benchmark scenes.

## Evidence record

Mọi gate ghi hypothesis, build/content version, cohort/profile, setup/seed, metric + observation, result, limitation và decision link. “Đã test” không hợp lệ nếu không có oracle và artifact.

## Regression invariants

1. Gate chỉ `CLOSED` sau full objective + valid exit.
2. Leave/save/reload giữ Gate/objective/enemy/Soul Echo hợp lệ và không duplicate reward.
3. Mana cạn không tự xóa shadow đang sống; không có upkeep.
4. Potential có preview và persistence; attribute respec theo luật.
5. Strata không ghi đè block/state World Gốc.
6. Không reward độc quyền do calendar/streak.
7. Một action/hit/Arise/reward retry không commit hai lần.

## Feature test matrix

Mỗi Feature Cell có happy path, boundary, invalid state, interruption, save/reload, latency/retry, first/third camera, accessibility cue, performance stress và backward compatibility khi liên quan.
