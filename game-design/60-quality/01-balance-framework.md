# QLT-BALANCE — Hiến chương cân bằng và cách chứng minh

> **DRI:** Balance Designer
> **Approver:** Game Director
> **Reviewers:** Player, Combat, Shadows, Enemy, Economy, UX, Accessibility, Performance
> **Status:** `DISCOVERY`

## 1. Balance phục vụ trải nghiệm nào

UMBRA không cân bằng để mọi lựa chọn có cùng damage trong mọi tình huống. Balance phải tạo:

- tăng trưởng nhìn thấy được mà không biến content thành số vô nghĩa;
- nhiều build có **cách thắng và điểm yếu khác nhau**;
- mastery đủ sức cứu sai số build hợp lý, nhưng chuẩn bị/counter vẫn đáng giá;
- learning→competent→expert đều có challenge band và cách biểu đạt tiến bộ; difficulty không đồng nghĩa clear rate thấp;
- enemy có luật đọc được, không gian lận hoặc trở thành damage sponge;
- Self và Hắc Ảnh Cận Vệ cùng mạnh nhưng không làm một phía vô nghĩa;
- world chơi nhiều năm không buộc power creep vô hạn hoặc grind/FOMO.

## 2. Năm lớp power không được cộng dồn vô thức

| Lớp | Vai trò đề xuất | Rủi ro cần chống |
|---|---|---|
| Baseline/Level | bảo đảm nhân vật còn hoạt động và biểu đạt tăng trưởng nền | Level gap thay toàn bộ kỹ năng |
| Gear/items | chuẩn bị và thích nghi encounter | loot vô hiệu hóa build cũ |
| Skill/loadout | động từ và cách giải tình huống | một rotation tối ưu duy nhất |
| Capability mastery | bounded capacity/recovery/expression do thực hành | tái tạo Primary Attributes/Rank, AFK grind |
| Active Retinue | role, phối hợp và kiểm soát chiến trường | auto-win, slot 5–8 thành power tax hoặc player chỉ đứng nhìn |

`Power Budget` chỉ là mô hình phân tích, không là một con số truth che mọi khác biệt. Mỗi lớp phải khai phần nó sở hữu, cap/diminishing return và cách migration khi topology đổi.

## 3. Fairness contract

- Damage và thất bại phải truy được source/action/hit/status.
- Telegraph có đủ lead time theo mastery band và cue không chỉ dựa màu/âm thanh đơn lẻ.
- Counter bất lợi mặc định là soft: tăng rủi ro, thời gian hoặc yêu cầu kỹ thuật; hard gate chỉ dùng khi content dạy, preview và có nhiều đường chuẩn bị.
- Enemy không đọc input bí mật hoặc đổi luật sau commit; reaction theo perception/AI contract.
- Randomness không quyết định outcome lớn nếu player không thể quản lý xác suất.
- Difficulty không âm thầm buff/nerf sau lưng người chơi. Adaptive behavior vẫn là candidate cần ethics/accessibility review.
- Assist/preset được phép giảm barrier ngoài ý muốn hoặc execution margin, nhưng phải khai lesson nào giữ, cue nào thêm và achievement/ruleset implication; accessibility không bị đánh đồng với auto-win.

## 4. Balance theo encounter ecology

Không cân một action trong chân không. Mỗi proof dùng ít nhất:

- player profile: minimum-valid, expected, high-investment;
- mastery profile: learning, competent, expert;
- context: first/third person, 0/1/2/4 active Shadow, open world/Gate, terrain/chunk constraints;
- enemy mix: pressure, ranged, control, support, elite/boss mechanic;
- resource state: fresh, depleted, recovery;
- mode/ruleset: Survival/difficulty; future co-op/PvP tách profile.

Enemy counter trước hết nhắm hành vi có vấn đề như spam, tụ cụm, đứng xa hoặc dodge sớm; “hệ khắc hệ” không thay encounter design.

## 5. Difficulty và progression arc hypothesis

| Giai đoạn | Cảm xúc/decision cần kiểm chứng |
|---|---|
| Level 1–19 | mong manh, học quan sát, shelter/escape có giá trị |
| Level 20–49 | mở lựa chọn, build bắt đầu khác nhau, chuẩn bị thắng sức mạnh thô |
| Level 50–79 | tactics/loadout/command và enemy composition sâu |
| Level 80–99 | power fantasy có chủ ý, spectacle không mất readability |
| Level 100+/Strata | mastery, constraint tự chọn và đổi trục xung đột |

