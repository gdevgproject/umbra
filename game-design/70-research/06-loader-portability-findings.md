# RES-LOADER-PORTABILITY — Fabric-first và NeoForge portability findings

> **DRI:** Technical Director + Compatibility Engineer
> **Status:** `EVIDENCE_SEED`
> **Audit date:** 2026-07-19

## Decision question

UMBRA phải giữ boundary nào ngay từ Fabric foundation để một bản NeoForge first-class trong tương lai khả thi, mà không làm giảm chất lượng Fabric hoặc xây multi-loader framework vô hạn trước consumer?

## Evidence được kiểm chứng

| Quan sát/version/context | Vấn đề nguồn giải | Nguyên lý chuyển sang UMBRA | Lựa chọn UMBRA | Evidence/nguồn | Rủi ro IP |
|---|---|---|---|---|---|
| Fabric 26.1+ và NeoForge 26.1 cùng dùng Minecraft code unobfuscated/tên Mojang; Fabric đã bỏ Yarn cho 26.1+ | giảm một lớp mapping khác biệt giữa loader | common code có thể nói cùng vocabulary vanilla ở cùng Minecraft baseline, nhưng loader API vẫn khác | common layer được phép dùng vanilla/Mojang type theo boundary; cấm loader type | [Fabric mapping migration](https://docs.fabricmc.net/develop/porting/mappings/), [Fabric 26.1 port](https://docs.fabricmc.net/develop/porting/fabric-api) | không có biểu đạt sáng tạo |
| Fabric dùng `fabric.mod.json`/entrypoints; NeoForge dùng `neoforge.mods.toml`, `@Mod`, mod bus và game bus | bootstrap/lifecycle khác thật, NeoForge lifecycle event có thể chạy song song | common bootstrap không phụ thuộc thứ tự/event object của loader; thread contract phải rõ | entrypoint/event registration nằm trong adapter, chuyển thành UMBRA command/callback có phase | [Fabric project structure](https://docs.fabricmc.net/develop/getting-started/project-structure), [NeoForge mod files](https://docs.neoforged.net/docs/gettingstarted/modfiles/), [NeoForge events](https://docs.neoforged.net/docs/1.21.11/concepts/events/) | không có |
| Cả hai có physical/logical side; single-player vẫn có logical server; client-only reference sai có thể crash dedicated server | side bug và static state thường chỉ lộ ở dedicated run | side/authority là semantic chung, side detection/entrypoint là adapter | server-safe common code; client-common riêng; dedicated smoke bắt buộc | [Fabric networking](https://docs.fabricmc.net/develop/networking), [NeoForge sides](https://docs.neoforged.net/docs/1.21.1/concepts/sides/) | không có |
| Fabric và NeoForge đều truyền payload nhưng registration/context API khác | gameplay handler dễ dính loader nếu nhận packet context trực tiếp | payload schema/validation/handler là common; transport và scheduling là adapter | stable message ID/version + shared semantic handler; adapter chỉ decode/schedule/send | [Fabric networking](https://docs.fabricmc.net/develop/networking), [NeoForge networking 26.1](https://docs.neoforged.net/docs/networking/) | không có |
| Persistence/attachment/config API khác; NeoForge attachment có copy-on-death/sync policy riêng | dùng convenience API làm data model sẽ đổi death/save semantics khi port | domain sở hữu retain/reset/sync; loader chỉ lưu/truyền | canonical UMBRA schema/codec/migration độc lập; adapter không quyết copy-on-death | [NeoForge Saved Data](https://docs.neoforged.net/docs/datastorage/saveddata/), [NeoForge Data Attachments](https://docs.neoforged.net/docs/1.21.4/datastorage/attachments/) | không có |
| NeoForge ModDevGradle có Vanilla-mode cho common code trong multi-loader project | multi-loader common compilation là use case được toolchain thừa nhận | tách logical boundary trước; physical Gradle module chỉ khi port spike chứng minh giá trị | không mở NeoForge module trong C1; `DB-043` quyết module topology bằng compile proof | [NeoForge ModDevGradle — Vanilla-mode](https://docs.neoforged.net/toolchain/docs/plugins/mdg/) | không có |
| Fabric và NeoForge đều hỗ trợ GameTest, nhưng harness/registration khác | cùng scenario không đồng nghĩa cùng test bootstrap | oracle/fixture semantics dùng chung; runner/registration theo loader | shared contract suite + adapter conformance + loader integration suites | [Fabric automated testing](https://docs.fabricmc.net/develop/automatic-testing), [NeoForge Game Tests](https://docs.neoforged.net/docs/misc/gametest/) | không có |
| NeoForge official public docs/news được audit hiện mô tả 26.1; chưa có baseline 26.2 được pin trong research này | không được tưởng tượng version/toolchain tương thích | future target không đồng nghĩa current support | NeoForge là required future loader target nhưng `NOT_SUPPORTED` cho tới port manifest/gates | [NeoForge news](https://neoforged.net/news/), [NeoForge docs](https://docs.neoforged.net/) | không có |

## Option analysis

### A — Fabric code trực tiếp khắp feature, port sau

Nhanh nhất ban đầu nhưng gameplay, save và tests sẽ nhiễm Fabric event/context/type. Chi phí port tăng theo số feature và dễ tạo hai implementation có luật khác nhau. Loại.

### B — Framework chung hóa mọi API ngay lập tức

Giảm import loader nhưng tạo lowest-common-denominator, interface vô chủ và chi phí trước consumer; camera/render/mixin vẫn không thể chung hoàn toàn. Loại.

### C — Ports-and-adapters có chọn lọc, Fabric-first

Giữ domain/state/schema/oracle chung; chỉ tạo port khi Fabric consumer thật chứng minh boundary. Fabric adapter được quyền dùng capability tối ưu của Fabric. NeoForge adapter tương lai phải đạt conformance/parity, không buộc common core biết loader. **Phương án đề xuất.**

## Transfer constraints

- Cùng Minecraft baseline vẫn có loader-specific hook, registry extension, config, patch và render behavior; không hứa 100% source chung.
- Performance phải benchmark riêng theo loader; semantic parity không có nghĩa timing/trace giống hệt.
- Một feature chỉ có trên một loader được phép khi có capability manifest, fallback và Product approval; không âm thầm phân kỳ core promise.
- World chuyển loader chỉ được support khi Minecraft/schema/content versions tương thích và cross-loader fixture chứng minh; không suy từ việc cùng mod ID.

Canonical choice nằm tại [Loader Portability Contract](../20-domains/12-platform/07-loader-portability-and-adapter-contract.md); file này chỉ giữ evidence và option.

