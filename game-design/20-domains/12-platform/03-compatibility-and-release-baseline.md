# SYS-COMPAT — Version, loader, compatibility và porting policy

> **DRI:** Release Engineer + Platform/Compatibility Engineer
> **Approver:** Technical Director
> **Status:** `PROPOSED`

## 1. Support truth hiện hành

Baseline discovery hiện tại là Minecraft Java `26.2`, Java `25`, Fabric. Vanilla 26.2 công bố Data Pack `107.1`, Resource Pack `88.0` và experimental Vulkan/OpenGL fallback. Fabric 26.2 guidance dùng Loom `1.17`, Gradle `9.5.1` và Loader stable lúc công bố `0.19.3`; exact API/plugin/build phải pin trong release ADR, không dùng chữ “latest”. Đây là `DEVELOPMENT_BASELINE`, chưa phải public `SUPPORTED` vì chưa có UMBRA artifact.

Minecraft `26.3` mới ở snapshot tại audit 2026-07-19. Snapshot 1 thêm Dappled Forest/Poplar/Abandoned Camps; Snapshot 4 đã đổi GLFW sang SDL3, keybind sang physical key và thay đổi world generation/loot/resource pack. Đây là bằng chứng port surface rộng, không phải bằng chứng mọi Data Registry hoặc mọi mod worldgen chắc chắn “break hoàn toàn”. UMBRA ghi `UPSTREAM_PREVIEW`, không build support promise từ snapshot.

NeoForge là future loader bắt buộc nhưng **chưa supported và chưa có 26.2 manifest được UMBRA kiểm chứng** tại audit 2026-07-19. Official NeoForge docs/news hiện cung cấp guidance 26.1 trong research set; Agent không được suy ra 26.2 bằng version name.

