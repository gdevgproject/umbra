# RES-REFCAT — Danh mục reference và định tuyến nghiên cứu

> **DRI:** Research Lead + Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Mục đích và quyền phát biểu

Đây là bộ nhớ định tuyến để Agent biết **reference nào đáng mở cho câu hỏi nào**, không phải encyclopedia và không phải source of truth về mechanic. Mỗi task vẫn bắt đầu bằng Decision Question, lọc reference theo lens, đọc nguồn/capture đúng version/context và chưng cất `quan sát → nguyên lý → lựa chọn UMBRA → bằng chứng → rủi ro IP`.

| Maturity | Nghĩa được phép dùng |
|---|---|
| `INDEXED` | tên/lens đã được ghi; chưa được phát biểu mechanic như fact |
| `SOURCE_SEED` | có nguồn chính thức hoặc talk mô tả hướng; claim chi tiết vẫn cần capture |
| `CAPTURED` | có build/platform/clip/timecode cho observation cụ thể |
| `RESEARCH_CARD` | observation, transfer constraint, option và IP risk đã được chưng cất cho một decision |

Việc thêm game vào catalog không thêm feature vào UMBRA. Popularity, ký ức hoặc “game lớn làm vậy” không phải approval.

## 2. Catalog hiện tại

| Reference | Lens nên dùng | Decision question phù hợp | Maturity / canonical evidence |
|---|---|---|---|
| Minecraft Java baseline | voxel world, survival/build/interact, input/save/server lifecycle | UMBRA giữ động từ/ownership và coexistence thế nào? | `CAPTURE_REQUIRED`; `DB-019`, các baseline contract |
| Where Winds Meet | third-person wuxia action, traversal/open world, build | camera–movement–combat/traversal phối hợp ra sao trong world mở? | `SOURCE_SEED`; `RES-AUDIENCE`, `RES-TRAVERSAL`; claim input/UI cần capture |
| Black Myth: Wukong | boss-forward action spectacle, animation/creature presentation | boss lớn giữ cue, framing và trọng lượng thế nào? | `INDEXED`; chưa có Research Card/capture canonical |
| Genshin Impact | third-person action, party/build synergy, traversal | action/readability/loadout, mantle/assist/buffer/cue và movement resource tạo trade-off gì—kể cả failure trên geometry khó? | `SOURCE_SEED` + community hypothesis 1.5–2.3 tại `RES-TRAVERSAL`; exact current mechanic vẫn cần pinned build capture |
| God of War (2018/Ragnarök) | intimate camera combat, companion relation, accessibility mở chiều sâu | camera gần đổi combat grammar thế nào; giảm barrier mà không xóa mastery ra sao? | `RESEARCH_CARD` seeds tại `RES-AUDIENCE`, `RES-RETINUE-EXPRESSION` |
| Marvel's Guardians of the Galaxy | bốn AI companion, command/readability/controlled chaos | active party nhiều ally giữ protagonist agency và cue priority thế nào? | `RESEARCH_CARD`; `RES-RETINUE-EXPRESSION` |
| **Shieldwall** | third-person embodied squad leadership, formation, battlefield objective | làm sao người chơi vẫn là chiến binh/thủ lĩnh trực tiếp khi ra lệnh đội; formation và siege/defense đọc được tới đâu? | `SOURCE_SEED`; official page xác nhận điều khiển formation khi chơi một nhân vật, dynamic battle, siege/defend |
| ARK | survival/build/taming/mount/tribe | creature ownership và base/world loop nối nhau thế nào? | `SOURCE_SEED`; `RES-AUDIENCE`; exact live behavior cần capture |
| GTA V | living open-world activity/vehicle/social breadth | activity đa dạng và world response tạo tự do mà không thành checklist ra sao? | `SOURCE_SEED`; `RES-AUDIENCE` |
| Ninja School Online / Ngọc Rồng Online | long-form grind, visible milestone, social memory | investment dài hạn cho payoff gì và khi nào thành chore/inflation? | `INDEXED — user-provided`; không có source/capture canonical |
| Naruto / Dragon Ball / Hunter × Hunter / Solo Leveling | shōnen becoming, training, breakthrough, rival/companion | nhịp yếu→luyện→vượt ngưỡng→được công nhận tạo meaning thế nào? | `INDEXED — audience lens`; không chuyển tên/power/moveset/lore |

### Shieldwall source seed

Nguồn chính thức của developer/publisher mô tả Shieldwall là third-person tactical battle simulator cho cảm giác squad leader; feature list nêu điều khiển đội hình trong khi chơi như một nhân vật, battle động, siege/defend và strategy nhiều đội. UMBRA chỉ ghi nhận lens **embodied commander** và **formation readability**. Tone hài/physics, lịch sử La Mã, unit count, objective, UI, horn/formation, map hoặc PvP structure không được nhập thành biểu đạt UMBRA.

- [Shieldwall — official Steam page by Nezon Production](https://store.steampowered.com/app/1216320/Shieldwall/)

## 3. Routing tags

| Tag | Reference seed | Owner phải đọc cùng |
|---|---|---|
| `ACTION_EMBODIMENT` | God of War, Where Winds Meet, Black Myth, Genshin | Combat + Camera + Animation + Audio/VFX + Accessibility |
| `BOSS_MASTERY` | Black Myth, God of War, action boss case studies | Encounter + AI + Combat + Balance + QA |
| `EMBODIED_COMMAND` | Shieldwall, Guardians of the Galaxy | Shadows + AI + Input/Camera + UX + Performance |
| `LONG_PROGRESSION` | Ninja School, Ngọc Rồng, shōnen works | Player + Economy + Narrative + Ethics |
| `SANDBOX_OWNERSHIP` | Minecraft, ARK | World + Platform + Content + Performance |
| `LIVING_WORLD` | GTA V, Where Winds Meet | World + Quest + AI + Narrative + Performance |

## 4. Cách cập nhật

Khi người dùng thêm reference, Agent ghi tối thiểu: tên chính xác, loại/source, lens, decision question, maturity, canonical Research Card liên quan và IP caveat. Khi một claim được capture/chưng cất, nâng maturity của **claim đó**, không nâng cả game như thể mọi mechanic đã biết. Reference không còn hữu ích được giữ provenance trong Git/ADR; không duy trì danh sách “game phải copy”.
