# RES-TRAVERSAL — Leo, cứu cú rơi và Khinh Công trong open-world voxel

> **Decision Questions:** `DB-049`, `DB-050`, `DB-051`, `DB-052`
> **Owner:** Player Traversal Research + Technical Design
> **Status:** `EVIDENCE_SEED`
> **Checked:** 2026-07-19; exact Genshin/Where Winds Meet build behavior và Minecraft 26.2 runtime shape vẫn cần direct capture trước khi khóa parameter

## 1. Câu hỏi quyết định

1. UMBRA nên cho leo gần như mọi face hay authored handhold, và làm sao không phá Minecraft building/world boundaries?
2. Traversal dùng Focus chung với Dodge hay resource riêng?
3. Kỹ thuật bấm attack khi rơi nên chuyển fall damage bằng rule nào để là mastery chứ không auto-save?
4. Khinh Công tạo launch + controlled descent ra sao mà không thành Creative flight/Elytra reskin?
5. Capability nên có từ đầu, Potential hay early universal progression?
6. Adaptive mantle/auto-steering/input buffer tạo responsiveness tới đâu trước khi cướp agency?
7. Slab/stair/thin/transparent/foliage/piston/fluid cần rule thống nhất nào thay cho block exception?
8. Prediction/revalidation nào giữ climb mượt mà vẫn server-authoritative khi hit hoặc world đổi?

## 2. Quan sát → vấn đề → giới hạn chuyển giao

