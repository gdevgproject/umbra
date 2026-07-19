# CTR-DEBUG-OBSERVABILITY — Causality, diagnostics và recovery

> **DRI:** QA Lead + Tools Engineer
> **Approver:** Technical Director + QA Lead
> **Reviewers:** Gameplay Engineering, AI, Data, Performance, Support, Security/Privacy
> **Status:** `DISCOVERY`

## 1. Player/support outcome

Khi game từ chối một hành động, hành xử sai, lag, kẹt state hoặc lỗi save, Agent phải lần được **chuỗi nguyên nhân** từ intent tới owner/boundary/state/result mà không yêu cầu người chơi đoán subsystem hoặc tự đào log. Observability là contract kiến trúc và test seam; nó không phải việc “thêm log sau khi có bug”.

Contract này sở hữu vocabulary trace/reason, state inspector, diagnostic bundle, mutation audit và safe recovery surface dùng chung. Domain owner vẫn sở hữu ý nghĩa state/failure và recovery rule của feature.

## 2. Bốn loại tín hiệu không được trộn

| Signal | Trả lời | Ví dụ |
|---|---|---|
| Trace/event | chuỗi nào đã xảy ra và vì sao | intent→validation→action→hit→damage→HUD |
| State snapshot | hiện tại truth/projection/cache là gì | owner/version/lifecycle/resource/target |
| Metric/counter | tần suất, tail, queue/cardinality ra sao | reject rate, probes/tick, p99, live-set |
| Diagnostic artifact | bằng chứng tái hiện/support của một build/scenario | manifest, recent trace, report, screenshot/JFR ref |

Log text là presentation của signal, không là schema canonical. Không parse câu log tiếng Anh để quyết test oracle hoặc recovery.

## 3. Causality envelope

Mọi command, transaction, published event, async task và player-visible failure quan trọng mang phần phù hợp của envelope:

| Field | Ý nghĩa |
|---|---|
| `trace_id` | toàn flow player/system xuyên boundary |
| `span_id` / `parent_span_id` | bước hiện tại và bước trực tiếp gọi nó |
| `correlation_id` | gom các operation cùng một outcome/process |
| `causation_id` | fact/intent cụ thể làm bước này tồn tại |
| `operation_id` | idempotency key của mutation/retry |
| `system_id` / `capability_id` | canonical owner và availability version |
| `actor_id` / `owner_scope` | subject, player/world/party/activity owner; không dùng display name |
| `world_instance` / `dimension` | context đã sanitize đủ tái hiện |
| `server_tick` / `clock_id` | ordering theo authoritative clock |
| `thread/phase` | owner-thread, async prepare, render hoặc loader lifecycle phase |
| `state_version` | version trước/sau hoặc projection age khi liên quan |
| `result_code` | success/rejection/failure/degradation reason ổn định |
| `schema/build/content` | version cần để đọc đúng payload |

Không phải mọi particle/frame có full span. Boundary, mutation, rejection, queue/degradation và lifecycle transition là điểm bắt buộc; hot-path detail dùng sampling/ring buffer/counter theo budget. Trace ID từ client là untrusted hint: server giới hạn/sanitize hoặc cấp ID canonical, không cho client giả provenance.

## 4. Reason taxonomy

- Reason code ổn định, typed và có owner; player text đi qua localization key, developer detail qua structured attributes.
- Phân biệt ít nhất `REJECTED_INTENT`, `CONFLICT`, `DEPENDENCY_UNAVAILABLE`, `INVALID_DATA`, `TRANSIENT_RUNTIME`, `INVARIANT_BREACH`, `RESOURCE_EXHAUSTED`, `COMPATIBILITY` theo [`SYS-RUNTIME`](../20-domains/12-platform/02-runtime-boundaries-and-authority.md).
- Không dùng một `UNKNOWN` để đóng bug. Unknown được phép làm fallback nhưng phải giữ cause/stack/boundary và sinh counter/backlog khi lặp.
- Expected rejection không spam error log; invariant breach không bị hạ xuống debug để giữ console sạch.
- Exception được capture một lần tại owner boundary với causal fields; wrapper chỉ thêm context, không log lại cùng stack ở mọi layer.

## 5. Contract theo subsystem

| Subsystem | Trace/state tối thiểu |
|---|---|
| Action/combat/resource | raw intent, context/basis, validation, reservation/commit/refund, action/hit/damage IDs, source/target, reject/cancel |
| AI/squad/expression | perceived facts, candidate/score, reservation, chosen intent, suppressed/interrupted reason, seed/cadence/LOD tier |
| Quest/Gate/reward/Arise | process/objective state, transition guard, participant/owner, exactly-once ledger, deadline clock, compensation/recovery |
| Save/migration/content | schema/content versions, record owner, migration step/journal, validation/quarantine, backup/restore checksum và invariant audit |
| Camera/input/animation/UI | action/context, camera mode/basis/ray/target, predicted/authoritative state, clip/marker/fallback và screenshot marker |
| Scheduler/performance | queue owner/depth/age/drop, task phase/cancel, subsystem label, cardinality/tier/degradation và profile reference |
| Loader/patch | Hook Requirement, loader/baseline/backend, callback phase/thread, mapped UMBRA operation, fallback/failure symptom |

