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
- Project Owner cấp **standing authority** cho Agent quản lý vận hành Git/GitHub thường nhật; repo/gate/evidence là authorization source, không yêu cầu Project Owner biết lệnh Git hoặc xác nhận lại từng thao tác.
- Khi scope đã được giao và gate tương ứng xanh, Agent tự được phép: tạo/switch branch hoặc worktree; commit; push topic/port branch; mở/cập nhật PR; quản lý issue/label/template/workflow/ruleset; merge PR đạt gate; xóa topic branch đã merge; tạo tag và publish snapshot/release kỹ thuật đã có release approval trong repo.
- Agent không được đẩy việc kỹ thuật như chọn branch, resolve merge method, chạy CI, đặt release metadata hoặc bật protection cho Project Owner. Nếu platform yêu cầu credential/approval UI, Agent yêu cầu đúng quyền tối thiểu rồi tiếp tục, không biến nó thành câu hỏi thiết kế.
- Kênh vận hành GitHub mặc định là connector/API/CLI chuyên dụng đã xác thực. Browser UI chỉ là fallback khi capability hiện có không thực hiện được thao tác semantic tương ứng hoặc GitHub bắt buộc xác thực tương tác; mở browser không phải một bước mặc định của workflow.
- Trước khi dùng browser fallback, Agent báo một câu ngắn nêu chính xác mục đích và external state sẽ thay đổi. Standing authority bao phủ các thao tác thường nhật trong scope, nên không hỏi lại từng click; chỉ chuyển quyền cho Project Owner khi cần credential/2FA hoặc chạm nhóm hành động phải xin phép ở dưới.
- Approval do sandbox/tooling cưỡng chế là ranh giới thực thi của môi trường, không phải product approval mới. Agent xin capability tối thiểu theo đúng thao tác và không bắt Project Owner chọn lệnh hay phương án kỹ thuật.
- Vẫn phải xin Project Owner trước: public 1.0 greenlight hoặc thay public promise; repo visibility/transfer/billing/collaborator/secret; force-push/rebase/reset shared history; xóa/sửa published tag/release asset; xóa branch/worktree có unique unmerged work; bỏ qua gate đỏ hoặc hành động có thể mất save/provenance.
- Routine Minecraft successor promotion/EOL theo `PD-043` không cần prompt riêng khi exact port/release/EOL gates đã xanh; ngoại lệ đổi support promise hoặc respin EOL ngoài policy mới cần Project Owner.
- Không ghi đè thay đổi có sẵn của user; dirty worktree được audit và giữ nguyên.
- Không dùng Git để che/xóa failure evidence.

Standing authority không biến Agent thành approver giả: Agent phải chứng minh từng gate bằng artifact/test, ghi role pass tách biệt và để lại PR/release/audit record. Một thao tác được phép nhưng thiếu evidence vẫn phải dừng ở gate, không hỏi Project Owner “cho qua”.

## 3. Branch và worktree

Khi task/working environment cho phép branch management, dùng short-lived topic branch:

```text
feat/<ticket-id>-<slug>
fix/<bug-id>-<slug>
refactor/<ticket-id>-<slug>
test/<ticket-id>-<slug>
docs/<id>-<slug>
spike/<decision-id>-<slug>
port/mc-<version>-<loader>
release/mc-<version>
```

Một branch = một outcome/review unit. Worktree riêng khi có hai task song song hoặc cần giữ main chạy được. Không đổi branch với uncommitted state không liên quan. Spike không merge nguyên trạng nếu chứa shortcut; chưng cất decision rồi viết production implementation.

`main` luôn theo `DEVELOPMENT_BASELINE`/`SUPPORTED_CURRENT`, không theo snapshot upstream. `port/mc-*` là branch chuyển baseline có thời hạn và `PR-3`; current line vẫn chạy trên `main` cho tới promote gate. `release/mc-*` chỉ được tạo khi đã có release line thật cần finalization/exceptional maintenance, sau EOL bị đóng băng; không tạo một branch cho mọi snapshot và không dùng long-lived `develop` song song. Topic/fix branch phải fork từ đúng support line mà nó sửa.

Fix áp cho current và old line được merge/port riêng theo cùng bug ID + regression oracle; không merge successor wholesale vào maintenance branch. Tag/release đã publish không di chuyển hoặc thay asset; correction dùng version/tag mới. Lifecycle/version coordinates do [`SYS-COMPAT`](../20-domains/12-platform/03-compatibility-and-release-baseline.md) sở hữu.

