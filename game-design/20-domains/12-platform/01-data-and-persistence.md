# SYS-DATA — Definition, state, migration và recovery

> **DRI:** Data Architect
> **Status:** `DISCOVERY`

## Ba lớp dữ liệu

| Lớp | Ví dụ | Policy |
|---|---|---|
| Definition/config | enemy, shadow archetype, skill, item, room, Gate, quest | datapack/config, versioned, validate khi load |
| Persistent instance | player choices, shadow identity, Gate/quest progress | server save, migration, transactional/idempotent |
| Derived/ephemeral | combat cache, UI view, AI score, hit window | rebuild được, không lưu như chân lý |

Schema cụ thể chỉ viết sau lifecycle. Mọi reference dùng stable ID và missing-definition fallback. Save có schema version, migration chain, backup/recovery và invariant audit. Update không được âm thầm reset irreversible choice.

Content definitions kế thừa cần hỗ trợ: enemy, shadow, skill, room/template, Gate, quest, item, faction, boss và parameter profile. Mỗi loại có validator và sample fixture trước content scale.
