# DOM-DUNGEONS — Gate, Dungeon và không gian thử thách

> **DRI:** Dungeon Designer
> **Approver:** Lead Game Designer
> **Reviewers:** World, Encounter, Narrative, Platform, Performance, QA
> **Status:** `DISCOVERY`

Dungeon biến khám phá Minecraft thành một lời hứa có rủi ro, mục tiêu và hậu quả rõ. Procedural generation dùng grammar authored; không lấy random room thay cho pacing.

## Invariants

- Gate là world object có lifecycle bền vững, không chỉ portal mở menu.
- Dungeon chưa hoàn thành không âm thầm biến mất khi người chơi rời đi.
- Gate chỉ đóng sau khi objective bắt buộc hoàn tất và flow thoát được resolve.
- Deadline hết khi còn người trong dungeon chuyển sang `BREAK_PENDING`, không cleanup dưới chân người chơi.
- Generation cùng seed/config cho kết quả kiểm tra được; invalid layout fail an toàn.
- Mọi objective, corpse/echo, boss và reward đều móc vào cùng instance ID.

## Tài liệu

1. [Gate lifecycle](01-gate-lifecycle.md)
2. [Dungeon catalog và generation](02-catalog-objectives-and-generation.md)
3. [Dungeon Break, Tower và Strata](03-break-tower-and-strata.md)