Nguồn: [Minecraft Java 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2), [26.3 Snapshot 1](https://www.minecraft.net/en-us/article/minecraft-26-3-snapshot-1), [26.3 Snapshot 4 notes](https://feedback.minecraft.net/hc/en-us/articles/47424728811149-Minecraft-Java-Edition-26-3-Snapshot-4), [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html), [NeoForge docs](https://docs.neoforged.net/), [NeoForge news](https://neoforged.net/news/).

## 2. Hai trục compatibility độc lập

| Trục | Ví dụ | Gate riêng |
|---|---|---|
| Minecraft baseline | Fabric 26.2 → Fabric 26.3 | API/data/resource/render/key/save diff |
| Loader target | Fabric 26.2 → NeoForge cùng Minecraft baseline | adapter/conformance/parity/package/save/perf |

Không đổi cả Minecraft baseline và loader trong cùng một port spike nếu có thể; nếu fail sẽ không biết trục nào gây lỗi. Mỗi artifact target đúng một `Minecraft × loader × Java × UMBRA schema/content` manifest.

## 3. Support tiers

| Tier | Cam kết |
|---|---|
| `SUPPORTED` | exact manifest và loader artifact đã qua release gate; hiện chỉ Fabric khi C1 tồn tại |
| `REQUIRED_FUTURE` | target Product đã khóa nhưng chưa có user support promise; NeoForge hiện ở đây |
| `VERIFIED OPTIONAL` | integration/config/resource pack cụ thể chạy matrix |
| `BEST EFFORT` | mod không đụng cùng boundary; bug được xem nhưng không block release |
| `UNSUPPORTED CONFLICT` | combat/camera/animation/UI/progression/world overhaul khác ghi đè cùng contract |

UMBRA có thể can thiệp sâu và không hứa tương thích mọi mod. Feature vanilla không liên quan—first-person, mining, building, inventory và world save—không được phá chỉ vì UMBRA ưu tiên.

## 4. Minecraft version strategy

- Mỗi release artifact target một baseline đã kiểm chứng; không khai range rộng chỉ vì metadata cho phép.
- Patch/drop đều qua compatibility evidence; Minecraft không cho UMBRA một semantic-versioning promise.
- Không làm một JAR đa-minor nếu adapter/test cost vượt giá trị. Port source trên branch mới thường an toàn hơn.
- Backward compatibility ưu tiên world/save migration, không phải binary chạy mọi bản Minecraft cũ.
- Giữ previous stable branch đủ lâu để restore/export và sửa data-loss nghiêm trọng.
- Downgrade world không support: cảnh báo/refuse hoặc restore copy, không thử best-effort trên save chính.

## 5. Loader strategy

Canonical boundary nằm tại [Loader Portability Contract](07-loader-portability-and-adapter-contract.md).

- Fabric là composition root/adapter hiện tại và được tối ưu bằng API/hook phù hợp.
- NeoForge dùng adapter/artifact riêng; không đọc Fabric adapter hoặc fork gameplay rule.
- Stable ID, content definitions, payload semantics, save schema và scenario oracle dùng chung.
- Loader event, lifecycle, config, attachment, packet context, patch/mixin/AT và packaging nằm ngoài domain core.
- Không phát hành universal JAR hoặc dùng runtime reflection để đoán loader.
- Feature parity được khai bằng capability manifest; khác biệt có chủ ý cần ADR/fallback, không im lặng.

## 6. Architecture chống break

Minecraft/loader hooks nằm sau port theo capability: bootstrap/lifecycle, side, registry/content, input, camera/render, networking, persistence, config, UI, scheduler và tests. Gameplay domain không gọi raw platform API khắp nơi.

Fabric event/API được ưu tiên; Mixin có owner, Hook Requirement, target, failure symptom, version sensitivity và regression. NeoForge future re-evaluate bằng official event/extension trước khi dùng AT/Mixin. 26.2 có experimental Vulkan nên UMBRA dùng Minecraft render abstraction và kiểm OpenGL/Vulkan riêng.

## 7. Version port train — cùng loader

```text
Official/API diff → sandbox branch → compile/bootstrap
→ adapter/patch inventory → data/resource/key diff
→ automated/lifecycle/save migration → render/perf matrix
→ feel/readability smoke → compatibility ADR → promote
```

Record khóa Minecraft, loader/API/build plugin/Gradle/Java, mappings khi liên quan, data/resource versions, OS/JVM/GPU backend, dedicated server, known conflicts và rollback.

## 8. Loader port train — cùng Minecraft baseline

```text
Matching stable loader/toolchain → adapter capability map
→ harmless vertical spike → import/dependency audit
→ shared contract + adapter conformance
→ registry/network/save/lifecycle/dedicated
→ cross-loader save fixture → render/input/perf parity
→ capability manifest/known differences → technical preview
→ supported gate
```

NeoForge port không bắt đầu chỉ vì loader phát hành. `DB-043` phải chứng minh Fabric boundary trước; port branch không thay đổi canonical gameplay để “làm NeoForge dễ hơn”.

## 9. Artifact và save policy

- Artifact name/manifest luôn chứa loader classifier; mod ID/namespace và UMBRA version giữ nhất quán.
- Release notes nói rõ loader, Minecraft, Java, schema/content, supported features và known differences.
- Cross-loader world portability chỉ được claim cho matrix đã test; restore-as-copy + backup manifest bắt buộc.
- Loader-specific state không được lọt vào canonical payload. Nếu extension bất khả tránh, nó có version/fallback/migration owner.

## 10. Release decision

Không buộc update ngày đầu Minecraft/loader ra bản mới. New baseline/loader chỉ được công bố khi capability gates xanh. Duy trì Fabric stable trong lúc NeoForge port hoặc Minecraft update lớn là đúng; không trì hoãn trải nghiệm hiện tại để chạy theo version badge.

## 11. Vòng đời một Minecraft support line

Canonical state machine:

```text
UPSTREAM_PREVIEW
→ PORT_CANDIDATE
→ DEVELOPMENT_BASELINE hoặc PORTING
→ SUPPORTED_CURRENT
→ MAINTENANCE_FINAL
→ EOL_ARCHIVED
```

| State | Nghĩa vận hành | User promise |
|---|---|---|
| `UPSTREAM_PREVIEW` | snapshot/pre-release upstream; chỉ diff/research/spike cô lập | không artifact, không mở world UMBRA thật, không issue support |
| `PORT_CANDIDATE` | Minecraft stable đã ra và matching Fabric/toolchain đủ để intake | chưa thay current; inventory diff/risk/cost trước |
| `DEVELOPMENT_BASELINE` | baseline đang xây trước public release | test nội bộ, không gắn badge `SUPPORTED` |
| `PORTING` | successor ở branch port; current line vẫn là truth phát hành | preview artifact nếu có phải gắn pre-release và save test riêng |
| `SUPPORTED_CURRENT` | exact manifest qua release gate và là dòng chính duy nhất | feature/fix/release thường xuyên theo scope hiện hành |
| `MAINTENANCE_FINAL` | successor đã sẵn sàng promote; dòng cũ chỉ nhận blocker/security/save-loss đã duyệt | chuẩn bị final release, migration note và EOL date |
| `EOL_ARCHIVED` | final artifact/tag/release bị đóng băng | vẫn tải được; không feature/fix thường lệ; không xóa hoặc đổi asset cũ |

Mojang phát hành bản mới chỉ chuyển nó thành `PORT_CANDIDATE`; không tự động EOL current. Dòng cũ chỉ rời `SUPPORTED_CURRENT` khi successor đã qua gate promote, có migration/backup/recovery proof và có final release record. Ngoại lệ sau EOL chỉ dành cho lỗi security hoặc data-loss nghiêm trọng do Project Owner + Technical Director mở lại; nếu không thể sửa an toàn, advisory và restore path thay cho bản vá giả.

## 12. Quy tắc intake snapshot và promote successor

1. Snapshot được theo dõi bằng upstream digest: registry/data/resource/input/render/network/save/worldgen và loader/toolchain signal; không merge snapshot dependency vào `main`.
2. Spike snapshot chỉ mở khi trả lời một câu hỏi blocker khó đảo, dùng world/instance riêng và bị xóa/chưng cất sau research; không publish như compatibility build.
3. Khi Minecraft stable ra, Release Engineer tạo candidate manifest và official/API diff; Platform/Compatibility Engineer lập Hook/Adapter/Patch inventory; QA gán `PR-3` và chọn old→new migration fixtures.
4. Port chạy trên `port/mc-<version>-<loader>`. `main` vẫn compile/load/save trên current line cho tới khi port gate xanh.
5. Promote cần clean install, integrated/dedicated, old-save backup→copy→migration→save/reload, new-world, input/key diff, render backend, performance/soak, known-conflict và diagnostics evidence.
6. Trước khi chuyển `main`, cắt final tag/release cho dòng cũ và tạo/freeze `release/mc-<old>` nếu cần giữ một maintenance reference. README/issue forms/release index đổi trong cùng transaction với promotion.

Không merge ngược toàn bộ successor vào branch cũ. Một fix cần cả hai line được port/cherry-pick theo bug ID, regression oracle và review riêng; cùng source diff không chứng minh cùng behavior trên hai Minecraft baseline.

## 13. Version coordinates, tag và artifact

UMBRA product version (`MAJOR.MINOR.PATCH`) mô tả thay đổi sản phẩm/schema của UMBRA; Minecraft/loader/Java là compatibility coordinates độc lập. Minecraft không tuân Semantic Versioning, nên metadata phải pin exact version—không dùng `*`, `^26.2` hoặc range rộng để ngụ ý 26.3 support.

| Artifact | Convention |
|---|---|
| Git tag/release | `v<umbra>-mc<minecraft>`, ví dụ `v0.4.2-mc26.2` |
| Pre-release | `v<umbra>-rc.<n>-mc<minecraft>` và GitHub flag `pre-release` |
| JAR | `umbra-<umbra>-mc<minecraft>-<loader>.jar` |
| Port branch | `port/mc-<minecraft>-<loader>` |
| Maintenance reference | `release/mc-<minecraft>`; chỉ tồn tại khi có release line thật |

Một GitHub Release có thể chứa nhiều loader artifact chỉ khi tất cả dùng cùng UMBRA/Minecraft release manifest và mỗi loader đã qua gate riêng. Checksum, source commit, workflow run/provenance, Minecraft, Java, loader/API, schema/content, capability set, migration-from, renderer/backend và known issues là trường bắt buộc. Tag và published asset không di chuyển hoặc thay thế; bản sửa dùng version/tag mới.

## 14. GitHub là projection công khai của support truth

- Root README luôn có bảng `Minecraft line × loader × status × download`; badge chỉ là shortcut, không là source duy nhất.
- GitHub Release là record tải xuống bất biến của một exact manifest. `Latest` chỉ trỏ `SUPPORTED_CURRENT`; final EOL release ghi rõ successor và ngày kết thúc hỗ trợ nhưng vẫn giữ asset.
- Release notes bắt buộc có `Requires`, `Supports`, `Does not support`, `Upgrade from`, `Backup first`, `Known incompatibilities`, `Diagnostics/issue link` và checksum/provenance.
- GitHub issue form bắt exact UMBRA/Minecraft/Java/loader/API/renderer/OS, source of artifact, reproduction và diagnostic bundle version. Launcher là context tái hiện, không phải compatibility coordinate; một launcher bên thứ ba không tự cấp hoặc hủy support.
- GitHub Actions dùng matrix sinh từ manifest cho các target đang `SUPPORTED_CURRENT`/port gate; không để YAML và README tự phát minh hai danh sách version khác nhau.
- Ruleset bảo vệ `main`, `release/mc-*` và release tags: PR + required checks, cấm force-push/delete; exact Git owner nằm ở [`GOV-ENGINEERING`](../../00-governance/06-engineering-and-git-workflow.md).

## 15. Ownership và decision rights

| Quyết định/đầu việc | DRI | Approver/reviewer |
|---|---|---|
| watch snapshot, candidate manifest, release/EOL communication | Build/Release Engineer | Producer + Community/Support |
| API/hook/registry/render/save diff và port implementation | Platform/Compatibility Engineer | Technical Director |
| compatibility/migration/performance matrix | Compatibility QA | QA Lead + Performance + Data |
| promote successor, end current line, exceptional EOL respin | Build/Release Engineer | Project Owner + Technical Director |

Trong studio một người, đây là bốn review pass có artifact riêng, không phải bốn người giả. `PD-044` cấp standing authority để Agent thực thi routine promote/EOL sau khi gate xanh; cột Approver là policy/gate authority, không bắt Project Owner xác nhận lại từng lệnh Git. Exception đổi public promise hoặc respin ngoài policy vẫn phải hỏi. Decision rationale và reversibility của model nằm tại [ADR-0003](decisions/ADR-0003-minecraft-support-line-and-github-release-model.md); research evidence nằm tại [Release Operations Findings](../../70-research/12-minecraft-version-and-release-operations.md).

## 16. Debug/bisect contract qua baseline

Mọi compatibility bug phải phân biệt tối thiểu `UPSTREAM_MINECRAFT`, `LOADER_API`, `UMBRA_COMMON`, `UMBRA_ADAPTER_PATCH`, `DATA_RESOURCE`, `SAVE_MIGRATION`, `RENDER_BACKEND`, `EXTERNAL_MOD` hoặc `LAUNCH_ENVIRONMENT`. Triage bắt đầu từ exact manifest + last-known-good tag, sau đó mới chạy vanilla/control, UMBRA-only và mod-matrix fixtures; không sửa gameplay rule chỉ vì một hook fail.

Port branch giữ commit nhỏ theo capability và mỗi Hook Requirement liên kết failure symptom/test để `git bisect` có ý nghĩa. Diagnostic bundle phải đủ để so old/new baseline mà không yêu cầu người chơi tự đoán jar, loader hoặc backend nào đã chạy.
