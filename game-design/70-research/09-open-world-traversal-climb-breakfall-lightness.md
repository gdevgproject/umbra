# RES-TRAVERSAL — Leo, cứu cú rơi và Khinh Công trong open-world voxel

> **Decision Questions:** `DB-049`, `DB-050`, `DB-051`, `DB-052`
> **Owner:** Player Traversal Research + Technical Design
> **Status:** `EVIDENCE_SEED`
> **Checked:** 2026-07-19; exact game/build behavior cần capture trực tiếp trước khi khóa parameter

## 1. Câu hỏi quyết định

1. UMBRA nên cho leo gần như mọi face hay authored handhold, và làm sao không phá Minecraft building/world boundaries?
2. Traversal dùng Focus chung với Dodge hay resource riêng?
3. Kỹ thuật bấm attack khi rơi nên chuyển fall damage bằng rule nào để là mastery chứ không auto-save?
4. Khinh Công tạo launch + controlled descent ra sao mà không thành Creative flight/Elytra reskin?
5. Capability nên có từ đầu, Potential hay early universal progression?

## 2. Quan sát → vấn đề → giới hạn chuyển giao

| Archetype/source | Quan sát có bằng chứng | Vấn đề nó giải | Không được bê nguyên |
|---|---|---|---|
| Genshin Impact — reference do user cung cấp | user quan sát leo mặt đứng, di chuyển dọc/ngang và dùng stamina; exact build/input/drain chưa được capture ở lượt này | vertical freedom + resource-readable route planning | không ghi ký ức về số, surface, shared Dodge stamina hay animation thành fact |
| [Nintendo — Breath of the Wild Explorer's Guide](https://assets.nintendo.com/image/upload/v1675114089/Microsites/zelda-breath-of-the-wild/pdf/ExplorersGuide.pdf) | official guide mô tả climbing gắn với stamina và upward jump tốn một phần lớn stamina | bar làm quãng leo/route trở thành decision, leap đổi tốc độ lấy endurance | UMBRA voxel/building, combat và companion khác; không copy HUD/cost/controls |
| [Ubisoft — Assassin’s Creed Shadows Parkour Overview](https://www.ubisoft.com/en-us/game/assassins-creed/news/4TA6gKaTvtOC1mOjZIxCZd/assassins-creed-shadows-parkour-system-overview) | official overview tách parkour-up/down, recovery roll, directional transitions, valid/unclimbable surfaces và world parkour paths | explicit intent giảm accidental movement; surface rules cho level design kiểm soát route | UMBRA không có authored handhold mesh cho mọi block và không reuse Dodge làm parkour-down mặc định |
| [Ubisoft — Evolution of Assassin’s Creed Parkour](https://news.ubisoft.com/en-us/article/7tPPFQdG9mmV7yCiUmkO1K/the-evolution-of-assassins-creeds-parkour) | series thay đổi từ sticky parkour highways tới near-any-surface climb; một bản còn biến fall thành ground-smash skill theo progression | traversal grammar phải khớp scale/shape world; fall action có thể là power-growth beat | không dùng auto-stick, fall immunity hoặc damage attack như default không cost/test |
| [Where Winds Meet official site](https://www.wherewindsmeetgame.com/) | official positioning xác nhận wuxia open-world và martial-arts/lightness fantasy; exact launch/descent behavior chưa đủ mô tả để claim | fantasy thân pháp nhẹ, expressive open-world traversal | user-described launch/slow descent vẫn là observation lead cần pinned-build capture |
| [GDC 2024 — Obstacle Traversal in an Organic World](https://media.gdcvault.com/gdc2024/Slides/GDC%2Bslide%2Bpresentations/GDC_Joel_Nilsson_Obstacle_Traversal.pdf) | traversal có thể tìm tiny ledges và phá vùng cấm; tác giả nêu no-traversal flags/invisible collision là giải pháp muộn họ muốn tránh bằng planning sớm | traversal là world/level contract, không chỉ movement feature | UMBRA sandbox không nên biến mọi shortcut thành bug; hard boundary cần authored rule/cue |
| [Fabric tags](https://docs.fabricmc.net/develop/data-generation/tags), [networking](https://docs.fabricmc.net/develop/networking) và [automated testing](https://docs.fabricmc.net/develop/automatic-testing) | tài liệu chính thức cung cấp data-driven tag generation, logical-side networking/validation và automated game-test fixtures | surface profile không phải hard-code list; server giữ authority; collision/lifecycle có thể regression-test | trang hiện quan sát mang baseline `26.1.2`; API/hook chính xác cho Minecraft `26.2` vẫn phải pin và capture ở `DB-019`, không suy ngược |
| Minecraft 26.2 baseline | voxel collision, ladder/vine/scaffolding, Elytra, fall/environment damage, building và camera đều đã có owner; exact behavior phải capture tại `DB-019` | reference “không có overhaul”: construction và hazard đang tạo route/value | không suy engine hook/shape behavior từ ký ức hoặc wiki version khác |

## 3. Nguyên lý chưng cất

1. **Traversal là world contract:** thêm leo gần như mọi mặt buộc structure, Gate, quest, enemy và boundary audit lại; không thể chỉ thêm velocity.
2. **Explicit intent thắng sticky automation trong Minecraft:** auto-grab tùy chọn, còn baseline cần action/context để không cướp mining/building.
3. **Resource phải theo horizon quyết định:** combat Focus và traversal Vigor tách pool; cùng một hình thức bar không có nghĩa cùng semantic.
4. **Surface là data, không là danh sách exception:** face profile/tag + shape/clearance probe cho voxel và future content.
5. **Animation trình bày constraint:** authority/collision/state quyết movement; IK/root motion không làm gameplay truth.
6. **Fall rescue cần transaction:** accept window, commit landing và đúng một fall conversion; không global immunity.
7. **Khinh Công cần giới hạn năng lượng:** ground-only launch, một launch/airborne sequence, no lift/hover và Vigor drain ở descent.
8. **Core access không thuộc build choice:** universal early grant + training; Potential chỉ có thể tạo bounded expression sau core.
9. **Vanilla construction vẫn phải tốt hơn ở vài trục:** ladder/scaffold/bridge không Vigor, logistics/companion an toàn và dùng trước unlock.

## 4. Options đã so sánh

### Resource

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| Focus chung Dodge + traversal | ít bar, giống một số reference | cross-context lockout; balance leo làm hỏng combat | loại khỏi baseline bởi `PD-034` |
| Vigor traversal riêng, contextual | tuning độc lập, HUD chỉ hiện lúc cần | thêm một concept phải dạy | direction UMBRA |
| Không resource, chỉ animation/cooldown | tự do tuyệt đối | route/height mất decision, Lightness dễ thành flight | không baseline; có thể Creative/debug |

### Unlock

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| có toàn bộ từ spawn | nhất quán ngay | người mới overload; mất reward/teaching beat | chỉ basic mantle candidate |
| Potential/build node | build identity | khóa world access, missable, quest/structure khó author | loại |
| early universal milestone + training | reward mạnh, dạy đúng lúc, mọi build có | cần migration/fallback và quest delivery | direction UMBRA |

### Surface

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| chỉ handhold authored | level control, animation đẹp | bất khả thi với mọi player-built voxel; inconsistent |
| mọi collision tuyệt đối | freedom tối đa | cheese, technical block, collision/animation lỗi |
| solid-face default + data-driven profile/deny | Minecraft-native, scale, có control | cần fixture/tag governance | direction UMBRA |

## 5. Lựa chọn UMBRA hiện tại

- Tạo `CTR-TRAVERSAL` dùng chung state/surface/Vigor và ba Feature Cell độc lập.
- Vigor tách Focus/Fatigue/Hunger, chỉ hiện theo context.
- Basic mantle từ đầu; Free Climb, Grounding Strike và Lightness là universal capability mở rất sớm theo milestone/training, exact level còn discovery.
- Full solid face là climb candidate; vanilla climb blocks giữ path/value riêng; partial/hazard/technical surfaces dùng profile.
- Grounding Strike dùng Primary Attack context + alternative binding, time-to-impact window và landing commit; safety không áp void/hazard component.
- Lightness = ground launch → apex → controlled descent; không wing, hover, midair relaunch hoặc infinite stack.

## 6. Bằng chứng còn thiếu

- direct capture Genshin/Where Winds Meet theo build/platform: input, stamina, surface/corner, apex/descent, camera, interrupt và failure;
- Minecraft 26.2 fixture capture: collision shapes, ladders/vines/scaffolding/Elytra/fall modifiers/portal/death;
- voxel camera-room prototype cho attach, corner, mantle, moving block và camera modes;
- server prediction/reconciliation/anti-flight trace dưới latency/TPS pressure;
- Vigor route simulation và HUD comprehension;
- paired feel test cho Grounding window và Lightness launch/descent;
- structure/Gate/enemy/Shadow sequence-break and follower audit;
- frame/tick/allocation/soak profile theo `PERF-S09`.

## 7. Rủi ro IP/originality

Chỉ chuyển nguyên lý: resource-readable vertical freedom, explicit traversal direction, landing commitment, launch–apex–descent và world-aware surface taxonomy. UMBRA tự tạo tên, state grammar, input mapping, numerical curve, animation, VFX/SFX, HUD, quest delivery, block taxonomy và consequence. Không sao chép exact pose/moveset/curve/icon của Genshin, Where Winds Meet, Zelda hoặc Assassin’s Creed.
