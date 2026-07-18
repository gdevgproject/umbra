# UMBRA — quy tắc làm việc bắt buộc cho Agent

Repository đang ở giai đoạn **Design Discovery**, chưa ở giai đoạn triển khai gameplay.

## Thứ tự đọc

1. `game-design/README.md`
2. `game-design/00-governance/01-document-architecture.md`
3. `game-design/00-governance/02-agent-operating-protocol.md`
4. Product charter, domain charter và Feature Cell nằm trong phạm vi công việc.
5. Shared Contract được Feature Cell dẫn tới.
6. Đọc production backlog/quality proof nếu yêu cầu thay đổi readiness hoặc thứ tự.

## Luật không được phá

- Không viết code gameplay khi Feature Cell chưa ở trạng thái `IMPLEMENTATION_READY`.
- Không tự nâng trạng thái. Mỗi gate cần đủ bằng chứng và đúng người duyệt ghi trong lifecycle.
- Không thêm đoạn “bổ sung vN” vào cuối tài liệu. Sửa nội dung chuẩn tại đúng một nơi và dùng Decision Record để giữ lý do.
- Không chép cùng một luật vào nhiều file. Một luật có một owner; nơi khác chỉ dẫn ID/link.
- Không biến candidate hoặc Git history thành quyết định đã chốt.
- Khi phát hiện mâu thuẫn, thiếu dữ kiện hoặc tác động chéo: dừng phần bị ảnh hưởng, ghi Open Question/Decision Record và cập nhật dependency.
- Mọi research phải tách `quan sát → nguyên lý → lựa chọn UMBRA → bằng chứng → rủi ro IP`; tên/asset/moveset nguồn không được trở thành biểu đạt UMBRA.
- Mọi tính năng phải xét: hai góc nhìn, input, animation, audio/VFX, UI/UX, accessibility, localization, multiplayer authority, save/migration, performance, compatibility và test; mục không liên quan phải ghi lý do, không được bỏ trống.
- Ticket là đơn vị triển khai sau cùng, không phải nơi nghiên cứu game design.

## Trước khi sửa tài liệu

Nêu rõ: mục tiêu người chơi, Feature ID, owner, trạng thái hiện tại, nguồn đã đọc, phạm vi và non-goals. Sau khi sửa, chạy `powershell -ExecutionPolicy Bypass -File tools/validate-design-docs.ps1` và báo các câu hỏi còn mở.
