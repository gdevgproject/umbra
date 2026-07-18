# SYS-FOUNDATION-KERNEL — Nền tảng tối thiểu có sức chịu tải lớn

> **DRI:** Technical Director
> **Status:** `DISCOVERY`

Foundation không phải một “God Core” biết mọi feature. Nó là tập capability nhỏ có contract ổn định để feature không tự giải quyết lại lifecycle/authority/data/test.

## Kernel capabilities

| Capability | Sở hữu | Không sở hữu |
|---|---|---|
| Bootstrap/side separation | registration, common/client/server entry, fail-fast report | gameplay rule |
| Identity/registry | namespace, stable IDs, action/content/asset version/reference validation | content meaning |
| Config/capability manifest | config layers, validation, feature availability | balance decision |
| Persistence/migration | schema envelope, portable backup manifest, migration journal, restore/recovery | domain fields không có owner |
| Command/event envelope | intent/result/idempotency/correlation | domain state machine |
| Authority/security guards | ownership/permission/range/rate/rejection | speculative anti-cheat game |
| Scheduler/work budget | cadence, queue, backpressure, labels | AI/combat decision |
| Observability/test hooks | trace, state inspector, diagnostics bundle, fixture APIs | production cheat behavior |
| Compatibility adapters | Minecraft/loader/render/event ports; Fabric binding hiện tại và conformance diagnostics | NeoForge implementation sớm hoặc promise mọi version/mod |
| Communication resources | locale/resource reload, key/placeholder validation hooks | prose/translation quality |

## Dependency rule

Domain phụ thuộc contract/ports của kernel; kernel không import feature implementation. Domain không đọc persistence/network/render/loader API trực tiếp ngoài adapter đã sở hữu nếu việc đó làm lifecycle khó test/migrate. Fabric/NeoForge type không đi qua port. Không xây event bus tổng quát nếu command/call trực tiếp trong cùng boundary rõ hơn.

Bounded capability, logical layer, public/internal surface, transaction/process, thread owner, failure containment và Change Surface Map tuân [`SYS-RUNTIME`](02-runtime-boundaries-and-authority.md). Kernel cung cấp primitive để thực thi contract đó nhưng không tự trở thành owner của mọi state hoặc orchestration. C1 phải có architecture fitness tests cho cycle, allowed dependency/internal access, forbidden loader/client import và public contract inventory; diagram/comment không thay automated proof.

## Capability availability

Mỗi feature có `ABSENT`, `DEV_ONLY`, `ENABLED`, `DISABLED_BY_CONFIG`, `UNAVAILABLE_INCOMPATIBLE` hoặc `MIGRATION_BLOCKED`. UI/content registration và save behavior theo state này; disabled không có nghĩa xóa persistent data. Capability dependency được validate khi load, không phát hiện giữa combat.

## Những quyết định khó đảo cần đóng sớm

- namespace/stable ID và content reference;
- server/client source separation và authority envelope;
- save root/schema/version/backup/migration journal;
- definition vs instance vs derived state;
- capability/config precedence;
- diagnostics/test fixture seam;
- render/camera adapter boundary;
- input Action ID/key-registry diff và locale/resource reload boundary;
- portable world backup/restore manifest;
- ownership/idempotency/error taxonomy.
- loader-neutral domain/save boundary, Fabric adapter inventory và import/dependency guard.
- causal trace/reason/state-inspector envelope và diagnostic bundle contribution.
- public command/query/event/port inventory, owner-thread/async commit và cross-capability process journal boundary.

Class/package/framework cụ thể chưa được khóa. `DB-021/043` chỉ qua discovery khi hai consumer thật chứng minh mỗi abstraction, một vertical fixture kiểm failure/recovery, architecture violation fixture chứng minh guard thật sự bắt lỗi và Fabric conformance không cần NeoForge code giả.
