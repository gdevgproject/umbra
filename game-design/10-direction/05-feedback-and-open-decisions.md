# PROD-FEEDBACK — Cách đọc và đưa feedback

> **DRI:** Design Operations
> **Status:** `ACTIVE`

Bạn không cần sửa Markdown. Khi đọc, có thể nói tự nhiên theo một trong các kiểu sau; Agent phải tự phân loại và định tuyến.

| Feedback của bạn | Agent hiểu là | Hành động bắt buộc |
|---|---|---|
| “Tôi không muốn…” | constraint/anti-goal | tìm blast radius, cập nhật canonical owner + impacted cells |
| “Nếu thêm…” | new idea | phân biệt scenario, feature, system hay expansion; không nhét vào ticket |
| “Cơ chế này nên…” | rule change | tìm owner, options/ADR, lùi status nếu đổi contract |
| “Tôi chưa hiểu…” | clarity/documentation defect | viết lại flow/vocabulary, không tự đổi game rule |
| “Cái này quá lớn/nhỏ” | decomposition feedback | áp dụng split/merge tests trong GOV-ARCH |
| “Làm luôn” | execution request | kiểm lifecycle; design trước nếu chưa ready |
| “Giống game X” | research lead | tạo Decision Question/Research Card, không copy solution |

## Các quyết định sản phẩm đang mở

1. Promise nhỏ nhất phải có để người chơi thật sự cảm thấy là Shadow Monarch.
2. Campaign 1.0 phải hoàn tất cả ba hồi hay chỉ một chương hoàn chỉnh?
3. Camera góc ba cải tổ là mode cốt lõi hay optional?
4. Prologue/gia đình xuất hiện từ slice đầu hay sau identity loop?
5. Tỷ lệ sandbox : Gate : management : narrative mục tiêu theo giai đoạn.
6. Năm attributes, Focus/Fatigue và Potential có quá nhiều lớp resource/build không?
7. Stratum/Tower thuộc 1.0 hay expansion sau campaign core?

Agent không được tự trả lời các câu hỏi này bằng một ticket hay candidate parameter; phải chuẩn bị options/evidence để bạn duyệt.
