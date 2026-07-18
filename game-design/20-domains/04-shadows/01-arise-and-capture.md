# SYS-SHADOW-CAPTURE — Arise và thu phục

> **DRI:** Shadow Systems Designer
> **Status:** `DISCOVERY`

## Player flow

```text
đánh bại mục tiêu đủ điều kiện
→ corpse capture window
→ nếu hết hạn, tạo Soul Echo gắn Gate
→ chọn Arise và xem chance/cost/hậu quả
→ resolve một attempt duy nhất
→ thành công tạo Shadow Identity; thất bại giảm attempts
→ Gate đóng/vỡ thì echo chưa xử lý bị cleanup theo luật hiển thị
```

## Candidate kế thừa cần prototype

- Tối đa ba attempt cho một mục tiêu.
- Boss ở attempt thứ ba đạt 100% nếu đã đủ điều kiện.
- Iron Knight dùng phân phối `[0, 0, 1]`: hai lần đầu chắc chắn thất bại để phục vụ narrative/teaching, lần ba thành công.
- Corpse tồn tại 120 giây rồi chuyển thành Soul Echo; echo tồn tại tới khi Gate đóng hoặc bị phá.

Các số trên không được hard-code trước balance/narrative review.

## Rule bắt buộc

- Eligibility và chance được tính ở server, snapshot tại lúc attempt bắt đầu.
- Retry packet không tiêu hao attempt hai lần.
- UI phân biệt impossible, failed và attempt remaining; không tạo xác suất giả.
- Success tạo đúng một identity idempotent, có origin/source encounter.
- Gate cleanup không xóa shadow đã capture.
- Boss scripted exception phải khai báo dữ liệu và được player-facing giải thích, không nằm trong nhánh code bí mật.

## Câu hỏi mở

Chance phụ thuộc rank gap, Potential, perk, achievement hay context nào; thất bại có tiêu Essence/Focus; multiplayer ownership; corpse vanilla ngoài Gate; và người chơi có thể từ chối/giải phóng mục tiêu ra sao.
