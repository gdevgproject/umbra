# SYS-DATA — Definition, state, migration và recovery

> **DRI:** Data Architect
> **Status:** `DISCOVERY`

## Ba lớp dữ liệu

| Lớp | Ví dụ | Policy |
|---|---|---|
| Definition/config | enemy, shadow archetype, skill, item, room, Gate, quest | datapack/config, versioned, validate khi load |
| Persistent instance | player choices, Shadow identity, Gate/quest progress | world-owned server save, migration, transactional/idempotent |
| Derived/ephemeral | combat cache, UI view, AI score, hit window | rebuild được, không lưu như chân lý |

Schema cụ thể chỉ viết sau lifecycle. Mọi reference dùng stable ID và missing-definition fallback. Save có schema/content version, migration chain, pre-migration backup, recovery và invariant audit. Update không âm thầm reset irreversible choice.

Progression/world/quest/Shadow/item identity phải nằm trong world save hoặc player data thuộc world theo ownership contract; không giấu gameplay truth trong config/global cache. Preferences client như camera sensitivity/UI layout/keybind có thể ở profile/config, nhưng mất file đó không được làm mất tiến trình.

Content definitions kế thừa cần hỗ trợ: enemy, Shadow, skill, room/template, Gate, quest, item, faction, boss và parameter profile. Mỗi loại có validator, version và sample fixture trước content scale.

Portability/recovery contract nằm tại [Save ownership, backup và transfer](06-save-ownership-backup-and-transfer.md).
