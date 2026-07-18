# SYS-LOADER-PORTABILITY — Fabric-first, NeoForge-ready adapter contract

> **DRI:** Technical Director + Compatibility Engineer
> **Approver:** Project Owner + Technical Director
> **Reviewers:** Platform, Data, Networking, Rendering, QA, Performance, Release
> **Status:** `PROPOSED`

## 1. Product decision và support truth

UMBRA tập trung tối ưu và phát hành trên Fabric ở hiện tại. NeoForge là **first-class future target bắt buộc**, không phải best-effort mod compatibility; tuy nhiên chưa phải loader được support cho tới khi có matching Minecraft baseline, artifact riêng và đủ parity evidence.

| Target | Trạng thái hiện tại | Cam kết |
|---|---|---|
| Fabric | `PRIMARY_CURRENT` | mọi capability/release hiện hành tối ưu và kiểm chứng tại đây |
| NeoForge | `REQUIRED_FUTURE / NOT_SUPPORTED` | architecture và data không tự khóa; port được mở theo `DB-043` và gate riêng |
| Loader khác | `UNSCOPED` | không suy rộng từ NeoForge; cần Product decision mới |

Không tạo universal JAR. Mỗi loader có artifact, metadata, dependency manifest, test report và performance baseline riêng; cùng mod version/content/schema vẫn dùng loader classifier rõ.

## 2. Nguyên tắc không thỏa hiệp

- **Một gameplay semantics:** stat, action, damage, AI decision, quest, reward, death và save meaning không được fork theo loader.
- **Fabric không bị kìm:** common contract không ép UMBRA xuống lowest-common-denominator. Fabric-specific optimization/hook hợp lệ ở adapter nếu không đổi semantics.
- **Loader không sở hữu domain:** Fabric/NeoForge event, packet context, attachment hoặc config object không đi vào gameplay core.
- **Schema sống lâu hơn adapter:** stable IDs, content definitions, serialization envelope và migrations không chứa loader runtime ID, event type hoặc implementation class name.
- **Abstraction phải có consumer:** không tạo port tổng quát chỉ vì “có thể cần”; mỗi port nêu semantic need, Fabric consumer và NeoForge mapping hypothesis.
- **Parity theo outcome:** hai loader phải tạo cùng authoritative state/reward/save result; call order, internal trace và frame cost không cần giống hệt.

## 3. Logical dependency layers

Đây là boundary logic; `DB-043` mới quyết lúc nào tách thành Gradle modules/source sets.

| Layer | Được phụ thuộc | Bị cấm |
|---|---|---|
| `domain-core` | Java, UMBRA value/state/command/event | `net.minecraft`, Fabric, NeoForge, client/render |
| `minecraft-common` | `domain-core`, vanilla server-safe types/codecs/registries | Fabric/NeoForge API, `net.minecraft.client` |
| `minecraft-client-common` | common contract + vanilla client/presentation types | loader API, authoritative mutation |
| `platform-contract` | UMBRA semantic ports/result/error/thread contracts | loader event/context/attachment/config type |
| `fabric-adapter` | all relevant common layers + Fabric/Loom/Mixin seams | gameplay rule hoặc schema riêng |
| `neoforge-adapter` (future) | same common layers + NeoForge/ModDevGradle seams | fork domain rule hoặc read Fabric adapter |
| `loader-patches` | minimal loader/version-specific hook implementation | business logic; unowned patch/mixin/AT |

Dependency chỉ đi xuống. Common core không dùng runtime loader detection, reflection hoặc `if (fabric/neoforge)`; adapter được inject tại bootstrap qua explicit composition root.

## 4. Port catalog

| Port | Common sở hữu | Adapter sở hữu |
|---|---|---|
| Bootstrap/lifecycle | phase state machine, idempotency, failure taxonomy | entrypoint, loader event registration, thread handoff |
| Side/environment | logical authority intent, client/server-safe contract | physical/logical side discovery và client entrypoint |
| Registry/content | stable ID, definition, validation, codec | loader registration timing/handle/datagen binding |
| Hook/event | UMBRA command/event vocabulary | Fabric event/mixin hoặc NeoForge event/hook chuyển đổi |
| Network | payload semantics, version, validation, authoritative handler | payload registration, connection context, send/schedule |
| Persistence | canonical schema, migration, retain/reset/copy policy | SavedData/attachment/storage lifecycle và dirty/sync hook |
| Config | key/default/scope/validation/reload semantics | file format/API registration, client/server binding |
| Scheduler | task class, priority, budget, cancellation/backpressure | owner-thread enqueue/tick callback |
| Input/render/UI | action/presentation state và cue contract | loader key/render callbacks, patch/hook |
| Test/diagnostics | fixture/oracle/trace schema | runner registration, log/crash path, launch config |
| Packaging | mod ID/version/content/schema manifest | `fabric.mod.json` hoặc `neoforge.mods.toml`, loader dependencies |

