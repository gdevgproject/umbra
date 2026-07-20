# PROD-UMBRA — Product Charter

> **DRI:** Game Director
> **Approver:** Game Director
> **Reviewers:** Lead Designer, Creative Director, Technical Director, Producer, UX Research
> **Status:** `PROPOSED`

## 1. North-star promise

UMBRA là một game dark-fantasy dài hạn được xây **bên trong và cùng với Minecraft**: người chơi bắt đầu bằng đời sống sinh tồn hữu hạn, tự rèn luyện thành một chủ thể quyền lực, đánh bại và Trỗi Dậy một số đối thủ đáng nhớ thành Hắc Ảnh Cận Vệ có danh tính, rồi dùng sức mạnh, công trình, quan hệ và lựa chọn của mình để làm một thế giới sống thay đổi theo thời gian.

Đây không phải “một combat mod cộng vài hệ RPG”. Đích đến là một **coherent total-overhaul** đủ sâu để người chơi có thể chọn nó làm mod trung tâm duy nhất, nhưng mỗi capability vẫn phải Minecraft-native, bật/tắt/test/migrate được và không kéo theo cả game chưa hoàn thành.

## 2. Bản chất trải nghiệm

UMBRA kết hợp năm lớp mà không để lớp nào nuốt lớp còn lại:

1. **Minecraft survival sandbox:** ăn ở, tài nguyên, xây dựng, địa hình, sáng tạo và save do người chơi sở hữu.
2. **Action embodiment:** camera góc ba chuyên nghiệp, điều khiển/animation/combat và traversal chiều dọc có trọng lượng; góc một vẫn được tôn trọng.
3. **Long-form progression:** cày cuốc có mục tiêu, breakthrough, build, mastery và graduation; không grind rỗng/FOMO.
4. **Shadow sovereign fantasy:** thu phục, gắn kết, phát triển và chỉ huy một đội Hắc Ảnh tinh nhuệ; từng thành viên đủ sâu để người chơi nhớ, phối hợp và lựa chọn.
5. **Living systemic world:** Gate, dân cư, faction, công trình, sinh vật/mount và narrative phản ứng với hành động người chơi.

## 3. Audience stack

Audience không phải nhãn marketing hay danh sách game họ từng chơi. Mỗi lớp dưới đây mô tả **động lực bên trong → hành vi lặp lại → chuẩn chất lượng họ nhận ra**; một người có thể thuộc nhiều lớp. UMBRA không lấy trung bình các tệp thành trải nghiệm nhạt, mà tạo các đường vào khác nhau cùng hội tụ vào fantasy Chúa Tể trong một world Minecraft có chủ quyền.

### Primary — người chơi Minecraft dài hạn

Họ xem world/save, công trình và lịch sử phát sinh là tài sản do mình tạo. Họ ở lại vì có thể tự đặt mục tiêu, biến địa hình thành nơi chốn, chuẩn bị bằng vật liệu thật trong world và quay lại thấy dấu vết nhiều tháng/năm vẫn còn giá trị. Họ kỳ vọng survival/build/exploration không bị biến thành phòng chờ cho menu RPG; combat, progression, AI và content phải làm giàu thêm những động từ Minecraft thay vì thay thế chúng.

### Secondary — người chơi cày cuốc và power fantasy

Tệp quen Ninja School Online/Ngọc Rồng Online hoặc truyện hành động–trưởng thành như Naruto, Dragon Ball, Hunter × Hunter, Solo Leveling. Họ thích luyện tập có mục tiêu, tích lũy nhìn thấy được, mốc đột phá hiếm, năng lực biểu tượng, rival/đồng đội và hành trình từ vô danh thành huyền thoại. Họ chấp nhận đầu tư dài khi mỗi chặng tạo năng lực, địa vị, quan hệ hoặc cách chơi mới; họ rời đi khi “cày” chỉ là lặp số, time gate, FOMO hoặc inflation xóa giá trị công sức cũ.

### Secondary — người chơi action RPG góc ba

