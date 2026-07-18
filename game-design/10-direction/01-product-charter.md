# PROD-UMBRA — Product Charter

> **DRI:** Game Director
> **Approver:** Game Director
> **Reviewers:** Lead Designer, Creative Director, Technical Director, Producer, UX Research
> **Status:** `PROPOSED`

## 1. North-star promise

UMBRA là một game dark-fantasy dài hạn được xây **bên trong và cùng với Minecraft**: người chơi bắt đầu bằng đời sống sinh tồn hữu hạn, tự rèn luyện thành một chủ thể quyền lực, đánh bại và Trỗi Dậy những đối thủ đáng nhớ thành quân đoàn có danh tính, rồi dùng sức mạnh, công trình, quan hệ và lựa chọn của mình để làm một thế giới sống thay đổi theo thời gian.

Đây không phải “một combat mod cộng vài hệ RPG”. Đích đến là một **coherent total-overhaul** đủ sâu để người chơi có thể chọn nó làm mod trung tâm duy nhất, nhưng mỗi capability vẫn phải Minecraft-native, bật/tắt/test/migrate được và không kéo theo cả game chưa hoàn thành.

## 2. Bản chất trải nghiệm

UMBRA kết hợp năm lớp mà không để lớp nào nuốt lớp còn lại:

1. **Minecraft survival sandbox:** ăn ở, tài nguyên, xây dựng, địa hình, sáng tạo và save do người chơi sở hữu.
2. **Action embodiment:** camera góc ba chuyên nghiệp, điều khiển/animation/combat có trọng lượng; góc một vẫn được tôn trọng.
3. **Long-form progression:** cày cuốc có mục tiêu, breakthrough, build, mastery và graduation; không grind rỗng/FOMO.
4. **Shadow sovereign fantasy:** thu phục, gắn kết, phát triển và chỉ huy một quân đoàn bất tử có danh tính.
5. **Living systemic world:** Gate, dân cư, faction, công trình, sinh vật/mount và narrative phản ứng với hành động người chơi.

## 3. Audience stack

### Primary — người chơi Minecraft dài hạn

Muốn survival/build/exploration còn nguyên giá trị nhưng combat, progression, AI, content và thế giới sâu tới mức một save có thể trở thành hành trình nhiều năm.

### Secondary — người chơi cày cuốc và power fantasy

Tệp quen Ninja School Online/Ngọc Rồng Online hoặc truyện hành động–trưởng thành như Naruto, Dragon Ball, Hunter × Hunter, Solo Leveling: thích luyện tập, tích lũy, đột phá, năng lực biểu tượng, rival/đồng đội và từ vô danh thành huyền thoại.

### Secondary — người chơi action RPG góc ba

Tệp thích Where Winds Meet, Black Myth: Wukong, Genshin Impact: kỳ vọng camera/aim/targeting, animation, boss, build và combat feedback có chất lượng cao; không chấp nhận F5 camera như trải nghiệm cuối.

### Adjacent — người chơi sandbox/living world

Tệp thích Minecraft, ARK, GTA V và systemic open worlds: tìm tự do, căn cứ/công trình, dân cư, sinh thái, cưỡi/điều khiển sinh vật hoặc phương tiện, hoạt động đa dạng và câu chuyện phát sinh.

### Future social audience

Muốn chơi cùng bạn bè, lập server, cùng xây/đánh Gate, hợp tác, đối đầu hoặc hình thành phe. UMBRA hiện **không phát triển multiplayer gameplay**, nhưng foundation không được khóa đường tới integrated/dedicated server, ownership, permissions, security và sync.

Casual có đường hiểu và tiến; expert có đất thể hiện mastery; grinder có mục tiêu dài nhưng không bị time gate; builder/explorer không bị biến thành người đứng ngoài loop. Chi tiết lens nằm ở [Audience Research](../70-research/04-audience-and-reference-landscape.md).

## 4. Emotional architecture

### North-star emotion — `PIL-BECOMING`: Tự mình trở thành Chúa Tể

Người chơi không chỉ **có** sức mạnh; họ nhớ mình từng yếu, hiểu vì sao mình mạnh, nhận ra dấu vết của lựa chọn và cảm thấy danh hiệu cuối cùng là thứ họ đã sống để trở thành.

### Bảy lời hứa cảm xúc