Domain có thể thêm field nhưng không đổi nghĩa field chung hoặc log toàn object graph. Payload có size/cardinality cap và redaction.

## 6. State inspector và recent-history buffer

Mỗi bounded capability cung cấp inspector read-only theo stable ID:

- availability/version/dependencies và degraded reason;
- authoritative owner/state/version + derived projection age;
- active transaction/action/process và recent transitions;
- queue/cache/subscription/task owner, size/cap và lifecycle;
- invariant verdict và safe links tới fixture/recovery command.

Runtime giữ recent-history ring buffer hữu hạn cho high-value events. Buffer có time/memory cap, sampling policy và snapshot trigger khi error/invariant/player marker xảy ra. Không giữ entity/world reference sống chỉ để debug; record dùng value/sanitized ID. Export không pause game vô hạn hoặc ghi toàn save mặc định.

## 7. Reproduction và divergence

- Seed, build/schema/content/config hash, fixture ID và authoritative input/action sequence được capture đủ cho **bounded replay** của model/scenario có thể tái hiện; UMBRA không hứa deterministic replay toàn Minecraft.
- Khi predicted/client view lệch server truth, trace ghi cả hai state/version và correction reason; không overwrite evidence bằng state cuối.
- AI random/utility và procedural task dùng named seed stream khi reproducibility là requirement; wall-clock/RNG global không được chen vào rule đó.
- Bug không tái hiện hoàn toàn vẫn cần minimal scenario, last-known-good build và causal marker để dùng regression/bisect.

## 8. Diagnostic bundle

Mỗi playable snapshot có một export gom tự động:

- build/commit/tag/source workflow, Minecraft support-line state, Java/loader/API, schema/content/capability manifest, artifact checksum/provenance và mod/config hash;
- world/player context đã sanitize, game mode/dimension/seed policy và fixture/scenario ID;
- recent causal trace, state inspectors, validation/migration/recovery report;
- error/crash tail, queue/performance sample và optional JFR/renderer reference;
- screenshot marker/camera/input/locale/backend khi liên quan;
- active waiver/known issue và exact bundle format version.

Launcher/distribution source và install path shape có thể được capture ở dạng đã sanitize để tái hiện `LAUNCH_ENVIRONMENT`, nhưng không được dùng thay exact Minecraft/loader/artifact coordinates hoặc biến một launcher bên thứ ba thành support promise.

Bundle mặc định loại token, chat, server address, đường dẫn username, full inventory/save và dữ liệu riêng tư không cần thiết. Preview cho biết sẽ xuất gì; server/operator permission và size limit rõ. User không phải tự tìm file log.

## 9. Recovery surface

Recovery command/tool chỉ gọi domain-owned operation, không sửa field nội bộ trực tiếp. Mỗi operation khai:

- precondition, authority/permission và confirmation;
- dry-run/preview khi có mất mát hoặc migration;
- transaction/audit/correlation ID;
- idempotency, rollback/compensation hoặc restore-from-backup;
- state/invariant check trước và sau;
- player-facing result + diagnostics reference.

Debug mutation, Creative grant và admin repair có provenance. Không có lệnh “reset everything” làm cách chữa mặc định; save corruption ưu tiên stop mutation, backup/quarantine và incident review.

## 10. Performance và failure safety

- Instrumentation có budget riêng: không allocate string/stack trace hoặc serialize payload lớn trên mỗi tick/frame bình thường.
- Structured fields được materialize theo level/sample; counter/ID nhẹ hơn full event. Trace storm có cap/drop metric, không block gameplay/save thread.
- Degradation của observability được báo (`dropped_count`, sampling/overflow reason); không im lặng làm trace trông đầy đủ.
- Diagnostic export/profile là operation có progress/cancel/timeout và I/O queue; không ghi đè evidence cũ duy nhất.
- Log/trace không được trở thành gameplay dependency. Tắt exporter ngoài vẫn giữ in-process reason/oracle tối thiểu.

## 11. Architecture/test gate

Một capability chưa `IMPLEMENTATION_READY` nếu thiếu:

1. stable reason codes cho happy/reject/failure/recovery;
2. trace points tại owner/boundary/mutation/lifecycle;
3. inspector và fixture có thể tạo/quan sát state quan trọng;
4. duplicate/reorder/unload/error fault injection và oracle;
5. diagnostic bundle contribution + privacy/size budget;
6. safe recovery hoặc lý do explicit vì sao chỉ backup/refuse là hợp lệ;
7. test chứng minh correlation/causation không đứt qua async, adapter, save/reload và presentation projection;
8. test instrumentation-off/sampling/overflow không đổi gameplay outcome.

Open decisions của `DB-021/022`: in-process trace schema/codec, buffer size, inspector protocol, export format, JFR correlation và tool/UI cụ thể. OpenTelemetry chỉ là nguồn nguyên lý về context propagation; UMBRA không mặc định ship exporter/service ngoài. Evidence seed: [Large-mod architecture and diagnostics](../70-research/10-large-mod-architecture-and-diagnostics.md).
