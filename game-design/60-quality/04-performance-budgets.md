# QLT-PERFORMANCE — Hiến chương, ngân sách và bằng chứng hiệu năng

> **DRI:** Performance Lead
> **Approver:** Technical Director + Game Director
> **Reviewers:** Rendering, AI, World, Combat, Data, QA, Accessibility
> **Status:** `DISCOVERY`

## 1. Mục tiêu chất lượng

UMBRA phải giữ phản hồi điều khiển, nhịp chiến đấu và độ an toàn của save trong những world chơi dài, kể cả khi roster, AI, VFX, quest và world simulation tăng mạnh. Hiệu năng là một constraint thiết kế của mọi capability, không phải đợt “tối ưu cuối dự án”.

Không có lời hứa “luôn 60 FPS” độc lập với máy, shader, render distance hoặc scene. Mỗi release phải khai rõ **hardware profile + settings + scene + percentile + thời lượng** mà nó hỗ trợ.

## 2. Sáu mặt ngân sách độc lập

| Mặt | Người chơi cảm nhận | Chỉ số bằng chứng tối thiểu |
|---|---|---|
| Client frame | FPS, 1% low, camera/input không giật | frame time median/p95/p99, CPU/GPU split, spike count |
| Logical server tick | hit/AI/world phản hồi đúng nhịp | MSPT median/p95/p99, tick >50 ms, subsystem attribution |
| Memory/GC | không khựng dần hoặc crash sau chơi lâu | heap live-set, allocation rate, GC pause, retained growth |
| Save/I/O | save/reload/teleport không đóng băng hoặc mất dữ liệu | latency, bytes, queue depth, retry/failure, integrity |
| Network/serialization | offline không lãng phí; future co-op không flood | payload size/rate, recipient count, encode/decode cost |
| Content cardinality | thêm enemy/VFX/NPC không phá budget âm thầm | active count theo tier, query/path/VFX/audio caps |

`20 TPS` cho logical server tạo deadline lý thuyết 50 ms/tick; `60 FPS` và `30 FPS` tương ứng khoảng 16,67 ms và 33,33 ms/frame. Đây là trần toán học, **không** phải toàn bộ ngân sách UMBRA: vanilla, driver, OS và headroom cũng tiêu thời gian.

## 3. Performance envelope cho Retinue nhỏ và world đông

Combat Retinue có hard cap **bốn active Shadow** theo [`CTR-SHADOW-RETINUE`](../30-shared-contracts/07-shadow-retinue-capacity-and-membership.md). Điều này loại giả thuyết 40 Shadow materialized nhưng không làm performance trở nên dễ: bốn companion có identity/relationship/command/animation sâu, hostile crowd, VFX, world simulation và save dài vẫn cạnh tranh cùng ngân sách.

Hostile density không được suy ra từ con số 80 cũ. `DB-018` phải khóa hai scene riêng: (a) encounter đọc được với player + bốn active Shadow và mix hostile thật; (b) spectacle/crowd stress dùng đủ representation tiers. Actor “nhìn thấy” không đồng nghĩa tất cả chạy perception, pathfinding, animation, audio và VFX ở fidelity cao nhất.

Mọi actor/world process phải ở đúng một representation tier:

| Tier | Ý nghĩa | Cho phép |
|---|---|---|
| `FOCUS` | trực tiếp giao chiến/được camera và luật đánh trúng quan tâm | cadence đầy đủ theo archetype; cue gameplay đầy đủ |
| `ACTIVE` | gần và có thể ảnh hưởng sớm | sensing/decision thưa hơn; path và animation có budget |
| `REPRESENTED` | cần nhìn thấy nhưng chưa cần suy nghĩ cá nhân đầy đủ | squad/formation aggregate, animation/VFX giản lược |
| `AGGREGATED` | ảnh hưởng world nhưng không cần entity sống | kết quả nhóm, lịch/sự kiện và tài nguyên theo batch |
| `DORMANT` | không có tác động player-visible hiện tại | chỉ persistent facts; không tick |

Chuyển tier phải có hysteresis để actor không dao động liên tục ở ranh giới. Gameplay cue bắt buộc, hit authority, save/reward và hành động đã commit không được biến mất do giảm tier.

## 4. Luật thiết kế theo subsystem

### AI, society và pathfinding

