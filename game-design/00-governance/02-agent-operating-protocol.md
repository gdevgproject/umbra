# GOV-AGENT — Quy trình làm việc của Agent

> **Owner:** Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Nguyên tắc

Agent là một thành viên studio mang một hoặc nhiều “chiếc mũ”, không phải máy điền chữ. Agent phải phân biệt điều đã biết, giả thuyết, lựa chọn, quyết định và bằng chứng.

Mỗi task bắt đầu bằng [Session Bootstrap và Continuity](08-session-bootstrap-and-continuity.md). Agent tìm quyết định đã có trước khi hỏi, và audit từng mệnh đề feedback trước handoff để không miss yêu cầu dài.

## 2. Quy trình cho mọi yêu cầu thiết kế

### Bước 1 — Resolve scope

Ghi ra trước khi sửa:

- Feature/System ID.
- Player outcome cần đạt.
- Trạng thái hiện tại.
- DRI và reviewer cần thiết.
- In-scope, non-goals và artifact phải tạo.

Nếu yêu cầu chạm nhiều feature, tạo Impact Map; không nhét tất cả vào một cell.

### Bước 2 — Read set tối thiểu

Đọc theo thứ tự:

1. Product Charter và pillar liên quan.
2. Domain/System charter.
3. Feature Cell hiện tại.
4. Shared Contract và dependency trực tiếp.
5. Decision Record còn hiệu lực.
6. Quality Spec liên quan.
7. Production backlog để biết thứ tự; Git history chỉ được tra khi thật sự cần provenance.

Agent phải liệt kê file đã đọc. Không kết luận từ tên file hoặc đoạn trích rời.

### Bước 3 — Extract before invent

Tách nội dung thành năm cột:

| Nhãn | Nghĩa |
|---|---|
| `FACT` | ràng buộc nền tảng đã kiểm chứng |
| `DECIDED` | quyết định UMBRA đã được duyệt |
| `CANDIDATE` | phương án từ corpus/research chưa duyệt |
| `ASSUMPTION` | điều tạm giả định để tiếp tục |
| `OPEN` | câu hỏi có thể đổi thiết kế |

Không nâng `CANDIDATE` thành `DECIDED` chỉ vì nó có con số cụ thể.

### Bước 4 — Research có câu hỏi

Research chỉ bắt đầu với câu hỏi quyết định, ví dụ: “Dodge trung tính nên là backstep hay hướng camera?” Không research chung chung “xem game X làm gì”.

Mỗi nguồn phải ghi:

- bối cảnh và phiên bản được quan sát;
- vấn đề nguồn đó giải quyết;
- cảm giác và trade-off;
- điều không chuyển được sang Minecraft;
- nguyên lý trừu tượng;
- bằng chứng/clip/timecode/link khi có;
- rủi ro sao chép/IP.

So sánh tối thiểu ba archetype phù hợp trước quyết định lớn; số lượng game không thay thế chất lượng câu hỏi.

### Bước 5 — Model interactions

Trước khi đề xuất, duyệt Impact Checklist:

- input/remap/context;
- action timing và combat rhythm;
- state/resource/formula;
- camera góc 1/góc 3 và target/readability;
- animation, hitbox/hurtbox, VFX, SFX;
- UI/UX/onboarding/accessibility;
- AI/counterplay/encounter;
- progression/build/economy/content reward;
- world/vanilla interoperability;
- client/server authority, latency, save/migration;
- performance/compatibility/config;
- localization và terminology;
- automated test, human playtest, telemetry/debug.

Mục không liên quan phải ghi `N/A — reason`.

### Bước 6 — Decide visibly

Đề xuất có ít nhất hai phương án thực sự khác nhau, tiêu chí đánh giá và hệ quả. Quyết định tạo/cập nhật ADR nếu đổi invariant, state lifecycle, shared contract, scope hoặc chi phí khó đảo ngược.

### Bước 7 — Update canonical home

Sửa luật tại owner duy nhất. Cập nhật link, dependency, status và acceptance cùng thay đổi. Không vá bản sao ở nhiều file.

### Bước 8 — Gate review

Chạy lifecycle checklist. Nếu thiếu research/playtest/prototype, giữ `DISCOVERY`/`VALIDATION`; không dùng ngôn ngữ “đã chốt”.

### Bước 9 — Handoff

Báo ngắn gọn:

- outcome thay đổi;
- file/ID canonical;
- quyết định và lý do;
- câu hỏi/rủi ro còn mở;
- bằng chứng đã có/chưa có;
- bước tiếp theo hợp lệ.

## 3. Khi được yêu cầu code

Agent kiểm `status: IMPLEMENTATION_READY`, approval và acceptance trước, sau đó làm theo [Engineering/Git Workflow](06-engineering-and-git-workflow.md). Nếu chưa đủ, không tự code; chuyển yêu cầu về discovery, nêu chính xác gate thiếu và có thể tiếp tục làm tài liệu trong phạm vi được giao.

Trong lúc code phát hiện design gap:

- bug trái contract: sửa bug và regression test;
- chi tiết triển khai không đổi hành vi: ghi implementation note;
- thay đổi player-visible rule/contract: dừng phần liên quan, tạo `OPEN`/ADR, đưa feature lùi lifecycle nếu cần;
- ý tưởng mới: đưa vào discovery queue, không scope-creep ticket.

Nếu gap đến từ feedback/playtest trong lúc ticket đang chạy, Agent phải dùng [Feedback Change Control](05-feedback-routing-and-edit-policy.md): tạo `CR-<TKT>-NN`, tách `OBSERVED/EXPECTED/REQUESTED`, lập Change Propagation Map và chọn `CONTINUE_CONFORMANCE_FIX / AMEND_AND_REBASELINE / SPLIT_FOLLOWUP / PAUSE_NEEDS_DESIGN / ROLLBACK_OR_DISABLE`. Không sửa code rồi mới viết docs cho khớp.

Chỉ phần thật sự không phụ thuộc delta mới được tiếp tục trong cùng worktree. Trước khi quay lại implementation, Agent phải xác nhận canonical rule/ADR, ticket acceptance, risk, tests và `design_baseline_commit` đã được rebaseline; evidence từ oracle cũ được đánh `STALE_BY_CHANGE`, không tái sử dụng vì vẫn xanh.

Bug được điều tra theo [Bug Workflow](07-bug-investigation-and-fix.md); không vá symptom hoặc đổi spec để hợp code.

## 4. Những hành vi bị cấm

- Chốt bằng “game X làm vậy”.
- Sáng tác số liệu rồi gọi là balance.
- Tạo schema trước khi trạng thái và lifecycle rõ.
- Tạo ticket để thay cho scenario/acceptance.
- Đánh dấu checklist bằng sự tồn tại của một đoạn Markdown.
- Dùng `TBD` không owner, không câu hỏi và không điều kiện đóng.
- Phục hồi nội dung lịch sử từ Git thành canonical mà không audit trạng thái và conflict.
