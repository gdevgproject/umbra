# CTR-GATE-LIFECYCLE — Vòng đời Gate

> **DRI:** Dungeon Designer + Technical Designer
> **Status:** `DISCOVERY`

```text
ANNOUNCED → OPEN → OCCUPIED → OBJECTIVES_COMPLETE → EXIT_RESOLUTION → CLOSED
               ↘ deadline: BREAK_PENDING → BROKEN → CONTAINED/CLOSED
               ↘ invalid/load failure: SUSPENDED → RECOVERED/CANCELLED
```

## Luật chuyển trạng thái

- `ANNOUNCED`: world cue tồn tại, chưa cho enter.
- `OPEN`: instance đã reserve và entrance hợp lệ.
- `OCCUPIED`: ít nhất một participant đã vào; leave sớm không reset.
- `OBJECTIVES_COMPLETE`: objective bắt buộc hoàn tất, reward eligibility snapshot.
- `EXIT_RESOLUTION`: giải quyết người chơi, loot, corpse/Soul Echo và persistence.
- `BREAK_PENDING`: deadline hết nhưng còn actor trong dungeon; không xóa instance.
- `BROKEN`: threat tràn ra overworld theo event contract.
- `SUSPENDED`: lỗi kỹ thuật/compatibility; khóa mutation và cung cấp recovery.

Mỗi transition có guard, actor, timestamp, side effects idempotent và recovery. Save/reload ở bất kỳ state nào không duplicate reward, boss hoặc Break.

## Leave, death và reconnect

Rời sớm giữ nguyên tiến độ hợp lệ, deadline tiếp tục theo policy đã hiển thị. Death/reconnect phải đưa người chơi tới vị trí an toàn xác định và không tạo đường exploit reset encounter. Multiplayer ownership/late join vẫn là discovery riêng.

## Liên kết bắt buộc

Gate instance sở hữu objective state, participant set, generation seed, encounter IDs, reward claim, active corpse/echo và cleanup journal; entity chỉ giữ reference.
