# PROD-TICKET — Chuẩn ticket triển khai

> **DRI:** Producer + Engineering Lead + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Ticket bắt buộc có

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

Bug trái spec: sửa + regression. Chi tiết nội bộ không đổi behavior: implementation note. Rule/player outcome mới: dừng phần liên quan, đưa Feature Cell về lifecycle và cập nhật impact map. Không biến quyết định design thành comment TODO.

## Quy trình thực thi

Ticket đã ready được triển khai theo [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md); bug theo [Bug Workflow](../00-governance/07-bug-investigation-and-fix.md). Ticket không hoàn tất nếu chỉ có code mà thiếu self-review, exact test evidence, doc sync và context handoff cho Agent sau.

Khi một task mới nhận tín hiệu “ticket trước đạt/tiếp”, Agent dùng [Ticket Autopilot](07-ticket-autopilot-protocol.md) và [Execution Ledger](08-execution-ledger.md). User verdict chỉ đóng human question; `DONE` cần automated evidence, commit/handoff và ledger khớp. Hướng dẫn user luôn là Test Card tiếng Việt, không giao checklist regression rộng.
