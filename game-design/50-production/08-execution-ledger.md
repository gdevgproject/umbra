# PROD-EXECUTION-LEDGER — Trạng thái thực thi canonical

> **DRI:** Producer
> **Status:** `ACTIVE`
> **Update rule:** Agent cập nhật cùng transaction khi select, đổi state, ghi evidence, commit hoặc handoff ticket.

Đây là nơi duy nhất trả lời “đang ở ticket nào, Git/evidence nào đã xác minh và có thể làm gì tiếp”. Ticket giữ scope/acceptance; Git giữ content/history; ledger giữ con trỏ thực thi. Không chép design decision vào đây.

## Current control record

```yaml
project_phase: DESIGN_DISCOVERY
capability_slice: C0-DESIGN-OS
active_ticket: NONE
active_state: NONE
branch: main
base_commit: f94b5d3
head_commit_verified: f94b5d3
worktree_state: DIRTY_DESIGN_DOCS
uncommitted_scope: Free Climb/Grounding Strike/Lightness/Vigor traversal design-feedback transaction plus backlog/quality/research synchronization; audit git status for exact files.
last_verified_ticket: NONE
last_automated_evidence: design-doc-validator
last_human_playtest: N/A
next_eligible_ticket: NONE
blocked_by: Implementation Backlog is BLOCKED_BY_DESIGN; foundation gates DB-019/021/043 are not approved.
next_valid_action: Continue Design Discovery; do not write gameplay code.
```

`base/head` trên phản ánh snapshot đã commit gần nhất, không tuyên bố clean worktree; Agent cold-start luôn phải audit dirty changes thực tế và cập nhật record khi bắt đầu ticket. Design-doc edits chưa commit không được giả thành implementation evidence.

## State vocabulary

| State | Nghĩa | Bằng chứng tối thiểu |
|---|---|---|
| `SELECTED` | ticket Ready đã được thuật toán chọn | gate/dependency/base/worktree audit |
| `IN_PROGRESS` | đang thay đổi trong scope | checkpoint + current diff/risks |
| `AUTOMATED_VERIFYING` | implementation xong, máy đang chứng minh | exact commands/partial results |
| `AWAITING_USER_PLAYTEST` | chỉ còn human question | automated prerequisite green + Vietnamese Test Card |
| `VERIFYING` | đã có human result hoặc không cần; đang gate cuối | self-review + evidence reconciliation |
| `DONE` | DoD, commit/handoff/ledger hoàn tất | commit + exact green evidence + next action |
| `BLOCKED` | external/technical blocker thật | reason, attempts, safe recovery action |
| `NEEDS_DESIGN` | phát hiện player-visible gap/contract conflict | affected IDs + open decision/ADR route |

## Update invariants

- Một thời điểm tối đa một active ticket trong worktree này.
- Không ghi `DONE` từ lời “đạt” nếu automated/commit/handoff còn thiếu.
- Không ghi commit/test dự kiến như kết quả đã xảy ra.
- Nếu Git và ledger lệch, Git không tự động thắng; Agent điều tra rồi sửa nguồn sai với evidence.
- Mỗi `DONE` giữ một `next_valid_action`; `next_eligible_ticket` chỉ có giá trị sau dependency/gate audit.
- Không xóa history ticket khỏi Git để làm ledger sạch; completed details nằm ở ticket/handoff/commit, không dồn thành log vô hạn trong file này.
