# FEAT-TRAVERSAL-LIGHTNESS — Khinh Công phóng người và hạ chậm

> **DRI:** Player Traversal Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Controls, Camera, Animation, Combat, World, Progression, VFX/Audio, Accessibility, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi đã học Khinh Công, đứng ổn định hoặc bám tường ở trạng thái nghỉ và **giữ Jump với ý định vận sức rõ**, nhân vật nạp lực có giới hạn rồi phóng cao theo quỹ đạo collision-safe; tới/qua đỉnh, kỹ thuật chuyển thành thân pháp lướt–hạ chậm tiêu Khí Lực và điều hướng có quán tính cho tới khi đáp, chủ động hủy hoặc cạn sức.

## 2. Fantasy và anti-goals

Fantasy: lực phát từ bước giậm và kỹ thuật thân pháp, không từ cánh/jetpack. Người chơi cảm thấy nhẹ, có đà, đọc được đỉnh quỹ đạo và tự chọn lúc chuyển sang hạ chậm.

Không phải:

- Creative flight hoặc Elytra reskin;
- hover, tăng độ cao lặp vô hạn hay đổi hướng 180° không quán tính;
- teleport/dash không collision;
- combat escape miễn phí không resource/recovery;
- active skill chiếm combat loadout slot;
- làm chậm mọi normal Jump, biến giữ Space vô tình thành launch, hoặc cho treo tường nạp vô hạn.

## 3. Unlock và progression

- Universal capability mở tại Level 10 sau Free Climb + Grounding Strike.
- Một training challenge ngắn sở hữu delivery; không là random drop hoặc build choice, và player vượt mốc có catch-up.
- Training dạy ba beat: launch theo hướng nhìn → nhận cue apex → hold/toggle hạ chậm → Grounding Strike hoặc đáp thường.
- Upgrade candidate: Vigor capacity/efficiency, steering cap, recovery hoặc one-time route technique. Không mở repeated midair launch/hover baseline.

## 4. Input intent: giữ Space nhưng không phá Jump/Climb Leap

`Lightness` là semantic action riêng dù default gesture dùng Jump. Consumer selection phải xảy ra trước khi tạo launch:

| Context + gesture | Owner/kết quả |
|---|---|
| grounded + movement có nghĩa + press Jump | normal Jump commit ngay; không chờ hold threshold |
| grounded stable/neutral + press–release ngắn | normal Jump; chỉ dùng một bounded tap gate đã qua latency/feel proof |
| grounded stable/neutral + giữ qua threshold | `GROUND_CHARGE`; normal Jump bị consume đúng một lần |
| `CLIMB_IDLE` + directional Jump | Free Climb Leap/Dyno commit ngay |
| `CLIMB_IDLE` + neutral hold qua threshold | `WALL_CHARGE`; vẫn attached và tiếp tục chịu contact/Vigor rules |
| `CLIMB_MOVE`, mantle, slip hoặc raw opposing axes | Free Climb/deny owner thắng; không tự charge |
| fresh Sneak trong wall charge | deliberate cancel/drop; không launch |

- Hold threshold, movement dead-zone và tap gate phải được prototype cùng low/high FPS và latency. Nếu tap Jump đứng yên có cảm giác chậm, default profile phải chuyển sang một binding `Lightness` remappable riêng; không được hy sinh responsiveness để tiết kiệm một phím.
- Movement vượt dead-zone **trước** khi hold threshold được giải như normal/directional Jump hoặc Climb Leap. Sau khi charge đã accept, movement trở thành launch-aim/steering input và không đổi ngược action owner; hysteresis quanh threshold ngăn cùng một gesture flicker giữa hai semantics.
- Alternative profiles bắt buộc: `DEDICATED_ACTION`, và `PRESS_TO_CHARGE / PRESS_TO_LAUNCH` hoặc single-press assisted tier cho người không thể giữ nút. Tất cả dùng cùng cost, clearance và authority—not auto-cast.
- Key-repeat, macro-like duplicate packet, auto-jump, held Space từ screen/portal/reconnect và Space đang được Jump/Climb Leap consume không mở charge mới.

## 5. Action/state machine

```text
SUPPORTED --valid hold--> GROUND_CHARGE
CLIMB_IDLE --valid neutral hold--> WALL_CHARGE
GROUND_CHARGE | WALL_CHARGE
  --release/tier/auto-cap + reserve + clearance--> LAUNCH_COMMIT
  --cancel/invalid/hit--> SUPPORTED | CLIMB_IDLE | FALLING
LAUNCH_COMMIT --impulse--> ASCENDING
ASCENDING → APEX → FALLING
APEX/FALLING --descent intent + Vigor--> LIGHTNESS_DESCENT
LIGHTNESS_DESCENT
  --release/toggle/Vigor 0/interrupt--> FALLING
  --valid ground--> LIGHT_LANDING → SUPPORTED
FALLING/LIGHTNESS_DESCENT
  --Grounding Attack guard--> GROUNDING_STRIKE
```

