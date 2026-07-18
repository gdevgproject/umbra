# GOV-ENGINEERING — Quy trình Agent, Git và giao hàng cho studio một người

> **Owner:** Technical Director + Producer
> **Approver:** Project Owner
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Mô hình studio thực tế

- **Người dùng:** Game Director/Product Owner, quyết fantasy/trade-off/acceptance khó thay thế.
- **Agent:** tự đội mũ Producer, Designer, Engineer, QA, Technical Writer và Researcher theo artifact; phải đổi góc review, không giả có sáu người đã kiểm độc lập.
- **Repository:** bộ nhớ dài hạn. Chat không phải source of truth; quyết định, assumption, test và handoff phải sống trong docs/ticket/Git.

## 2. Quy tắc authority Git

- `main` đại diện trạng thái tích hợp luôn compile/load/save được theo capability hiện có.
- Implement một ticket đã ready mặc định có thể tạo **local scoped commit** theo workflow này, trừ khi user nói không commit.
- Không push, merge vào remote protected branch, rebase/reset lịch sử đã chia sẻ, tag release hoặc xóa branch/worktree nếu chưa được user yêu cầu/cho phép.
- Không ghi đè thay đổi có sẵn của user; dirty worktree được audit và giữ nguyên.
- Không dùng Git để che/xóa failure evidence.

## 3. Branch và worktree

Khi task/working environment cho phép branch management, dùng short-lived topic branch:

```text
feat/<ticket-id>-<slug>
fix/<bug-id>-<slug>
refactor/<ticket-id>-<slug>
test/<ticket-id>-<slug>
docs/<id>-<slug>
spike/<decision-id>-<slug>
```

Một branch = một outcome/review unit. Worktree riêng khi có hai task song song hoặc cần giữ main chạy được. Không đổi branch với uncommitted state không liên quan. Spike không merge nguyên trạng nếu chứa shortcut; chưng cất decision rồi viết production implementation.

Git khuyến nghị topic branches để cô lập thay đổi; `git bisect` hỗ trợ tìm commit gây regression. [Git Branching Workflows](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows), [Git Debugging](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git)

## 4. Ticket execution lifecycle

### A. Intake

1. Đọc `AGENTS.md`, Ticket Standard và canonical read set.
2. Xác nhận ticket/Feature status, outcome, non-goals và authority.
3. Audit `git status`, branch/worktree, diff liên quan và baseline build/test.
4. Lập Impact Map: code/data/save/network/render/config/test/docs.
5. Nêu assumption; dừng nếu thiếu quyết định player-visible khó đảo.

### B. Plan và proof-first

1. Chọn lát cắt nhỏ nhất tạo outcome/technical proof.
2. Chỉ ra regression cần viết trước hoặc cùng implementation.
3. Xác định debug/diagnostics hook và rollback/feature flag.
4. Nếu ticket không còn vừa một review unit, split trước code; không âm thầm scope-creep.

### C. Implement

- Thay đổi đúng owner/boundary; không đọc/ghi state chéo tùy tiện.
- Ưu tiên event/API/adapter; mixin chỉ khi cần và phải có compatibility note/test.
- Mỗi bước giữ build được khi thực tế; không để mainline phụ thuộc asset/data chưa có fallback.
- Khi phát hiện design gap, áp dụng GOV-AGENT: dừng phần bị ảnh hưởng và route về design.

### D. Self-review

Đọc toàn bộ diff như reviewer khác vai: correctness, contract, lifecycle/race/idempotency, save/migration, authority/security, camera/client, performance, localization/accessibility, tests và unintended files. Tìm code/dead config/TODO/comment đã lỗi thời.

### E. Verify

Chạy static + targeted + regression + integration phù hợp; với foundation/capability snapshot thêm integrated/dedicated, save/reload và lifecycle matrix. Ghi exact commands/result; không nói “should pass”.

### F. Commit và handoff

Commit chỉ chứa scope của ticket; không gộp formatting/unrelated user edits. Handoff ghi outcome, canonical docs, files, tests/evidence, migration/compat notes, assumptions/risks, commit hash và next valid action.

## 5. Commit standard

Format subject:

```text
<type>(<scope>): <imperative outcome>
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `perf`, `build`, `chore`. Body ghi Ticket/Feature/Contract IDs, **why**, behavior/migration và tests. Subject không dùng “update stuff”, tên Agent hoặc mô tả file thuần túy.

Một commit phải:

- là thay đổi nguyên tử có thể review/revert;
- compile và qua test bắt buộc, trừ spike branch được ghi rõ;
- không chứa secret, save cá nhân, binary/log/generated artifact ngoài policy;
- không sửa contract player-visible mà thiếu doc/ADR;
- có regression test cùng fix khi khả thi.

Nhiều commit trong một ticket được phép khi mỗi commit có ý nghĩa/buildable. Trước integration, squash WIP/noise; giữ commit phân tách hữu ích cho review/bisect.

## 6. Mainline và playable snapshot

- Chỉ integrate khi ticket DoD và capability gate đạt.
- Main phải compile, mở test world, save/reload/quit và chạy smoke suite.
- Capability snapshot có manifest: commit, schema/content version, supported baseline, known issues, test report và backup/restore note.
- Tag snapshot/release chỉ khi user cho phép; tên candidate: `playable/c<N>-<slug>-<date>`.
- Rollback code không mặc nhiên rollback save; migration có forward/recovery policy riêng.

## 7. Comment và documentation trong code

- Comment giải thích **vì sao/invariant/engine quirk**, không kể lại dòng code.
- Public contract/state transition/codec/packet/migration có Javadoc hoặc contract docs phù hợp.
- Mixin comment ghi target, lý do API/event không đủ, version sensitivity, failure symptom và test bảo vệ.
- TODO/FIXME phải có ticket ID, owner/trigger hoặc bị loại trước merge.
- Không giữ commented-out code; Git đã giữ lịch sử.
- Tên code dùng canonical glossary/ID; player text qua localization key.

## 8. Context handoff để Agent mới không phụ thuộc chat

Mỗi ticket/handoff phải đủ cho Agent mới trả lời:

1. outcome và player/technical proof;
2. canonical files đã đọc;
3. quyết định/assumption/open question;
4. boundaries và files thay đổi;
5. test commands/fixtures/evidence;
6. save/network/compat/perf impact;
7. known failure và next action.

Nếu thông tin chỉ tồn tại trong cuộc trò chuyện, task chưa hoàn thành về mặt vận hành.
