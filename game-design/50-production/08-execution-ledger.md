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
base_commit: 59a5aa1
head_commit_verified: 59a5aa1
worktree_state: DIRTY_DESIGN_DOCS_INDEX_AND_WORKTREE
uncommitted_scope: Project Owner system override rebaseline for Level-only progression, Skills/preview, HP+Vigor, Dodge/Free Climb/Lightness/Hạ Kình, Villager traits/power/Hub density, modular capability roadmap and blocked real ticket packs; audit git status for exact staged/unstaged files and preserve unrelated user changes.
last_verified_ticket: NONE
last_automated_evidence: powershell -ExecutionPolicy Bypass -File tools/validate-design-docs.ps1 — PASS, 161 canonical Markdown files, dirty design transaction, 2026-07-20
last_human_playtest: N/A
next_eligible_ticket: NONE
blocked_by: Implementation Backlog is BLOCKED_BY_DESIGN; first foundation gate DB-019 is not approved, followed by DB-021 and the remaining per-ticket gates.
next_valid_action: Resolve DB-019 exact pinned Minecraft/Fabric baseline and promote only TKT-C1-001 after its full ticket audit; do not write gameplay code before READY.
active_change_request: NONE
amend_pending: false
stale_evidence: NONE
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
- Khi feedback interrupt ticket, ledger trỏ `active_change_request`, `amend_pending` và `stale_evidence`; chi tiết/luật nằm ở ticket/canonical owner, không chép vào ledger.
- `NEEDS_DESIGN` quay lại `IN_PROGRESS` chỉ sau canonical decision + ticket/test rebaseline; ticket `DONE` lịch sử không bị rewrite khi CR mới tạo follow-up.
- Không xóa history ticket khỏi Git để làm ledger sạch; completed details nằm ở ticket/handoff/commit, không dồn thành log vô hạn trong file này.
