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
| `PD-029` | Fabric là loader hiện tại; NeoForge là first-class future target bắt buộc | common semantics/save + ports-and-adapters có chọn lọc; artifact/test/perf manifest riêng, chưa claim NeoForge support |
| `PD-030` | Agent tự gán performance risk cho mọi runtime change | `PR-0–PR-3` quyết lane đo; không benchmark mọi thay đổi và không bỏ đo feature có rủi ro |
| `PD-031` | Shadow là một Retinue tinh nhuệ: tối đa 8 sở hữu, tối đa 4 triển khai chiến đấu | bắt đầu với 1 slot khi mở hệ; slot 5–8 tăng chiều rộng dự bị/home chứ không tăng active power; không kho/quân đoàn ẩn; exact unlock/full-roster flow theo `CTR-SHADOW-RETINUE`/`DB-044` |
| `PD-032` | Shadow cần biểu cảm/ritual theo context và personality | quỳ là dấu câu hiếm; semantic/priority/group reservation/fallback theo `SYS-SHADOW-EXPRESSION`, không emote spam hoặc cắt combat |
| `PD-033` | UMBRA dùng một health authoritative tương thích Minecraft, nhưng sở hữu damage semantics và HUD thanh cố định | không tạo “RPG HP” song song; Max HP tăng không sinh thêm hàng tim, mọi damage môi trường phải qua matrix có attribution/test |
| `PD-035` | Combat Flask là quick-recovery action/slot chuyên biệt; food vẫn giữ vai trò hunger/survival | bắt đầu một charge là direction; giả thuyết tối đa 10 chưa khóa, cần `DB-047` cân bằng capacity–potency–refill–interrupt |
| `PD-036` | Third-person free movement mặc định camera-relative và camera orbit không kéo thân nhân vật khi đứng yên | lock-on/precision dùng basis riêng; ranged không mặc định ép first-person, chuyển mode phải predictable và có setting |
| `PD-037` | Vertical traversal là core first-party capability: Free Climb, Hạ Kình khi rơi và Khinh Công | tạo `SYS-PLAYER-TRAVERSAL` + `CTR-TRAVERSAL`; world/Gate/enemy/Shadow/camera/animation phải xét chiều dọc từ foundation |
| `PD-040` | Tệp action RPG được định nghĩa bởi embodiment, luyện phản xạ, mastery, phối hợp build–skill và chinh phục đối thủ xứng đáng—not chỉ camera/boss/animation | Combat, Camera, Animation, AI, Encounter, Skills, Balance, Accessibility và QA cùng chịu quality bar; Gate boss không được sản xuất như mob nhiều máu |
| `PD-041` | Emotional architecture không bị khóa vào con số bảy; `PIL-EMBODIMENT` và `PIL-TRIUMPH` là hai lời hứa riêng | phân biệt chất lượng điều khiển từng giây, năng lực tích lũy, chiến thắng xứng đáng và quyền lực dài hạn; Feature Cell phải test đúng failure mode |
| `PD-042` | `PIL-DISCOVERY` gồm cả cái thật sự mới và việc tái khám phá Minecraft quen thuộc dưới affordance/sinh thái/hậu quả mới | không thêm pillar trùng; `DB-026` sở hữu portfolio/cadence, content batch phải chứng minh câu hỏi/quyết định/ký ức thay vì dùng catalog count hoặc GTA-style activity breadth làm proxy |
| `PD-043` | Một Minecraft baseline phát hành chính tại một thời điểm; snapshot chỉ research, successor chỉ thay current sau gate | dòng cũ có final immutable release + EOL marker và vẫn tải được; không duy trì feature song song vô hạn hoặc bỏ current trước khi successor xanh |
| `PD-044` | Agent có standing authority tự quản lý Git/GitHub thường nhật theo gate/evidence | direct push vào `main` được phép khi evidence xanh; PR dùng theo rủi ro, không bắt buộc cho mọi commit; ưu tiên connector/API/CLI, browser chỉ là fallback được báo mục đích; Project Owner chỉ duyệt product greenlight, credential/2FA, destructive history/data hoặc exception ngoài policy |
| `PD-045` | Free Climb phải đạt voxel-native game-feel quality bar, không dừng ở wall-motion kỹ thuật | collision/support shape thật + surface profile/revision phủ partial/thin/foliage/transparent/fluid/moving block; adaptive mantle, buffered/continuous intent, bounded steering, momentum/blend và multisensory cue; M0 server commit/revalidation mở seam tương lai nhưng không implement multiplayer gameplay |
| `PD-046` | Free Climb không phí thêm default key khi Jump/Sneak đã biểu đạt đúng ý định Minecraft | Jump chủ động hướng vào valid wall có thể attach và khi đang bám trở thành directional climb-leap tốn Vigor; fresh Sneak sau latch là deliberate Drop. Intent lineage/inhibitor phải tách auto-jump, passive/external fall, build/pillar, grazing contact và external mode để contextual control không thành auto-save hoặc cướp thao tác |
| `PD-047` | Future Double Jump phải là Nhịp Không Trung có thể chain thật với Aerial Dodge nhưng không nhập hai action | tách `FEAT-TRAVERSAL-AERIAL-STEP` và `FEAT-COMBAT-AERIAL-DODGE`; một `AerialChain` cho bounded use riêng, cả hai dùng Vigor qua transaction riêng, stable support mới reset; wall touch/Climb không refill và attached/mantling không là airborne/Grounding-eligible |
| `PD-048` | Khinh Công là kỹ thuật vận sức bằng hold intent từ stable ground hoặc `CLIMB_IDLE`, phóng cao rồi lướt–hạ chậm dài bằng Vigor | default gesture ưu tiên giữ Jump nhưng không được làm chậm running/directional Jump; tap/hold phải có prototype và dedicated/toggle alternative. Charge có tier/cap, không i-frame/hold vô hạn; ceiling/contact revision revalidate, low altitude không hover |
| `PD-049` | Hạ Kình vừa chuyển cú đáp vừa là aerial attack impact diện rộng có trọng lượng theo family vũ khí | chỉ fresh Attack sau armed cue mới context-transform; không cướp held mining/Attack trên wall, không đào/phá block; AoE có cap/occlusion/target/friendly rules, extreme fall không scale vô hạn và unarmed/tool luôn có fallback |
| `PD-050` | UMBRA được phát triển cuốn chiếu bằng living design system: feedback có thể đổi/thêm/xóa rule giữa implementation nhưng design–ticket–code–test không được trôi khỏi nhau | mọi feedback giữa ticket được capture thành `CR`, phân loại conformance/tuning/design delta/new capability/constraint/incident và chọn disposition; player-visible delta phải amend/rebaseline hoặc `NEEDS_DESIGN`, hotfix ưu tiên rollback/disable, downstream evidence bị stale có truy nguyên |
| `PD-051` | `Level` từ 1 tới 100+ là trục tiến trình nhân vật toàn cục duy nhất; Rank, Primary Attributes, Potential và Prestige cũ bị loại khỏi lõi | mọi candidate F→Vương Giả/STR–AGI–VIT–INT–PER bị rút; build khác nhau bằng skill/loadout/gear/Retinue và mastery capability, không bằng trục hạng/bảng điểm song song |
| `PD-052` | UMBRA chỉ có hai mutable core meters do mình sở hữu: một Minecraft-compatible `HP` và `Vigor`; Mana, Focus, Fatigue và Posture meter bị xóa | Dodge/Sprint Burst, Free Climb, Aerial Dodge và Lightness cùng dùng Vigor; stagger/launch là action result rời rạc; vanilla hunger/saturation vẫn do Minecraft sở hữu |
| `PD-053` | Khóa Vigor capacity/regen/delay/Dodge/Climb parameters và locomotion regen states theo `VIG-*` | mọi phép tính/rounding/milestone nằm duy nhất tại `QLT-PARAMETERS`; upgrade không vượt cap hoặc refill bằng relog/equip |
| `PD-054` | Khóa active-skill khởi đầu, Level cadence và full-future preview theo `SKL-*` | event có thể trao skill/node/slot theo tuyến authored nhưng không tự làm hotbar tăng vô hạn; preview không giấu thông tin build và có version/migration |
| `PD-055` | Dodge/Free Climb Level 1, Lightness Level 10 qua training, Hạ Kình sau combat lesson | Hạ Kình dùng `GRD-*`: fresh Falling Attack, valid-impact fall conversion, zero Vigor, entity-only AoE/no block grief và weapon/unarmed fallback |
| `PD-056` | Sức mạnh/silhouette NPC tăng đơn điệu và Village Hub giữ density pyramid theo `NPC-POWER/VISUAL/DENSITY-*` | band rời nhau, quota là maximum chứ không target spawn; residency/reconcile/save/visitor tương thích POI/chunk/entity lifecycle Minecraft |
| `PD-057` | NPC level 70+ kiêu ngạo với actor thấp hơn; một tỷ lệ hiếm là Bully hoặc Guardian, và mọi NPC level cao đều rút lui khi HP nguy kịch | Bully chỉ cảnh cáo nhẹ, clamp không thể kết liễu và có cue chế nhạo; Guardian cứu player bị hostile áp đảo; personality variant hiếm nhưng bắt buộc tồn tại trong content population của từng band; exact incidence/HP threshold thuộc evidence, AI không scan/tick toàn dân |
| `PD-058` | Delivery ưu tiên một tầng foundation ổn định rồi các capability snapshot hoạt động như mod độc lập; Camera và Skill Platform là hai train đầu tiên sau kernel | mỗi train có flag, public contract, save/migration, automated proof và rollback riêng; tích hợp full game chỉ ghép public surfaces đã xanh; ticket draft được lập sớm nhưng chỉ `READY` mới cho phép code |