Tệp thích Where Winds Meet, Black Myth: Wukong, Genshin Impact và các action game đặt nặng kỹ năng. Họ không chỉ “muốn có boss và animation đẹp”: họ tự nguyện lặp lại một trận để luyện quan sát, né/parry/spacing, phản xạ, camera/target control, quản lý commitment và phối hợp vũ khí–skill–build thành lối đánh của riêng mình. Họ thích nhìn combat vận động đẹp vì hình thể, nhịp, VFX/SFX và phản ứng va chạm làm rõ chính quyết định họ vừa thực hiện—không phải vì animation tự chơi thay họ.

Chiến thắng có giá trị khi đối thủ đáng học: moveset có grammar, telegraph công bằng, AI tạo pressure có chủ đích, phase kiểm tra điều đã dạy, lỗi giải thích được và retry cho thấy tiến bộ. Gate boss vì vậy là quality bar liên ngành của Combat, Camera, Animation, Audio/VFX, AI, Encounter, Skills, Balance, Accessibility và QA; không thể được sản xuất như “mob nhiều máu + vài chiêu”. Dải độ khó phải cho người mới học được và expert còn đất biểu diễn mà không âm thầm gian lận hay làm phẳng mastery. F5 camera, input trễ, hitbox lệch, build một rotation, spectacle che cue hoặc stat bỏ qua toàn bộ kỹ năng đều là lỗi sản phẩm đối với tệp này.

### Adjacent — người chơi sandbox/living world

Tệp thích Minecraft, ARK, GTA V và systemic open worlds: tìm tự do chuyển mục tiêu, căn cứ/công trình có công dụng, dân cư/sinh thái có quy luật, cưỡi/điều khiển sinh vật hoặc phương tiện, hoạt động đa dạng và câu chuyện phát sinh. Họ nhận ra “thế giới sống” qua phản ứng và lựa chọn quan sát được, không qua hàng nghìn NPC giả lập nhưng không tạo hậu quả.

### Future social audience

Muốn biến thành tựu cá nhân thành ký ức chung: chơi cùng bạn bè, lập server, cùng xây/đánh Gate, phân vai, hợp tác, đối đầu hoặc hình thành phe. UMBRA hiện **không phát triển multiplayer gameplay**, nhưng foundation không được khóa đường tới integrated/dedicated server, ownership, permissions, security và sync; tương lai social không được làm solo thành bản thiếu người.

Casual có đường hiểu và tiến; expert có đất thể hiện mastery; grinder có mục tiêu dài nhưng không bị time gate; builder/explorer không bị biến thành người đứng ngoài loop. Chi tiết lens nằm ở [Audience Research](../70-research/04-audience-and-reference-landscape.md).

## 4. Emotional architecture

### North-star emotion — `PIL-BECOMING`: Tự mình trở thành Chúa Tể

Người chơi không chỉ **có** sức mạnh; họ nhớ mình từng yếu, hiểu vì sao mình mạnh, nhận ra dấu vết của lựa chọn và cảm thấy danh hiệu cuối cùng là thứ họ đã sống để trở thành.

### Chín lời hứa cảm xúc

