# UMBRA Design System — Cổng đọc duy nhất

> **Trạng thái dự án:** `DESIGN_DISCOVERY`
> **Mục đích:** một nguồn sự thật để người dùng đọc tuyến tính, feedback bằng lời; Agent tự định tuyến và duy trì toàn bộ hệ.

UMBRA là Minecraft Java dark-fantasy gameplay overhaul quy mô lớn: người chơi đi từ kẻ vô danh tới Chúa Tể Hắc Ảnh, chinh phục Gate, tự xây build và biến đối thủ đáng nhớ thành quân đoàn có danh tính—trong khi xây dựng, khám phá, sinh tồn, nhà và thế giới Minecraft vẫn có giá trị.

Không còn bộ tài liệu cũ song song. Tất cả ý thiết kế đã có canonical home trong cây này; Git giữ lịch sử. Một mục có chữ `CANDIDATE`, `OPEN`, `DISCOVERY` không phải nội dung cần né mà là điều được trình bày trung thực để người dùng quyết hoặc cho phép nghiên cứu tiếp.

## Tuyến đọc dành cho người dùng

### Vòng 1 — Hiểu game và cho feedback lớn

1. [Product Charter](10-direction/01-product-charter.md)
2. [Experience Framework](10-direction/02-experience-framework.md)
3. [System Map](10-direction/03-system-map.md)
4. [Scope và Release Strategy](10-direction/04-scope-and-release-strategy.md)
5. [Feedback và Open Decisions](10-direction/05-feedback-and-open-decisions.md)

[Canonical Glossary](10-direction/06-canonical-glossary.md) là tài liệu tra cứu khi gặp thuật ngữ, không bắt buộc đọc liền mạch.

Sau vòng này, có thể feedback fantasy, scope, core loop, camera, progression hoặc thứ tự ưu tiên. Không cần đọc kỹ thuật.

### Vòng 1.5 — Gói lo ngại nền tảng vừa được giải quyết

Chỉ đọc sau năm file trên hoặc khi muốn review đúng chủ đề:

1. [Input System](20-domains/11-presentation/input/README.md) → [Vanilla 26.2 Key Baseline](20-domains/11-presentation/input/vanilla-26.2-key-baseline.md)
2. [Camera Aim/Target Policy](20-domains/11-presentation/camera/aim-and-targeting-policy.md)
3. [UI/UX Design System](20-domains/11-presentation/ui/README.md)
4. [Version/Compatibility Policy](20-domains/12-platform/03-compatibility-and-release-baseline.md) → [Save Portability](20-domains/12-platform/06-save-ownership-backup-and-transfer.md)
5. [Early-game Danger](20-domains/08-world/04-early-game-survival-pressure.md)
6. [Content Instance Architecture](40-content/07-content-instance-architecture.md) → [Asset Pipeline](40-content/06-asset-production-and-registry.md)
7. [Quest Dependency/Production](20-domains/09-narrative/05-quest-dependency-and-production.md)
8. [Performance Constitution](60-quality/04-performance-budgets.md)
9. [Death và game-mode policy](20-domains/02-combat/death/README.md)
10. [Living Society](20-domains/08-world/05-living-society-simulation.md) → [Future Multiplayer Readiness](20-domains/12-platform/04-offline-first-multiplayer-readiness.md)

Không cần đọc cả gói một lần; feedback sau từng file vẫn được Agent đồng bộ toàn hệ.

### Tuyến ưu tiên cho feedback thuộc tính/cân bằng hiện tại

Đọc [Balance Discovery Guide](20-domains/01-player/03-attribute-and-balance-review-guide.md) trước. Hãy trả lời 12 câu Vòng A hoặc gửi nghiên cứu Where Winds Meet/Genshin theo format trong file; chưa cần đọc Parameter Registry. Sau vòng A, Agent mới dẫn sang damage/defense, enemy/counter và progression longevity để tránh khóa công thức khi fantasy còn mơ hồ.

### Vòng 2 — Đọc game tuyến tính theo miền

