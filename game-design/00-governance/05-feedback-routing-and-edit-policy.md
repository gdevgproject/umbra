# GOV-ROUTING — Agent tự định tuyến feedback và sửa tài liệu

> **Owner:** Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

Người dùng chỉ cần mô tả điều muốn đổi bằng ngôn ngữ tự nhiên. Agent chịu trách nhiệm phân loại, đọc đúng set, lập impact map, sửa tất cả canonical homes và báo câu hỏi thật sự cần quyết.

Trong thuật ngữ studio, UMBRA vận hành theo **continuous discovery + delivery**, dùng **living design system**, **change control**, **change-impact analysis** và **requirements traceability**. “Cuốn chiếu” không có nghĩa sửa code trước rồi hợp thức hóa tài liệu; nó nghĩa feedback có thể xuất hiện ở bất kỳ lát cắt nào nhưng luôn đi qua một transaction giữ design–ticket–code–test cùng một sự thật.

## Phân loại yêu cầu

| Loại | Dấu hiệu | Hành động |
|---|---|---|
| Clarification | làm rõ câu, không đổi outcome/rule | sửa owner file + links |
| Local rule | đổi một Feature Cell, dependency hữu hạn | đọc feature/contracts/quality, cập nhật scenarios |
| Cross-system | chạm resource/state/input/save hoặc ≥2 domain | tạo Impact Map, cập nhật mọi owner + ADR |
| New feature | player intent/outcome mới | tạo seed, tìm domain/system, discovery backlog |
| Product expansion | audience, core loop, release promise hoặc domain mới | Product/scope ADR, roadmap re-evaluation |
| Balance tuning | chỉ đổi parameter trong rule đã approved | registry + simulation/evidence; không sửa rải rác |
| Bug/report | implementation trái contract | route QA/code khi feature đã triển khai; không viết lại rule để hợp bug |
| Runtime feel feedback | build chạy đúng spec nhưng cảm giác/outcome chưa tốt | bảo toàn capture, so với hypothesis; tuning trong approved envelope hoặc design change |
| Implementation constraint | engine/platform/performance làm solution dự kiến không khả thi | tìm alternative giữ outcome; chỉ route design khi player rule/trade-off phải đổi |
| Urgent incident | crash, save/data/security/progression blocker cần giảm hại ngay | rollback/disable/recover theo approved truth; không dùng “hotfix” để bypass design |

Quy mô không được suy từ số chữ feedback. “Thêm lock-on” ngắn nhưng là Feature Cell cross-system; sửa một đoạn lore dài có thể chỉ là local content.

## Thuật toán định tuyến

1. Rút ra desired player outcome và constraints.
2. Tìm stable ID/thuật ngữ trong `game-design/`; đọc owner file hoàn chỉnh.
3. Từ domain map/catalog, liệt kê producers, consumers, shared contracts và quality proof.
4. Gắn nhãn từng mệnh đề `FACT/DECIDED/CANDIDATE/ASSUMPTION/OPEN`.
5. Chọn loại thay đổi ở bảng trên; nếu cross-system, lập impact table trước khi edit.
6. Sửa luật tại đúng owner; nơi khác chỉ cập nhật link/dependency/acceptance.
7. Cập nhật status/lifecycle, backlog và traceability nếu scope/readiness đổi.
8. Chạy validator, đọc lại tuyến ảnh hưởng và báo người dùng: đã hiểu gì, đổi gì, còn quyết gì.

## Khi feedback mơ hồ

Agent tiếp tục bằng assumption đảo ngược được và ghi rõ. Chỉ hỏi người dùng khi lựa chọn làm đổi fantasy, irreversible rule, release scope hoặc chi phí lớn. Câu hỏi phải nêu option/trade-off và canonical file sẽ bị ảnh hưởng.

## Điều Agent không đẩy cho người dùng

Không yêu cầu người dùng chỉ file, tự format Markdown, tự tìm trùng lặp, tự cập nhật link/status/backlog hoặc tự nhớ tác động kỹ thuật. Người dùng quyết outcome/trade-off; Agent quản trị hệ tài liệu.

## Feedback phát sinh giữa một ticket implementation

Mỗi feedback có thể đổi outcome/ticket đang chạy được ghi như một ticket-local **Change Request** `CR-<TKT-ID>-NN`; nó là con trỏ truy nguyên, không phải nơi sở hữu luật game. Ticket giữ observation/request/disposition; Feature/Contract/Parameter/ADR vẫn là canonical truth.

### Capture trước khi giải thích

Change Request tối thiểu ghi:

