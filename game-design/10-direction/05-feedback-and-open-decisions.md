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
| `PD-004` | Architecture luôn server-authoritative và multiplayer-ready | ownership, payload validation và security seams từ foundation |
| `PD-005` | Public goal là full coherent game | không dùng prototype làm public promise |
| `PD-006` | Mỗi capability tạo playable internal snapshot | roadmap, Git, save/test/feature flag gate thay đổi |
| `PD-007` | Prologue/family thiết kế sớm; implementation foundation trước | return/home meaning không block combat proof |
| `PD-008` | Longevity mục tiêu nhiều năm | construction/mastery/identity/systemic/authored breadth, không FOMO |
| `PD-009` | User test ít và chủ yếu ở phần máy không tự kết luận | automated evidence trước, Test Card tối giản |
| `PD-010` | Một người dùng + Agent là studio thực tế | repo/ticket/handoff chống mất context |
| `PD-011` | Keybind là versioned input system, không chọn từ ký ức | audit 26.2, remap/conflict/context/ergonomics và layout tests |
| `PD-012` | Việt `vi_vn` và Anh `en_us` bắt buộc; theo Minecraft locale | không có mod-language override ở baseline; runtime resource reload |
| `PD-013` | Một active Minecraft baseline được pin/port có gate | save compatibility ưu tiên hơn one-JAR backward binary support |
| `PD-014` | Gameplay state đi cùng world save và backup/transfer được | manifest, restore-as-copy, migration/recovery tests |
| `PD-015` | UI cần design system + information architecture | không sản xuất hàng loạt screen từ một nhãn style mơ hồ |
| `PD-016` | Phàm Nhân đầu game phải thật sự mong manh và biết sợ hostile | research paired player–zombie–world; không buff stat đơn lẻ |
| `PD-017` | Mỗi enemy/skill/quest/item đáng kể có dossier riêng | grammar → kit → instance → variant, interaction tags/tests |
| `PD-018` | UMBRA là all-in-one first-party overhaul | full vanilla baseline; external overhaul conflict có thể unsupported |
| `PD-019` | Third-person mặc định sau `C2`; first-person luôn được hỗ trợ | camera switch/aim policy và parity tests |
| `PD-020` | Không hỏi lại fixed roster/quest count cho “1.0” | breadth tăng theo quality/dependency; release manifest khóa khi đủ coherent |
| `PD-021` | Quest Kernel được chứng minh sớm, rich quest content mở theo dependency | state/reward/save trước; campaign breadth sau core systems |
| `PD-022` | Asset có registry, provenance, direction và technical gates | AI/reference không thay originality, art direction hoặc in-game QA |

## 3. Delegated research — Agent tự giải, không hỏi user sớm

- Exact third-person centered/shoulder distances, transition, reticle/soft-target/lock-on và aim assist.
- Default keyboard/mouse layout, Dodge key, skill/hotbar/command mapping.
- Exact early-game zombie/player/world levers và difficulty parameters.
- UI visual direction/component layouts và asset production tools.
- Authored/systemic/player-created mix, content batch size và release breadth.

Các mục này chỉ quay lại hỏi user khi prototype tạo trade-off fantasy thật sự; trước đó Agent chịu trách nhiệm research/evidence.

## 4. Câu hỏi Product còn mở

1. Player death giữ/reset cụ thể level/stat, temporary combat state, Fatigue, Gate participation, Shadow deployment và inventory thế nào?
2. Creative mode là author/debug sandbox hoàn toàn hay có rule ngăn progression/reward ghi vào survival save?
3. Living society ưu tiên simulation sâu ở NPC cá nhân, settlement/economy hay faction/world-state trước?
4. Future multiplayer ưu tiên co-op cùng save, persistent server society hay PvP? Câu trả lời chỉ chọn seam, chưa mở feature.

## 5. Cách trả lời

Bạn có thể trả lời một câu, phản đối tiền đề hoặc thêm nỗi sợ/ý tưởng mới. Agent phải tìm quyết định cũ trước khi hỏi, cập nhật owner/backlog/quality và không bắt bạn nhớ lịch sử trò chuyện.
