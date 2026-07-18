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
| `PD-020` | Không hỏi lại fixed boss/quest/world breadth cho “1.0” | breadth content tăng theo quality/dependency; Shadow cap là quyết định riêng tại `PD-031` |
| `PD-021` | Quest Kernel được chứng minh sớm, rich quest content mở theo dependency | state/reward/save trước; campaign breadth sau core systems |
| `PD-022` | Asset có registry, provenance, direction và technical gates | AI/reference không thay originality, art direction hoặc in-game QA |
| `PD-023` | Hiệu năng là design budget và release evidence của mọi capability | không chờ tối ưu cuối; client/tick/memory/I/O/network/cardinality có owner, benchmark và degradation |
| `PD-024` | Death bảo vệ progression dài hạn và Shadow identity; deployment được recall | consequence tạm thời, mode/activity-aware, không death spiral hoặc cộng nhiều hình phạt |
| `PD-025` | Creative là first-class author/debug sandbox theo ý định Minecraft | cho phép grant/spawn/test; provenance theo event bảo vệ challenge/ranked eligibility, không “taint” cả save |
| `PD-026` | Living society đi theo identity/ledger → hub observable → relationship → settlement → faction → deep individual | chứng minh chiều sâu nhìn thấy trước khi scale simulation |
| `PD-027` | Future multiplayer ưu tiên co-op 2–4; sau đó PvP 1v1/3v3, ranking/event | chỉ khóa ownership/security/performance seam; current scope vẫn offline |
| `PD-028` | Attribute/damage/Potential/counterplay được mở lại như discovery toàn hệ | công thức corpus cũ chỉ là candidate; user review + research + prototype mới được approve |
| `PD-029` | Fabric là loader hiện tại; NeoForge là first-class future target bắt buộc | common semantics/save + ports-and-adapters có chọn lọc; artifact/test/perf manifest riêng, chưa claim NeoForge support |
| `PD-030` | Agent tự gán performance risk cho mọi runtime change | `PR-0–PR-3` quyết lane đo; không benchmark mọi thay đổi và không bỏ đo feature có rủi ro |
| `PD-031` | Shadow là một Retinue tinh nhuệ: tối đa 5 sở hữu, tối đa 4 triển khai chiến đấu | bắt đầu với 1 slot khi mở hệ; slot 5 rất muộn và là dự bị chiến lược; không kho/quân đoàn ẩn; exact unlock/full-roster flow theo `CTR-SHADOW-RETINUE`/`DB-044` |
| `PD-032` | Shadow cần biểu cảm/ritual theo context và personality | quỳ là dấu câu hiếm; semantic/priority/group reservation/fallback theo `SYS-SHADOW-EXPRESSION`, không emote spam hoặc cắt combat |
| `PD-033` | UMBRA dùng một health authoritative tương thích Minecraft, nhưng sở hữu damage semantics và HUD thanh cố định | không tạo “RPG HP” song song; Max HP tăng không sinh thêm hàng tim, mọi damage môi trường phải qua matrix có attribution/test |
| `PD-034` | Mana và Focus là hai resource riêng; Focus hồi nhanh cho phòng thủ chủ động, không là stamina di chuyển chung | HUD fixed-width có cost preview/notch; exact cap/regen/cost vẫn do `DB-046/042` chứng minh |
| `PD-035` | Combat Flask là quick-recovery action/slot chuyên biệt; food vẫn giữ vai trò hunger/survival | bắt đầu một charge là direction; giả thuyết tối đa 10 chưa khóa, cần `DB-047` cân bằng capacity–potency–refill–interrupt |
| `PD-036` | Third-person free movement mặc định camera-relative và camera orbit không kéo thân nhân vật khi đứng yên | lock-on/precision dùng basis riêng; ranged không mặc định ép first-person, chuyển mode phải predictable và có setting |

## 3. Delegated research — Agent tự giải, không hỏi user sớm

- Exact third-person centered/shoulder distances, transition, reticle/soft-target/lock-on và aim assist.
- Default keyboard/mouse layout, Dodge key, skill/hotbar/command mapping.
- Exact early-game zombie/player/world levers và difficulty parameters.
- UI visual direction/component layouts và asset production tools.
- Exact numerical band của HP/Mana/Focus, Combat Flask capacity/potency/refill và health-environment mapping.
- Authored/systemic/player-created mix, content batch size và release breadth.

Các mục này chỉ quay lại hỏi user khi prototype tạo trade-off fantasy thật sự; trước đó Agent chịu trách nhiệm research/evidence.

## 4. Câu hỏi Product còn mở

Bốn câu hỏi death, Creative, living society và multiplayer trước đây đã được khóa ở `PD-024–027`; Agent không hỏi lại. Vòng feedback có đòn bẩy lớn tiếp theo là fantasy/topology thuộc tính, damage và counterplay tại [Balance Discovery Guide](../20-domains/01-player/03-attribute-and-balance-review-guide.md), ưu tiên 12 câu Vòng A.

Exact death penalty/preset là tuning discovery của `DB-040`, không phải câu hỏi Product. Exact performance target theo hardware/profile là technical evidence của `DB-039`, không xin một con số cảm tính từ user.

## 5. Cách trả lời

Bạn có thể trả lời một câu, phản đối tiền đề hoặc thêm nỗi sợ/ý tưởng mới. Agent phải tìm quyết định cũ trước khi hỏi, cập nhật owner/backlog/quality và không bắt bạn nhớ lịch sử trò chuyện.