- build/commit/ticket, nguồn feedback và evidence/capture nếu có;
- `OBSERVED`: người chơi đã làm gì và thấy gì;
- `EXPECTED`: contract/hypothesis hiện nói gì;
- `REQUESTED`: outcome người dùng muốn, tách khỏi solution họ gợi ý;
- affected Feature/Contract/Scenario IDs và Change Surface Map ban đầu;
- reversibility, severity/data risk, player-visible/save/authority/input/performance impact;
- disposition, owner/approver, evidence bị stale và điều kiện đóng.

Không bắt người dùng viết form. Agent atomize lời tự nhiên thành record này và phải giữ cả observation lẫn desired outcome; không biến một solution gợi ý như “đổi phím X” thành quyết định trước khi audit input graph.

### Phân loại contract trước khi sửa

| Loại thực tế | Rule |
|---|---|
| `CONFORMANCE_BUG` | code trái canonical rule: giữ docs, viết failing regression rồi sửa code |
| `IN_ENVELOPE_TUNING` | outcome/rule không đổi, parameter nằm trong range đã approved: cập nhật Parameter Registry + evidence + code/data |
| `DESIGN_DELTA` | thêm/xóa/đổi player-visible outcome, input, state, resource, failure hoặc presentation contract: dừng phần ảnh hưởng, route canonical design/ADR |
| `NEW_CAPABILITY` | intent/outcome độc lập: đưa Discovery/backlog, không nhét vào ticket hiện tại |
| `IMPLEMENTATION_CONSTRAINT` | solution nội bộ bị chặn nhưng outcome giữ nguyên: Technical Design/ADR kỹ thuật; nếu phải đổi outcome thì nâng thành `DESIGN_DELTA` |
| `INCIDENT_MITIGATION` | S0/S1 hoặc unusable baseline: ưu tiên recovery/rollback/disable; mitigation không tự trở thành design mới |

### Chọn đúng disposition

| Disposition | Khi dùng | Ticket/code được làm gì |
|---|---|---|
| `CONTINUE_CONFORMANCE_FIX` | bug trái rule, scope/risk vẫn bounded | giữ ticket; thêm regression và fix đúng owner |
| `AMEND_AND_REBASELINE` | delta local, đảo ngược được, cùng Feature/owner/rollback story và approver đã khóa | sửa canonical docs/acceptance trước hoặc cùng transaction; rebaseline ticket/test rồi tiếp tục |
| `SPLIT_FOLLOWUP` | ý hay nhưng độc lập, không cần để outcome ticket hiện tại đúng | giữ ticket hiện tại; tạo design item/ticket candidate có dependency rõ, không code placeholder |
| `PAUSE_NEEDS_DESIGN` | shared contract, fantasy, input conflict, save/authority hoặc trade-off khó đảo thay đổi | ledger/ticket vào `NEEDS_DESIGN`; giữ phần không bị ảnh hưởng buildable, không merge behavior đang tranh chấp |
| `ROLLBACK_OR_DISABLE` | incident/data risk hoặc feedback cho thấy path hiện tại không thể phát hành an toàn | quay về last-known approved behavior/feature flag; recovery trước, design follow-up sau |

Agent không đo scope bằng số dòng. Một chỉnh dead-zone trong approved range có thể amend; một thay đổi “Space giờ làm việc khác” thường là cross-system `DESIGN_DELTA` dù diff code rất nhỏ.

### Design Sync Transaction — thứ tự chống drift

Khi disposition đổi design, cùng một change set phải hoàn tất theo thứ tự:

1. đánh dấu `CR`; nếu cần quyết định thì ticket/ledger vào `NEEDS_DESIGN`, còn amend local giữ `IN_PROGRESS` nhưng ledger trỏ `active_change_request` và ghi `amend_pending: true` trước khi tiếp tục behavior bị ảnh hưởng;
2. sửa canonical Feature/Contract/Parameter và ADR/Product decision khi cần; lifecycle được lùi nếu evidence cũ không còn chứng minh rule mới;
3. cập nhật scenario, traceability, quality/performance, dependency/backlog và localization/accessibility owners bị tác động;
4. sửa ticket outcome/non-goals/Change Surface/acceptance/risk/rollback và ghi exact evidence nào trở thành `STALE_BY_CHANGE`;
5. mới sửa production code/data/migration/diagnostics và executable tests theo contract mới;
6. chạy doc validator + targeted/neighbour/integration/performance/lifecycle proof tương ứng;
7. reconcile ledger, manifest, handoff và downstream work trước commit/merge.

Trong branch/spike có thể tồn tại code thử nghiệm đi trước để trả lời một câu hỏi, nhưng nó phải bị feature-flagged/cô lập, gắn `CR/DB`, không được merge như production truth và không được dùng để tự nâng lifecycle.