| Archetype/source | Quan sát có bằng chứng | Vấn đề nó giải | Không được bê nguyên |
|---|---|---|---|
| Product feedback `PD-046` | Minecraft có ít phím công thái học; Jump chủ động vào tường biểu đạt ý định leo, Jump khi bám nên thành directional leap tốn Vigor và Sneak/Shift nên chủ động ngắt bám | contextual grammar giảm key tax và khớp muscle memory Minecraft | đây là UMBRA direction cần prototype, không phải claim về Genshin/Minecraft vanilla behavior |
| Genshin Impact — reference do user cung cấp | user quan sát leo mặt đứng, di chuyển dọc/ngang, mantle thích nghi, route assist, cue Vigor và stamina; **chưa có pinned build/platform/clip trong repo** | lead cho vertical freedom, responsive transition và cue escalation | mọi claim adaptive mantle/auto-steering/haptic/animation cụ thể vẫn là `CAPTURE_REQUIRED`; không ghi ký ức hoặc mô tả user thành fact đã kiểm chứng |
| [HoYoLAB community climbing guide, observed versions 1.5–2.3](https://www.hoyolab.com/article/401485) | tác giả community mô tả route/rest planning, jump tốn stamina, wall-jump có điều kiện và thừa nhận checklist engine chỉ là suy luận; difficult terrain có thể fail/đòi positioning | reference gần cũng có geometry ambiguity và learned exploits, không phải “mượt tuyệt đối” để copy | `COMMUNITY_OBSERVATION`, không phải developer documentation/current-build proof; chỉ dùng làm hypothesis/capture route |
| [Nintendo — Breath of the Wild Explorer's Guide](https://assets.nintendo.com/image/upload/v1675114089/Microsites/zelda-breath-of-the-wild/pdf/ExplorersGuide.pdf) | official guide mô tả climbing gắn với stamina và upward jump tốn một phần lớn stamina | bar làm quãng leo/route trở thành decision, leap đổi tốc độ lấy endurance | UMBRA voxel/building, combat và companion khác; không copy HUD/cost/controls |
| [Ubisoft — Assassin’s Creed Shadows Parkour Overview](https://www.ubisoft.com/en-us/game/assassins-creed/news/4TA6gKaTvtOC1mOjZIxCZd/assassins-creed-shadows-parkour-system-overview) | official overview tách parkour-up/down, recovery roll, directional transitions, valid/unclimbable surfaces và world parkour paths | explicit intent giảm accidental movement; surface rules cho level design kiểm soát route | UMBRA không có authored handhold mesh cho mọi block và không reuse Dodge làm parkour-down mặc định |
| [Ubisoft — Evolution of Assassin’s Creed Parkour](https://news.ubisoft.com/en-us/article/7tPPFQdG9mmV7yCiUmkO1K/the-evolution-of-assassins-creeds-parkour) | series thay đổi từ sticky parkour highways tới near-any-surface climb; một bản còn biến fall thành ground-smash skill theo progression | traversal grammar phải khớp scale/shape world; fall action có thể là power-growth beat | không dùng auto-stick, fall immunity hoặc damage attack như default không cost/test |
| [Where Winds Meet official site](https://www.wherewindsmeetgame.com/) | official positioning xác nhận wuxia open-world và martial-arts/lightness fantasy; exact launch/descent behavior chưa đủ mô tả để claim | fantasy thân pháp nhẹ, expressive open-world traversal | user-described launch/slow descent vẫn là observation lead cần pinned-build capture |
| [GDC 2024 — Obstacle Traversal in an Organic World](https://media.gdcvault.com/gdc2024/Slides/GDC%2Bslide%2Bpresentations/GDC_Joel_Nilsson_Obstacle_Traversal.pdf) | traversal có thể tìm tiny ledges/phá vùng cấm; talk phân biệt shallow/ground approach thành step-up và high/air approach thành mantle trước khi move | traversal là world contract; cùng obstacle cần semantic khác theo delta/approach | không copy threshold/pose; UMBRA sandbox cần partial-shape, camera, authority revalidation và boundary cue thay invisible patch muộn |
| [Unreal Motion Warping](https://dev.epicgames.com/documentation/en-us/unreal-engine/motion-warping-in-unreal-engine) + [Pose Warping](https://dev.epicgames.com/documentation/en-us/unreal-engine/pose-warping-in-unreal-engine) | official engine docs mô tả warp một cửa sổ animation tới target và chỉnh pose theo capsule/movement direction | ít base clip hơn vẫn thích nghi target/góc, tách motion/pose adaptation khỏi rule chọn đích | đây là principle/tool archetype, không khóa engine/library; warp không được thay server collision/commit |
| [Xbox Accessibility Guideline 103](https://learn.microsoft.com/en-us/xbox/accessibility/xbox-accessibility-guidelines/103) | critical visual/audio information nên có thêm sensory channel; haptic chỉ bổ sung vì có thể bị tắt/không có, color không là signifier duy nhất | low/critical/exhausted và deny reason phải perceivable khi một kênh thiếu | không bắt mọi cue bật đồng thời hoặc coi haptic/controller là current platform requirement |
| [Xbox Accessibility Guideline 107](https://learn.microsoft.com/en-us/xbox/accessibility/xbox-accessibility-guidelines/107) | prolonged hold/repeated input có thể gây mỏi; guideline khuyến nghị toggle/auto hoặc alternative không giữ lâu | persistent latch là baseline hợp lý; hold-to-cling chỉ là profile tùy chọn có parity | không suy một control profile phù hợp mọi người; Drop/Cancel và recovery khỏi mất focus vẫn phải rõ |
| [Fabric tags](https://docs.fabricmc.net/develop/data-generation/tags), [networking](https://docs.fabricmc.net/develop/networking) và [automated testing](https://docs.fabricmc.net/develop/automatic-testing) | docs cung cấp data-driven tags, logical server tồn tại cả single-player, packet sync và unit/GameTest/client GameTest | profile không hard-code list; logical server commit; shape/lifecycle/camera có fixture | docs quan sát mang baseline `26.1.2`; hook/API exact cho `26.2` vẫn phải pin tại `DB-019` |
| Fabric/Yarn mapped API seeds: [`AbstractBlock#getCollisionShape`](https://maven.fabricmc.net/docs/yarn-24w03b%2Bbuild.5/net/minecraft/block/AbstractBlock.html), [`PistonBlockEntity#getCollisionShape`](https://maven.fabricmc.net/docs/yarn-23w42a%2Bbuild.5/net/minecraft/block/entity/PistonBlockEntity.html), [`FluidState#getShape/getVelocity`](https://maven.fabricmc.net/docs/yarn-21w05b%2Bbuild.8/net/minecraft/fluid/FluidState.html) | mapping artifacts cho thấy block, moving piston và fluid có shape/state/velocity surfaces riêng, không thể suy tất cả từ static full cube | solver cần collision + dynamic/fluid revision thay vì block name/opacity | đây là cross-version API evidence seed, không chứng minh signature/behavior 26.2; phải pin source/capture trước implementation |
| Minecraft 26.2 baseline | voxel collision, ladder/vine/scaffolding, Elytra, fall/environment damage, building và camera đều đã có owner; exact behavior phải capture tại `DB-019` | reference “không có overhaul”: construction và hazard đang tạo route/value | không suy engine hook/shape behavior từ ký ức hoặc wiki version khác |

## 3. Nguyên lý chưng cất

1. **Traversal là world contract:** thêm leo gần như mọi mặt buộc structure, Gate, quest, enemy và boundary audit lại; không thể chỉ thêm velocity.
2. **Explicit intent không đồng nghĩa phím riêng:** Jump edge + provenance + approach có thể là ClimbIntent mạnh; sticky collision vẫn bị loại để không cướp mining/building.
3. **Resource phải theo horizon quyết định:** combat Focus và traversal Vigor tách pool; cùng một hình thức bar không có nghĩa cùng semantic.
4. **Surface là data, không là danh sách exception:** face profile/tag + shape/clearance probe cho voxel và future content.
5. **Animation trình bày constraint:** authority/collision/state quyết movement; IK/root motion không làm gameplay truth.
6. **Fall rescue cần transaction:** accept window, commit landing và đúng một fall conversion; không global immunity.
7. **Khinh Công cần giới hạn năng lượng:** ground-only launch, một launch/airborne sequence, no lift/hover và Vigor drain ở descent.
8. **Core access không thuộc build choice:** universal early grant + training; Potential chỉ có thể tạo bounded expression sau core.
9. **Vanilla construction vẫn phải tốt hơn ở vài trục:** ladder/scaffold/bridge không Vigor, logistics/companion an toàn và dùng trước unlock.
10. **Responsiveness là transaction, không phải bỏ guard:** input buffer/late grace giữ intent có sequence/expiry; consume một lần khi state legal, không dựa animation frame.
11. **Assist cần confidence và hysteresis:** stabilization sửa seam/noise; route assist chỉ trong cone người chơi và nhả khi intent đảo, không auto-path.
12. **Adaptive mantle là semantic selection:** delta/approach/support/clearance chọn step/low/high/crest; animation warp quanh target authoritative.
13. **Opacity không phải collision:** glass có thể support, foliage có collision cần unstable profile, thin shape cần dedicated grip; fluid-only không support.
14. **World mutation thắng candidate cũ:** piston/place/break/fluid/entity blocker làm revision đổi; latch/mantle revalidate ở commit.
15. **Local deterministic hazard thắng global random friction:** flowing water/hot/unstable profile có cue/cap; baseline không rain-slip toàn thế giới hoặc random fall.
16. **Prediction có correction budget:** smoothing phục vụ presentation, không che topology mismatch hoặc lerp xuyên block.
17. **Reference phải được phản biện bằng failure:** ngay cả Genshin community guide cũng ghi route khó/overhang/positioning và suy luận engine; UMBRA không gọi mọi sticky behavior là polish hoặc biến exploit thành contract.
18. **Causality phân biệt jump-to-wall với auto-save:** explicit player Jump vào face trực diện có thể tự bám; chỉ walk collision, auto-jump, passive fall, external force, grazing parkour hoặc build/pillar context thì không. Velocity/contact cuối không đủ chứng minh ý định.
19. **Vigor đo effort được chấp nhận, không đo ngón tay:** hybrid base cling time + accepted displacement + committed action giữ sức nặng cơ thể và route choice, nhưng không phạt input bị geometry chặn, assist/correction hay knockback.
20. **HUD trả lời quyết định tiếp theo:** contextual fixed meter cần cho current, reserved, next cost/insufficient và recovery state; exact time/distance mặc định dễ nói dối khi route/surface/action đổi.

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

### Feel và voxel mutation

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| một mantle + sticky auto-route | ít semantic/clip, thường nhìn mượt ở demo | sai delta/partial shape, cướp route, animation sở hữu displacement | loại baseline |
| manual tuyệt đối, không buffer/assist | agency rõ, solver đơn giản | seam/noise/transition khiến input bị nuốt và keyboard cứng | không đạt `PIL-EMBODIMENT` |
| buffered intents + bounded stabilization/assist + adaptive semantic mantle | giữ intent, scale hai thiết bị/camera và geometry | cần hysteresis, diagnostics, prototype | direction UMBRA |
| lock/reserve ledge/world trong mantle | tránh candidate đổi | chặn building/world mutation, future race phức tạp | loại; revalidate commit |
| global rain/random slip | route drama | chờ đợi ngoài agency, khó attribution và phá sandbox routine | không baseline |

### Entry automation và cling control

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| va collision tự attach | liền mạch khi chỉ chạy khám phá | cướp mining/building/combat, bám do knockback, HUD spam | loại baseline |
| dedicated Climb bắt buộc | intent rõ, dễ buffer | thêm phím cạnh combat/hotbar/build; không tận dụng jump-to-wall rõ nghĩa | precision/accessibility option, không default |
| Jump lineage + approach + inhibitor | ít phím, nhận jump arc và air clutch; phân biệt nguồn tác động | causality/context phức tạp, cần nhiều adversarial test | direction UMBRA |
| hold-to-cling bắt buộc | release-to-drop trực tiếp | prolonged hold gây mỏi; dễ rơi do focus/input hiccup | chỉ là optional profile |
| persistent latch + fresh Sneak Drop | dùng Space/Shift quen thuộc, ít mỏi | phải xử lý pre-held Sneak, dismount/swim/mantle phase | baseline direction |

### Vigor cost và HUD

| Option | Ưu | Hại | Verdict |
|---|---|---|---|
| chỉ thời gian bám | dễ hiểu | đi lên/xuống/leap gần như cùng hiệu suất; chờ camera bị phạt nặng | loại dạng thuần |
| chỉ quãng dời | đứng yên miễn phí | AFK cling, seam/exploit; không có pressure đọc route | loại dạng thuần |
| base time + accepted displacement + committed action | biểu đạt giữ thân + effort, tune route/action được | cần trace, cap và tránh double-charge | direction UMBRA |
| meter luôn hiện hoặc world-space-only | trạng thái luôn thấy/gần nhân vật | HUD clutter hoặc mất trong first-person/occlusion | loại baseline |
| contextual fixed meter + redundant body/audio cue | nguồn truth ổn định, chỉ hiện khi quyết định liên quan | cần lifecycle/hysteresis/layout proof | direction UMBRA |

## 5. Lựa chọn UMBRA hiện tại

- Tạo `CTR-TRAVERSAL` dùng chung state/surface/Vigor và ba Feature Cell độc lập.
- Vigor tách Focus/Fatigue/Hunger, chỉ hiện theo context.
- Basic mantle từ đầu; Free Climb, Grounding Strike và Lightness là universal capability mở rất sớm theo milestone/training, exact level còn discovery.
- Full solid face là climb candidate; vanilla climb blocks giữ path/value riêng; partial/hazard/technical surfaces dùng profile.
- Free Climb dùng contact patch từ collision/support shape + profile + `WorldRevision`; transparency không quyết support, fluid-only/moving piston không support baseline.
- Input là continuous-vector-ready và edge intent có buffer/sequence/expiry; stabilization bounded, route assist có cone/cap/hysteresis.
- Đi/chạy/sprint chỉ va tường không leo; explicit player Jump arc trực diện hoặc airborne Jump request có thể attach. Auto-jump/passive/external/build/grazing context bị inhibit; optional precision Climb không cần default key.
- Khi attached, Jump + neutral/Up/Left/Right chọn targeted upward leap/dyno, Jump + Down wall-eject và fresh Sneak deliberate Drop. Technique reserve cost + post-contact guard; invalid target không đổi hướng hoặc charge.
- Free Climb Vigor dùng base cling + accepted actor displacement + committed action, không tính raw blocked input/assist/correction/external force; recovery cần stable support dwell.
- Vigor HUD là contextual fixed meter với reserved/next-cost/recovery semantics; wall collision không tự bật preview.
- Mantle có semantic step-up/low/high/crest theo geometry/approach; animation warp/fallback giữ target/timing/cost authoritative.
- Block/fluid/entity mutation và hit được resolve/revalidate tại server commit; client predict trong envelope và correction có budget.
- Global rain slip và hidden fall-damage grace không thuộc baseline; local hazard/flow modifier deterministic, cue rõ và explicit recovery technique giữ mastery.
- Grounding Strike dùng Primary Attack context + alternative binding, time-to-impact window và landing commit; safety không áp void/hazard component.
- Lightness = ground launch → apex → controlled descent; không wing, hover, midair relaunch hoặc infinite stack.

## 6. Bằng chứng còn thiếu

- direct capture Genshin/Where Winds Meet theo build/platform: input, stamina, surface/corner, apex/descent, camera, interrupt và failure;
- direct capture riêng các claim user nêu về Genshin: mantle variants, route attraction, input buffer, analog response, low/exhausted multisensory cue và recovery; nếu không thấy thì ghi falsified/variant-specific, không hợp thức hóa bằng ký ức;
- Minecraft 26.2 fixture capture: full/partial/connected/thin/transparent/foliage shapes, waterlogging/fluid height/velocity, moving piston, ladders/vines/scaffolding/Elytra/fall modifiers/portal/death;
- voxel camera-room prototype cho patch decomposition, seam/corner scoring, adaptive mantle, buffer, assist hysteresis, mutation race và camera modes;
- server prediction/reconciliation/anti-flight trace dưới latency/TPS pressure;
- Vigor route simulation và HUD comprehension;
- paired feel test cho Grounding window và Lightness launch/descent;
- structure/Gate/enemy/Shadow sequence-break and follower audit;
- frame/tick/allocation/soak profile theo `PERF-S09`.

## 7. Rủi ro IP/originality

Chỉ chuyển nguyên lý: resource-readable vertical freedom, explicit/buffered intent, context-selected traversal type, bounded assist, multisensory redundancy, commit revalidation và world-aware surface taxonomy. UMBRA tự tạo tên, state grammar, scoring, input mapping, numerical curve, animation, VFX/SFX, HUD, quest delivery, block profile và consequence. Không sao chép exact pose/moveset/curve/icon/haptic signature của Genshin, Where Winds Meet, Zelda, Assassin’s Creed hoặc engine sample.

Attribution correction: official BOTW guide xác nhận mưa/wet surface làm grip trượt; repo chưa có source/capture cho claim “Genshin đổi grip theo mưa/gió/ban đêm”. Vì vậy dynamic weather không được gắn nhãn Genshin fact và không đi vào UMBRA baseline từ feedback này.