Nếu hai loader cần semantic khác nhau, đó là design conflict: dừng feature, tạo ADR/capability rule; không thêm boolean vào core để che khác biệt.

## 5. Save và content portability

- Namespace, definition ID, player/world/Shadow/quest IDs và canonical schema giữ nguyên giữa loader artifacts.
- Persistent payload dùng loader-neutral primitives/vanilla IDs và versioned codec; không serialize Fabric/NeoForge handle, registry ordinal hoặc Java implementation name.
- Death copy, reconnect, sync visibility và ownership do domain contract quyết; adapter convenience default không được tự thay rule.
- Shared `assets/` và `data/` là nguồn content chính khi vanilla format đủ; loader extension được đặt riêng và phải có fallback/parity declaration.
- Cross-loader chuyển world chỉ được công bố cho exact matrix `source loader/build → target loader/build → Minecraft/schema/content`. Luôn restore-as-copy, không thử trên save chính.
- Port gate cần fixture: tạo state trên Fabric → save/backup → load NeoForge → verify IDs/state → save → load lại Fabric, khi support hai chiều được tuyên bố.

## 6. Hook, mixin và access discipline

- Mỗi hook có `Hook Requirement`: cần quan sát/mutate gì, timing/thread, legal fallback, failure symptom và test oracle.
- Fabric event/API được ưu tiên; Mixin/class tweaker chỉ nằm trong Fabric patch inventory.
- NeoForge ưu tiên official event/extension; Access Transformer/Mixin hoặc patch khác chỉ nằm trong NeoForge inventory.
- Không copy injection target giữa loader mà không re-audit. Cùng Minecraft method không bảo đảm loader patch/order tương đương.
- Loader-specific patch comment ghi requirement ID, lý do public hook không đủ, version sensitivity và regression test.
- Build/static rule phải chặn Fabric/NeoForge import ngoài adapter và client import trong server-safe layers.

## 7. Testing và performance parity

| Suite | Fabric hiện tại | NeoForge tương lai |
|---|---|---|
| Pure domain/model | chạy một lần, không loader | dùng cùng artifact/tests |
| Minecraft-common contract | current baseline | cùng baseline/compiler proof |
| Adapter conformance | bắt buộc | bắt buộc trước technical preview |
| GameTest/integration | Fabric runner/client/server | NeoForge runner/client/server |
| Dedicated side smoke | bắt buộc mọi capability | bắt buộc mọi supported capability |
| Save portability | self round-trip/migration | cross-loader fixtures trước claim |
| Performance | Fabric budget baseline | baseline riêng; không mượn số Fabric |
| Visual/input parity | Fabric screenshots/traces | loader/backend matrix riêng |

Scenario ID, fixture, oracle và expected authoritative outcome dùng chung khi có thể; adapter bootstrap code không được copy test logic. Loader port/change được xếp `PR-3` theo `QLT-TEST` vì tác động lifecycle, performance và compatibility rộng.

## 8. Rollout gates

1. `L0 — BOUNDARY_READY`: C1 có import rules, port catalog, Fabric adapter inventory và common contract tests; chưa có NeoForge code.
2. `L1 — PORTABILITY_SPIKE`: matching NeoForge baseline tồn tại; một vertical vô hại bootstrap + registry + payload + save chạy trên branch/spike.
3. `L2 — TECH_PREVIEW`: NeoForge artifact riêng, install/dedicated/save/recovery diagnostics và feature manifest; không gọi full support.
4. `L3 — SUPPORTED_PARITY`: mọi capability trong release manifest qua conformance, lifecycle, save, performance, localization/accessibility và known-conflict gates.
5. `L4 — CO-RELEASE`: hai loader cùng release train nếu chi phí vận hành/evidence bền vững; không phải mặc định bắt buộc.

Port spike không được chen vào trước C1 foundation proof. Nếu matching NeoForge baseline chưa ổn định, giữ `L0`; không đoán API hoặc trì hoãn Fabric.

## 9. Definition of architecture ready

- Hai consumer thật chứng minh mỗi port được tạo.
- Không Fabric import ngoài adapter theo dependency/static check.
- Canonical save fixture không chứa loader implementation detail.
- Fabric feature chạy integrated + dedicated với cùng outcome.
- Adapter failure có capability state/diagnostic rõ, không crash mơ hồ.
- Cold Agent có thể chỉ ra nơi thêm NeoForge binding cho registry/network/save/hook mà không sửa domain rule.

Research/evidence: [Loader Portability Findings](../../70-research/06-loader-portability-findings.md). Proposed rationale: [ADR-0001](decisions/ADR-0001-loader-portability-strategy.md). Production owner: `DB-043`.
