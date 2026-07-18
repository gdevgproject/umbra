# SYS-COMPAT — Version, loader, compatibility và porting policy

> **DRI:** Release Engineer + Platform/Compatibility Engineer
> **Approver:** Technical Director
> **Status:** `PROPOSED`

## 1. Support truth hiện hành

Baseline discovery hiện tại là Minecraft Java `26.2`, Java `25`, Fabric. Vanilla 26.2 công bố Data Pack `107.1`, Resource Pack `88.0` và experimental Vulkan/OpenGL fallback. Fabric 26.2 guidance dùng Loom `1.17`, Gradle `9.5.1` và Loader stable lúc công bố `0.19.3`; exact API/plugin/build phải pin trong release ADR, không dùng chữ “latest”.

NeoForge là future loader bắt buộc nhưng **chưa supported và chưa có 26.2 manifest được UMBRA kiểm chứng** tại audit 2026-07-19. Official NeoForge docs/news hiện cung cấp guidance 26.1 trong research set; Agent không được suy ra 26.2 bằng version name.

Nguồn: [Minecraft Java 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2), [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html), [NeoForge docs](https://docs.neoforged.net/), [NeoForge news](https://neoforged.net/news/).

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
