# GOV-LIFE — Lifecycle và quality gates

> **Owner:** Producer + Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Trạng thái chuẩn

```text
SEED → DISCOVERY → PROPOSED → VALIDATION → APPROVED → IMPLEMENTATION_READY
     → IMPLEMENTING → IMPLEMENTED → VERIFIED → RELEASED → RETIRED
```

| Trạng thái | Nghĩa | Điều tuyệt đối chưa được làm |
|---|---|---|
| `SEED` | ý tưởng/cơ hội chưa framing | hứa roadmap |
| `DISCOVERY` | đang hiểu người chơi, constraint, reference, option | chốt solution/code |
| `PROPOSED` | có contract và phương án đề xuất | gọi là đã duyệt |
| `VALIDATION` | prototype/simulation/playtest câu hỏi rủi ro | mở rộng production |
| `APPROVED` | player rule đã duyệt | mặc định coi kỹ thuật sẵn sàng |
| `IMPLEMENTATION_READY` | interface, dependency, acceptance, asset/data/test đủ | scope-creep |
| `IMPLEMENTING` | đang code/author asset/data | đổi contract âm thầm |
| `IMPLEMENTED` | chạy được và self-test xanh | gọi là chất lượng đã xác nhận |
| `VERIFIED` | QA, performance, compatibility, playtest đạt | tự động coi là released |
| `RELEASED` | nằm trong bản phát hành hỗ trợ | bỏ migration/support |
| `RETIRED` | không còn canonical | xóa provenance |

`BLOCKED` không phải lifecycle. Dùng `blocked_by` và giữ trạng thái hiện tại.

## 2. Gate Discovery → Proposed

- Problem/player outcome và anti-goals rõ.
- Existing behavior/constraint đã audit.
- Dependency/impact map có owner.
- Research question và nguồn cần kiểm tra rõ.
- Tối thiểu hai option có trade-off.
- Không còn câu hỏi nào có thể biến feature thành một feature khác.

## 3. Gate Proposed → Validation

- Feature contract, scenario matrix và failure/recovery có mặt.
- Các shared contract bị ảnh hưởng đã được nêu.
- Parameter chưa chứng minh được ghi range/hypothesis, không giả làm final.
- Prototype plan trả lời một câu hỏi rủi ro cụ thể.
- Accessibility/localization/camera/animation/network/performance đã xét.

## 4. Gate Validation → Approved

- Evidence gắn trực tiếp với hypothesis.
- Các profile người chơi liên quan đã được đại diện.
- Outcome đạt hoặc quyết định chấp nhận trade-off được ghi ADR.
- Không còn conflict với pillar/invariant/domain boundary.
- Approver ký và review record có ngày.

## 5. Gate Approved → Implementation Ready

- State machine/action phases/data ownership rõ.
- Input/output/event/error contract rõ.
- Public/internal capability surface, authoritative writer, clock/thread/transaction boundary, direct consumers và failure containment rõ theo `SYS-RUNTIME`.
- Dependency version/ID ổn định; không chờ decision khác.
- Content, animation, VFX/SFX, UI string và locale requirement có plan.
- Acceptance gồm automated oracle, manual feel check, perf/compat/save test.
- Rollout/fallback/debug/config/migration rõ nếu liên quan.
- Feature đã được cắt thành Capability Slice có thể chạy/test độc lập.
- Ticket chỉ phân rã việc triển khai, không chứa câu hỏi design.

## 6. Quy tắc lùi trạng thái

Feature phải lùi trạng thái nếu thay đổi:

- player intent/outcome;
- invariant hoặc lifecycle;
- resource/cost/counterplay cốt lõi;
- input/camera/animation làm thay đổi feel;
- authority/save/data shape;
- dependency chưa còn đúng;
- evidence mới phủ định giả thuyết.

Sửa typo, link hoặc làm rõ câu không đổi nghĩa không làm lùi trạng thái.

## 7. Trạng thái dự án UMBRA hiện tại

Không có gameplay feature nào mặc định `IMPLEMENTATION_READY` chỉ vì đã có formula/schema/ticket candidate. Các status phải được xác nhận theo từng Feature Cell. Tooling thuần tài liệu/validation có thể sẵn sàng riêng; Dodge, quest, progression và combat không thừa kế readiness từ độ chi tiết của văn bản.