| ID | Lời hứa | Nhu cầu tâm lý | Biểu hiện quan sát được | Failure mode phải tránh |
|---|---|---|---|---|
| `PIL-ASCENDANCE` | Thăng tiến và quyền lực | competence, status, momentum | động từ, silhouette, âm thanh, lựa chọn và phản ứng thế giới đổi theo mốc | number inflation, auto-win |
| `PIL-AGENCY` | Tự do và quyền sở hữu | autonomy, self-expression | chọn đường sống/build/mục tiêu/căn cứ/đội Hắc Ảnh; thế giới không ép một nhịp duy nhất | choice giả, menu railroad |
| `PIL-EMBODIMENT` | Nhập thân và khoái cảm điều khiển | control fluency, presence, sensorimotor coherence | input→pose→di chuyển→va chạm→phản hồi là một chuỗi có chủ ý; người chơi cảm thấy “mình vừa làm được” | floaty, input lag, camera đánh nhau với người chơi, animation cướp quyền |
| `PIL-MASTERY` | Tinh thông | học, kiểm soát, tự hào | timing, camera, vị trí, build, chuẩn bị và command đều có thể luyện | input bị animation cướp, stat thắng mọi thứ |
| `PIL-TRIUMPH` | Chiến thắng xứng đáng | optimal challenge, courage, earned pride | đối thủ đáng học tạo tension; thất bại cho kiến thức; thích nghi và thực hiện đúng dẫn tới giải tỏa/tự hào | khó tùy tiện, AI gian lận, thắng rẻ hoặc assist xóa bài học |
| `PIL-ATTACHMENT` | Gắn kết | care, memory, companionship | Shadow/NPC/place có tên, lịch sử, quan hệ và hồi đáp lâu dài | pet vô danh, bi kịch rẻ tiền |
| `PIL-DISCOVERY` | Kỳ quan, mới lạ và tái khám phá | curiosity, surprise, sense-making | sinh vật/sinh thái/cơ chế/địa điểm mới tạo câu hỏi; Minecraft quen thuộc đổi affordance và được nhìn lại bằng năng lực, quan hệ hoặc world state mới | checklist map, reskin, catalog mới nhưng không đổi quyết định |
| `PIL-CONSEQUENCE` | Được thế giới công nhận | impact, responsibility, social status | NPC, đô thị, lãnh thổ, danger và opportunity phản ứng với việc đã làm | simulation giả, consequence không thể đọc |
| `PIL-BELONGING` | Nơi thuộc về và di sản | safety, identity, continuity | nhà/công trình/gia đình/collection/save khiến việc trở về và ở lại có ý nghĩa | chores, căn cứ chỉ là kho |

Ranh giới tránh trùng: `Embodiment` là chất lượng của từng giây điều khiển; `Mastery` là năng lực người chơi tích lũy; `Triumph` là cung căng thẳng–thích nghi–vượt qua một đối trọng xứng đáng; `Ascendance` là thay đổi quyền lực/địa vị còn lại sau chiến thắng. `Awe/spectacle`, `tension`, `relief`, `pride`, `wonder` và `responsibility` là **nhịp cảm xúc điều phối** giữa các pillar, không phải lý do tự động tạo thêm hệ. Ví dụ boss dùng embodiment→tension→mastery→triumph→awe; trở về nhà dùng relief→recognition→belonging.

`PIL-DISCOVERY` có hai mode phải cùng tồn tại: **frontier novelty** (loài, sinh thái, Gate, luật hoặc nơi chốn chưa biết) và **transformed familiarity** (một block, mob, biome, công trình hoặc thói quen Minecraft quen thuộc bỗng có affordance/hậu quả mới). Đây không đồng nghĩa `PIL-CONSEQUENCE`: Discovery tạo câu hỏi và model mới; Consequence chứng minh thế giới ghi nhận lựa chọn. Nó cũng không đồng nghĩa chỉ có nhiều activity/vehicle như một open world rộng—breadth là nguồn nguyên liệu, còn payoff là người chơi thay đổi route, công cụ, giả thuyết hoặc tham vọng.

Mỗi Feature Cell có một pillar chính, tối đa hai pillar phụ và một failure mode cảm xúc cần test. Không tối ưu “gây nghiện” bằng thao túng; UMBRA hướng tới **voluntary long-term return** nhờ ý nghĩa, mastery, ownership và curiosity.

## 5. Product invariants

