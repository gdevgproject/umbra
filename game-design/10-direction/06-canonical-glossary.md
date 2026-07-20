# PROD-GLOSSARY — Thuật ngữ canonical Việt/Anh

> **DRI:** Narrative + Localization + Design Operations
> **Status:** `DISCOVERY`

Tên gameplay dưới đây là working canonical để tài liệu nhất quán; Creative/Localization review có thể đổi tên bằng một cập nhật toàn hệ. ID/state machine tiếng Anh giữ ổn định hơn display name.

| Thuật ngữ Việt | English/system term | Nghĩa và ranh giới |
|---|---|---|
| UMBRA | UMBRA | tên dự án/sản phẩm; chưa phải tên lore bắt buộc |
| Di Sản | Legacy | nguồn/khế ước quyền lực cốt truyện; không đồng nghĩa toàn bộ UI |
| Hệ Thống | System | voice/interface hướng dẫn và điều phối progression |
| Cổng | Gate | world object + lifecycle dẫn tới dungeon instance |
| Cấp Độ | Level | trục progression toàn cục duy nhất từ 1 tới 100+; NPC có Level cố định, player tăng trưởng |
| Trỗi Dậy | Arise | hành động thu phục mục tiêu đủ điều kiện thành Shadow |
| Bóng / Hắc Ảnh | Shadow | đồng đội undead persistent có identity; chọn một display term sau tone test |
| Dư Âm Linh Hồn | Soul Echo | representation sau corpse window, gắn Gate lifecycle |
| Hắc Ảnh Cận Vệ | Shadow Retinue | toàn bộ roster tối đa tám Shadow đã kết ước; không đồng nghĩa quân đội số lượng lớn |
| Đội Hình Chiến Đấu | Active Retinue | tối đa bốn Shadow được triển khai chiến đấu; các member còn lại là dự bị/home |
| Dư Âm Chờ Phán Quyết | Unresolved Claim | một cơ hội thu phục chưa thành Shadow khi roster đầy; cap một, không chiến đấu/tăng trưởng/giao dịch |
| Tán Vỡ | Shattered | Shadow tạm mất materialized form, không chết vĩnh viễn |
| Tầng Giới | Stratum | world/progression layer tự chọn sau endgame; không ghi đè World Gốc |
| Tháp | Tower | chuỗi challenge floor/checkpoint/mutator; không đồng nghĩa Stratum |
| Tinh Thông | Mastery | tiến bộ bounded do thực hành một capability; không là Rank/Primary Attribute trá hình |
| Mở Kỹ Năng | Skill Unlock Event | grant idempotent tại Level 1 và mỗi mốc 5 Level theo authored line |
| Bình Hồi Phục Chiến Đấu | Combat Flask | vessel quick-recovery chuyên biệt có charge; không thay toàn bộ food/potion |
| Cơ sở di chuyển | Move Basis | frame biến input thành hướng world; camera-relative/target-relative/aim-relative tùy context |
| Khí Lực | Vigor | custom action resource duy nhất cho Dodge/Sprint Burst/Free Climb/Khinh Công; không phải HP hoặc Minecraft Hunger |
| Leo Tự Do | Free Climb | bám và di chuyển trên face voxel hợp lệ bằng Khí Lực; không đồng nghĩa ladder/vine vanilla |
| Hạ Kình | Grounding Strike | kỹ thuật fresh-Attack khi rơi: hãm/quy hướng, impact vùng bounded theo vũ khí và chuyển đúng fall component tại valid landing |
| Khinh Công | Lightness Art | giậm đất phóng theo quỹ đạo rồi chủ động hạ chậm; không phải Creative flight/Elytra/cánh |
| Khựng / Choáng / Hất tung | Stagger / Stun / Launch | action result có duration/immunity/recovery; không có Posture meter |
| Cụm Dân Cư | Village Hub | settlement identity ổn định từ POI/residency, owner của resident quota |
| Kẻ Bắt Nạt | Bully | rare high-level NPC archetype có cảnh cáo nonlethal, không thể kết liễu player |
| Hộ Vệ | Guardian | rare NPC archetype can thiệp khi perceived hostile pressure áp đảo player |
| Kính Trọng | Respect | quan hệ/nhận thức theo NPC/context, không là reputation toàn cục |
| Ô Tính Năng | Feature Cell | đơn vị design nhỏ nhất có một player intent→outcome |
| Lát Cắt Năng Lực | Capability Slice | bản chơi nhỏ nhất xuyên input→feedback→test |
| Hợp Đồng Chung | Shared Contract | vocabulary/state/rule được nhiều feature dùng |
| Nội Dung Cụ Thể | Content Instance | boss/quest/item/faction/room điền vào luật đã duyệt |

## Quy tắc dùng ngôn ngữ

- File thiết kế tiếng Việt; ID/state/code vocabulary tiếng Anh nhất quán.
- Lần đầu trong file có thể viết `Trỗi Dậy (Arise)`, sau đó dùng một term.
- `Rank/Hạng`, `Primary Attributes`, `Potential`, `Prestige`, `Mana`, `Focus`, `Fatigue` và `Posture meter` là thuật ngữ gameplay đã bị loại; chỉ xuất hiện trong migration/provenance khi ghi rõ `legacy field`.
- Không dùng `stamina` mơ hồ; dùng `Vigor/Khí Lực` cho resource action duy nhất.
- Không gọi Shadow là pet/minion nếu đang nói identity/fantasy; `summoned actor` chỉ dùng kỹ thuật.
- Không gọi mọi không gian mới là dimension; phân biệt Gate instance, Tower và Stratum.
- Term chưa khóa ghi `working name`, không tạo nhiều synonym để né quyết định.
