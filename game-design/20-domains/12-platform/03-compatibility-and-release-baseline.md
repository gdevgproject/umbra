# SYS-COMPAT — Version, compatibility và porting policy

> **DRI:** Release Engineer + Platform/Compatibility Engineer
> **Status:** `PROPOSED`

## 1. Baseline hiện hành

Baseline discovery là Minecraft Java `26.2`, Java `25`, Fabric; vanilla 26.2 công bố Data Pack `107.1`, Resource Pack `88.0` và experimental Vulkan/OpenGL fallback. Tại thời điểm audit 2026-07-18, Fabric hướng dẫn 26.2 dùng Loom `1.17`, Gradle `9.5.1` và stable Loader lúc công bố là `0.19.3`; exact Fabric API/build plugin vẫn phải pin trong release ADR, không lấy chữ “latest” làm reproducible build.

Nguồn: [Minecraft Java 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2), [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html).

## 2. Support policy

| Tier | Cam kết |
|---|---|
| `SUPPORTED` | exact Minecraft/Fabric/Java baseline trong release manifest; vanilla survival/creative/spectator đã khai; first/third-person UMBRA |
| `VERIFIED OPTIONAL` | integration/config/resource pack được liệt kê và chạy matrix |
| `BEST EFFORT` | mod không đụng cùng boundary; bug được xem nhưng không block release |
| `UNSUPPORTED CONFLICT` | combat/camera/animation/UI/progression/world-overhaul khác ghi đè cùng contract |

UMBRA là overhaul ưu tiên và có thể can thiệp sâu. Không hứa tương thích mọi mod; khi xung đột, UMBRA không làm méo core experience để nhường một overhaul khác. Tuy vậy, feature vanilla không liên quan—đặc biệt first-person, mining, building, inventory và world save—không được phá chỉ vì UMBRA ưu tiên.

## 3. Minecraft version strategy

- Mỗi release artifact target một baseline/minor đã kiểm chứng; không khai range rộng chỉ vì Fabric cho phép syntax semver.
- Minecraft không tuân semantic versioning; patch/minor đều phải qua compatibility evidence.
- Không làm một JAR đa-minor hoặc backward binary compatibility nếu adapter/test cost lớn hơn giá trị. Thường port source sang release branch mới an toàn hơn.
- Backward compatibility ưu tiên **world/save migration**, không phải chạy cùng binary trên mọi Minecraft cũ.
- Giữ previous stable branch đủ lâu để xuất/khôi phục save và sửa lỗi mất dữ liệu nghiêm trọng; feature mới đi vào active baseline.
- Upgrade save chỉ từ các schema được công bố. Downgrade world không support; game cảnh báo/refuse hoặc yêu cầu copy backup, không thử “best effort” trên save chính.

## 4. Architecture chống break

Minecraft/Fabric hooks nằm sau adapter theo capability: input, camera/render, registry/data, networking, persistence, UI và lifecycle. Gameplay domain không gọi raw platform API khắp nơi. Ưu tiên Fabric event/API; mixin có owner, target, failure symptom, version sensitivity và regression test.

26.2 có experimental Vulkan và Fabric cảnh báo raw OpenGL sẽ break; UMBRA dùng Minecraft/Blaze3D render abstraction, không raw OpenGL trong gameplay/presentation modules. Backend OpenGL/Vulkan là matrix riêng khi renderer được triển khai.

## 5. Porting train

```text
Release note/API diff → sandbox branch → compile/bootstrap
→ adapter/mixin inventory → data/resource pack diff → key baseline diff
→ automated/lifecycle/save migration → render/perf matrix
→ manual feel/readability smoke → compatibility ADR → promote baseline
```

Mỗi port record khóa Minecraft, data/resource pack versions, Fabric Loader/API/Loom/Gradle/Java, mappings, OS/JVM/GPU backend, dedicated server, known conflicts và rollback. Không nâng baseline trên `main` trước khi world copy và previous snapshot đều có đường khôi phục.

## 6. Release decision

Không buộc update ngày đầu Minecraft ra bản mới. Ưu tiên bảo toàn save và experience; new baseline chỉ được công bố khi capability gates xanh. Nếu Mojang update phá rendering/input/data lớn, duy trì bản UMBRA stable cũ trong khi port branch hoàn thiện là hành vi đúng, không phải thất bại.
