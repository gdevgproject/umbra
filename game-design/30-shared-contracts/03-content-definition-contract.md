# CTR-CONTENT-DEFINITION — Definition và instance

> **DRI:** Technical Designer + Content Lead
> **Status:** `DISCOVERY`

Mọi content definition có stable ID, schema version, display/localization refs, tags, dependency refs, owner, validation constraints và lifecycle status. Runtime instance chỉ lưu state thay đổi và definition version/reference.

Validator phải phát hiện duplicate ID, missing ref, cycle cấm, invalid enum/range, unavailable asset/localization, budget vượt và incompatible version. Missing content khi load save dùng placeholder/recovery; không crash hoặc xóa dữ liệu không báo.

Áp dụng cho faction, enemy, shadow archetype, skill, item, room, Gate type, quest, boss, loot, dialogue và parameter profile.
