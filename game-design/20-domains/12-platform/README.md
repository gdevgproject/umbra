# DOM-PLATFORM — Data, runtime, persistence và compatibility

> **DRI:** Technical Director
> **Approver:** Technical Director
> **Reviewers:** Lead Designer, Data, Performance, QA, Release
> **Status:** `DISCOVERY`

Platform tạo nền để Feature Cell thay đổi mà không làm vỡ save, authority hoặc hệ khác. Kiến trúc kỹ thuật phục vụ contract thiết kế; không biến package diagram thành game design.

## Invariants

- Modular monolith với boundary/event rõ trước khi nghĩ tới framework phức tạp.
- Client gửi intent; server sở hữu state/kết quả gameplay.
- Definition tách khỏi persistent instance và derived runtime view.
- Stable ID, schema version, validation và migration là bắt buộc cho content/save.
- Feature có config/flag hoặc harness đủ để test cô lập khi hợp lý.
- Compatibility baseline là release record có kiểm chứng, không là lời hứa vĩnh viễn.

## Tài liệu

- [Data và persistence](01-data-and-persistence.md)
- [Runtime boundaries và authority](02-runtime-boundaries-and-authority.md)
- [Compatibility và release baseline](03-compatibility-and-release-baseline.md)
