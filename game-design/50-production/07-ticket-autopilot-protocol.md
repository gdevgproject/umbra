# PROD-TICKET-AUTOPILOT — Agent tự tiếp tục ticket qua task mới

> **DRI:** Producer + Technical Director + QA Lead
> **Approver:** Project Owner
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. User contract

Khi bước sang implementation, người dùng chỉ cần làm hai việc:

1. nói kết quả playtest hoặc “`<TICKET-ID> đạt, làm ticket tiếp`”;
2. thực hiện một Test Card tiếng Việt ngắn khi Agent đã chạy hết automated pack phù hợp và còn câu hỏi chỉ con người/phần cứng thật mới trả lời được.

Agent sở hữu việc đọc context, đối soát Git/evidence, chọn ticket hợp lệ tiếp theo, lập change surface, implement, tự review, test, ghi ledger/handoff và hướng dẫn user. “Đạt” từ user là **human evidence**, không tự thay compile/test/gate hoặc cho phép Agent bỏ qua mismatch.

## 2. Cold-start transaction

Mọi task `IMPLEMENTATION`, kể cả user chỉ nói “tiếp”, chạy theo thứ tự:

1. đọc `AGENTS.md`, `GOV-CONTINUITY`, file này và [Execution Ledger](08-execution-ledger.md);
2. audit `git status --short`, branch/worktree, `HEAD`, diff chưa commit và commit gắn ticket gần nhất;
3. reconcile active/last ticket giữa ledger, ticket artifact, Git diff/commit và exact test record;
4. đọc toàn bộ ticket + Feature/Contract/ADR/quality owner được dẫn; không dùng chat làm decision source;
5. lập `Change Surface Map` từ stable ID/symbol bằng search: entrypoint, owner state, mọi reader/writer/caller, persistence/codec/migration, authority/network, render/client, loader adapter/patch, config/content/localization và tests;
6. chạy baseline nhỏ nhất chứng minh trạng thái trước sửa khi build hiện tại chạy được;
7. chỉ sau đó mới chọn/tiếp tục/implement.

Không quy định “đọc N file code”. Agent dừng discovery code khi đã xác định finite owner boundary, producer/consumer và regression surface; một hit đầu tiên trong search không đủ để bắt đầu sửa.

## 3. Reconcile ticket trước

| Tình huống | Agent phải làm |
|---|---|
| User báo đạt, automated evidence + ledger khớp | ghi human verdict, chạy gate còn thiếu, đóng ticket/commit nếu đủ rồi chọn next |
| User báo đạt nhưng test đỏ/thiếu | giữ ticket ở `VERIFYING`, giải thích ngắn, tự chạy/sửa phần máy; không chuyển next |
| Ledger nói done nhưng worktree/commit/test không khớp | dừng auto-selection, điều tra provenance và sửa ledger/evidence; không giả Git đúng |
| Có dirty change không thuộc ticket | giữ nguyên, cô lập scope; không stage/commit/revert thay đổi của user |
| Contract/code mâu thuẫn | phân loại design gap/bug; dừng phần player-visible, không chọn bên thuận tiện |
| Ticket trước thật sự hoàn tất | cập nhật `LAST_VERIFIED`, ledger/manifest và mới tính ticket tiếp theo |

Không dùng user như regression runner. Nếu họ báo lỗi, Agent bảo toàn evidence, cố tái hiện và đưa nó thành automated regression theo Bug Workflow.

## 4. Thuật toán chọn ticket tiếp

Agent chọn item đầu tiên thỏa **tất cả**:

1. ticket artifact tồn tại và `READY`/được đúng approver mở;
2. Feature Cell/Contract được dẫn đã `IMPLEMENTATION_READY`;
3. dependency tickets/gates có evidence hoàn tất;
4. capability hiện tại cho phép ticket và previous playable baseline xanh;
5. không có S0/S1, migration/save/authority blocker hoặc open decision chặn phạm vi;
6. worktree/branch cho phép cô lập thay đổi;
7. trong các candidate còn lại, ưu tiên dependency-critical/irreversible risk rồi thứ tự Implementation Backlog.

