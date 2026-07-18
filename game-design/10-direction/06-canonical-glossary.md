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
| Hạng | Rank | F→Vương Giả của player; NPC dừng ở Quốc Gia |
| Trỗi Dậy | Arise | hành động thu phục mục tiêu đủ điều kiện thành Shadow |
| Bóng / Hắc Ảnh | Shadow | đồng đội undead persistent có identity; chọn một display term sau tone test |
| Dư Âm Linh Hồn | Soul Echo | representation sau corpse window, gắn Gate lifecycle |
| Hắc Ảnh Cận Vệ | Shadow Retinue | toàn bộ roster tối đa tám Shadow đã kết ước; không đồng nghĩa quân đội số lượng lớn |
| Đội Hình Chiến Đấu | Active Retinue | tối đa bốn Shadow được triển khai chiến đấu; các member còn lại là dự bị/home |
| Dư Âm Chờ Phán Quyết | Unresolved Claim | một cơ hội thu phục chưa thành Shadow khi roster đầy; cap một, không chiến đấu/tăng trưởng/giao dịch |
| Tán Vỡ | Shattered | Shadow tạm mất materialized form, không chết vĩnh viễn |
| Tầng Giới | Stratum | world/progression layer tự chọn sau endgame; không ghi đè World Gốc |
| Tháp | Tower | chuỗi challenge floor/checkpoint/mutator; không đồng nghĩa Stratum |
| Tiềm Năng | Potential | lớp cam kết build irreversible sau preview |
| Tinh Thông | Mastery | tiến bộ do thực hành weapon/shadow/content role |
| Tập Trung | Focus | resource nhịp phòng thủ chủ động |
| Mana | Mana | resource sức mạnh skill/phép/triệu hồi đặc biệt; không phải Focus hoặc upkeep Retinue |
| Bình Hồi Phục Chiến Đấu | Combat Flask | vessel quick-recovery chuyên biệt có charge; không thay toàn bộ food/potion |
| Cơ sở di chuyển | Move Basis | frame biến input thành hướng world; camera-relative/target-relative/aim-relative tùy context |
| Khí Lực | Vigor | resource traversal ngắn cho Free Climb/Khinh Công; không phải Focus, Fatigue hoặc Hunger |
| Leo Tự Do | Free Climb | bám và di chuyển trên face voxel hợp lệ bằng Khí Lực; không đồng nghĩa ladder/vine vanilla |
| Hạ Kình | Grounding Strike | kỹ thuật context khi rơi: hãm/quy hướng, impact nhẹ và chuyển fall damage tại valid landing |
| Khinh Công | Lightness Art | giậm đất phóng theo quỹ đạo rồi chủ động hạ chậm; không phải Creative flight/Elytra/cánh |
| Thể Lực / Mệt Mỏi | Fatigue | áp lực phiên săn dài, không là stamina di chuyển thường |
| Thế | Posture | khả năng giữ thế trước pressure, mở stagger/finisher |
| Kính Trọng | Respect | quan hệ/nhận thức theo NPC/context, không là reputation toàn cục |
| Ô Tính Năng | Feature Cell | đơn vị design nhỏ nhất có một player intent→outcome |
| Lát Cắt Năng Lực | Capability Slice | bản chơi nhỏ nhất xuyên input→feedback→test |
| Hợp Đồng Chung | Shared Contract | vocabulary/state/rule được nhiều feature dùng |
| Nội Dung Cụ Thể | Content Instance | boss/quest/item/faction/room điền vào luật đã duyệt |

## Quy tắc dùng ngôn ngữ

- File thiết kế tiếng Việt; ID/state/code vocabulary tiếng Anh nhất quán.
- Lần đầu trong file có thể viết `Trỗi Dậy (Arise)`, sau đó dùng một term.
- Không dùng `stamina` cho cả Focus và Fatigue.
- Không gọi Shadow là pet/minion nếu đang nói identity/fantasy; `summoned actor` chỉ dùng kỹ thuật.
- Không gọi mọi không gian mới là dimension; phân biệt Gate instance, Tower và Stratum.
- Term chưa khóa ghi `working name`, không tạo nhiều synonym để né quyết định.
