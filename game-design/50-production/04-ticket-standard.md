# PROD-TICKET — Chuẩn ticket triển khai

> **DRI:** Producer + Engineering Lead + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Ticket bắt buộc có

- stable ticket ID, capability slice và Feature/Contract IDs;
- player-visible outcome hoặc infrastructure proof;
- exact in-scope/non-goals;
- design links ở trạng thái `IMPLEMENTATION_READY`;
- dependencies và files/modules dự kiến, không áp đặt solution nếu chưa review;
- acceptance theo scenario/oracle;
- data/save/migration, client/server, performance, accessibility/localization impact;
- test/observability artifact;
- rollback/feature flag khi rủi ro;
- DRI, reviewers và Definition of Done.
- branch/commit delivery policy và exact handoff artifact;
- Minecraft lifecycle IDs phải chạy hoặc `N/A — reason`;
- baseline test command/result trước khi sửa nếu là bug/refactor.

## Quy tắc chia

Một ticket phải review/test được độc lập nhưng không nhỏ đến mức chỉ “tạo class”. Nếu thay đổi observable rule, ticket trỏ Feature Cell; nếu chỉ infrastructure, trỏ contract/proof. Ticket sau không được ngầm hoàn thiện luật còn thiếu của ticket trước.

## Khi phát hiện gap trong code

Bug trái spec: sửa + regression. Chi tiết nội bộ không đổi behavior: implementation note. Rule/player outcome mới: dừng phần liên quan, đưa Feature Cell về lifecycle và cập nhật impact map. Không biến quyết định design thành comment TODO.

## Quy trình thực thi

Ticket đã ready được triển khai theo [Engineering/Git Workflow](../00-governance/06-engineering-and-git-workflow.md); bug theo [Bug Workflow](../00-governance/07-bug-investigation-and-fix.md). Ticket không hoàn tất nếu chỉ có code mà thiếu self-review, exact test evidence, doc sync và context handoff cho Agent sau.
