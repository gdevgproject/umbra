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
- Integrated single-player và dedicated server dùng cùng authority path; không implement multiplayer hiện tại nhưng giữ seam cho co-op 2–4 trước, PvP 1v1/3v3 sau và không lưu gameplay truth ở client.
- Compatibility baseline là release record có kiểm chứng, không là lời hứa vĩnh viễn.
- Fabric là target hiện tại; NeoForge là future target bắt buộc nhưng dùng adapter/artifact riêng. Gameplay semantics và canonical save không phụ thuộc loader.

## Tài liệu

- [Data và persistence](01-data-and-persistence.md)
- [Runtime boundaries và authority](02-runtime-boundaries-and-authority.md)
- [Compatibility và release baseline](03-compatibility-and-release-baseline.md)
- [Offline-first và multiplayer readiness](04-offline-first-multiplayer-readiness.md)
- [Foundation Kernel](05-foundation-kernel.md)
- [Save ownership, backup và transfer](06-save-ownership-backup-and-transfer.md)
- [Fabric-first/NeoForge-ready Loader Portability](07-loader-portability-and-adapter-contract.md)