- Baseline source gồm stable support và `CLIMB_IDLE`; wall launch là cùng technique với authored wall adapter, không phải wall-touch refill hay free wall jump.
- Một airborne sequence có tối đa một launch commit. Ground/support reset chỉ khi landing footprint/time đủ hợp lệ; chạm cạnh không refill để chain exploit.
- Charge có `QUICK` và `FULL` semantic tier candidate, không có analog power vô hạn. Tới full tier chỉ cho một hold cap ngắn rồi auto-launch hoặc chuyển maintenance drain có giới hạn; prototype chọn một, không đứng bất tử.
- Charge không cấp i-frame/super-armor mặc định. Hit, support/contact revision, piston, block break/place hoặc entity displacement revalidate; cancel trước commit refund phần reserve chưa tiêu, wall contact mất chuyển thành fall.
- Cùng semantic action có thể sở hữu charge/descent vì contexts loại trừ rõ; exact physical profile/remap thuộc `DB-052`.

## 6. Launch trajectory và obstruction

- Ground charge lấy camera-relative `MoveBasis` tại commit; người chơi có thể bắt đầu neutral rồi đưa hướng sau khi charge accept. Neutral release dùng camera-forward candidate.
- Wall charge dùng surface-relative launch basis: luôn có minimum outward-clearance component + lift, còn input sau charge điều chỉnh tangent/desired azimuth trong cone. Nó không phóng vào chính mặt tường, snap theo camera qua 180° hoặc biến `W/S` trước threshold thành charge thay vì climb leap/eject.
- Charge tier chọn một bounded impulse envelope; vertical/horizontal impulse, windup, steering before apex và collision response là parameter riêng. Charge lâu hơn tăng quyền chọn tuyến/độ cao trong cap, không nhân damage/fall immunity vô hạn.
- Camera xoay sau commit không bẻ quỹ đạo ngay; limited air steering thay đổi dần theo acceleration cap.
- Ceiling/overhang/collision sweep có thể shorten/reject launch; không phase qua block hoặc sửa bằng teleport.
- **Ceiling rất sát trước commit:** clearance fail, không impulse; ground charge trở về support, wall charge vẫn bám nếu contact còn, và refund theo pre-commit rule.
- **Ceiling/overhang xuất hiện sau commit:** capsule sweep dừng thành phần vận tốc vào mặt, phát collision cue rồi chuyển apex/fall; không hoàn Vigor đã commit và không nudge qua voxel.
- Khoảng cao quá thấp để hình thành ascent vẫn cho safe reject hoặc `QUICK` launch rút ngắn nếu profile chứng minh đọc được; không phát full animation xuyên trần rồi snap xuống.
- Launch tạo sound/visual/noise semantic có thể ảnh hưởng stealth/AI sau content contract.

## 7. Vigor, apex và lướt–hạ chậm

- Charge tạo reserve tăng theo tier; HUD preview phần commit và projected descent reserve. Wall charge trả **base climb drain + charge increment**, nhưng accounting phải chống double-drain cùng tick.
- Launch commit tiêu launch cost một lần; controlled descent drain theo authority clock và steering/condition profile. Không vay âm Vigor hoặc tạo resource khác để trả thay.
- Có minimum reserve guard hoặc exhausted-launch recovery để tránh animation hứa bay dài nhưng release lập tức vì zero Vigor; exact policy thuộc `DB-052`.

- Apex cue là visual + optional audio/haptic, không chỉ particle màu.
- Hạ chậm giảm downward acceleration/terminal velocity theo authoritative action; không đóng băng Y hoặc tạo lift.
- Horizontal steering camera-relative có speed/acceleration/turn cap; diagonal normalized.
- Vigor drain theo server clock; không hồi giữa không trung. Cạn Vigor chuyển về normal fall với cue/grace được prototype.
- Release/toggle trả về fall; re-entry descent trong cùng airborne sequence có policy/cost để tránh stutter exploit.
- Wind/updraft/weather/slow-fall effect có composition rule; không cộng modifier làm velocity âm/infinite.
- “Bay” trong fantasy là launch cao + đường lướt/hạ có tầm, không phải tự tăng độ cao. Ở quá thấp, descent activation đi thẳng vào landing adapter; không hover sát đất hoặc reset chain.