Git khuyến nghị topic branches để cô lập thay đổi; `git bisect` hỗ trợ tìm commit gây regression. [Git Branching Workflows](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows), [Git Debugging](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git)

Với studio chỉ có Project Owner + Agent, `main` cho phép push thường sau khi automated evidence bắt buộc đã xanh; PR là công cụ tùy theo rủi ro cho port/release, thay đổi lớn hoặc review unit cần cô lập, không phải nghi thức cho mọi commit. Ruleset chỉ chặn force-push/delete và không được hard-require PR/status check khiến repository tự khóa; CI trên `push` là hậu kiểm remote, không thay pre-push evidence. Ruleset cho `release/mc-*` và release tags chỉ được tạo khi ref tương ứng thực sự tồn tại và cần bảo vệ, không dựng trước topology chưa dùng. Settings trên GitHub là external state: file trong repo chỉ mô tả/kiểm trợ, không được báo “đã bảo vệ” trước khi audit Settings/Rulesets.

## 4. Ticket execution lifecycle

### A. Intake

1. Đọc `AGENTS.md`, [Ticket Autopilot + Execution Ledger](../50-production/07-ticket-autopilot-protocol.md), Ticket Standard và canonical read set.
2. Xác nhận ticket/Feature status, outcome, non-goals và authority.
3. Audit `git status`, branch/worktree, diff liên quan và baseline build/test.
4. Lập Impact Map: code/data/save/network/render/config/test/docs.
5. Gán performance risk `PR-0–PR-3` và loader portability impact; `N/A` cần lý do.
6. Nêu assumption; dừng nếu thiếu quyết định player-visible khó đảo.
7. Ghi `design_baseline_commit`, exact Feature/Contract/ADR/Parameter read set và mọi unresolved `CR`/`STALE_BY_CHANGE` dependency; doc owner đổi sau mốc này là re-audit trigger, không phải noise Git.

Khi task gọi build/debug/capture hoặc app authoring ngoài repo, resolve capability/path và re-audit trigger qua [GOV-WORKSTATION](09-workstation-toolchain-readiness.md). Không cài lại, browse phiên bản mới hoặc kết luận tool thiếu chỉ vì sandbox không resolve tên lệnh.

Nếu user nói ticket trước “đạt”/“làm tiếp”, Intake bắt đầu bằng reconcile ledger ↔ ticket ↔ Git ↔ exact evidence; không coi câu chat là authorization bỏ gate. Agent lập Change Surface Map bằng stable ID/symbol, mọi reader/writer/caller và boundary save/authority/render/loader/test trước khi sửa.

### B. Plan và proof-first

1. Chọn lát cắt nhỏ nhất tạo outcome/technical proof.
2. Chỉ ra regression cần viết trước hoặc cùng implementation.
3. Xác định debug/diagnostics hook và rollback/feature flag.
4. Nếu ticket không còn vừa một review unit, split trước code; không âm thầm scope-creep.

### C. Implement

- Thay đổi đúng owner/boundary; không đọc/ghi state chéo tùy tiện.
- Trước khi tạo abstraction/helper/state mới, search stable ID, symbol, caller và test hiện có. Tái sử dụng khi semantics, owner, lifecycle và failure policy thật sự giống nhau—not chỉ vì vài dòng code trông giống.
- Shared abstraction cần ít nhất hai consumer thật hoặc foundation contract đã duyệt; không tạo “universal utility” để future-proof tưởng tượng. Duplication tạm chỉ tồn tại khi extraction lúc này làm trộn owner, và phải có ticket/removal condition nếu để lại nợ.
- Reuse domain rule ở common core; loader/client/server adapter chỉ chuyển context/intent/result. Không “tái sử dụng” bằng cách cho domain phụ thuộc object Fabric/NeoForge/Minecraft client.
- Ưu tiên event/API/adapter; mixin chỉ khi cần và phải có compatibility note/test.
- Fabric/NeoForge imports, event/context/config/attachment types chỉ tồn tại trong loader adapter/patch layer. Common core không runtime-detect loader hoặc fork gameplay semantics.
- Platform adapter chuyển callback sang UMBRA command/result; không đưa loader object vào domain. Exception cần ADR, capability fallback và import-rule waiver có owner.
- Mỗi bước giữ build được khi thực tế; không để mainline phụ thuộc asset/data chưa có fallback.
- Khi phát hiện design gap, áp dụng GOV-AGENT: dừng phần bị ảnh hưởng và route về design.

