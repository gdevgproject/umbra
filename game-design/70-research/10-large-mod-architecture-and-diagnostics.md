# RES-LARGE-MOD-ARCH — Boundary verification và causal diagnostics cho mod lớn

> **DRI:** Technical Director + Test Architecture Lead
> **Status:** `EVIDENCE_SEED`
> **Audit date:** 2026-07-19

## Decision question

UMBRA cần những constraint và proof nào để modular monolith vẫn khoanh vùng lỗi, kiểm blast radius và truy nguyên nhân khi AI/content/save/loader/presentation tăng mạnh, mà không biến foundation thành framework vô hạn?

## Evidence chưng cất

| Quan sát/version/context | Nguyên lý | Lựa chọn UMBRA | Bằng chứng cần giữ | Rủi ro IP |
|---|---|---|---|---|
| ArchUnit hỗ trợ kiểm layered/onion architecture và cycle giữa slices bằng automated rule | boundary chỉ đáng tin khi vi phạm làm test fail, không chỉ nằm trong diagram/comment | `DB-021` cần fitness functions cho cycle, allowed edge, internal access, loader/client import; tool cụ thể vẫn candidate | violation fixtures + generated module/dependency report trong C1 | API/tooling, không có biểu đạt gameplay |
| Spring Modulith mô tả logical module bằng provided API/event, internal implementation và required interface; verification bắt cycle, internal access và dependency ngoài allowlist | module cần public surface/consumer rõ và structural verification; framework không phải điều kiện của nguyên lý | mỗi bounded capability khai public command/query/event/port và internal surface; UMBRA không thêm Spring runtime | cold-agent report + contract tests + consumer inventory | không copy code/framework structure; chỉ dùng principle |
| OpenTelemetry context propagation liên kết trace/log/metric qua `trace_id` và parent context; tài liệu cũng cảnh báo sanitize untrusted context/baggage | correlation cần causal context xuyên async/boundary và privacy/security policy | UMBRA dùng trace/correlation/causation/operation IDs trong in-process envelope; không mặc định ship exporter hoặc nhận client ID như truth | intent→mutation→projection/save trace, forged-context và sampling/overflow tests | telemetry convention, không có asset/moveset |
| OpenTelemetry phân trace, metric, log và profile thành tín hiệu trả lời câu hỏi khác nhau | một log text không thay state inspector, counter hay profiler; các tín hiệu cần cùng build/scenario context | `CTR-DEBUG-OBSERVABILITY` tách trace/state/metric/artifact và cho phép link JFR/profile reference | diagnostic bundle có manifest + recent trace + state + perf reference | không có |
| Fabric events là callback/hook và thường thay mixin; custom event vẫn cần trigger/test implementation | loader event là integration seam, không tự trở thành domain event hoặc ownership model | Fabric adapter map callback thành UMBRA command/fact; event bus không che dependency/ordering | Hook Requirement + adapter conformance + listener-order-independent oracle | không có |
| NeoForge lifecycle có event bus riêng, nhiều mod lifecycle event chạy parallel và cần enqueue về main thread khi phù hợp | callback order/thread khác loader là rủi ro thật; thread/phase phải nằm trong port contract | adapter normalize lifecycle phase/thread trước application/domain; không dùng registration order làm gameplay rule | parallel/owner-thread violation fixture và dedicated startup trace | không có |
| Fabric và NeoForge đều có GameTest nhưng runner/registration khác | scenario/oracle chung nên sống ngoài loader bootstrap; adapter cần conformance riêng | giữ shared scenario IDs/outcome, runner theo loader; không copy test logic vào adapter | pure/contract + loader integration manifest | không có |
| Oracle JFR 25 cho phép tìm thread stall, allocation/GC/I/O và memory leak; profiler setting có thể tự tạo pause/observer effect | performance trace cần profiler metadata, live-set/tail và correlation với scenario; profile không thay causal domain trace | diagnostic bundle link recording/profile, không ghi JFR mọi lúc hoặc coi một profile là budget verdict | build/seed/settings/profiler-state + p95/p99/live-set trend | không có |

## Sources chính thức

- [ArchUnit User Guide — architecture and cycle checks](https://www.archunit.org/userguide/html/000_Index.html)
- [Spring Modulith — application module fundamentals](https://docs.spring.io/spring-modulith/reference/fundamentals.html)
- [Spring Modulith — module structure verification](https://docs.spring.io/spring-modulith/reference/1.3/verification.html)
- [OpenTelemetry — context propagation](https://opentelemetry.io/docs/concepts/context-propagation/)
- [OpenTelemetry — signals](https://opentelemetry.io/docs/concepts/signals/)
- [Fabric — events](https://docs.fabricmc.net/develop/events)
- [Fabric — automated testing](https://docs.fabricmc.net/develop/automatic-testing)
- [NeoForge — events and lifecycle](https://docs.neoforged.net/docs/1.21.11/concepts/events/)
- [NeoForge — Game Tests](https://docs.neoforged.net/docs/misc/gametest/)
- [Oracle Java 25 — JFR performance troubleshooting](https://docs.oracle.com/en/java/javase/25/troubleshoot/troubleshoot-performance-issues-using-jfr.html)
- [Oracle Java 25 — memory leak diagnostics](https://docs.oracle.com/en/java/javase/25/troubleshoot/troubleshooting-memory-leaks.html)

## Option analysis

### A — Chỉ convention/review thủ công

Ít setup nhưng boundary drift chỉ lộ khi bug/port; diagram nhanh lỗi thời. Loại cho invariant máy có thể kiểm.

### B — Framework/module/event platform tổng quát ngay từ đầu

Có nhiều abstraction nhưng khóa tool trước consumer, tăng startup/runtime/learning surface và dễ biến UMBRA thành platform riêng. Loại.

### C — Logical contract + fitness functions theo boundary thật

Giữ modular monolith, khai public/internal/allowed edges, thêm automated rule và causal trace dần theo hai vertical consumers. Tool/framework đảo được; gameplay/save semantics không phụ thuộc chúng. **Phương án đề xuất cho `DB-021/022`.**

## Giới hạn suy luận

- Các nguồn mô tả tool/observability nói chung hoặc loader lifecycle, không chứng minh package/module cụ thể tối ưu cho UMBRA.
- UMBRA không phải hệ phân tán; dùng nguyên lý causal context, không nhập toàn bộ OpenTelemetry stack.
- Spring Modulith là evidence về module verification, không là dependency candidate cho Minecraft mod.
- Toàn bộ choice vẫn `DISCOVERY` cho tới C1 vertical fixture, compile/dependency proof và architecture ADR của `DB-021`.

Canonical choices: [`SYS-RUNTIME`](../20-domains/12-platform/02-runtime-boundaries-and-authority.md) và [`CTR-DEBUG-OBSERVABILITY`](../30-shared-contracts/05-observability-and-recovery.md).
