# GOV-CONTINUITY — Bootstrap Agent và continuity qua chat mới

> **Owner:** Design Operations + Technical Director
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Repo là bộ nhớ, chat là working context

Một Agent mới phải có thể tiếp tục dự án mà không được xem lịch sử chat. Quyết định, assumption, research, open question, readiness, dependency, test evidence và handoff cần sống trong canonical docs/ticket/Git. Không tạo “memory dump” song song với source of truth.

## 2. Xác định work mode trước khi làm

| Mode | Dấu hiệu | Entry set |
|---|---|---|
| `DESIGN_FEEDBACK` | user nêu ý tưởng, lo ngại, rule, scope, research | README → architecture → Agent protocol → Product/Feedback → owner domains/contracts/quality/backlog |
| `DESIGN_EXECUTION` | một DB item được chọn để research/decide | DB item → Product pillar → domain/system/feature → dependencies → research/quality |
| `IMPLEMENTATION` | ticket đã approved/Ready hoặc user nói pass/next | AGENTS → Ticket Autopilot + Execution Ledger → ticket → Feature/Contract/ADR → code owners → quality → Git workflow |
| `BUG` | hành vi code trái contract | bug workflow → reproduction/evidence → owner contract → impact neighbors |
| `PORT/RELEASE` | đổi Minecraft/loader/build/release | compatibility + loader portability → baseline ADR → adapter/patch inventory → save/test/performance/release gates |

Không đọc toàn bộ 100+ file theo nghi thức; đọc **đủ graph liên quan và toàn bộ từng file đã chọn**. Không kết luận từ `rg` snippet.

## 3. Bootstrap record trong commentary/handoff

Agent nêu ngắn: mode, desired outcome, stable IDs, files đã đọc, FACT/DECIDED/OPEN chính, impact surface và artifact sẽ sửa. Nếu một fact đã có trong `PROD-FEEDBACK`/ADR/contract, không hỏi user lại.

## 4. Design feedback transaction

1. Atomize mọi mệnh đề; đánh số để không miss.
2. Classify local/cross-system/new feature/product/risk/delegated research.
3. Lập impact map từ producer→contract→consumer→quality→production.
4. Sửa canonical owner; nơi khác chỉ link/dependency/acceptance.
5. Ghi quyết định vào Product Feedback/ADR khi user đã khóa; không để lại như open question.
6. Update roadmap/backlog/traceability nếu readiness hoặc sequence đổi.
7. Chạy validator và audit lại từng mệnh đề ban đầu.

## 5. Implementation continuity package

Ticket/handoff phải đủ để Agent mới trả lời mà không đoán: outcome/non-goals, exact docs/ADRs, code/data owners, dependency versions, state/authority/save rules, acceptance, exact tests/results, remaining risks, worktree/branch/commit và next valid action. Incomplete task có checkpoint; completed task không để “continue from chat” instruction.

[Ticket Autopilot](../50-production/07-ticket-autopilot-protocol.md) sở hữu thuật toán đối soát/chọn/thi hành; [Execution Ledger](../50-production/08-execution-ledger.md) là con trỏ canonical. Khi user báo ticket đạt hoặc yêu cầu ticket tiếp, Agent coi đó là input evidence, audit ledger–ticket–Git–test rồi mới chuyển trạng thái. Không có ticket Ready thì ở lại Design Discovery.

## 6. Context-loss recovery

Khi chat bị compact hoặc mở task mới:

1. không cố nhớ lại từ lời kể mơ hồ;
2. đọc repo status + entry set theo mode;
3. tìm stable ID/decision, không tìm theo câu chữ duy nhất;
4. kiểm diff/worktree trước khi sửa để giữ user changes;
5. nếu canonical docs và code mâu thuẫn, dừng phần liên quan và phân loại design gap/bug—not tự chọn bên tiện hơn.
6. nếu ledger và Git/test mâu thuẫn, dừng auto-selection, bảo toàn dirty work và reconcile bằng evidence; không suy luận “ticket chắc đã xong”.

## 7. Continuity proof

Mỗi capability gate có “cold-agent review”: Agent/reviewer không dùng chat phải mô tả đúng player outcome, invariants, dependencies, open risks, test command và next work chỉ từ repo. Nếu không làm được, handoff/tài liệu chưa đạt dù code chạy.