| ID | Lời hứa | Nhu cầu tâm lý | Biểu hiện quan sát được | Failure mode phải tránh |
|---|---|---|---|---|
| `PIL-ASCENDANCE` | Thăng tiến và quyền lực | competence, status, momentum | động từ, silhouette, âm thanh, lựa chọn và phản ứng thế giới đổi theo mốc | number inflation, auto-win |
| `PIL-AGENCY` | Tự do và quyền sở hữu | autonomy, self-expression | chọn đường sống/build/mục tiêu/căn cứ/quân đoàn; thế giới không ép một nhịp duy nhất | choice giả, menu railroad |
| `PIL-MASTERY` | Tinh thông | học, kiểm soát, tự hào | timing, camera, vị trí, build, chuẩn bị và command đều có thể luyện | input bị animation cướp, stat thắng mọi thứ |
| `PIL-ATTACHMENT` | Gắn kết | care, memory, companionship | Shadow/NPC/place có tên, lịch sử, quan hệ và hồi đáp lâu dài | pet vô danh, bi kịch rẻ tiền |
| `PIL-DISCOVERY` | Kỳ quan và bí ẩn | curiosity, surprise | địa điểm, sinh thái, Gate, faction, lore và systemic event tạo câu hỏi mới | checklist map, reskin |
| `PIL-CONSEQUENCE` | Được thế giới công nhận | impact, responsibility, social status | NPC, đô thị, lãnh thổ, danger và opportunity phản ứng với việc đã làm | simulation giả, consequence không thể đọc |
| `PIL-BELONGING` | Nơi thuộc về và di sản | safety, identity, continuity | nhà/công trình/gia đình/collection/save khiến việc trở về và ở lại có ý nghĩa | chores, căn cứ chỉ là kho |

`Awe/spectacle`, `tension`, `relief`, `pride`, `wonder` và `responsibility` là **nhịp cảm xúc điều phối**, không tạo thêm pillar. Ví dụ boss dùng tension→mastery→awe; trở về nhà dùng relief→recognition→belonging.

Mỗi Feature Cell có một pillar chính, tối đa hai pillar phụ và một failure mode cảm xúc cần test. Không tối ưu “gây nghiện” bằng thao túng; UMBRA hướng tới **voluntary long-term return** nhờ ý nghĩa, mastery, ownership và curiosity.

## 5. Product invariants

1. **Minecraft là world substrate:** đào, xây, redstone, làng, sinh tồn, Nether/End và creative tooling không trở thành phần thừa giữa các menu RPG.
2. **Third-person action camera là core system:** không phải polish/optional experiment; góc một giữ support và parity về luật.
3. **Offline-first, server-authoritative:** single-player là target hiện tại; gameplay truth nằm ở logical server và mọi client intent được validate.
4. **Always-playable development:** mỗi capability kết thúc bằng snapshot tự chạy/test được; public 1.0 không bị đồng nhất với build nội bộ.
5. **Một feature không được khóa tương lai:** stable IDs, versioned state, migration, feature boundaries/config và recovery là nền ngay từ đầu.
6. **Cảm xúc trước số lượng:** feature phải tạo/thay đổi quyết định hoặc quan hệ, không chỉ tăng catalog.
7. **Đọc được và công bằng:** telegraph, state, cost, failure, authority và hậu quả có ngôn ngữ rõ.
8. **Không FOMO/manipulative retention:** không calendar lockout, streak bắt buộc, odds giả hoặc phần thưởng độc quyền theo giờ đăng nhập.
9. **Hiệu năng là contract:** quy mô lớn dùng LOD/representation/budget, không hứa entity full-simulation vô hạn.
10. **Original by transformation:** reference tạo principle/hypothesis; UMBRA tự sở hữu premise, rule, asset, lore, moveset và consequence.
11. **Save của người chơi là tài sản:** world cũ, công trình, Shadow identity và irreversible choice không bị update tùy tiện xóa giá trị.

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
→ Xây nơi đứng chân, chuẩn bị build/quân đoàn/vật tư
→ Di chuyển, khám phá, giao tiếp hoặc nhận diện nguy cơ/cơ hội
→ Chiến đấu/chinh phục bằng control, mastery, build và command
→ Thu hoạch kiến thức, vật chất, quan hệ hoặc đối thủ có thể Trỗi Dậy
→ Chuyển hóa phần thưởng thành năng lực, công trình, quân đoàn và world consequence
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

## 9. Cửa feedback Product hiện tại

Các câu hỏi death, Creative, living society và multiplayer đã được khóa ở mức Product; exact parameter/tier/ruleset nằm ở system discovery, không hỏi lại. Cửa feedback có đòn bẩy lớn tiếp theo là fantasy/topology thuộc tính, damage, Potential và counterplay tại [Balance Discovery Guide](../20-domains/01-player/03-attribute-and-balance-review-guide.md).

Exact camera/input/UI/content breadth, death penalty và performance target theo hardware là delegated research do Agent giải bằng prototype/evidence; chỉ quay lại Product khi xuất hiện trade-off fantasy hoặc scope khó đảo ngược.
