# PROD-EXPERIENCE — Khung trải nghiệm và nhịp cảm xúc UMBRA

> **DRI:** Game Director + UX Research Lead
> **Status:** `PROPOSED`

## 1. Emotional heartbeat

Vòng lặp cảm xúc nền:

```text
Ổn định mong manh → tò mò/tham vọng → nguy cơ đọc được
→ học và chuẩn bị → tự mình thực hiện → vượt qua/ứng biến
→ khoảnh khắc quyền lực → được ghi nhận → sở hữu hậu quả
→ nghỉ/thể hiện/xây dựng → tự chọn tham vọng tiếp theo
```

Game không giữ người chơi bằng cách luôn tăng áp lực. Tension cần relief; mastery cần sân phô diễn; power cần trách nhiệm/đối trọng; discovery cần nơi trở về để thông tin mới có nghĩa.

## 2. Bản đồ ham muốn dài hạn

| Desire engine | Câu hỏi người chơi tự hỏi | Hệ phục vụ | Dấu hiệu khỏe | Dấu hiệu bệnh |
|---|---|---|---|---|
| Survive | “Tối nay mình sống và dựng chỗ đứng thế nào?” | vanilla/world/home | quyết định tài nguyên/địa hình có nghĩa | chores lặp |
| Embody | “Nhân vật có làm đúng điều mình định làm không?” | input/camera/movement/combat/presentation | điều khiển trở nên trực giác nhưng vẫn có trọng lượng | floaty, input–animation rời nhau |
| Improve | “Mình luyện gì để vượt giới hạn?” | combat/build/mastery | thấy lỗi và tiến bộ thật | stat gate |
| Overcome | “Đối thủ này đang dạy và thử mình điều gì?” | enemy/boss/Gate/difficulty | thất bại tăng hiểu biết; chiến thắng tạo tự hào xứng đáng | trial-and-error mù, thắng rẻ |
| Acquire | “Đối thủ/vật phẩm/năng lực hiếm nào đáng theo đuổi?” | Shadows/items/content | reward đổi động từ/identity | loot spam |
| Express | “Save/build/đội hình này là của mình ra sao?” | construction/loadout/command | hai save khác nhau nhìn thấy được | meta duy nhất |
| Discover | “Ngoài kia còn gì mới, và thứ quen thuộc đã đổi nghĩa ra sao?” | altered-vanilla affordance, ecology/creature, Gate/world/faction/lore | discovery làm đổi route, công cụ, giả thuyết hoặc mục tiêu quay lại | checklist marker, reskin/catalog không đổi quyết định |
| Be recognized | “Thế giới có biết mình đã làm gì?” | society/narrative/events | phản ứng và quyền truy cập hợp lý | reputation number vô hồn |
| Belong | “Mình đang bảo vệ/xây dựng điều gì?” | home/family/shadows | muốn tự nguyện trở về | daily maintenance |
| Transcend | “Sau đỉnh cũ, loại thử thách mới là gì?” | rank/Tower/Strata | đổi trục xung đột | HP inflation |

## 3. Nhịp thời gian

| Nhịp | Khoảng | Payoff bắt buộc |
|---|---:|---|
| Input | 50–250 ms cảm nhận | nút/camera phản hồi, không mơ hồ context |
| Action | 0.2–5 giây | anticipation–active–recovery đọc được |
| Encounter | 30 giây–12 phút | một bài học, adaptation hoặc spectacle beat |
| Activity | 10–60 phút | Gate/chuyến xây/khám phá/quest có kết thúc hoặc safe pause |
| Session | 20 phút–nhiều giờ | ít nhất một lựa chọn/hậu quả lưu được; không cần daily reset |
| Chapter | 3–20 giờ | breakthrough, shadow/boss/place định danh hoặc world change |
| Campaign | phụ thuộc scope | hoàn tất câu hỏi chủ đề và graduation |
| Long horizon | nhiều năm | mastery, construction, collection, systemic worlds và expansion tự chọn |

