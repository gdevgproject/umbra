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
8. **26.2 thay đổi key và rendering thật.** Friends List thêm default `O`; Quick Actions/other mappings phải được audit từ artifact, không từ trí nhớ. 26.2 cũng thêm experimental Vulkan; raw OpenGL là rủi ro break. [Minecraft 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2), [Fabric 26.2](https://fabricmc.net/2026/06/15/262.html)
9. **Key mapping là client-side, remappable và layout-sensitive.** Category/label cần translation; Fabric lưu ý GLFW key name giả định US layout. [Fabric Key Mappings](https://docs.fabricmc.net/develop/key-mappings)
10. **Translatable text dùng language resources và typed arguments.** UMBRA có thể theo Minecraft locale thay vì tạo language setting riêng. Mojang 26.2 asset index đã xác minh `minecraft/lang/vi_vn.json` tồn tại. [Text and Translations](https://docs.fabricmc.net/develop/text-and-translations)
11. **Java world backup có thể chuyển thiết bị/ổ ngoài.** UMBRA state cần sống cùng world và có restore/migration proof. [Minecraft Help](https://help.minecraft.net/hc/en-us/articles/4409159214605-Locating-Minecraft-Java-Edition-Files-for-Backup-or-Transfer)
12. **26.2 có công cụ và failure profile render mới.** Tracy nhận GPU timings; Vulkan vẫn experimental, có thể giảm performance/instability và Minecraft có fallback startup; particle overload được xử lý bằng sampling thay vì giữ mọi particle. [Minecraft 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2)
13. **JFR đo được CPU, allocation, GC, locks và I/O với profile overhead khác nhau.** Continuous/default và profiling recording không được trộn thành cùng điều kiện benchmark; heap statistics có thể tạo GC pause riêng. [Oracle JFR troubleshooting](https://docs.oracle.com/en/java/javase/17/troubleshoot/troubleshoot-performance-issues-using-jfr.html), [JFR configuration](https://docs.oracle.com/en/java/javase/17/jfapi/flight-recorder-configurations.html)

## Suy luận UMBRA

- `C1-FOUNDATION-KERNEL` phải chạy cả integrated và dedicated server từ đầu.
- Death/respawn không chỉ là gameplay rule; nó là copy/reset/persist matrix cho từng state.
- Camera không được sở hữu gameplay target/hit truth; nó tiêu thụ target/action state và chỉ gửi intent.
- Save schema, packet codec, content definition và render adapter phải có version seam độc lập.
- Screenshot của người dùng là bằng chứng cuối cho feel/hardware-specific issue, không phải cách duy nhất Agent biết game có hoạt động.
- Mỗi baseline mới cần diff key registry, resource/data versions, GUI/render adapters và backup migration trước khi promote.
- Performance evidence phải tách logical-server tick, client CPU/GPU frame, memory/GC và I/O; không suy từ FPS average.

## Chuỗi chưng cất cho performance research

| Quan sát | Nguyên lý | Lựa chọn UMBRA | Bằng chứng cần giữ | Rủi ro IP |
|---|---|---|---|---|
| Single-player vẫn có logical server | client frame và gameplay tick là hai deadline khác | benchmark/budget riêng, cùng authority path | integrated + dedicated profile | không có biểu đạt sáng tạo bị sao chép |
| 26.2 có OpenGL/Vulkan, Tracy GPU timing và particle overload sampling | backend/cosmetic density là biến test; overload cần degradation có thứ tự | `QLT-PERFORMANCE` yêu cầu backend profile, VFX cap và cue ưu tiên | Tracy/frame stats/screenshot theo backend | dùng capability/API, không dùng asset/moveset nguồn |
| JFR cho thấy allocation/GC/lock/I/O và profiler có observer effect | đo tail latency/live-set, ghi profiler state | soak/JFR + median/p95/p99, không average-only | recording metadata và baseline diff | không có |
| Fabric tách render extraction/drawing và hỗ trợ unit/GameTest | thread boundary/test type phải theo owner và claim | pure prep, bounded commit; unit/GameTest/visual/soak không thay thế nhau | automated manifest + profile | không có |

Canonical design choice và budget nằm tại [Performance Constitution](../60-quality/04-performance-budgets.md); research file này chỉ giữ bằng chứng/lập luận.