Agent không tự biến design backlog/epic/candidate thành ticket Ready. Nếu không có ticket hợp lệ, ledger ghi `NEXT_ELIGIBLE: NONE` + exact design gate; Agent quay về design work được user giao, không dựng code placeholder.

## 5. Execution loop của một ticket

```text
SELECTED → IN_PROGRESS → AUTOMATED_VERIFYING
→ AWAITING_USER_PLAYTEST (chỉ nếu cần) → VERIFYING
→ DONE | BLOCKED | NEEDS_DESIGN
```

- `SELECTED`: ghi ticket/branch/base commit/read set/risk vào ledger trước sửa.
- `IN_PROGRESS`: proof-first, feature flag/rollback/diagnostics theo risk; mỗi scope expansion phải re-audit.
- `AUTOMATED_VERIFYING`: static→unit/model→GameTest→integration→performance/compatibility lanes đúng risk.
- `AWAITING_USER_PLAYTEST`: chỉ sau automated prerequisite; gửi đúng một Test Card tiếng Việt có `PLAY-ID`.
- `VERIFYING`: self-review toàn diff, neighboring regressions, save/authority/loader/perf/doc sync.
- `DONE`: DoD, exact evidence, local scoped commit/handoff và ledger đều hoàn chỉnh; không đồng nghĩa push/merge/tag.

Ticket không cần human question bỏ qua `AWAITING_USER_PLAYTEST`; Agent không hỏi user “chơi thử xem có lỗi gì không”.

## 6. Code là bộ nhớ thực thi, không phải nơi chép lại GDD

Thứ tự bảo vệ knowledge khó thấy:

1. approved Contract/ADR sở hữu luật;
2. regression/property/integration test thực thi invariant;
3. type/API/boundary làm sai usage khó hoặc không thể compile;
4. comment gần code giải thích **vì sao tại boundary này** và dẫn stable ID/test.

Các nhãn comment được phép khi thật sự cần:

- `INVARIANT(<ID/test>):` điều không được phá và failure nếu phá;
- `ENGINE_QUIRK(<baseline/hook>):` hành vi Minecraft/loader/version khiến solution khác thường;
- `AUTHORITY(<ID>):` thread/server owner và vì sao client/local mutation bị cấm;
- `SAVE_COMPAT(<schema/migration>):` dữ liệu cũ phải đọc/chuyển thế nào;
- `PERF_BUDGET(<scene/counter>):` cardinality/cadence/cap không hiển nhiên;
- `WORKAROUND(<BUG/TICKET>):` nguyên nhân, phạm vi, test bảo vệ và điều kiện loại bỏ.

Không dùng comment kể lịch sử ticket, mô tả lại code, thay spec/test hoặc cảnh báo mơ hồ “đừng sửa”. Khi chạm code có nhãn bảo vệ, Agent phải đọc ID/test, chạy oracle liên quan và cập nhật code–test–comment như một transaction. Workaround không có removal condition/owner không được merge.

## 7. Handoff tự đủ cho Agent kế tiếp

Ticket/ledger/handoff ghi:

- outcome/non-goals và Feature/Contract/ADR exact;
- base/head commit, branch/worktree, files/modules và dirty state được bảo tồn;
- Change Surface Map + invariants/guarded comments đã chạm;
- exact commands/results/evidence artifact, risk `PR-*`, compatibility/save/migration impact;
- human question/verdict nếu có;
- unresolved risk/known issue và **một next valid action**.

Cold-agent proof: một Agent không xem chat phải chỉ từ repo mô tả đúng outcome, vì sao code có hình dạng hiện tại, test nào bảo vệ, ticket có thật sự done không và việc hợp lệ tiếp theo. Nếu không, ticket chưa hoàn tất về vận hành.

