# AUDIT-BASELINE — Audit corpus thiết kế cũ

> **DRI:** Lead Game Designer + Design Operations
> **Ngày audit:** 2026-07-18
> **Status:** `COMPLETE`

## Kết luận

Corpus v4 có tầm nhìn rộng, nhiều invariant hữu ích và ý thức tốt về performance/data/test. Tuy nhiên nó **chưa đủ điều kiện để tuyên bố gameplay sẵn sàng code**. Vấn đề không phải thiếu thêm một file tổng hợp; vấn đề là sai cấp độ nguồn chân lý và thiếu lifecycle bằng chứng theo feature.

## Phát hiện kiến trúc

| Mức | Phát hiện | Hậu quả | Xử lý mới |
|---|---|---|---|
| Critical | Tài liệu readiness tự đánh dấu M0/gameplay đã chốt dựa trên việc có đoạn văn/schema/formula | false confidence; ticket biến thành nơi quyết định design | reset gameplay về `DISCOVERY`; gate theo Feature Cell |
| Critical | Luật nằm lặp ở README, GDD, domain, formula, schema, test, backlog | sửa một nơi tạo conflict âm thầm | owner theo loại artifact + link bằng ID |
| High | Các đoạn “Bổ sung v4.0” ghi đè nội dung cũ thay vì hợp nhất | cùng file có nhiều sự thật | canonical text tại chỗ + ADR + Git history |
| High | Đánh số file tuyến tính giả vờ biểu diễn dependency graph | feature chéo domain khó tìm impact | hierarchy + dependency + experience + delivery views |
| High | Milestone/ticket cũ xuất hiện trước discovery từng feature | code theo ticket nhưng research diễn ra trong implementation | freeze backlog cũ; Capability Slice sau gate |
| Medium | Một file có nhiều owner nhưng không có một DRI | quyết định cuối mơ hồ | DRI/Approver/Reviewer rõ |
| Medium | Case study lớn nằm cạnh nguồn chân lý | dễ biến reference thành requirement | research archive/card tách biệt |

## Mâu thuẫn/thiếu logic cụ thể

| ID | Vấn đề | Nguồn cũ | Trạng thái |
|---|---|---|---|
| `A-001` | Luật attribute nói 5 điểm tự do, không +1 tự động; phần lý do lại nói mô hình auto+free | progression 03.3 | `OPEN` |
| `A-002` | UI shop dùng “xoay vòng ngày”, trong khi hiến chương/no-FOMO tránh daily/calendar pressure | UI 25.3.3 vs economy/principles | `OPEN` |
| `A-003` | GDD mở Shadow Exchange level 70; skill table mở hạng S, theo rank table là level 80 | GDD 02.6 vs skills 06.5/progression | `OPEN` |
| `A-004` | “Boss đọc dodge” có thể bị hiểu là đọc input, trái nguyên tắc AI không gian lận | combat risk vs AI fairness | `OPEN`; phải đổi thành telegraphed roll-catch/counter pattern nếu duyệt |
| `A-005` | Dodge có tám hướng nhưng chưa nói camera/world-relative, target lock, water/ladder/vehicle/crawl và loại damage được miễn | combat/formula/test | `OPEN` |
| `A-006` | Dodge được phép hủy recovery chung chung, chưa có cancel matrix theo attack phase; có thể làm mất weight/risk | combat 05.2 | `OPEN` |
| `A-007` | Light attack là combo chuột trái nhưng chưa có hit cadence/authorization chống spam click và tương tác cooldown vanilla | combat 05 | `OPEN` |
| `A-008` | Velocity dodge/server authority có số cụ thể nhưng chưa có prediction, correction, latency fairness, collision oracle | formula/architecture | `OPEN` |
| `A-009` | Camera chỉ có shake/VFX; chưa có thiết kế first/third person, crosshair/target/framing | combat/UI | `MISSING` |
| `A-010` | Animation dodge/combat chưa có state graph, event timing, blend/cancel/root-motion policy | toàn corpus | `MISSING` |
| `A-011` | Quest schema chỉ có list objective/reward/prerequisite; thiếu lifecycle, actor, branch, failure/recovery, world mutation, idempotency, localization và debug | data 15.7/narrative | `MISSING` |
| `A-012` | Nhiệm vụ narrative, training, guild và dynamic objective bị gom dưới một schema nông | GDD/narrative/data | `OPEN` |
| `A-013` | Thuật ngữ “Thể Lực (Fatigue)” dễ bị hiểu là stamina tức thời; Focus mới thực sự trả chi phí action | combat/UI/formula | `OPEN`; cần terminology research |
| `A-014` | Localization chỉ được nhắc qua văn phong; chưa có ID/string/fallback/plural/font/QA contract | toàn corpus | `MISSING` |
| `A-015` | Version Minecraft/Fabric/JDK là dữ kiện dễ đổi nhưng được ghi như invariant sản phẩm | architecture/compat/roadmap | `UNVERIFIED`; chuyển sang release/platform decision |
| `A-016` | Scope 1.0 gồm quá nhiều domain chưa từng prototype, trong khi M2 mới định kiểm core loop | roadmap/backlog | `OPEN`; cần scope ladder sau vertical evidence |

## Điểm tốt được bảo tồn

- Fantasy zero-to-monarch và năm trụ cảm xúc có sức kết nối.
- “Minecraft trước, mod sau”, no-FOMO, original transformation và performance-first là guardrail tốt.
- Gate lifecycle và Soul Echo đã tiến gần dạng state machine/testable.
- Shadow là đồng đội vĩnh viễn, không upkeep mana là một identity rõ.
- Data-driven, server authority, migration và LOD được nghĩ sớm đúng hướng.
- Boss-as-teacher, content card và human playtest là nền production tốt.

Những điểm này được đưa vào Product Charter/System Map dưới trạng thái phù hợp, không bị mất khi archive.

## Hành động migration

1. Corpus cũ chuyển `90-archive/v4-monoliths` và bị tước quyền source-of-truth.
2. Bốn file cũ còn ở root `game-design/` do quyền filesystem vẫn được coi là legacy theo banner ở README; cần chuyển/stub khi quyền cho phép.
3. Tạo governance, Product Charter, System Map và Shared Contract Catalog.
4. Dùng Dodge làm Feature Cell mẫu để kiểm kiến trúc.
5. Migrate từng system theo risk/fan-out, không copy hàng loạt rồi giả hoàn tất.
6. Chỉ tái tạo production backlog khi Feature Cell đạt gate.

