# SYS-UI-DESIGN — UI/UX design system và information architecture

> **DRI:** UX Lead + UI Art Director
> **Reviewers:** Game Design, Accessibility, Localization, Camera, Rendering, QA
> **Status:** `DISCOVERY`

## 1. Experience goals

UI phải khiến một game rất sâu vẫn **đọc được, học được và mở rộng được**. Nó không chỉ “đẹp”: người chơi phải biết đang ở đâu, quyết định nào quan trọng, hậu quả gì xảy ra và cách quay lại game trong ít thao tác.

## 2. Presentation families

| Family | Dùng cho | Rule chính |
|---|---|---|
| Diegetic/world cue | marker, telegraph, interactable, world state | gắn không gian, không xuyên/che vô lý |
| Combat HUD | HP/resource/target/action/status | glanceable, context-minimal, không che actor |
| Lightweight overlay | wheel, quick command, compare, notification | giữ context game, đóng nhanh |
| Full-screen workspace | build, roster, crafting, quest, map | task-oriented, back-stack và safe pause policy |
| Modal | irreversible/destructive/critical error | hiếm, focus rõ, không chain modal |
| Codex/help | recall, glossary, mechanic explanation | searchable, context-linked, không thay training |

Không dùng một component cho mọi family chỉ vì có thể tái sử dụng code.

## 3. Visual direction hypothesis

Tên làm việc: **Shadowed Minecraft Instrumentality**—khối, vật liệu và nhịp pixel tôn trọng Minecraft; silhouette, chiều sâu, ink/shadow và ánh kim thể hiện fantasy Chúa Tể. Đây là direction để concept test, không phải lệnh “làm mọi màn hình màu đen”.

Nguyên tắc:

- hierarchy và legibility thắng ornament;
- Minecraft-native geometry nhưng không giả vanilla screen cho hệ thống phức tạp;
- màu hiếm dùng cho meaning/state, không chỉ trang trí;
- texture/noise/particles không làm giảm contrast hoặc text clarity;
- animation giải thích transition/ownership, không kéo dài thao tác;
- dark/light environment, first/third camera, GUI scale và Vulkan/OpenGL đều phải test.

## 4. Token và component architecture

Token hóa spacing, type scale, color role, elevation/surface, border, icon size, motion duration/easing, sound role và safe area. Component có states `default/hover/focus/pressed/disabled/selected/warning/error/loading/empty` và keyboard focus rõ.

Reusable primitives: action prompt, resource meter, item/skill card, comparison row, filter/search, tabs chỉ trong một task, breadcrumb/back-stack, tooltip/detail panel, confirmation, toast, target plate và command feedback. Component version đổi meaning cần migration/review cho mọi consumer.

## 5. Information architecture

Không tổ chức menu theo package code. Mỗi flow bắt đầu bằng player task như “đổi build”, “tìm Shadow phù hợp”, “theo dõi quest”, rồi mới ánh xạ data owner.

Để scale hàng trăm item/skill/Shadow/quest:

- global search không thay filter chuyên domain;
- saved filters/favorites/recent và sort có meaning;
- list–detail/compare giữ context, không mở chuỗi modal;
- progressive disclosure: summary → decision details → advanced formula;
- deep link từ reward/quest/notification tới đúng object và back về nguồn;
- empty/loading/error/missing-definition states là flow chính thức;
- screen không được phụ thuộc text length tiếng Anh.

## 6. UX intelligence rules

- Hiện thông tin ở lúc có thể dùng, không phải lúc engine vừa tạo.
- Default phù hợp người mới; expert path giảm thao tác nhưng không ẩn hậu quả.
- Irreversible choice có preview delta, dependency và recovery policy.
- UI không biến mọi system thành currency bar hoặc red-dot chore.
- Marker/journal cho phép độ hướng dẫn khác nhau; discovery không tự động thành checklist.
- Controller chưa là support promise nhưng focus graph và action abstraction không được khóa nó ra khỏi kiến trúc.

## 7. Deliverables trước code UI lớn

1. Screen/task inventory và information graph.
2. Visual reference board có originality review.
3. Low-fi wireframes cho HUD, build, roster, quest và settings.
4. Token sheet + component state sheet Việt/Anh.
5. Interactive prototype cho ba flow phức tạp nhất.
6. Accessibility/localization/performance review và screenshot baselines.

Không sản xuất full skin trước khi wireframe chứng minh navigation. Không khóa UI style chỉ bằng một mockup đẹp ở một độ phân giải.
