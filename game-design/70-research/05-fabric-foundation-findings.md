# RES-FABRIC-FOUNDATION — Kết luận nền tảng từ tài liệu chính thức

> **DRI:** Technical Director
> **Status:** `EVIDENCE_SEED`

Nguồn được đọc tại thời điểm baseline discovery; API/version vẫn phải pin theo từng release.

## Kết luận có ảnh hưởng kiến trúc

1. **Single-player vẫn có logical server.** Integrated server/LAN và dedicated server đều là logical server. Vì vậy offline-first không phải lý do giữ gameplay truth ở client. [Fabric Networking](https://docs.fabricmc.net/develop/networking)
2. **Payload từ client phải được server validate.** Target, distance, state, ownership và rate không được tin từ packet; đây là nền chống desync/cheat và chuẩn bị future multiplayer. [Fabric Networking](https://docs.fabricmc.net/develop/networking)
3. **Persistence và sync là hai quyết định khác nhau.** Saved Data lưu dữ liệu qua session; Data Attachments có policy persist/sync/copy-on-death riêng. Chọn API sau khi xác định scope/lifecycle, không biến API thành data model. [Saved Data](https://docs.fabricmc.net/develop/serialization/saved-data), [Data Attachments](https://docs.fabricmc.net/develop/serialization/data-attachments)
4. **Có ba lớp test tự động chính thức:** Fabric Loader JUnit, server GameTest và client GameTest. Client GameTest có thể chạy world và chụp screenshot; người dùng không nên làm thay các oracle máy có thể kiểm. [Automated Testing](https://docs.fabricmc.net/develop/automatic-testing)
5. **Event có thể tốt hơn mixin cho compatibility**, nhưng không phải mọi hook đều có event; khi cần mixin phải có narrow seam, conflict test và fallback. [Fabric Events](https://docs.fabricmc.net/develop/events)
6. **Creative inventory là một path thật cần test.** Item/block được tạo từ creative tab hoặc `/give` phải có state mặc định hợp lệ và behavior nhất quán. [Creative Tabs](https://docs.fabricmc.net/develop/items/custom-creative-tabs)
7. **Rendering pipeline đang biến động.** Render extraction/drawing và RenderState làm camera/render hook có chi phí compatibility cao; cần adapter, version pin và visual regression. [Rendering Concepts](https://docs.fabricmc.net/develop/rendering/basic-concepts), [World Rendering](https://docs.fabricmc.net/develop/rendering/world)

## Suy luận UMBRA

- `C1-FOUNDATION-KERNEL` phải chạy cả integrated và dedicated server từ đầu.
- Death/respawn không chỉ là gameplay rule; nó là copy/reset/persist matrix cho từng state.
- Camera không được sở hữu gameplay target/hit truth; nó tiêu thụ target/action state và chỉ gửi intent.
- Save schema, packet codec, content definition và render adapter phải có version seam độc lập.
- Screenshot của người dùng là bằng chứng cuối cho feel/hardware-specific issue, không phải cách duy nhất Agent biết game có hoạt động.