### Propagation và evidence invalidation

- Search reverse stable IDs và symbols để lập `Change Propagation Map`: canonical producer → shared contracts → consumers → parameters/content/localization → tickets/code/tests → save/platform/performance/release.
- Ticket active bị đổi acceptance phải rebaseline; baseline/test record cũ không được tiếp tục dùng như bằng chứng của rule mới.
- Ticket `DONE` giữ lịch sử, không bị viết lại. Nếu behavior tích hợp không còn thỏa design mới, mở follow-up change ticket và đánh dấu capability/manifest evidence liên quan `STALE_BY_CHANGE` cho tới khi xanh lại.
- Không tự reopen toàn bộ backlog. Chỉ hạ readiness/đánh stale những artifact có dependency `CONTRACT/BEHAVIORAL` thật sự; dependency `PRIVATE` không bị lan truyền vì trùng từ khóa.
- Một `CR` chỉ đóng khi canonical docs, ticket, code, test và ledger đồng bộ, hoặc khi disposition là reject/defer có lý do và dependency rõ.
- Thay đổi **xóa** feature/input/state phải audit save/schema/config/custom bindings/localization/content references và migration/deprecation; “xóa code” không đủ đóng CR.
- Feedback mới có thể chủ động supersede quyết định cũ của người dùng. Agent ghi decision delta/ADR và sửa canonical truth; không giữ hai rule song song hoặc hỏi lại như thể feedback trước chưa tồn tại.
- Nhiều feedback tới khi một CR còn mở phải atomize thành CR riêng nếu outcome/disposition khác, khai dependency/order và resolve conflict trước code; không gom thành “polish feedback” không truy nguyên.

### Routing scenario oracles

| ID | Tình huống | Outcome bắt buộc |
|---|---|---|
| `GOV-CR-S01` | playtest thấy code trái approved Dodge rule | `CONFORMANCE_BUG` → regression + fix; Feature doc không bị viết lại để hợp bug |
| `GOV-CR-S02` | player muốn chỉnh timing trong approved parameter range | `IN_ENVELOPE_TUNING` → registry/evidence/code rebaseline; ticket có thể amend |
| `GOV-CR-S03` | player muốn Space đổi nghĩa giữa ticket traversal | `DESIGN_DELTA` cross-system → `PAUSE_NEEDS_DESIGN` hoặc approved amend; Input/Feature/scenario/test cùng đổi |
| `GOV-CR-S04` | ticket UI phát hiện cần một combat action mới chưa có docs | `NEW_CAPABILITY` → discovery/follow-up; UI ticket không tạo placeholder gameplay rule |
| `GOV-CR-S05` | Minecraft hook không thể giữ solution dự kiến nhưng outcome vẫn giữ | `IMPLEMENTATION_CONSTRAINT` → alternative/technical ADR; chỉ nâng design delta nếu trade-off player-visible đổi |
| `GOV-CR-S06` | build hiện tại corrupt save/crash progression | `INCIDENT_MITIGATION` → preserve evidence, recover/rollback/disable trước; workaround có flag/expiry, không tự approve design |
| `GOV-CR-S07` | design đổi sau một ticket `DONE` | giữ lịch sử DONE; follow-up change ticket, capability evidence `STALE_BY_CHANGE` tới khi proof mới xanh |
| `GOV-CR-S08` | feedback tới khi worktree có dirty user changes | giữ active context/evidence, cô lập scope; không revert/stage/commit thay đổi ngoài CR |
| `GOV-CR-S09` | user thay thế feedback trước bằng outcome mới | record supersession/decision delta, update one canonical truth và invalidate evidence theo dependency thật |
| `GOV-CR-S10` | ba feedback cùng lúc chạm input, animation và tuning | atomize CR/disposition/dependency; không dùng một “polish” ticket che nhiều outcome/rollback story |

## “Hotfix” và rapid iteration không phải một thứ

- Feedback cảm giác trong playtest thường là **rapid design iteration**, vẫn cần options, prototype và rebaseline; tốc độ không bỏ change control.
- **Hotfix** dành cho incident cần giảm hại ngay. Lựa chọn ưu tiên là recover, rollback hoặc disable về behavior đã approved.
- Nếu bắt buộc có workaround player-visible tạm thời, nó cần feature flag, `WORKAROUND(CR-ID)`, regression, owner, expiry/removal condition, known-issue/handoff và không được làm Feature đạt `VERIFIED`.
- Không sửa spec để một hotfix “trông đúng”, không để TODO/comment là nơi duy nhất lưu deviation và không merge một experiment chỉ vì user thích lần chơi đầu.
