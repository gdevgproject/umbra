# UMBRA — quy tắc làm việc bắt buộc cho Agent

Repository đang ở giai đoạn **Design Discovery**, chưa ở giai đoạn triển khai gameplay.

## Thứ tự đọc

1. `game-design/README.md`
2. `game-design/00-governance/01-document-architecture.md`
3. `game-design/00-governance/02-agent-operating-protocol.md`
4. `game-design/00-governance/08-session-bootstrap-and-continuity.md`; xác định work mode trước khi chọn read set.
5. Nếu code/fix: `game-design/00-governance/06-engineering-and-git-workflow.md` và `07-bug-investigation-and-fix.md` khi liên quan.
   Nếu task cần build/debug/capture hoặc công cụ asset/authoring ngoài repo: đọc `game-design/00-governance/09-workstation-toolchain-readiness.md`; không inventory/cài lại tool nếu không có re-audit trigger của doc này.
   Nếu chạm runtime/platform/build/port: đọc `game-design/60-quality/03-testing-and-evidence.md` và `game-design/20-domains/12-platform/07-loader-portability-and-adapter-contract.md`.
   Nếu user nói ticket trước đạt/tiếp/làm ticket kế: đọc `game-design/50-production/07-ticket-autopilot-protocol.md` và đối soát `08-execution-ledger.md` trước khi chọn việc.
   Nếu user đưa feedback mới khi ticket/code đang chạy hoặc implementation cần một rule không có trong docs: đọc `game-design/00-governance/05-feedback-routing-and-edit-policy.md`, giữ active ticket/worktree và route một `CR-*` trước khi sửa behavior.
6. Product charter, domain charter và Feature Cell nằm trong phạm vi công việc.
7. Shared Contract được Feature Cell dẫn tới.
8. Đọc production backlog/quality proof nếu yêu cầu thay đổi readiness hoặc thứ tự.

## Luật không được phá

- Không viết code gameplay khi Feature Cell chưa ở trạng thái `IMPLEMENTATION_READY`.
- Không tự nâng trạng thái. Mỗi gate cần đủ bằng chứng và đúng người duyệt ghi trong lifecycle.
- Không thêm đoạn “bổ sung vN” vào cuối tài liệu. Sửa nội dung chuẩn tại đúng một nơi và dùng Decision Record để giữ lý do.
- Không chép cùng một luật vào nhiều file. Một luật có một owner; nơi khác chỉ dẫn ID/link.
- Không biến candidate hoặc Git history thành quyết định đã chốt.
- Khi phát hiện mâu thuẫn, thiếu dữ kiện hoặc tác động chéo: dừng phần bị ảnh hưởng, ghi Open Question/Decision Record và cập nhật dependency.
- Mọi research phải tách `quan sát → nguyên lý → lựa chọn UMBRA → bằng chứng → rủi ro IP`; tên/asset/moveset nguồn không được trở thành biểu đạt UMBRA.
- Mọi tính năng phải xét: hai góc nhìn, input, animation, audio/VFX, UI/UX, accessibility, localization, multiplayer authority, save/migration, performance, compatibility và test; mục không liên quan phải ghi lý do, không được bỏ trống.
- Mọi runtime change phải gán performance risk `PR-0–PR-3` và chạy evidence lane tương ứng; không benchmark mù mọi thay đổi hoặc bỏ đo hot-path/cardinality risk.
- Fabric là loader hiện tại; NeoForge là future target bắt buộc. Không để Fabric/NeoForge type thoát adapter, không fork gameplay/save theo loader và không tuyên bố NeoForge support trước conformance/parity gate.
- Ticket là đơn vị triển khai sau cùng, không phải nơi nghiên cứu game design.
- Feedback giữa ticket phải qua Change Request/disposition của `GOV-ROUTING`: bug trái contract mới sửa trực tiếp; local delta phải amend + rebaseline; feature mới tách follow-up; shared/player-visible gap vào `NEEDS_DESIGN`; incident ưu tiên rollback/disable. Không sửa code rồi hợp thức hóa docs, không để ticket ngoại vi tự phát minh rule trung tâm và không dùng “hotfix” để bỏ gate.
- Không chọn ticket tiếp theo chỉ từ chat hoặc lời “đạt”. Reconcile ledger ↔ ticket ↔ Git ↔ exact test evidence; chỉ tự chọn item đã Ready và dependency/gate xanh.
- Invariant khó thấy phải được bảo vệ theo thứ tự contract/ADR → automated test → type/boundary → comment dẫn stable ID/test. Không dùng comment “đừng sửa” thay executable proof.
- `main` phải luôn playable theo capability hiện có. Project Owner đã cấp standing authority để Agent tự quản lý Git/GitHub theo `GOV-ENGINEERING`: branch/commit/push/PR/ruleset/merge/release kỹ thuật được tự thực hiện khi gate và automated evidence xanh, không hỏi lại từng thao tác. Kênh thực thi và browser fallback do `GOV-ENGINEERING §2` sở hữu. Chỉ dừng xin phép cho credential/2FA, rewrite lịch sử shared, xóa provenance/release/data, thay quyền–visibility–billing/secret, public 1.0 greenlight hoặc quyết định sản phẩm khó đảo chưa có trong repo.
- User không làm thay test tự động. Chỉ yêu cầu user playtest sau automated pack phù hợp và cung cấp Test Card + diagnostics/capture protocol.
- Mọi Test Card và hướng dẫn thao tác cho Project Owner viết bằng tiếng Việt, một câu hỏi human-only mỗi card.
- Không hỏi lại điều user đã khóa trong Product Feedback/ADR. Khi chat mới, repo là bộ nhớ; mọi task phải qua continuity bootstrap.

## Trước khi sửa tài liệu

Nêu rõ: mục tiêu người chơi, Feature ID, owner, trạng thái hiện tại, nguồn đã đọc, phạm vi và non-goals. Sau khi sửa, chạy `powershell -ExecutionPolicy Bypass -File tools/validate-design-docs.ps1` và báo các câu hỏi còn mở.