Level không tự quyết toàn bộ HP/damage multiplier. World scaling, authored bands và hybrid vẫn thuộc damage discovery; zombie đầu game là paired player–enemy–world problem của `DB-034`.

## 6. Damage, defense và TTK

Damage pipeline/order/rounding chỉ có một canonical owner trong Parameter Registry sau khi damage discovery khóa semantics. Crit, variance, armor, penetration, resistance, status buildup và elemental relationship chưa được duyệt. Posture meter đã bị xóa; stagger/launch nếu có là typed result, không là resource.

TTK là **cửa sổ biểu đạt pattern, learning delta và số lỗi được dung thứ**, không là một số toàn game. Regular phải kịp dạy/biểu lộ archetype; elite buộc thích nghi; boss dạy rồi kiểm tra mà không lặp phase vô ích. Candidate `3–8s`, `20–40s`, `2–4m`, `5–12m` chỉ là corpus hypothesis. Clear rate/TTK không đủ: proof còn cần cause-of-failure, cue recognition, adaptation between attempts, input/camera error và build-route diversity.

Damage display là một phần balance evidence: multi-hit/Retinue + hostile đông phải gộp/cap đủ để player đọc nguyên nhân mà không gây clutter hoặc performance spike. Exact number scale, bar/icon/color/crit/blocked presentation thuộc `DB-042` + UI contract.

## 6.1. Retinue topology và encounter proof

Sức chứa/active cap do [`CTR-SHADOW-RETINUE`](../30-shared-contracts/07-shadow-retinue-capacity-and-membership.md) sở hữu. Balance không được tăng HP/số quái theo công thức `roster_count × multiplier`.

- Tối đa bốn reserve (roster slot 5–8) không đóng góp power budget trận hiện tại và không phải yêu cầu để đạt content baseline.
- Encounter chứng minh qua profile `Self only`, `Self + 1`, `Self + 2` và `Self + 4`; mỗi profile cần đường thắng hợp lệ nếu content không ghi rõ party requirement.
- Thêm Shadow chủ yếu tăng role coverage, target control và recovery option; diminishing return/counter/objective/terrain ngăn bốn member thành bốn lần DPS.
- Director tăng composition, pressure lane, objective hoặc counterplay trước HP sponge/quân số vô hạn.
- Enemy threat/target reservation phải giữ player có vai trò chủ động, không để AI hai phía tự chơi.

## 7. PvE, co-op và PvP

- Solo là reference target hiện tại; co-op sau này không được khiến solo thành bản thiếu người.
- Co-op scale ưu tiên enemy composition, role pressure và mechanics trước nhân HP.
- Future PvP `1v1/3v3` có ruleset/parameter/cap riêng khi cần. Không nerf PvE fantasy mặc định để vá ranked balance.
- Mọi result/simulation ghi ruleset ID, build version và content version.

## 8. Quy trình từ giả thuyết tới số được duyệt

1. Khóa damage/defense/counter semantics không dùng Primary Attributes/Posture meter.
2. Đặt candidate range và lý do tại Parameter Registry.
3. Chạy deterministic simulation/property/boundary tests để loại công thức hỏng.
4. Prototype với ít nhất ba build × ba mastery profile × encounter ecology phù hợp.
5. Playtest feel/readability/fairness; kiểm accessibility và performance.
6. Ghi evidence/approver rồi mới nâng parameter; kèm migration/respec nếu save bị ảnh hưởng.

Một bảng spreadsheet không chứng minh combat hay. Một playtest hay không chứng minh overflow, exploit hoặc build dead. Cần cả quantitative và qualitative evidence.

## 9. Change control

Mọi balance change khai mục tiêu, affected profiles/content, save/migration, UI text, AI/counter, economy/reward, performance cardinality và future rulesets. Ưu tiên sửa nguyên nhân hệ thống; không giữ power creep chỉ vì sợ nerf, cũng không nerf build phổ biến chỉ vì usage cao. Player-facing thay đổi lớn cần preview/reason và đường respec/recovery tương xứng.

## 10. Cửa feedback hiện tại

Đọc [Level, Skill và Vigor Review Guide](../20-domains/01-player/03-level-skill-and-vigor-review-guide.md). Parameter Registry là owner phép tính đã khóa; không phục hồi công thức Rank/Primary Attribute cũ.
