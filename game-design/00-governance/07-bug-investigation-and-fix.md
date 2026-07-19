# GOV-BUG — Điều tra và sửa lỗi không tạo nợ dài hạn

> **Owner:** QA Lead + Engineering Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Bug workflow

```text
Report → Preserve evidence → Reproduce → Classify contract
→ Minimize scenario → Add failing oracle → Find root cause
→ Fix smallest correct boundary → Run impact matrix
→ Self-review → Commit/handoff → Close only with evidence
```

## 2. Report tối thiểu

Bug ID, build/commit/schema, environment/mod/config, game mode, world/seed, precondition, exact action, expected/actual, reproduction rate, severity/data risk và diagnostics bundle. User report thiếu dữ liệu vẫn được nhận; Agent tự thu phần có thể tìm.

## 3. Phân loại trước khi sửa

| Loại | Hành động |
|---|---|
| Code trái approved contract | fix code + regression |
| Contract mơ hồ/thiếu | route design; không đoán player rule |
| Data/content invalid | validator/migration/fallback + fixture |
| Compatibility/version | adapter/baseline/known limitation + matrix |
| Performance/race | profile/reproduction budget; không micro-optimize cảm tính |
| Save corruption/data loss | stop mutation, backup/recovery first, incident review |
| User expectation nhưng code đúng | UX/readability review; không đóng “not a bug” máy móc |

Nếu review cho thấy expected player outcome cần đổi thay vì chỉ tăng readability, mở ticket-local `CR` và route theo [`GOV-ROUTING`](05-feedback-routing-and-edit-policy.md). Bug workflow không được đổi canonical rule để làm reproduction “pass”.

## 4. Root-cause rules

- Không sửa symptom bằng reset state toàn cục nếu chưa hiểu owner/lifecycle.
- Không thêm delay/retry vô hạn để che race.
- Không swallow exception hoặc silently delete invalid data.
- Regression khó định vị dùng last-known-good và `git bisect` khi test có thể tự động.
- Một bug ở boundary phải audit mọi consumer cùng pattern.
- Nếu bug có thể duplicate damage/reward/item hoặc mất save, thêm idempotency/invariant audit chứ không chỉ fix một call site.
- Nếu root cause là invariant/engine quirk khó thấy, regression test là bộ nhớ chính; thêm guarded comment `INVARIANT/ENGINE_QUIRK/AUTHORITY/SAVE_COMPAT/PERF_BUDGET/WORKAROUND` dẫn ID/test theo Ticket Autopilot. Không để lại “đừng sửa đoạn này” không có oracle.

## 5. Severity

| Severity | Ví dụ | Policy |
|---|---|---|
| S0 | mất/corrupt save, security/RCE/permission escalation | dừng release/use path, recovery + incident |
| S1 | crash/block progression/duplicate economy/combat authority exploit | fix trước capability continuation |
| S2 | feature sai đáng kể/camera unusable/desync recoverable | ưu tiên trong slice |
| S3 | presentation/clarity/polish có workaround | backlog có evidence |

## 6. Fix Definition of Done

Reproduction cũ fail trước/fix sau; neighboring scenarios xanh; save/authority/perf impact xét; diagnostics reason rõ; docs/known issues/migration cập nhật; guarded invariant/comment đồng bộ khi cần; Execution Ledger/handoff ghi exact evidence và next action; commit nguyên tử; không còn temporary bypass không có ticket.