Game phải save/quit an toàn tại boundary hợp lý; phiên dài không phải điều kiện để tránh mất tiến độ.

## 4. Activity envelope theo giai đoạn

Không khóa tỷ lệ cứng cho mọi người chơi. Các band dưới đây là **design envelope** để phát hiện một hệ đang nuốt game:

| Giai đoạn | World survival/build/explore/discovery | Combat/Gate | Build–Shadow–management | Narrative/society/return |
|---|---:|---:|---:|---:|
| Khởi đầu | 40–65% | 10–25% | 0–10% | 15–30% |
| Thức Tỉnh | 25–45% | 25–40% | 10–20% | 15–25% |
| Chỉ Huy | 20–35% | 25–40% | 20–35% | 15–25% |
| Bá Chủ/Chúa Tể | 15–35% | 20–40% | 20–40% | 15–30% |

Đây là tỷ lệ trải nghiệm có thể lựa chọn, không quota bắt người chơi làm. Builder có thể ở world lâu; action player có đường vào Gate nhanh; cả hai vẫn nhận reward quay lại phần còn lại.

Discovery không nhận một cột phần trăm riêng vì nó cắt xuyên world, Gate, creature, progression, narrative và capability mới. Feedback về “nhiều điều mới lạ hơn vanilla” **không yêu cầu đổi các band hiện tại**; nó yêu cầu audit chất lượng của nội dung bên trong mỗi band. Chỉ đổi band khi session/campaign playtest cho thấy một activity family thật sự nuốt các đường tự chọn khác.

### 4.1. Discovery portfolio

Mỗi content/capability wave phải biết mình đóng góp mode nào; không cần ép đủ cả năm trong một feature:

1. **Transformed familiarity:** block, mob, biome, shelter, crafting hoặc route quen có affordance/counter/consequence mới.
2. **Frontier novelty:** creature, ecology, faction, Gate, structure, rule hoặc world layer chưa biết tạo kỳ quan thật.
3. **Mechanical revelation:** người chơi phát hiện một interaction/combination mới có thể chủ động dùng lại, không chỉ mở codex.
4. **Systemic recombination:** các rule đã biết gặp terrain, AI, event hoặc player construction để sinh tình huống không hoàn toàn scripted.
5. **Meaning revelation:** lore/relationship/world fact tái nghĩa hóa lựa chọn hiện tại mà không phủ định agency.

Portfolio khỏe dùng nhịp `cue → hypothesis → thử/quan sát → model mới → lựa chọn/revisit`. Novelty không được đo bằng số mob/biome/item; một addition không tạo câu hỏi, quyết định hoặc ký ức chỉ là breadth debt. Exact cadence/mix là output của `DB-026`, không phải một tỷ lệ được bịa trước playtest.

## 5. Hành trình năng lực

| Giai đoạn | Cảm giác chính | Trục mới về chất | Graduation beat |
|---|---|---|---|
| Phàm Nhân | mong manh nhưng có agency | survival, shelter, observation | tự dựng chỗ đứng và sống qua nguy cơ đầu |
| Kẻ Thức Tỉnh | nỗ lực được đo | camera/action foundation, level/stat | thắng bằng kỹ năng đã học |
| Kẻ Săn Mồi | có năng lực độc nhất | Job Change, Trỗi Dậy | đối thủ đầu trở thành đồng đội có tên |
| Chỉ Huy | sức mạnh có tổ chức | role, command, formation | thắng encounter bằng đội hình/lệnh |
| Bá Chủ | quyền lực được thế giới nhìn thấy | Domain, society, territory | nơi chốn/faction phản ứng theo lựa chọn |
| Chúa Tể | tự định nghĩa di sản | Stratum, prestige, ending | chọn quyền lực được dùng để làm gì |