1. **Minecraft là world substrate:** đào, xây, redstone, làng, sinh tồn, Nether/End và creative tooling không trở thành phần thừa giữa các menu RPG.
2. **Third-person action camera là core system:** không phải polish/optional experiment; góc một giữ support và parity về luật.
3. **Offline-first, server-authoritative:** single-player là target hiện tại; gameplay truth nằm ở logical server và mọi client intent được validate.
4. **Always-playable development:** mỗi capability kết thúc bằng snapshot tự chạy/test được; public 1.0 không bị đồng nhất với build nội bộ.
5. **Một feature không được khóa tương lai:** stable IDs, versioned state, migration, feature boundaries/config và recovery là nền ngay từ đầu.
6. **Cảm xúc trước số lượng:** feature phải tạo/thay đổi quyết định hoặc quan hệ, không chỉ tăng catalog.
7. **Đọc được, công bằng và đáng học:** telegraph, state, cost, failure, authority và hậu quả có ngôn ngữ rõ; difficulty tăng bài kiểm tra/nhịp phối hợp trước stat và mọi thất bại quan trọng phải để lại kiến thức hành động được.
8. **Không FOMO/manipulative retention:** không calendar lockout, streak bắt buộc, odds giả hoặc phần thưởng độc quyền theo giờ đăng nhập.
9. **Hiệu năng là contract:** quy mô lớn dùng LOD/representation/budget, không hứa entity full-simulation vô hạn.
10. **Original by transformation:** reference tạo principle/hypothesis; UMBRA tự sở hữu premise, rule, asset, lore, moveset và consequence.
11. **Save của người chơi là tài sản:** world cũ, công trình, Shadow identity và irreversible choice không bị update tùy tiện xóa giá trị.
12. **Retinue depth before combat count:** tối đa tám Shadow sở hữu, bốn triển khai chiến đấu; bốn chỗ dự bị mở chiều rộng đội hình/quan hệ chứ không tăng actor hoặc power budget trận hiện tại, và không có kho/quân đoàn ẩn ngoài roster.

## 6. Anti-goals đã hiệu chỉnh

- Không biến Minecraft thành launcher cho các activity/menu tách khỏi world.
- Không biến “all-in-one” thành việc sao chép hời hợt mọi mod; capability chỉ vào game khi đạt quality bar chung.
- Không làm combat gây damage theo click rate, packet rate hoặc animation frame client.
- Không làm camera góc ba chỉ là offset F5 có crosshair mới.
- Không tạo animation tự chơi dài làm mất quyền điều khiển.
- Không làm Shadow thành consumable/pet vô danh hoặc xóa chúng khi mana cạn.
- Không giả lập dân cư/kinh tế/sinh thái chi tiết nếu không tạo quyết định hoặc hậu quả nhìn thấy.
- Không dùng procedural generation để thay authored grammar, validation và recovery.
- Không implement co-op/PvP trước discovery; cũng không viết kiến trúc single-player-only buộc phải phá sau này.
- Không hứa mọi loader/version/mod compatibility trước evidence.
- Không dùng số giờ, checklist hoặc số feature làm bằng chứng chất lượng.

## 7. Core experience loop

```text
Sinh tồn/quan sát thế giới và tự chọn tham vọng
→ Xây nơi đứng chân, chuẩn bị build/đội Hắc Ảnh/vật tư
→ Di chuyển, khám phá, giao tiếp hoặc nhận diện nguy cơ/cơ hội
→ Chiến đấu/chinh phục bằng control, mastery, build và command
→ Thu hoạch kiến thức, vật chất, quan hệ hoặc đối thủ có thể Trỗi Dậy
→ Chuyển hóa phần thưởng thành năng lực, công trình, đội Hắc Ảnh và world consequence
→ Trở về để thấy thế giới ghi nhận mình
→ Chọn một tham vọng lớn hơn hoặc một cách sống khác
```

Không phải phiên nào cũng đi Gate. Xây dựng, khám phá, luyện tập, quản lý, story và social-world activity phải là các đường hợp lệ quay lại loop.

## 8. Quyết định Product Director đã khóa

