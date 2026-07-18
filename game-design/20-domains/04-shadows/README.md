# DOM-SHADOWS — Hắc Ảnh Cận Vệ

> **DRI:** Shadow Systems Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Narrative, AI, Combat, Progression, UX, Platform, Performance
> **Status:** `DISCOVERY`

## Mission

Biến một số ít kẻ địch đáng nhớ thành đồng đội lâu dài có danh tính, lịch sử, quan hệ và vai trò chiến thuật; quyền lực của Chúa Tể nằm ở chất lượng kết ước và phối hợp, không ở việc chất entity thành quân số.

## Invariants

- Shadow đã sở hữu không chết vĩnh viễn do một trận thua thông thường.
- Shadow không phải vật phẩm tiêu hao hoặc bản sao vô danh.
- Triệu hồi cơ bản không có mana upkeep theo thời gian.
- Mọi Shadow có identity ổn định dù đang dự bị, materialized, Tán Vỡ hay hiện diện tại nhà.
- Sức chứa tuân thủ [`CTR-SHADOW-RETINUE`](../../30-shared-contracts/07-shadow-retinue-capacity-and-membership.md): mở từ một tới tối đa năm thành viên, tối đa bốn triển khai chiến đấu.
- Không có kho phụ/quân đoàn ẩn; giới hạn nhỏ phải được dùng để đầu tư AI, animation, quan hệ và command sâu hơn cho từng cá thể.
- Capture, command, growth và social memory dùng chung một identity, không tạo bốn bản dữ liệu rời.

## System map

| System | Nội dung |
|---|---|
| Capture | corpse/Soul Echo, Arise attempt, eligibility, boss exception |
| Identity | tên, origin, personality, bond, memory, role, rank |
| Growth | XP, evolution, mastery, trait và giới hạn |
| Membership | slot 1→5, full-roster claim, reserve, parting |
| Deployment | summon, dismiss, shatter/revive, active party 4, home assignment |
| Command | formation, role, direct order, ping, autonomy |
| Society | relationship, ritual expression, banter, family/home presence, special shadow arcs |

## Feature order

Capture contract → identity/persistence → một Shadow chiến đấu → summon/shatter/revive → sức chứa/reserve → command nhỏ → đội hình bốn thành viên → social/ritual/bond/content depth.
