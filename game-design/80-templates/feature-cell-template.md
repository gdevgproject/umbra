# FEAT-[DOMAIN]-[NAME] — [Tên feature]

> **DRI:** [một vai trò]
> **Approver:** [một vai trò]
> **Reviewers:** [chỉ discipline chịu tác động]
> **Status:** `SEED`
> **Target slice:** [chưa xếp lịch nếu trước APPROVED]

## 1. Contract một câu

Khi **[player intent]**, trong **[context]**, game **[observable outcome]**, để tạo **[target feeling/decision]**.

## 2. Giá trị và ranh giới

- Pillar chính:
- Pillar phụ:
- Problem/opportunity:
- In scope:
- Non-goals:
- Success signal:

## 3. Vocabulary

| Term/ID | Nghĩa chính xác | Không được hiểu là |
|---|---|---|

## 4. Preconditions và postconditions

| Loại | Rule |
|---|---|
| Có thể bắt đầu khi | |
| Bị từ chối khi | |
| Khi thành công | |
| Khi thất bại/gián đoạn | |
| State không được đổi | |

## 5. Player flow

```text
Intent → validation → anticipation → active result → feedback → recovery → next choice
```

Mô tả happy path, failure path, cancel path và recovery path.

## 6. State/action model

```text
[state] --actor/event/guard--> [state] / side effects
```

Ghi owner của state, clock/tick, actor có quyền transition và quy tắc idempotency.

## 7. Scenario matrix

| ID | Given | When | Then | Feedback | Oracle | Status |
|---|---|---|---|---|---|---|

Phải phủ: neutral, bốn hướng/chéo nếu liên quan, boundary, conflict, resource thiếu, interruption, death/reload, first/third view, latency, accessibility và vanilla interoperability.

## 8. Cross-discipline contract

| Discipline | Requirement / N/A reason | Owner artifact |
|---|---|---|
| Input | | |
| Combat timing | | |
| Camera/target | | |
| Animation | | |
| VFX/SFX | | |
| UI/UX/onboarding | | |
| Accessibility | | |
| Localization | | |
| AI/counterplay | | |
| Progression/balance/economy | | |
| World/vanilla | | |
| Authority/network | | |
| Data/save/migration | | |
| Performance/compatibility/config/loader | | |
| Test/debug/telemetry | | |

## 9. Dependencies và impact

| ID | Quan hệ | Điều feature cần | Điều feature cam kết |
|---|---|---|---|

## 10. Parameters

| Parameter | Candidate range | Hypothesis | Evidence | Final owner |
|---|---|---|---|---|

Không ghi một số là final nếu chưa có evidence/approval.

## 11. Research và options

- Decision question:
- Research Cards:
- Option A / trade-offs:
- Option B / trade-offs:
- Recommendation hypothesis:

## 12. Acceptance và validation

- Automated oracle:
- Manual feel question:
- Performance risk: `PR-0/1/2/3`, trigger và lane evidence:
- Performance budget: client frame/server tick/memory/I/O/network/cardinality; representation tier, degradation và benchmark ID:
- Loader portability: common semantics/schema, current Fabric binding, future adapter seam hoặc `N/A — reason`:
- Compatibility matrix:
- Accessibility/localization check:
- Prototype/playtest record:

## 13. Open questions

| ID | Câu hỏi có thể đổi thiết kế | Owner | Cách đóng | Blocks gate? |
|---|---|---|---|---|

## 14. Decisions và provenance

- ADR đang hiệu lực:
- Corpus/research đã migrate:
- Rejected/deferred với lý do:

## 15. Gate checklist

Link tới `GOV-LIFE`; không tự tạo Definition of Done riêng mâu thuẫn lifecycle.