- Không scan toàn bộ world/roster mỗi tick; dùng spatial index, dirty event và relevance query có cap.
- Sensing, planning, target evaluation và path request có cadence/budget riêng; không giả định mọi actor quyết định mỗi tick.
- Squad chia sẻ threat/formation/path corridor khi phù hợp; cá thể chỉ giữ state tạo khác biệt quan sát được.
- Path request có hàng đợi, priority, timeout, invalidation và fallback an toàn; không tạo path storm khi teleport/chunk đổi.
- Society ngoài vùng quan sát chạy aggregate/event-driven; identity được hydrate khi cần, không mô phỏng “não đầy đủ” cho toàn dân.

### Combat và Shadows

- Hit query có phạm vi/cardinality cap, stable hit ID và dedupe; tốc độ click/packet không tạo thêm damage ngoài Action Timeline.
- Status/auras dùng event, expiry bucket hoặc cadence đã khai; cấm vòng lặp mọi-effect × mọi-entity mỗi tick.
- Shadow command ưu tiên squad intent rồi mới fan-out trong active party; social/home event không broadcast toàn Retinue nếu chỉ một member liên quan.
- Damage numbers, particles, decals và audio voice có pool/cap/aggregation; cue telegraph nguy hiểm luôn ưu tiên hơn spectacle.

### Rendering, camera, UI và asset

- Dùng render abstraction hiện hành của Minecraft/Fabric; không dựa raw OpenGL vì 26.2 có OpenGL/Vulkan và render pipeline đang đổi.
- Tách extraction/preparation khỏi drawing theo API hiện hành; render state phải bounded, immutable/thread-safe khi contract yêu cầu.
- Mesh/material/animation/particle/audio asset có technical budget tại registry; off-screen/occluded/distant presentation được cull hoặc hạ LOD.
- Adaptive quality có thể giảm density, shadow/cosmetic update, animation detail và damage-number clutter; không được giấu target, hit confirm, danger telegraph hay UI state quan trọng.
- OpenGL và Vulkan là hai profile kiểm chứng riêng cho tới khi upstream tuyên bố backend ổn định; fallback/crash recovery của Minecraft không thay test UMBRA.

### World generation, save và I/O

- Pure preparation có thể chạy background chỉ khi dữ liệu thread-safe; mutation world/logical-server state commit trên owner thread theo batch có giới hạn.
- Generation/save queue có backpressure, cancellation và progress/diagnostic; không giữ vô hạn work do player di chuyển nhanh.
- Persistent data tránh snapshot lại toàn bộ graph khi một fact đổi; schema, compaction và migration phải đo trên world dài.
- Save/reward authoritative không bị bỏ để cứu frame. Nếu quá tải, giảm cosmetic/far simulation trước và hoàn tất hoặc rollback transaction an toàn.

### Memory và lifecycle

- Mọi cache có owner, key, cap, invalidation và lifecycle unload; không giữ reference sang world/entity đã đóng.
- Hot path phải khai allocation pressure; pooling chỉ dùng khi profile chứng minh lợi ích và lifecycle an toàn.
- Soak test theo dõi live-set sau GC, không chỉ heap peak; load/unload world, dimension, resource reload và respawn là leak boundaries bắt buộc.

## 5. Thứ tự giảm tải

Khi budget bị vượt, hệ thống giảm theo thứ tự:

1. cosmetic density và ambient audio/VFX;
2. off-screen/distant presentation cadence;
3. ambient society detail và far-world resolution;
4. non-critical AI replanning và background generation throughput;
5. giới hạn tạo thêm actor/work mới, kèm feedback rõ nếu player action bị từ chối.

Không giảm hoặc bỏ: input intent đã nhận, legal hit, telegraph nguy hiểm đang diễn ra, ownership/reward, save transaction và recovery log. Giảm tải phải ổn định, có hysteresis và observable; không “random mất hành vi” mà không biết lý do.

## 6. Benchmark suite chuẩn