Đọc `README.md` của 12 domain theo thứ tự: [Player](20-domains/01-player/README.md) → [Combat](20-domains/02-combat/README.md) → [Skills](20-domains/03-skills/README.md) → [Shadows](20-domains/04-shadows/README.md) → [AI](20-domains/05-ai/README.md) → [Dungeons](20-domains/06-dungeons/README.md) → [Encounters](20-domains/07-encounters/README.md) → [World](20-domains/08-world/README.md) → [Narrative](20-domains/09-narrative/README.md) → [Items/Economy](20-domains/10-items-economy/README.md) → [Presentation](20-domains/11-presentation/README.md) → [Platform](20-domains/12-platform/README.md).

Mỗi domain README cho biết mission, ranh giới, invariant và các file chi tiết. Chỉ mở file con khi muốn feedback mechanic đó.

### Vòng 3 — Xem cách dự án được làm

1. [Capability Roadmap](50-production/01-capability-roadmap.md)
2. [Design Backlog](50-production/02-design-backlog.md)
3. [Implementation Backlog](50-production/03-implementation-backlog.md)
4. [Quality Coverage](60-quality/06-design-coverage.md)

Đọc governance/content/quality/research khi muốn review quy trình hoặc bằng chứng, không bắt buộc để hiểu fantasy.

## Khi gửi feedback

Chỉ cần nói điều mong muốn, ví dụ “dodge lùi nên là backstep và không xoay camera”, “tôi muốn gia đình có vai trò lớn từ đầu”, hoặc “thêm lock-on giống action RPG nhưng phải giữ góc một”. Agent áp dụng [Feedback Routing](00-governance/05-feedback-routing-and-edit-policy.md): phân loại quy mô, đọc các owner liên quan, lập impact map, sửa đúng canonical homes, cập nhật backlog/quality và báo lại câu hỏi cần quyết.

## Kiến trúc thư mục

```text
game-design/
├─ 00-governance/       luật tài liệu, Agent, vai trò và quality gates
├─ 10-direction/        lời hứa sản phẩm, trải nghiệm, scope và quyết định lớn
├─ 20-domains/          game design theo 12 miền có owner
├─ 30-shared-contracts/ vocabulary/state/rule dùng qua nhiều miền
├─ 40-content/          pipeline và chuẩn faction/boss/asset/content instance
├─ 50-production/       roadmap, design backlog, ticket và release gate
├─ 60-quality/          balance, parameter, test, performance, traceability
├─ 70-research/         protocol và nguyên lý đã chưng cất
├─ 80-templates/        mẫu tạo artifact mới
└─ design-assets/       hình minh họa thiết kế còn dùng
```

## Một luật — một nơi

- Product giải thích **vì sao và lời hứa gì**.
- Domain/System/Feature giải thích **người chơi làm gì và luật thuộc ai**.
- Shared Contract giải thích **nhiều feature giao tiếp ra sao**.
- Content Instance điền **boss/quest/item/faction cụ thể**.
- Parameter Registry sở hữu **mọi con số/công thức**.
- Quality định nghĩa **bằng chứng nào chứng minh đúng/tốt/nhanh**.
- Production chỉ định **thứ tự và proof**, không tự viết game rule.

Nếu hai nơi phát biểu cùng một luật, Agent phải chọn owner, giữ luật ở đó và thay nơi còn lại bằng link.

## Trạng thái thật hiện tại

- Corpus đã được hợp nhất; không còn legacy doc để người dùng phải né.
- Product/scope vẫn `PROPOSED`: cần feedback của Game Director (người dùng).
- Phần lớn gameplay ở `DISCOVERY`; nhiều con số chi tiết chỉ là candidate cần test.
- Dodge là Feature Cell mẫu sâu nhất nhưng chưa `IMPLEMENTATION_READY`.
- Chưa có gameplay ticket sẵn sàng code. Việc kế tiếp đúng là tiếp tục đọc/feedback Product; khi chuyển sang design execution, foundation queue bắt đầu tại `DB-019` (pin baseline 26.2), trước kernel, camera và combat.
