# UMBRA Design System

> **Trạng thái toàn dự án:** `DESIGN_DISCOVERY`
>
> Đây là cổng vào nguồn chân lý mới. Các file đánh số kiểu cũ và thư mục `90-archive/` chỉ là đầu vào lịch sử, không cho phép bắt đầu code.

UMBRA là một Minecraft Java gameplay overhaul dark-fantasy quy mô lớn: người chơi đi từ một cư dân yếu ớt tới Chúa Tể Hắc Ảnh, tự phát triển năng lực, chinh phục Gate và biến đối thủ đáng nhớ thành một quân đoàn có danh tính; đồng thời vẫn giữ xây dựng, khai phá, sinh tồn và tính mở của Minecraft.

## Đọc theo nhu cầu

| Bạn cần | Đọc |
|---|---|
| Hiểu cách toàn bộ tài liệu vận hành | [Kiến trúc tài liệu](00-governance/01-document-architecture.md) |
| Giao việc cho AI/Agent | [Agent protocol](00-governance/02-agent-operating-protocol.md) |
| Biết studio có những vai trò nào | [Bản đồ trách nhiệm](00-governance/03-studio-responsibility-map.md) |
| Biết khi nào được research/design/code | [Lifecycle và quality gates](00-governance/04-design-lifecycle-and-gates.md) |
| Theo dõi nội dung cũ đã di trú tới đâu | [Migration catalog](00-governance/05-migration-catalog.md) |
| Hiểu game ở cấp sản phẩm | [Product charter](10-direction/product-charter.md) |
| Xem toàn bộ domain/hệ thống/phụ thuộc | [System map](10-direction/system-map.md) |
| Xem lỗi cấu trúc và mâu thuẫn đã phát hiện | [Baseline audit](10-direction/baseline-audit.md) |
| Thiết kế combat | [Combat domain](20-domains/combat/README.md) |
| Xem mẫu chi tiết hóa dodge | [Dodge Feature Cell](20-domains/combat/dodge/README.md) |
| Xem thứ tự discovery hợp lý | [Design Discovery Queue](50-production/design-discovery-queue.md) |
| Tạo tính năng mới | [Feature Cell template](80-templates/feature-cell-template.md) |
| Tra nội dung v4 cũ | [Archive policy](90-archive/README.md) |

## Cấu trúc

```text
game-design/
├─ 00-governance/       luật vận hành tài liệu và team
├─ 10-direction/        tầm nhìn, phạm vi, bản đồ toàn game
├─ 20-domains/          thiết kế theo domain → system → Feature Cell
├─ 30-shared-contracts/ luật dùng chung có một owner
├─ 40-content/          faction, boss, quest, item, room và narrative instance
├─ 50-production/       discovery queue, initiative, release slice, ticket sau gate
├─ 60-quality/          test, balance, performance, compatibility, telemetry
├─ 70-research/         nghiên cứu nguồn và thư viện nguyên lý
├─ 80-templates/        mẫu chuẩn
└─ 90-archive/          corpus cũ, chỉ đọc
```

## Nguyên tắc nguồn chân lý

Tầm nhìn trả lời **vì sao**. Domain charter trả lời **ranh giới**. Feature Cell trả lời **người chơi làm gì và luật nào áp dụng**. Shared Contract trả lời **nhiều feature phải giao tiếp ra sao**. Content Instance điền **nội dung cụ thể**. Quality Spec định nghĩa **bằng chứng**. Production chỉ quyết định **thứ tự**, không được viết lại thiết kế.

Nếu hai nơi cùng phát biểu một luật, cấu trúc đang sai. Chọn một owner, chuyển luật về đó và thay bản sao bằng liên kết.

## Trạng thái hiện tại

- Tầm nhìn và fantasy cốt lõi: có nền tốt, đang chuẩn hóa.
- Phạm vi game: rất lớn, chưa được greenlight toàn bộ cho 1.0.
- Hệ thống cũ: đã lập inventory nhưng phần lớn mới ở `DISCOVERY` hoặc `PROPOSED`.
- Dodge: được dùng làm Feature Cell mẫu; **chưa** `IMPLEMENTATION_READY`.
- Backlog code M0–M8 cũ: đóng băng làm tham khảo cho tới khi các Feature Cell tương ứng qua gate.