## 8. Combat và action interaction

| Action/context | Direction |
|---|---|
| Grounding Strike | được phép cancel descent khi guard/transaction hợp lệ |
| Ground Dodge | không dùng trên không; không chạy ground curve/animation |
| Aerial Dodge | future [`FEAT-COMBAT-AERIAL-DODGE`](../../02-combat/dodge/aerial-dodge.md); chỉ tại cancel edge/use/Vigor hợp lệ trong cùng `AerialChain` |
| Aerial Step/Double Jump | future [`FEAT-TRAVERSAL-AERIAL-STEP`](04-aerial-step.md); ascent/apex/fall cần cancel edge, descent deny baseline để tránh lift–descent loop |
| Light/heavy melee | deny hoặc aerial variant theo weapon contract; không tự reuse ground animation |
| Ranged/aim | prototype riêng; nếu cho phép phải giữ parallax/turn/steering readable |
| Hit/knockback/grab | severity có thể break descent và giữ attacker attribution |
| Shadow command/quick recovery | precedence/cancel explicit; không dùng giữa hard-committed launch |

Khinh Công không cấp i-frame. Enemy counterplay đến từ ranged threat, vertical pursuer, landing pressure và route design—không từ đọc nút người chơi.

- Aerial Step/Aerial Dodge đã dùng trước launch không được reset; launch mở từ wall sau một chain đang treo vẫn nối cùng `AerialChain`. Exact rule candidate: Lightness launch consume quyền Step còn lại để chặn lift stacking, trong khi Dodge có thể dùng ở một cancel edge rồi kết thúc descent; phải proof tại `DB-057`.
- Attack/Mine/Place/Use trong charge hoặc launch hard phase mặc định `DENY_NO_COST`; trong descent chỉ aerial variants có profile rõ mới được phép. Unknown future skill default deny theo `CTR-TRAVERSAL`.
- Grounding Strike chỉ nhận fresh/short-buffered Attack sau khi actor thật sự `FALLING` hoặc từ descent cancel edge; wall charge/attached không phải falling.

## 9. Camera, animation và presentation

- Third-person framing mở đủ thấy actor, quỹ đạo và landing space; FOV/zoom/shake có cap và reduced-motion.
- First-person giữ horizon ổn định, giảm roll/bob; không buộc auto-switch nếu comfort profile chưa yêu cầu.
- Animation set: grounded stance/load, wall brace/load, charge tier loop có exit marker, ground/wall launch commit, ascending extension, apex weight-shift, controlled-descent body line, steering lean, low-height landing, light landing, exhausted fall, head-collision, hit/cancel và fallback.
- Charge phải truyền lực từ chân/tay–hông–thân, không chỉ particle tăng sáng. Wall adapter có tay/chân contact khớp surface anchor; launch release bỏ anchor đúng commit marker.
- Actor có thể xoay presentation theo velocity/steer nhưng gameplay direction/velocity không do bone/root motion sở hữu.
- Không thêm cánh. VFX dùng pressure trail/khí/cloth-shadow abstraction nguyên bản, budgeted và shader/backend-safe.
- Vigor meter contextual + trajectory/apex/low-resource cues; không giữ thêm HUD bar thường trực ngoài traversal.
- Charge tier dùng body pose + âm thanh nhịp + UI ring/notch có text/icon state; không chỉ màu. Full charge, low reserve và forced fall là ba semantic cue khác nhau; haptic chỉ là kênh bổ sung.

## 10. Minecraft/world interaction

- Không phá/đặt block, giẫm crop hay kích redstone từ xa. Landing dùng vanilla collision/support truth.
- Elytra/Creative flight/mount/swim/portal có precedence; không stack Lightness modifiers.
- Người chơi có thể chuyển từ descent sang Free Climb khi va face chỉ qua explicit input/eligibility và còn Vigor.
- Lightness launch/descent không reset Aerial Step/Aerial Dodge use. Wall touch, descent re-entry hoặc apex transition không mở chain mới; exact future composition thuộc `DB-057` và không block `DB-052` core proof.
- Height/route design của Gate/structure xét launch envelope; hard boundary không dựa tường cao duy nhất.
- Ladder/scaffolding/bridge vẫn tiết kiệm Vigor, vận chuyển Shadow/mob/item và hoạt động trước unlock.
- Active Shadow dùng off-screen safe rejoin/hold policy trước khi có traversal animation tương đương.
- `GROUND_CHARGE` revalidate slabs/stairs/snow/carpet/moving support footprint; `WALL_CHARGE` revalidate partial/thin/foliage/fluid/piston surface profile và revision đúng Free Climb. Nước/lava, bubble column, cobweb/powder snow và climbable block chuyển owner thay vì cho launch chồng modifier.