- Public goal là **full coherent game promise**, không phải phát hành sớm chỉ vì một slice chạy được.
- Trong phát triển, mọi phase phải cho chủ dự án chạy/chơi/test được mà không chờ toàn game hoàn tất.
- Camera góc ba cải tổ là capability cốt lõi và foundation dependency.
- Hiện tại làm offline/single-player; future ladder là co-op party 2–4 trước, PvP 1v1/3v3 rồi ranking/event sau. Chỉ chuẩn bị authority/data/security/performance seams, không implement multiplayer feature hiện tại.
- Prologue/gia đình được thiết kế sớm để giữ meaning/continuity, nhưng platform–control–combat foundation được triển khai trước; first core-loop build phải có một return/home beat tối thiểu.
- Dự án hướng tới một save chơi nhiều năm và mở rộng liên tục; không cam kết longevity bằng grind vô hạn.
- Hiệu năng là constraint thiết kế của mọi capability và world dài; không để tới giai đoạn polish cuối.
- Death giữ progression dài hạn/Shadow identity, recall deployment và tạo consequence tạm thời theo mode/activity; Creative là first-class author/debug sandbox có provenance.
- Living society phát triển từ identity/event ledger và hành vi hub nhìn thấy được trước khi mở settlement/faction/deep individual simulation.
- Fabric là loader tối ưu hiện tại; NeoForge là first-class future target bắt buộc. Hai loader dùng artifact/adapter riêng nhưng không được fork gameplay semantics hoặc canonical save.
- UMBRA chỉ có một Minecraft baseline phát hành chính tại một thời điểm: snapshot upstream chỉ để research; dòng cũ vẫn tải được ở bản cuối và chỉ thành EOL sau khi successor đã qua port/release gate, không biến mất hoặc bị ghi đè.
- Mọi runtime change được Agent phân loại performance risk để đo đúng lúc; không benchmark mù mọi commit và không bỏ qua feature có hot-path/cardinality risk.
- Shadow roster mở từ một tới tối đa tám slot; tối đa bốn Shadow triển khai chiến đấu. Các slot 5–8 mở chiều rộng dự bị/home và lựa chọn đội hình, không cộng actor hay power budget miễn phí; exact milestone được discovery theo `CTR-SHADOW-RETINUE`.
- Discovery là strength cốt lõi: UMBRA phải tạo cả nội dung/cơ chế/sinh vật thật sự mới và lý do nhìn lại Minecraft quen thuộc bằng một model mới; không đo bằng catalog count hoặc đồng nhất với activity breadth của reference open-world.
- Level 1→100+ là trục progression toàn cục duy nhất; Rank, Primary Attributes, Potential và Prestige cũ bị xóa. Build dùng skill/loadout, gear, Retinue và bounded capability mastery.
- HP + Vigor là hai core meters UMBRA; Mana/Focus/Fatigue/Posture bị xóa. Vigor thống nhất Dodge/Sprint Burst/Free Climb/Lightness; vanilla hunger vẫn thuộc Minecraft.
- Skill acquisition công khai toàn bộ tương lai từ Level 1, phát grant đầu ở Level 1 và unlock event mỗi 5 Level. Dodge/Free Climb có từ Level 1, Hạ Kình sau combat lesson, Khinh Công Level 10 qua training.
- NPC Level cao hiếm theo Village Hub, power/silhouette tăng đơn điệu và có social personality/self-preservation; Bully không thể kết liễu player.
- Sau kernel, Camera và Skill Platform là hai delivery train ưu tiên, mỗi train đóng bằng snapshot hoạt động như một mod độc lập trước khi tích hợp full game.

## 9. Cửa feedback Product hiện tại

Các câu hỏi death, Creative, living society, multiplayer và topology progression/resource mới đã được khóa ở mức Product; không hỏi lại hoặc phục hồi hệ cũ. Cửa discovery hợp lệ tiếp theo là EXP/damage/counterplay, skill line/loadout, Vigor milestone distribution và NPC/Hạ Kình parameter còn mở tại [Level, Skill và Vigor Review Guide](../20-domains/01-player/03-level-skill-and-vigor-review-guide.md).

Exact camera/input/UI/content breadth, death penalty và performance target theo hardware là delegated research do Agent giải bằng prototype/evidence; chỉ quay lại Product khi xuất hiện trade-off fantasy hoặc scope khó đảo ngược.
