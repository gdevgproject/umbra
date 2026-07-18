# SYS-PLAYER-BUILD — Attributes, Specialization, Potential và Mastery

> **Status:** `DISCOVERY`

## Trạng thái discovery

Toàn bộ topology và con số dưới đây là hypothesis kế thừa, chưa là luật. [Tuyến review thuộc tính và cân bằng](03-attribute-and-balance-review-guide.md) là cửa vào cho vòng quyết định `DB-042`; Parameter Registry không được nâng các candidate này trước evidence.

## Năm attributes candidate

| Attribute | Combat | Minecraft integration |
|---|---|---|
| STR | melee/posture | mining speed có cap |
| AGI | attack/movement/action timing | swim/climb/fall mitigation |
| VIT | HP/recovery/status | hunger/poison resistance |
| INT | Mana/skill/legion capacity | enchanting efficiency |
| PER | crit/threat/weakness/stealth | ore hint/trade information |

Secondary resistances (poison, bleed, cold, fire, control) đến từ VIT/gear/Potential, không tạo thêm năm primary stats.

## Allocation decision

Canonical candidate hiện tại: **5 điểm tự phân bổ mỗi level, không auto +1**. Lý do cũ viện dẫn hybrid `auto + free` là mô tả nguồn tham chiếu và bị loại vì mâu thuẫn. Tuy nhiên option auto baseline vẫn cần so sánh qua balance prototype trước Approved.

- Soft cap candidate 100 effective points; hard caps cho crit/speed/i-frame/resist.
- Attribute respec mở sau Job Change, trả Tinh Hoa và có cooldown theo game-time candidate.
- UI preview ảnh hưởng tức thời, cap, milestone và locked future use.

## Talent và Specialization

Talent đầu game candidate: Kẻ Sống Sót, Tay Nhanh, Đầu Lạnh, Tim To, Vai Nặng. Chúng đổi trải nghiệm đầu game, không là tier sức mạnh.

Sau Job Change, ba specialization:

- **Sát Ảnh:** burst/stealth/self, yếu khi bị bầy ép.
- **Thống Soái:** quân số/aura/command, bản thân yếu hơn.
- **Hắc Pháp:** AoE/CC/mana/setup.

Đổi spec bằng quest + cost, không nút đổi giữa boss; chung shadow roster.

## Potential

- Thiên Hướng phản ánh cách chơi nhưng không bí mật sửa hiệu quả stat.
- Candidate milestone 20/50/80 cho node cam kết vĩnh viễn.
- Trước confirm phải thấy toàn bộ effect hiện tại/tương lai/trade-off.
- Node ví dụ: STR phá giáp/mining rhythm; AGI perfect movement/stealth; VIT detox/stone skin; INT mana/command economy; PER threat/formation read.

## Mastery

- Weapon Mastery mở passive theo loại vũ khí.
- Shadow Mastery theo archetype shadow.
- Content Mastery cho phép chọn modifier/reward khi farm lặp.

## Open decisions

Các câu hỏi topology, damage, counterplay, Potential, difficulty và UI nằm duy nhất tại [Balance Discovery Guide](03-attribute-and-balance-review-guide.md). File này chỉ giữ candidate hiện hành để review, không tạo danh sách câu hỏi song song.