## 6. Kiến trúc longevity 5–10 năm

Đây là tham vọng trải nghiệm, không lời hứa số giờ. Longevity cần sáu nguồn phối hợp:

1. **Player construction:** công trình, quy hoạch, collection và world ownership không cạn như quest authored.
2. **Mastery breadth:** vũ khí/build/camera/control/command có chiều sâu, không chỉ vertical stat.
3. **Identity collection:** Shadow, item, place, faction và relationship có lịch sử riêng.
4. **Systemic recombination:** encounter grammar, world event, objective, AI doctrine và terrain phối hợp có kiểm soát.
5. **Graduated endgame:** power-trip periods rồi đổi sang multi-front, strategy, discovery và self-selected challenge.
6. **Expansion seams:** content/add-on/config có version contract; world cũ không bị hy sinh.

Không dùng inflation, reset bắt buộc, daily reward hoặc tỷ lệ rơi phi lý để giả longevity.

## 7. Ba tầng quyết định

- **Tức thời:** camera, vị trí, timing, target, attack/dodge/parry/command.
- **Phiên chơi:** xây/khám phá/Gate nào, chuẩn bị gì, đẩy tiếp hay trở về.
- **Dài hạn:** build, Potential, Shadow đầu tư, căn cứ, quan hệ, faction, Stratum và ending.

Feature tác động cả ba tầng phải có Impact Map; không nhét mọi tầng vào một ticket.

## 8. Thước đo trải nghiệm

- Người chơi mô tả được fantasy UMBRA mà không chỉ nói “Minecraft có level”.
- Sau tutorial, người chơi điều khiển camera góc ba/aim/action mà không đánh nhau với camera.
- Sau thất bại, người chơi nêu được nguyên nhân và một cách thử khác.
- Người chơi action có thể phân biệt lỗi đọc cue, timing, vị trí, camera, build hoặc command; sau luyện tập họ thực hiện lại ổn định hơn thay vì chỉ tăng stat.
- Boss/Gate quan trọng tạo được cung anticipation→học→adaptation→execution→triumph; expert còn cách thắng đẹp/hiệu quả hơn nhưng assist hợp lệ không xóa bài học cốt lõi.
- Hai save cùng thời lượng có build, công trình, Shadow roster hoặc quan hệ khác nhau.
- Người chơi tự nhớ tên/đặc điểm ít nhất ba Shadow sau thời gian đủ dài.
- Sau 50+ giờ, vanilla building/exploration vẫn được chọn tự nguyện.
- Người đạt power milestone cảm thấy “mình đã trở thành”, không chỉ nhìn con số.
- Người chơi có thể nghỉ nhiều tháng rồi quay lại mà không mất reward độc quyền hoặc bị trừng phạt.

## 9. Design constitution

Theo thứ tự ưu tiên khi xung đột:

1. Sovereign becoming và player agency.
2. Save/world ownership của người chơi.
3. Minecraft-native coherence.
4. Embodiment/control/camera/readability là nền của spectacle; presentation phải khuếch đại quyết định người chơi vừa thực hiện.
5. Làm Trỗi Dậy và identity sâu trước breadth.
6. Thất bại tạo kiến thức; thử thách xứng đáng kiểm tra điều đã dạy; reward đổi chất hoặc quan hệ.
7. Lựa chọn có sân tỏa sáng và trade-off.
8. Không FOMO/manipulative retention.
9. Performance, persistence và recovery là quality gate.
10. Data-driven/config nhưng không biến game thành bảng cấu hình.
11. Evidence có quyền giết ý tưởng yêu thích.
12. Có power trip và graduation; endgame đổi trục thay vì chỉ tăng số.
13. Irreversible choice preview đầy đủ.
14. Content mới đổi quyết định, không chỉ texture/stat.
15. Học nguyên lý, không sao chép biểu đạt.
16. Lifecycle dài hạn có state/transition/owner/test.
