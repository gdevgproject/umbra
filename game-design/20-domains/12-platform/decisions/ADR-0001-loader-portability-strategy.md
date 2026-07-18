# ADR-0001 — Fabric-first ports-and-adapters cho future NeoForge

> **Status:** `PROPOSED`
> **Date:** 2026-07-19
> **Decision owner:** Technical Director + Project Owner
> **Affected IDs:** `PD-029`, `SYS-COMPAT`, `SYS-FOUNDATION-KERNEL`, `SYS-LOADER-PORTABILITY`, `DB-043`
> **Supersedes / superseded by:** none

## Context

UMBRA cần tối ưu Fabric ngay bây giờ nhưng Product đã khóa NeoForge là first-class future target. Hai loader khác entrypoint/lifecycle/event, registration, networking, persistence/config, build/packaging và patch strategy. Nếu Fabric API lọt vào gameplay/save, port sau sẽ fork luật; nếu chung hóa mọi API trước consumer, foundation trở thành framework vô hạn và kìm Fabric.

## Decision criteria

1. Không fork gameplay semantics hoặc canonical save.
2. Fabric current path đạt performance/feature quality tối đa.
3. Chi phí NeoForge port tăng theo adapter, không theo toàn bộ feature corpus.
4. Test/diagnostics có thể chứng minh parity và tìm loader-specific failure.
5. Chỉ xây abstraction có consumer; architecture đảo được theo evidence.

## Options considered

### Option A — Fabric trực tiếp khắp code, port sau

- Lợi ích: tốc độ bootstrap ban đầu cao nhất.
- Chi phí/rủi ro: event/context/attachment/config nhiễm domain; save/death/network semantics dễ fork; port cost tăng theo feature.
- Reversibility: thấp sau khi persistent features và render hooks lan rộng.

### Option B — Universal abstraction/JAR ngay từ đầu

- Lợi ích: loader được nhìn thấy sớm trong build.
- Chi phí/rủi ro: lowest-common-denominator, empty interfaces, reflection/runtime detection, CI nặng; không có matching NeoForge consumer để chứng minh API.
- Reversibility: trung bình nhưng cleanup lớn; dễ biến foundation thành sản phẩm riêng.

### Option C — Ports-and-adapters có chọn lọc, Fabric-first

- Lợi ích: semantics/schema/oracle chung; Fabric dùng capability riêng ở adapter; NeoForge port theo conformance; boundary test được.
- Chi phí/rủi ro: cần dependency discipline, adapter inventory và một số wiring; không thể đạt 100% source chung ở render/patch.
- Reversibility: cao nếu port nhỏ và theo capability.

## Decision

Đề xuất chọn **Option C**. C1 chỉ đạt `L0 — BOUNDARY_READY`: logical layers, import guard, common schema/oracle và Fabric adapter conformance. Không tạo NeoForge module/implementation trước matching baseline và `L1` spike. Hai loader phát hành JAR/manifest/performance report riêng; parity được đo theo authoritative outcome.

Quyết định Product “NeoForge là future target bắt buộc” đã được ghi ở `PD-029`; ADR này chưa `ACCEPTED` cho tới khi `DB-043` có compile/dependency/conformance proof và Project Owner duyệt.

## Consequences

- Positive: save/gameplay không bị loader sở hữu; Fabric không phải chờ NeoForge; future port có seam/test rõ.
- Negative: C1 phải duy trì import/dependency guard và composition root; adapter code không bằng zero.
- New constraints/debt: Hook Requirement/patch inventory theo loader; artifacts và performance baselines tách riêng; cross-loader save claim cần fixture.
- Follow-up/evidence: hai Fabric consumers cho mỗi port, common-core compile proof, dedicated smoke, harmless NeoForge vertical khi baseline tồn tại.

## Rollback/supersession trigger

Xem lại nếu NeoForge/Minecraft tạo shared official abstraction loại bỏ phần lớn adapter, hoặc port proof cho thấy port contract đắt hơn isolated code mà không tăng save/semantic safety. Supersession phải giữ canonical schema/migration; không chuyển bằng cách fork save hoặc xóa compatibility history.
