# DOM-SHADOWS — Quân đoàn Hắc Ảnh

> **DRI:** Shadow Systems Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Narrative, AI, Combat, Progression, UX, Platform, Performance
> **Status:** `DISCOVERY`

## Mission

Biến kẻ địch đáng nhớ thành đồng đội lâu dài có danh tính, lịch sử và vai trò chiến thuật; sức mạnh quân đoàn phải thay đổi cách chơi chứ không chỉ tăng số entity.

## Invariants

- Shadow đã sở hữu không chết vĩnh viễn do một trận thua thông thường.
- Shadow không phải vật phẩm tiêu hao hoặc bản sao vô danh.
- Triệu hồi cơ bản không có mana upkeep theo thời gian.
- Mọi shadow có identity ổn định dù đang materialized, stored hay garrisoned.
- Quy mô hiển thị tuân thủ performance representation; fantasy “quân đoàn lớn” không đồng nghĩa mọi thành viên luôn là full AI entity.
- Capture, command, growth và social memory dùng chung một identity, không tạo bốn bản dữ liệu rời.

## System map

| System | Nội dung |
|---|---|
| Capture | corpse/Soul Echo, Arise attempt, eligibility, boss exception |
| Identity | tên, origin, personality, bond, memory, role, rank |
| Growth | XP, evolution, mastery, trait và giới hạn |
| Deployment | storage, summon, dismiss, shatter/revive, garrison |
| Command | formation, role, direct order, ping, autonomy |
| Society | relationship, banter, family/home presence, special shadow arcs |

## Feature order

Capture contract → identity/persistence → một shadow chiến đấu → summon/shatter/revive → command nhỏ → squad/formation → LOD legion → social/bond/content scale.