## 3. Delegated research — Agent tự giải, không hỏi user sớm

- Exact third-person centered/shoulder distances, transition, reticle/soft-target/lock-on và aim assist.
- Default keyboard/mouse layout, Dodge key, skill/hotbar/command mapping.
- Exact early-game zombie/player/world levers và difficulty parameters.
- UI visual direction/component layouts và asset production tools.
- Exact numerical band của HP/damage, Combat Flask capacity/potency/refill và health-environment mapping; Vigor cap/cost/regen đã khóa tại `PD-053`, chỉ còn phân bố milestone và feel evidence.
- Exact Free Climb input/surface/speed, Vigor band, mantle/assist/buffer/correction band, Grounding Strike window và Lightness launch/descent curve.
- Authored/systemic/player-created mix, content batch size và release breadth.

Các mục này chỉ quay lại hỏi user khi prototype tạo trade-off fantasy thật sự; trước đó Agent chịu trách nhiệm research/evidence.

## 4. Câu hỏi Product còn mở

Bốn câu hỏi death, Creative, living society và multiplayer trước đây đã được khóa ở `PD-024–027`; Agent không hỏi lại. Rank/Primary Attributes/Potential/Prestige và topology Mana/Focus cũng đã bị supersede ở `PD-051–055`; discovery tiếp theo chỉ được hỏi về damage/counterplay, authored skill lines, Vigor milestone distribution và những parameter chưa được Project Owner cung cấp tại [Level, Skill và Vigor Review Guide](../20-domains/01-player/03-level-skill-and-vigor-review-guide.md).

Exact death penalty/preset là tuning discovery của `DB-040`, không phải câu hỏi Product. Exact performance target theo hardware/profile là technical evidence của `DB-039`, không xin một con số cảm tính từ user.

## 5. Cách trả lời

Bạn có thể trả lời một câu, phản đối tiền đề hoặc thêm nỗi sợ/ý tưởng mới. Agent phải tìm quyết định cũ trước khi hỏi, cập nhật owner/backlog/quality và không bắt bạn nhớ lịch sử trò chuyện.
