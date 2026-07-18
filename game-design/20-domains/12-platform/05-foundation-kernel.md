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
| Compatibility adapters | Fabric/Minecraft/render/event seams pin theo baseline | promise mọi version/mod |
| Communication resources | locale/resource reload, key/placeholder validation hooks | prose/translation quality |

## Dependency rule

Domain phụ thuộc contract/ports của kernel; kernel không import feature implementation. Domain không đọc persistence/network/render API trực tiếp ngoài adapter đã sở hữu nếu việc đó làm lifecycle khó test/migrate. Không xây event bus tổng quát nếu command/call trực tiếp trong cùng boundary rõ hơn.

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

Class/package/framework cụ thể chưa được khóa. DB-021 chỉ qua discovery khi hai consumer thật chứng minh mỗi abstraction và một vertical fixture kiểm được failure/recovery.
