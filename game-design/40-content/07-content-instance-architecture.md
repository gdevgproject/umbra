# CNT-INSTANCE-ARCH — Kiến trúc content sâu và có thể mở rộng

> **DRI:** Content Director + Lead Systems Designer
> **Status:** `PROPOSED`

## 1. Không đánh đổi depth lấy scale

Mỗi enemy, skill, item, quest, faction, room hoặc event có thể được chau chuốt như một sản phẩm nhỏ. Data-driven không nghĩa mọi object chỉ là một hàng stat; nó nghĩa shared grammar ổn định để instance khác biệt mà không thêm `if ID == ...` vào engine.

## 2. Bốn tầng

| Tầng | Sở hữu | Ví dụ |
|---|---|---|
| Grammar/Contract | luật engine và vocabulary | action phase, objective primitive, status semantics |
| Archetype/Kit | behavior/asset bundle tái dùng có chủ đích | melee pursuer, ranged controller, rescue quest kit |
| Content Instance | một object có identity, role, learning và acceptance riêng | một zombie UMBRA archetype, một skill, một quest cụ thể |
| Variant/Spawn Profile | parameter/context hợp lệ không đổi identity | biome tier, elite affix, difficulty profile |

Variant phải được nâng thành Instance khi đổi player lesson, state machine, counterplay, reward identity, narrative meaning hoặc asset/performance tier đáng kể.

## 3. Content dossier

Mỗi instance có stable `CNT-*` ID và dossier riêng: fantasy/purpose, dependencies, provides/requires/conflicts tags, behavior/state graph, scenarios, interaction matrix, parameters, presentation/assets/audio, acquisition/spawn/delivery, progression/economy, save/migration, localization, accessibility, debug fixture, performance tier, acceptance và originality.

Một skill tạo mechanic mới phải mở/reuse Feature Cell trước; content file không được bí mật phát minh engine rule. Một enemy cần sensory/pathfinding/target state mới phải review AI contract. Một quest reward chưa có item/economy owner thì quest chưa Ready.

## 4. Interaction explosion

Không test ngây thơ mọi cặp content. Dùng typed capability tags và risk classes:

- universal invariants chạy cho mọi instance;
- contract tests chạy theo `provides/requires`;
- pairwise/combinatorial tests sinh cho tag có interaction;
- hand-authored scenario cho high-risk/hero object;
- stress set đại diện nhiều role/size/VFX/state;
- runtime validator từ chối dependency/conflict không hợp lệ.

Thêm hệ khắc chế mới phải định nghĩa semantics tập trung, ownership, stacking/precedence, cue và matrix migration; không thêm bảng khắc chế riêng vào từng quái.

## 5. Sequencing breadth

Không đặt trần số lượng. Tuy nhiên breadth được sản xuất theo **representative exemplar → kit validation → controlled batch → cross-content stress → polish pass**. Content có interaction phức tạp được làm muộn hơn khi contract nền đã chứng minh—not vì thiếu tham vọng, mà để tránh phải sửa hàng trăm instance sau một thay đổi nền.

Mỗi batch có quality debt budget; object chưa có identity/lesson chỉ là candidate, không được coi là breadth hoàn thành.