| ID | Cảnh | Rủi ro chính |
|---|---|---|
| `PERF-S00` | vanilla/control world cùng seed/settings | phân biệt chi phí base với UMBRA |
| `PERF-S01` | hub đông + UI + lịch NPC | AI/social/render/text/audio |
| `PERF-S02A` | arena: player + 4 active Shadow + encounter hostile mix đã khóa ở `DB-044/018` | combat, target reservation, command, VFX, path, readability |
| `PERF-S02B` | spectacle/crowd: cùng Retinue cap 4 + hostile ở FOCUS/ACTIVE/REPRESENTED/AGGREGATED | degradation, query/path cap, VFX/audio density, outcome correctness |
| `PERF-S03` | Gate generation + player di chuyển/chunk churn | queue, world commit, I/O |
| `PERF-S04` | AoE/status/multi-hit/damage-number burst | spike/cardinality/GC |
| `PERF-S05` | teleport/dimension/death/respawn/reload lặp | leak, stale task, cleanup |
| `PERF-S06` | world dài + save/backup/migrate/restore | live-set, file growth, integrity |
| `PERF-S07` | soak AFK và play script kéo dài | leak, queue drift, degradation |
| `PERF-S08` | future proof: dedicated server + 4 test clients | serialization, relevance, authority; chưa mở multiplayer feature |

Mỗi run ghi version/build, seed, hardware/driver/JDK, heap, backend, resolution, render/simulation distance, quality preset, warm-up, duration và feature flags. Báo median/p95/p99, 1% low/spike, không chỉ average. So với vanilla control và baseline UMBRA gần nhất; regression phải truy được subsystem/feature ID.

## 7. Tooling và mức bằng chứng

- Automated benchmark lấy tick/frame/queue/cardinality counters và lưu machine-readable result.
- Minecraft Tracy GPU timings được dùng cho render investigation trên 26.2; Java Flight Recorder dùng CPU, allocation, GC, lock và I/O. Profiling mode có overhead riêng nên benchmark phải ghi profiler state.
- Unit test chứng minh thuật toán/cap; GameTest chứng minh lifecycle/gameplay; screenshot/video chứng minh presentation; soak/profile chứng minh stability. Không loại bằng chứng nào thay thế loại khác.
- Telemetry trong bản chơi của user mặc định local/opt-in, tối thiểu hóa dữ liệu và có export rõ. Không gửi dữ liệu ngầm.
- Việc **khi nào** phải chạy lane nào do `PR-0–PR-3` tại [Test Architecture](03-testing-and-evidence.md) sở hữu. File này sở hữu metric/budget/scene, không để Agent tự chọn theo cảm tính.

Nguồn kỹ thuật chính: [Minecraft Java 26.2 — Vulkan, Tracy GPU timing và particle overload](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2), [Fabric automated testing](https://docs.fabricmc.net/develop/automatic-testing), [Fabric rendering phases](https://docs.fabricmc.net/develop/rendering/world), [Oracle JFR performance troubleshooting](https://docs.oracle.com/en/java/javase/17/troubleshoot/troubleshoot-performance-issues-using-jfr.html).

## 8. Gate của Feature Cell và content

Mỗi Feature Cell phải khai:

- steady work, burst work, allocation, I/O/network và worst-case cardinality;
- representation tier nào tồn tại và điều kiện chuyển tier;
- load-shed/degradation nào hợp lệ, cue nào bất khả xâm phạm;
- benchmark scene/counter/profile dùng để chứng minh;
- budget owner và hành động khi vượt budget.

Mỗi content instance khai actor, path/query, animation, VFX, audio và UI budget bằng tag/profile dùng chung. “Có vẻ mượt trên máy dev” không đủ để qua gate.

## 9. Gate release và crash prevention

Release/capability slice không qua nếu:

- p95/p99 hoặc 1% low vượt target đã khóa cho profile mà không có waiver/timebox;
- queue, cache, live-set hoặc save size tăng không chặn theo thời gian/cardinality;
- malformed/stale payload, missing content hay resource reload có thể crash;
- overload làm sai hit/reward/save hoặc che telegraph;
- benchmark thiếu vanilla control, metadata tái lập hoặc diff baseline.

Các con số subsystem cũ như “AI ≤8 ms/tick” chỉ còn là **hypothesis**, không là contract cho tới khi `DB-039` khóa hardware profiles, headroom và benchmark evidence.

## 10. Open decisions có owner

- `DB-039`: minimum/recommended hardware profiles, preset và percentile target cho capability đầu.
- `DB-018`: composition/tier/cue và hostile cardinality cụ thể của `PERF-S02A/B`; không phục hồi giả thuyết 40 Shadow.
- `DB-041`: fidelity/tần suất của living society theo tier.
- Mỗi feature tự khóa local budget sau prototype; không xin một con số toàn game từ user.
