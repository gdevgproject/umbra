# PROD-UMBRA — Product Charter

> **DRI:** Game Director
> **Approver:** Game Director
> **Reviewers:** Lead Designer, Creative Director, Technical Director, Producer
> **Status:** `PROPOSED`

## 1. One-line promise

UMBRA biến Minecraft Survival thành hành trình dark-fantasy dài hạn nơi người chơi tự tay đi từ kẻ vô danh tới Chúa Tể Hắc Ảnh, biến những đối thủ đáng nhớ thành một quân đoàn có danh tính, trong khi thế giới sandbox, căn nhà và các lựa chọn của họ vẫn còn ý nghĩa.

## 2. Đối tượng trải nghiệm

- Người chơi Minecraft thích survival, khám phá, xây dựng nhưng muốn progression và chiến đấu sâu hơn.
- Người chơi action RPG thích mastery, build và boss nhưng chấp nhận ngôn ngữ không gian/khối của Minecraft.
- Người chơi summoner/collector muốn đồng đội lâu dài, không phải pet dùng rồi bỏ.
- Người chơi dài hạn muốn thế giới cũ còn giá trị sau endgame.

Casual phải đọc được và có đường tiến; expert phải có không gian biểu đạt kỹ năng. UMBRA không cân bằng bằng cách giấu thông tin hoặc phá luật sau lưng người chơi.

## 3. Năm trụ cảm xúc

| ID | Trụ | Lời hứa quan sát được |
|---|---|---|
| `PIL-POWER` | Quyền lực | sức mạnh thay đổi động từ, hình ảnh và phản ứng thế giới, không chỉ số damage |
| `PIL-ATTACHMENT` | Gắn kết | bóng/NPC có danh tính, lịch sử và giá trị lâu dài |
| `PIL-DISCOVERY` | Khám phá | Gate, faction, dungeon và lore tạo câu hỏi mới, không chỉ đổi màu |
| `PIL-MASTERY` | Tinh thông | input, timing, build, chỉ huy và chuẩn bị đều có thể học và thể hiện |
| `PIL-ROOTEDNESS` | Nơi thuộc về | nhà, gia đình, đô thị và công trình khiến việc trở về có ý nghĩa |

Mỗi feature phải phục vụ một trụ chính và tối đa hai trụ phụ. Nếu cố phục vụ tất cả, feature chưa có trọng tâm.

## 4. Ràng buộc thiết kế

1. **Minecraft vẫn là nền:** đào, xây, địa hình, redstone, làng, Nether/End không bị biến thành khoảng nghỉ vô nghĩa giữa các menu RPG.
2. **Cảm xúc trước số lượng:** feature mới phải tạo hoặc thay đổi một quyết định người chơi.
3. **Đọc được và công bằng:** telegraph, trạng thái, cost, failure và hậu quả phải có ngôn ngữ rõ.
4. **Không FOMO:** không streak bắt buộc, calendar lockout hay phần thưởng độc quyền vì đăng nhập đúng giờ.
5. **Hiệu năng là contract:** fantasy quân đoàn lớn phải dùng LOD/representation phù hợp thay vì hứa entity vô hạn.
6. **Original by transformation:** reference tạo nguyên lý/hypothesis, không tạo tên, asset, lore hay moveset để sao chép.
7. **Thế giới cũ không bị xóa giá trị:** tiến trình mới là lựa chọn và chiều sâu, không cưỡng ép toàn save thành stat sponge.

## 5. Anti-goals

- Không biến Minecraft thành một menu ARPG đặt trên block world.
- Không làm combat spam click hoặc chuỗi animation tự chạy dài không kiểm soát.
- Không làm shadow thành consumable/pet vô danh.
- Không giả lập xã hội/kinh tế chi tiết nếu không tạo quyết định chơi.
- Không dùng procedural generation để thay thế authored grammar và quality.
- Không hứa co-op, PvP, controller, mọi loader hay mọi phiên bản trong 1.0 khi chưa qua discovery riêng.
- Không dùng độ dài checklist làm thước đo độ hoàn thiện.

## 6. Core experience loop ở cấp sản phẩm

```text
Chọn mục tiêu có ý nghĩa
→ Chuẩn bị build/quân đoàn/vật tư
→ Khám phá và chiến đấu trong không gian Minecraft
→ Thu hoạch kiến thức, loot, tiến trình và đối thủ có thể thu phục
→ Chuyển hóa thành năng lực, quan hệ hoặc thay đổi thế giới
→ Trở về nhà/xã hội để thấy hậu quả
→ Chủ động chọn thử thách tiếp theo
```

Mỗi Capability Slice không cần đủ toàn loop, nhưng phải nói rõ nó cải thiện mắt xích nào và không làm hỏng mắt xích liền kề.

## 7. Câu hỏi product chưa khóa

- Phạm vi tối thiểu của bản phát hành đầu tiên tạo đúng fantasy Shadow Monarch là gì?
- Prologue và gia đình là bắt buộc từ slice đầu hay được giới thiệu sau combat foundation?
- Tỷ lệ thời gian mục tiêu giữa vanilla sandbox, Gate, quản lý và narrative là bao nhiêu theo từng giai đoạn?
- “1.0” nghĩa là câu chuyện hoàn chỉnh, hệ thống hoàn chỉnh hay gói trải nghiệm tối thiểu có thể phát triển lâu dài?
- Camera góc ba cải tổ là mode cốt lõi hay optional presentation layer?

Cho tới khi các câu hỏi này có evidence/ADR, Product Charter chưa `APPROVED`.
