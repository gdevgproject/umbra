# RES-MINECRAFT-RELEASE-OPERATIONS — Vòng đời Minecraft version và GitHub release

> **Researcher:** Release Tech + Platform/Compatibility
> **Date observed:** 2026-07-19
> **Source/version/platform:** Minecraft Java 26.2; 26.3 Snapshots 1–4; Fabric 26.2; GitHub Releases/Rulesets/Actions 2026
> **Decision supported:** `PD-043`, `SYS-COMPAT`, `ADR-0003`, `DB-019`, `R35`
> **Status:** `SYNTHESIZED`

## Question

UMBRA nên vận hành branch, version, support/EOL và GitHub Release thế nào để theo kịp Minecraft mà vẫn giữ main/save ổn định và bản cuối của line cũ tìm được?

## Observation method

Đọc changelog chính thức Mojang cho 26.2 và 26.3 Snapshot 1/2/4; Fabric 26.2 guidance và metadata version docs; GitHub docs về tag-based releases, pre-release, immutable assets, rulesets, matrix workflows và provenance. Không chạy snapshot hoặc mod build vì task đang ở Design Discovery.

## Observations

| Quan sát/version/context | Vấn đề nguồn giải | Nguyên lý | Lựa chọn UMBRA | Evidence | Rủi ro IP |
|---|---|---|---|---|---|
| Java 26.2 phát hành 2026-06-16; Sulfur Caves/Cube thuộc 26.2, không phải 26.3 | phân biệt release truth với tin truyền miệng | support record phải dựa exact upstream release | 26.2 là development baseline | [Minecraft Java 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2) | không có biểu đạt sáng tạo được chuyển |
| 26.3 Snapshot 1 thêm Dappled Forest/Poplar/Abandoned Camps; Snapshot 4 đổi GLFW→SDL3, physical keys và có worldgen/loot/resource-pack changes | một content drop có thể đồng thời đổi input/render/data | audit theo subsystem diff, không suy break từ số biome hoặc phủ nhận rủi ro vì chỉ là content | 26.3 là `UPSTREAM_PREVIEW`; input/render/worldgen đều vào port inventory | [Snapshot 1](https://www.minecraft.net/en-us/article/minecraft-26-3-snapshot-1), [Snapshot 4 notes](https://feedback.minecraft.net/hc/en-us/articles/47424728811149-Minecraft-Java-Edition-26-3-Snapshot-4) | không có |
| Fabric nói 26.2 ảnh hưởng rendering/registration, raw OpenGL cần migrate; pin Loom/Gradle/Loader tại thời điểm công bố | loader/toolchain và game break surface độc lập | exact manifest + adapter/patch inventory; không dùng “latest” | Fabric 26.2 pin qua `DB-019`, OpenGL/Vulkan matrix riêng | [Fabric 26.2](https://fabricmc.net/2026/06/15/262.html) | không có |
| Fabric metadata cảnh báo Minecraft không tuân SemVer và `*` không được khuyến nghị | version range có thể load artifact chưa test | compatibility coordinate exact, UMBRA SemVer tách riêng | metadata pin exact Minecraft; tag/artifact chứa classifier | [Fabric mod metadata](https://docs.fabricmc.net/develop/loader/fabric-mod-json) | không có |
| Mojang cảnh báo testing versions có thể corrupt world và khuyên backup/directory riêng | snapshot user testing có data-loss risk | preview không dùng save chính hoặc support promise | spike isolated + restore-as-copy only | [Minecraft pre-release guidance](https://www.minecraft.net/en-us/article/minecraft-26-2-pre-release-3) | không có |
| GitHub Release dựa trên tag; có pre-release, immutable tag/assets/attestation | người dùng cần tải đúng binary cũ và xác minh provenance | published artifact không được thay tại chỗ | final old-line release giữ asset/checksum; fix dùng tag mới | [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases), [Immutable releases](https://docs.github.com/en/code-security/concepts/supply-chain-security/immutable-releases) | không có |
| GitHub rulesets có thể yêu cầu PR/status checks và chặn force-push/delete; Actions matrix tạo exact job combinations | Git policy và test matrix có thể thực thi | branch/tag truth cần executable guard từ manifest | protect `main`/release/tags; manifest-generated target matrix | [Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets), [Actions matrix](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations) | không có |

## Why it may work there

Mojang/Fabric tối ưu tốc độ phát hành và tiến hóa engine; GitHub cung cấp provenance/distribution primitives nhưng không biết UMBRA save semantics. Vì vậy upstream label hoặc GitHub `Latest` không thể tự quyết support; UMBRA cần gate riêng nối exact manifest với migration/test evidence.

## Transferable principle

Tách ba sự thật: upstream availability, UMBRA verified compatibility và artifact distribution. Mỗi sự thật có state/owner/evidence; chỉ promote khi cả ba hội tụ.

## Does not transfer to Minecraft/UMBRA

- Không coi mọi content addition là Data Registry break hoàn toàn; phải diff thật.
- Không coi compile success hoặc loader xuất hiện là save/render/input parity.
- Không dùng Git branch tồn tại làm support promise; chỉ exact release manifest qua gate mới có quyền đó.
- Không dùng launcher brand thay game/loader/artifact coordinates.

## UMBRA hypothesis

Một current line + successor port branch + immutable final old-line release sẽ giữ chi phí bounded và giảm issue sai version. Lần port đầu phải đo lead time, conflict family, migration failures và support issue misclassification để xác nhận.

## IP/originality guardrail

Research chỉ dùng technical facts/workflow primitives. Không lấy tên, asset, biome expression, UI hoặc content của Mojang/Fabric/GitHub làm biểu đạt UMBRA.

## Evidence quality

- Confidence: cao cho state/naming primitives và upstream facts; trung bình cho maintenance duration vì chưa có public UMBRA release data.
- Missing comparison: telemetry từ một port UMBRA thật và capacity cost của exceptional old-line fix.
- Staleness risk: cao cho 26.3 snapshot/tool versions; audit lại khi 26.3 stable hoặc `DB-019` mở.
