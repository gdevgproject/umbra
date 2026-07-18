# SYS-COMBAT-FLOW — Hành động, vũ khí và nhịp trận

> **DRI:** Combat Designer
> **Status:** `DISCOVERY`

## Bộ hành động nền

| Feature | Ý định | Trade-off cốt lõi |
|---|---|---|
| Light attack | gây áp lực an toàn, nối nhịp | impact thấp hơn, dễ bị đọc |
| Heavy attack | đổi commitment lấy damage/posture | anticipation và recovery dài |
| Dodge | đổi vị trí và cửa sổ phòng thủ hữu hạn | tốn tài nguyên, mất nhịp tấn công |
| Parry | dùng timing biến đòn địch thành lợi thế | thất bại bị phạt rõ |
| Skill | thay đổi luật cục bộ theo build | mana/cooldown/commitment |
| Weapon swap | đổi nhịp/công cụ | không được cancel miễn phí mọi recovery |

Dodge được đặc tả riêng tại [Feature Cell Dodge](dodge/README.md). Light attack và Dodge là prototype đôi đầu tiên để kiểm chứng action timeline, hit cadence, camera và animation.

## Combat stance và vanilla coexistence

Combat context quyết định khi cùng một nút mang nghĩa chiến đấu hay vanilla. Vào/ra context phải có tín hiệu rõ, timeout hợp lý và cách thoát chủ động. Mining, building, interaction và item use không được bị chiếm ngoài context. Keybind phải remap được; không lấy hard-code làm thiết kế.

## Năm grammar vũ khí kế thừa từ corpus

| Lớp | Nhịp | Lợi thế | Rủi ro |
|---|---|---|---|
| Song đoản kiếm | nhanh, combo, reposition | burst và cơ động | tầm ngắn, commitment tích lũy |
| Kiếm | nhịp cân bằng | phản ứng linh hoạt | không cực trị |
| Vũ khí dài | kiểm soát khoảng cách/quét | zone và posture | xoay trở/recovery |
| Tầm xa | tạo pressure từ vị trí | an toàn có điều kiện | aim, ammunition/resource, áp sát |
| Pháp trượng | cast và kiểm soát nguyên tố | utility/AoE | mana và interruption |

Đây là grammar, không phải cam kết đủ năm moveset ở slice đầu.

## Combo, posture và finisher

- Combo thưởng cho nhịp hành động đa dạng/hợp lệ, không thưởng click rate.
- Posture là khả năng giữ thế trước áp lực, không phải thanh HP thứ hai.
- Stagger mở cửa sổ có giới hạn; finisher cần telegraph, camera-safe và không khóa người chơi quá lâu.
- Boss có thể thay đổi cách phục hồi posture nhưng không âm thầm miễn nhiễm toàn bộ hệ.

## Sáu kênh damage ứng viên

Physical, Fire, Ice, Lightning, Arcane và Shadow là taxonomy ứng viên để phục vụ build/counterplay. Trước khi khóa phải chứng minh mỗi kênh tạo quyết định khác nhau; nếu chỉ đổi màu/kháng số thì hợp nhất.

## Tiêu chí cảm giác

Responsive không đồng nghĩa bỏ commitment. Impact đến từ timing, âm thanh, phản lực, hit pause có kiểm soát, camera và phản ứng mục tiêu. Readability luôn thắng spectacle khi hai thứ xung đột.