### C.1. Feedback/change checkpoint giữa ticket

- Mọi feedback có thể đổi outcome, input, state, resource, failure, presentation hoặc acceptance đi qua [`GOV-ROUTING`](05-feedback-routing-and-edit-policy.md), không được xử lý như “yêu cầu nhỏ” chỉ vì diff dự kiến ngắn.
- Nếu một ticket ngoại vi cần một player rule không tồn tại trong docs, đó là `NEW_CAPABILITY/DESIGN_DELTA`, không phải quyền cho engineer chọn default. Chỉ scaffolding behavior-neutral/fail-closed có thể tiếp tục; rule trung tâm phải về đúng Feature/Contract owner trước production code.
- Agent capture `CR`, so code với design baseline và chọn disposition trước khi sửa behavior. Bug conformance có thể tiếp tục; tuning ngoài approved envelope hoặc design delta không được giả thành bug.
- `AMEND_AND_REBASELINE` chỉ hợp lệ khi cùng Feature/owner/rollback story và approver đúng vai đã khóa delta. Agent sửa canonical docs/scenarios/ticket/test oracle trong cùng change set rồi mới coi code là production candidate.
- `PAUSE_NEEDS_DESIGN` giữ phần bị ảnh hưởng buildable/feature-flagged và cập nhật ledger ngay. Không commit/merge code player-visible đang chờ quyết định; phần độc lập chỉ tiếp tục khi dependency map chứng minh không bị ảnh hưởng.
- Spike để trả lời feel/feasibility dùng branch/flag, ID `DB/CR`, capture và removal condition; kết quả spike là evidence, không tự trở thành rule.
- Hotfix S0/S1 ưu tiên recovery/rollback/disable. Workaround tạm cần `WORKAROUND(CR-ID)`, test, expiry và known issue; không được dùng để vượt lifecycle/release gate.

### D. Self-review

Đọc toàn bộ diff như reviewer khác vai: correctness, contract, lifecycle/race/idempotency, save/migration, authority/security, camera/client, performance risk/evidence, loader-boundary/import leakage, localization/accessibility, tests và unintended files. Reconcile `design_baseline_commit`, mọi `CR`, doc/code/test drift và downstream evidence stale; tìm code/dead config/TODO/comment đã lỗi thời.

### E. Verify

Chạy static + architecture conformance + targeted + regression + integration phù hợp; chọn performance lane theo `PR-0–PR-3`. Với foundation/capability snapshot thêm integrated/dedicated, save/reload và lifecycle matrix. Boundary/public surface thay đổi phải kèm architecture report diff và contract/consumer tests; không duyệt cycle/forbidden edge bằng comment. Chỉ chạy loader matrix đang `SUPPORTED`; adapter conformance/portability proof theo ticket, không giả NeoForge xanh khi chưa có implementation. Ghi exact commands/result; không nói “should pass”.

### F. Commit và handoff

Commit chỉ chứa scope của ticket; không gộp formatting/unrelated user edits. Handoff ghi outcome, canonical docs, files, tests/evidence, migration/compat notes, assumptions/risks, mọi `CR` + disposition/evidence invalidation, commit hash và next valid action.

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
- Loader adapter/patch comment ghi Hook Requirement ID và không mô tả domain rule song song; Fabric/NeoForge implementation dùng inventory riêng.
- TODO/FIXME phải có ticket ID, owner/trigger hoặc bị loại trước merge.
- Không giữ commented-out code; Git đã giữ lịch sử.
- Tên code dùng canonical glossary/ID; player text qua localization key.

Invariant khó thấy phải được bảo vệ bằng contract/ADR + executable test/type boundary trước comment. Khi cần signpost cục bộ, dùng nhãn và stable link theo [Ticket Autopilot §6](../50-production/07-ticket-autopilot-protocol.md): `INVARIANT`, `ENGINE_QUIRK`, `AUTHORITY`, `SAVE_COMPAT`, `PERF_BUDGET`, `WORKAROUND`. Chạm code có nhãn nghĩa là phải đọc ID/test và chạy oracle; comment/test/code cập nhật cùng transaction.

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

Mỗi lần select/state/evidence/commit/handoff thay đổi phải cập nhật [Execution Ledger](../50-production/08-execution-ledger.md). Ledger là con trỏ, không thay ticket scope hoặc Git history.