## 11. Authority, save, security và performance

- Server validate source support **hoặc wall anchor**, hold lineage/tier, clearance, capability, Vigor reserve, action state, impulse envelope và state transitions.
- Client prediction được reconcile; forged flight/velocity/ground-reset payload bị reject/rate-limit/trace.
- Unlock/Vigor/cooldown versioned; airborne state ephemeral. Quit/reconnect không refill hoặc khôi phục một launch giữa animation.
- Risk `PR-2`; full traversal/companion snapshot `PR-3`. Bounded collision query, no trail allocation per frame, correction/velocity counters và backend profiles bắt buộc.
- Degrade trail/cloth/ambient sound trước; không degrade collision, apex/low-Vigor cue hoặc authoritative velocity.
- Current target offline nhưng dùng logical-server authority; future multiplayer seam giữ charge lineage, source revision, reserve và launch commit trong một transaction. Hai actor chung ledge/piston/place/hit race theo `CTR-TRAVERSAL`, chưa implement prediction/network gameplay tại Discovery.
- Unlock, input profile và versioned Vigor state cần migration; runtime charge/contact/trajectory không save nửa chừng. Fabric/NeoForge adapter tương lai chỉ chuyển hook/payload, không sở hữu hold selector, curve hoặc save fork.
- Localization có label/help/subtitle/reject keys cho charge tiers, full, ceiling blocked, anchor lost, low/exhausted Vigor và descent; không hard-code `Space` vì binding/profile thay đổi.

## 12. Acceptance hypotheses

- launch direction predictable ở 360°, diagonal, slope, low ceiling, ledge và two-camera modes;
- không hover, repeated launch, wall-touch refill, logout refill hoặc modifier-stack infinite flight;
- Vigor 0/release/hit/collision chuyển về fall có cue và không kẹt state;
- Grounding Strike/Free Climb/landing transitions không double cost/damage/fall suppression;
- người mới hiểu apex và hạ chậm sau tutorial; expert có đường steering/mastery thật;
- world route mở rộng đáng kể nhưng ladder/building và danger vẫn hữu ích;
- low/high FPS, lag, portal/death/reload và future server validation giữ cùng outcome.
- tap/running Jump không bị charge gesture cướp; neutral hold có feedback trước commit và alternative input đạt parity;
- wall charge mất anchor, bị bắn, Sneak-drop hoặc ceiling fail không treo người/nhân đôi reserve;
- low ceiling, moving piston/support, low-altitude descent và full-charge cap không clip/hover/stuck gravity.

## 13. Scenario matrix bắt buộc

| ID | Given/When | Oracle |
|---|---|---|
| `LGT-S-001` | chạy + Jump, neutral tap, neutral hold | normal Jump tức thời theo profile; chỉ hold rõ mở charge |
| `LGT-S-002` | climb idle neutral hold vs directional Jump/Sneak | wall charge vs leap/drop đúng một consumer |
| `LGT-S-003` | quick/full/over-hold + release/auto-cap | tier/cost/launch một lần; không hold bất tử |
| `LGT-S-004` | trần sát/trần xuất hiện/piston/support revision trước và sau commit | reject/refund hoặc collision/fall đúng phase, no clip |
| `LGT-S-005` | charge bị projectile/melee/grab/knockback | no i-frame; cancel/fall/attribution và reserve đúng |
| `LGT-S-006` | ascent→apex→descent ở high/low altitude và Vigor 0 | cue/readable, low landing không hover, exhausted fall đúng |
| `LGT-S-007` | Step/Dodge trước/sau Lightness, Grounding từ descent, Climb reattach | one chain/no refill; transition/cost đúng owner |
| `LGT-S-008` | slab/stair/leaf/bar/water/lava/cobweb/bubble/moving block | source/composition surface owner đúng |
| `LGT-S-009` | held key/duplicate/reconnect/death/portal/resource reload | không ghost charge, relaunch hoặc stuck gravity/reserve |
| `LGT-S-010` | first/third, remap, press-toggle assist, reduced motion | trajectory/cost parity và cue đa kênh |

## 14. Open decisions

`DB-052`: hold/tap disambiguation và fallback binding, charge tier/cap, ground/wall windup, impulse envelope, apex cue, descent activation/re-entry, terminal velocity/steering, Vigor reserve/drain, collision/wind/status composition, AerialChain consumption, combat actions, upgrades và accessibility/comfort profile.
