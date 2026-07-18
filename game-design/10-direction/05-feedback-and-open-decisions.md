# PROD-FEEDBACK — Quyết định đã khóa và câu hỏi cần feedback

> **DRI:** Design Operations
> **Status:** `ACTIVE`

Bạn không cần đọc hết hoặc chỉ đúng file. Feedback có thể thiếu context; Agent phải đối chiếu toàn hệ, giữ intent, phát hiện assumption sai và sửa các owner liên quan.

## 1. Cách Agent hiểu feedback

| Feedback | Phân loại | Agent phải làm |
|---|---|---|
| “Tôi không muốn…” | invariant/anti-goal | tìm blast radius, sửa canonical owners + tests/backlog |
| “Nếu sau này thêm…” | expansion seam | tách future capability khỏi current implementation |
| “Cơ chế này nên…” | rule change | options/impact/ADR; lùi lifecycle nếu cần |
| “Tôi chưa hiểu…” | clarity defect hoặc design gap | viết lại flow; không che gap bằng từ ngữ |
| “Giống game X” | reference lens | rút nhu cầu/nguyên lý, research có câu hỏi, không copy |
| “Tôi sợ lỗi…” | risk statement | biến thành invariant, failure scenario, observability và regression |
| “Bạn tự quyết” | delegated design decision | dùng evidence/trade-off, ghi quyết định/candidate rõ; chỉ hỏi nếu đổi fantasy/scope khó đảo |

## 2. Quyết định từ feedback hiện tại

| ID | Quyết định | Hệ quả |
|---|---|---|
| `PD-001` | UMBRA là total-overhaul/game-in-Minecraft, không chỉ combat mod | audience, scope, foundation và quality bar mở rộng |
| `PD-002` | Third-person camera overhaul là core capability | đứng trước combat polish; có domain contract/test riêng |
| `PD-003` | Offline/single-player là target hiện tại | không implement multiplayer gameplay |
| `PD-004` | Architecture luôn server-authoritative và multiplayer-ready | ownership, packet validation, permissions/security seams từ foundation |
| `PD-005` | Public goal là full coherent game | không dùng prototype làm public promise |
| `PD-006` | Mỗi capability phải tạo playable internal snapshot | roadmap, Git, save/test/feature flag gate thay đổi |
| `PD-007` | Prologue/family được thiết kế sớm; implementation foundation trước | first core loop phải có return/home meaning, không block combat proof |
| `PD-008` | Longevity mục tiêu nhiều năm | dùng construction/mastery/identity/systemic content/expansion, không grind/FOMO |
| `PD-009` | Người dùng test ít và chủ yếu ở phần máy không tự kết luận | client GameTest/screenshots/logs tự động; user protocol tối giản |
| `PD-010` | Một người dùng + Agent là studio thực tế | Git/ticket/handoff phải chống mất context và thay vai trò chuyên môn |

## 3. Câu hỏi Product còn mở

1. Public 1.0 cần những act/boss/faction/Stratum nào để lời hứa “full game” đủ cụ thể?
2. Camera góc ba ưu tiên shoulder, centered hay context-adaptive làm baseline; lock-on/aim chuyển mode ra sao?
3. First-person support tới mức feature parity, presentation parity hay compatibility mode cho một số animation?
4. Player death nên giữ/reset những gì: level/stat, temporary combat state, Fatigue, Gate participation, Shadow deployment, item/inventory?
5. Creative mode là author/debug sandbox hoàn toàn hay có rule ngăn progression/reward bị ghi vào survival save?
6. Vanilla/third-party compatibility promise: hỗ trợ chính thức nhóm nào và fallback khi không thể phối hợp?
7. World/living society cần simulation depth tới đâu trước khi chi phí vượt player-visible value?
8. UMBRA tự cung cấp mount/vehicle/world structures tới đâu; phần nào dành cho content/add-on contract?
9. Long-term authored:systemic:player-created content ratio nào thực tế sau vertical slice?
10. Future multiplayer ưu tiên co-op cùng save, server persistent society hay PvP; câu trả lời chỉ dùng để chọn seam, chưa mở feature.

## 4. Cách trả lời

Bạn có thể trả lời một câu, phản đối tiền đề hoặc thêm nỗi sợ/ý tưởng mới. Agent phải cập nhật bảng quyết định/câu hỏi, không bắt bạn nhớ lịch sử trò chuyện.
