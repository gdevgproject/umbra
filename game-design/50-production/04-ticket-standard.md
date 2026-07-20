# PROD-TICKET — Chuẩn ticket triển khai

> **DRI:** Producer + Engineering Lead + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Lifecycle và quyền code

Ticket thật có thể được lập sớm để chia implementation work, nhưng không được chứa research/design mới. Trạng thái:

| State | Nghĩa | Cho phép code? |
|---|---|---|
| `DRAFT` | outcome/dependency/rollback boundary đã định hình, còn promotion fields mở | không |
| `BLOCKED_BY_DESIGN` | exact Feature/Contract/DB gate chưa xanh | không |
| `READY` | toàn bộ mandatory fields, approval, baseline và dependency xanh | có; Ticket Autopilot mới được chọn |
| `SELECTED/IN_PROGRESS/VERIFYING` | execution state do ledger quản | theo ticket |
| `DONE` | DoD/evidence/commit/handoff hoàn tất | không sửa lịch sử; delta mới là ticket/CR mới |

`DRAFT/BLOCKED` tối thiểu phải có stable ID, phase, outcome, in-scope/non-goals, exact design blockers, ticket dependency, risk hypothesis, acceptance sketch, rollback unit và promotion checklist. Field chưa biết ghi `OPEN — owner/gate`, không được bịa solution. Trước khi chuyển `READY`, ticket phải có đầy đủ danh sách dưới đây.

## Ticket `READY` bắt buộc có

- stable ticket ID, capability slice và Feature/Contract IDs;
- player-visible outcome hoặc infrastructure proof;
- exact in-scope/non-goals;
- design links ở trạng thái `IMPLEMENTATION_READY`;
- dependencies và files/modules dự kiến, không áp đặt solution nếu chưa review;
- Change Surface Map: authoritative writer, public command/query/event/port, direct callers/subscribers, persistence/network/render/loader surfaces và dependency-edge class `PRIVATE/CONTRACT/BEHAVIORAL`;
- acceptance theo scenario/oracle;
- data/save/migration, client/server, performance, accessibility/localization impact;
- performance risk class `PR-0–PR-3`, trigger, budget/benchmark ID và before/after evidence hoặc `N/A — reason`;
- loader portability impact: common contract, Fabric adapter, loader patch/import boundary, save/artifact parity hoặc `N/A — reason`;
- test/observability artifact;
- architecture conformance impact/report diff, typed failure/reason và causality trace; `N/A` cần lý do;
- rollback/feature flag khi rủi ro;
- DRI, reviewers và Definition of Done.
- branch/commit delivery policy và exact handoff artifact;
- Minecraft lifecycle IDs phải chạy hoặc `N/A — reason`;
- baseline test command/result trước khi sửa nếu là bug/refactor.
- execution-ledger transition dự kiến và điều kiện chọn ticket tiếp theo.
- `design_baseline_commit` + exact Feature/Contract/ADR/Parameter read set; owner-doc change là re-audit trigger.
- mục `Change Control`: ticket-local `CR-*`, source/evidence, `OBSERVED/EXPECTED/REQUESTED`, classification/disposition, affected stable IDs, Change Propagation Map, evidence `STALE_BY_CHANGE`, rebaseline/approval và closure condition; khi chưa có feedback ghi `NONE`.

## Quy tắc chia

Một ticket phải review/test được độc lập nhưng không nhỏ đến mức chỉ “tạo class”. Nếu thay đổi observable rule, ticket trỏ Feature Cell; nếu chỉ infrastructure, trỏ contract/proof. Ticket sau không được ngầm hoàn thiện luật còn thiếu của ticket trước.

`EPIC-*` là boundary lập kế hoạch, không phải ticket template. Phải tách `TKT-*` nếu bất kỳ điều kiện nào đúng:

- có hai authoritative writer/state machine có thể triển khai hoặc rollback độc lập;
- có hai design artifact chưa cùng `IMPLEMENTATION_READY`;
- có hai migration/loader/feature-flag rollout path độc lập;
- acceptance tạo hai cụm oracle không cần cùng diff để xanh;
- một phần có thể tạo playable/infrastructure proof hữu ích khi phần còn lại chưa tồn tại;
- risk lane khác bản chất (`PR-1` UI/config so với `PR-3` scheduler/save/port) làm review/evidence không còn bounded;
- title cần dùng “và” để nối hai player/technical outcome không cùng failure/rollback story.

Giữ cùng ticket khi phần “glue” không có giá trị hoặc không test được độc lập và mọi thay đổi cùng một owner/transaction/rollback. Ticket integration chỉ nối public surfaces đã chứng minh; không sở hữu lại internals hoặc lấp design gap.

## Khi phát hiện gap trong code

Bug trái spec: sửa + regression. Chi tiết nội bộ không đổi behavior: implementation note. Rule/player outcome mới: dừng phần liên quan, tạo `CR`, đưa Feature Cell về lifecycle và cập nhật impact/propagation map. Dùng disposition tại [`GOV-ROUTING`](../00-governance/05-feedback-routing-and-edit-policy.md); không biến quyết định design thành comment TODO hoặc gọi mọi feedback là hotfix.

Amend tại chỗ chỉ khi delta vẫn có một outcome/owner/rollback story và ticket còn là một review unit. Nếu acceptance tách thành cụm độc lập, risk/save/loader path đổi bản chất hoặc downstream cần phát hành riêng, split follow-up/change ticket. Ticket không đạt DoD khi còn `CR` chưa disposition, canonical docs–code–test lệch, hoặc evidence stale chưa được rerun/waive bởi đúng owner.

## Quy trình thực thi

Ticket đã ready được triển khai theo [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md); bug theo [Bug Workflow](../00-governance/07-bug-investigation-and-fix.md). Ticket không hoàn tất nếu chỉ có code mà thiếu self-review, exact test evidence, doc sync và context handoff cho Agent sau.

Khi một task mới nhận tín hiệu “ticket trước đạt/tiếp”, Agent dùng [Ticket Autopilot](07-ticket-autopilot-protocol.md) và [Execution Ledger](08-execution-ledger.md). User verdict chỉ đóng human question; `DONE` cần automated evidence, commit/handoff và ledger khớp. Hướng dẫn user luôn là Test Card tiếng Việt, không giao checklist regression rộng.
