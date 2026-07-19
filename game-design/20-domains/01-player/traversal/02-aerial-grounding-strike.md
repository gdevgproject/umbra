# FEAT-AERIAL-GROUNDING-STRIKE — Hạ Kình khi rơi

> **DRI:** Combat Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat, Animation, Camera, Input, VFX/Audio, World, Balance, Accessibility, QA
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi đã học kỹ thuật, đang rơi về một vùng đáp hợp lệ và bấm fresh Primary Attack trong cửa sổ được báo rõ, game chấp nhận một Hạ Kình: hãm/quy hướng ngắn, lao thẳng xuống theo adapter vũ khí, chuyển fall damage của đúng cú đáp thành landing an toàn và tạo một impact vùng **mạnh, có giới hạn và không phá block**.

## 2. Ý định được giữ và giới hạn

Giữ đúng fantasy người dùng:

- kỹ thuật phản xạ, không auto-save;
- có khoảnh khắc hãm/xoay/đập xuống đẹp;
- dùng vũ khí hiện tại hoặc fallback không vũ khí;
- impact diện rộng có trọng lượng, khác theo family vũ khí;
- success cho landing an toàn.

Không biến thành:

- nút miễn mọi lava/void/grab/scripted lethal;
- AoE thay thế mọi active combat skill hoặc scale vô hạn theo độ cao;
- block-break/grief tool;
- infinite hover hoặc reset vertical height;
- client tự khai gần đất để xóa damage.

## 3. Unlock và role

- Universal passive technique, mở sớm sau Light Attack + fall teaching; không chiếm skill slot và không là Potential.
- Level chỉ là eligibility candidate; một training beat ngắn dạy cue/time-to-impact và thất bại an toàn ở độ cao thấp.
- Role đồng chính: `landing conversion` + `committed aerial attack payoff`. Kỹ thuật phải đáng dùng trong combat nhưng windup, vùng đáp, recovery, Vigor và nguy cơ bị ngắt ngăn spam nhảy.
- Implementation snapshot dùng capability grant; production quest delivery chỉ khi Quest Kernel sẵn sàng.

## 4. Eligibility

Server chỉ accept `GroundingIntent` khi:

- capability unlocked, actor alive/controlled và đang `AIRBORNE/FALLING`;
- downward velocity/airborne history đủ để hành động có nghĩa;
- bounded ground sweep dự đoán một landing candidate trong time-to-impact band;
- actor không ở Creative/Spectator flight, Elytra, swim, riding, `CLIMB_*`, `MANTLE_*`, grab/knockdown hoặc hard-committed Aerial Step/Aerial Dodge/Lightness action;
- Vigor/transaction rule hợp lệ;
- Primary Attack context không bị UI/mining/use/another committed attack sở hữu.

Cửa sổ dựa **time-to-impact + velocity**, không chỉ “cách đất X block”, để ổn định hơn ở tốc độ rơi/TPS khác nhau. Exact band thuộc `DB-051`.

### 4.1. Primary Attack không được biến mining thành slam ngoài ý muốn

Chỉ một **fresh Attack press edge** sau khi `GROUNDING_ARMED` cue có hiệu lực mới tạo intent. Held Attack từ trước khi rơi, giữ chuột để đào block, key-repeat và press đã bị Free Climb/attack owner consume không được “sống lại”.

Precedence từ cao xuống thấp:

1. Screen/container/chat, Use conflict, item/channel hoặc committed combat action giữ owner hiện tại.
2. `CLIMB_*`/`MANTLE_*`: Grounding `DENY_NO_COST`; Attack không buffer qua lúc thả tường.
3. `FALLING + GROUNDING_ARMED + fresh Attack`: Grounding thắng việc **bắt đầu** một mining swing mới; impact không đào block.
4. Falling nhưng chưa armed/không valid landing: normal aerial attack hoặc vanilla attack/mine owner; Grounding không consume.

Nếu một block-mining transaction đã active từ trước airborne lineage, Grounding không cướp nó baseline. Control profile `DEDICATED_ACTION` luôn khả dụng cho accessibility/precision; setting `CONTEXTUAL_ATTACK` là default candidate. Crosshair cue/body cue phải hiện trước khi contextual Attack đổi nghĩa.

## 5. Action lifecycle

```text
FALLING
  --eligible attack + reserve--> ARREST_ORIENT
ARREST_ORIENT
  --commit trajectory--> DESCENT_COMMIT
DESCENT_COMMIT
  --valid contact--> IMPACT_COMMIT
IMPACT_COMMIT
  → RECOVERY → SUPPORTED
any pre-impact
  --invalid/interrupted--> FALLING with preserved attribution
```

- `ARREST_ORIENT` là hãm bounded để animation/facing đọc được, không đứng yên vô hạn.
- Landing point là prediction, không target lock. Horizontal correction có cap và không kéo player xuyên mép/tường.
- Fall suppression chỉ gắn đúng `transition_id` tại `IMPACT_COMMIT`; miss/reject không đặt immunity global.
- Impact/heal/resource/damage retry idempotent. Một action ID có tối đa một landing conversion và một AoE hit instance.

## 6. Vigor và failure policy

Direction cần prototype:

- action reserve một lượng Vigor nhỏ; người còn ít Vigor vẫn có thể dùng như “last chance” nhưng thành exhausted recovery;
- không cho negative Vigor hoặc logout refill;
- reject trước commit refund; sau trajectory commit áp cost theo action policy;
- hết Vigor do Free Climb là pressure thật, nhưng UI phải báo technique unavailable trước khi player dựa vào nó.

So sánh `full cost`, `minimum-positive last chance` và `bounded overdraw + long recovery` ở `DB-051`; chưa khóa con số.

## 7. Weapon, animation và damage

- Một semantic action dùng adapter theo weapon family: blade, heavy, polearm, ranged-held, catalyst/staff và unarmed fallback.
- Weapon adapter đổi silhouette, impact shape, damage/posture mix và recovery trong một approved envelope; **safety commit/fall-conversion truth không phụ thuộc cosmetic clip**.
- Animation events: accept cue, orient marker, descent commit, impact marker, recovery end. Root motion không sở hữu world position.
- AoE là radial/cone/ring hit có stable action/hit ID, source/owner, friendly-fire/ruleset, vertical band, occlusion rule và target cap.
- Impact mạnh hơn light attack và có diện tích rõ, nhưng tổng output bị cap theo action + weapon profile. Fall energy chỉ chọn bounded intensity tier; extreme fall không nhân damage vô hạn.
- Không phá block/crop/redstone/container, không đào block dưới crosshair, không sinh fire/explosion mặc định. Surface chỉ đổi decal/dust/audio và landing validity.
- VFX dust/decal theo block surface profile; missing effect không mất impact cue. Audio/subtitle/haptic có intensity cap.

| Weapon family | Fantasy/shape direction | Không được làm |
|---|---|---|
| blade | chém bổ + shock arc/radial vừa, recovery cân bằng | hit xuyên tường vì VFX dài |
| heavy | tâm impact/posture cao, vùng rộng hơn nhưng recovery dài | bán kính và damage đều tốt nhất không trade-off |
| polearm | mũi đâm tâm + ring phụ, landing precision cao | khóa mục tiêu/teleport xuống enemy |
| ranged-held | brace/butt/stomp hoặc kinetic burst an toàn | tự bắn ammo/đổi thành ranged AoE miễn phí |
| catalyst/staff | palm/staff seal có visual riêng, cùng physical landing truth | sinh elemental field nếu skill khác chưa sở hữu |
| unarmed/tool/unknown | stomp/palm fallback chuẩn, không dùng mining swing | đào block, durability cost hoặc missing-animation deny safety |

### 7.1. Animation và presentation lifecycle

- `ARMED`: body/crosshair cue nhỏ, không camera snap.
- `ARREST_ORIENT`: co thân/đưa vũ khí vào line, bounded hit-stop-like anticipation nhưng world time/velocity authority không đóng băng vô hạn.
- `DESCENT_COMMIT`: silhouette kéo thẳng về landing corridor; cloth/trail biểu đạt tốc độ, root motion không sở hữu vị trí.
- `IMPACT_COMMIT`: weapon/contact marker đồng bộ hit, dust, bass/transient, camera impulse và landing conversion; server marker thắng nếu clip lệch.
- `RECOVERY`: weapon family có recovery khác trong cap; input buffer chỉ mở ở marker rõ. First-person giảm pitch slam/shake; reduced-motion giảm trail/shake nhưng giữ âm thanh, reticle và body cue.
- Partial block, fluid surface, falling block hoặc candidate mất trước impact dùng adapter/fallback: impact chỉ commit nếu support truth hợp lệ; nếu không, tiếp tục fall và giữ provenance.

## 8. Interaction matrix direction

| Context | Direction |
|---|---|
| Free fall bình thường | eligible theo time-to-impact |
| Rơi do Free Climb slip | eligible nếu còn Vigor/policy; không xóa nguyên nhân slip khỏi trace |
| Đang attached/mantling trên tường | `DENY_NO_COST`; không phải airborne/falling và Attack không được buffer thành Grounding sau này |
| Wall-eject/Drop khỏi tường | chỉ eligible sau transition sang `FALLING`, control hợp lệ và **fresh Attack** trong time-to-impact; Attack đã bấm trên tường không sống lại |
| Sau Aerial Step/Aerial Dodge | chỉ sau commit/recovery edge khi actor thật sự falling; một short Attack buffer có expiry được phép nếu action owner khai |
| Lightness descent | Primary Attack có thể cancel thành Grounding Strike sau guard |
| Knockback/launch của enemy | eligibility theo control state; hard launch/grab có thể deny |
| Lava/fire/hazard landing | impact có thể tránh fall component, không tránh contact/environment damage |
| Water/slime/hay/powder snow | landing adapter tránh double mitigation/bounce |
| Void/no valid ground | deny; không tạo platform/teleport |
| Low ceiling/wall near landing | clearance sweep hoặc reject/fallback fall |
| Multiplayer future | server ground/velocity truth; forged near-ground payload reject |
| Normal aerial attack | nếu Grounding chưa armed thì weapon combat owner thắng; không consume Attack |
| Held mining/Attack | không arm/cast; fresh edge sau cue mới xét |
| Unarmed/tool in hand | stomp/palm fallback; no mining/durability side effect |

## 9. Input, camera và accessibility

- Primary Attack context-transform chỉ active khi cue/eligibility rõ; normal aerial attack path sau này phải có precedence matrix.
- Input edge đã bị Free Climb/attack owner consume hoặc deny khi attached không được reinterpret khi actor rời tường. `GroundingIntent` luôn mang current airborne lineage/action-chain ID và một consumer.
- Alternative dedicated binding được phép cho one-handed/accessibility và người không muốn context transform.
- Input buffer có cap để nhận phản xạ hợp lệ dưới latency nhưng không “bấm từ rất cao rồi auto cứu”. Exact inclusive boundary server trace được.
- Third-person giữ điểm đáp/actor trong frame; camera không snap top-down hoặc tự lock enemy.
- First-person dùng reduced roll/sway và impact cue; setting có thể gợi ý third-person, không bắt buộc auto-switch.
- Accessibility có window assist/predictive cue, không auto-cast; future ranked ruleset có profile riêng nếu cần.
- `GROUNDING_ARMED` cue dùng ít nhất body/reticle + audio tùy profile, không chỉ đổi màu. HUD không thêm thanh thường trực; Vigor preview wake trong window.

## 10. Authority, save và performance

- Runtime action ephemeral; capability/Vigor/cooldown authoritative và versioned.
- Death/portal/reconnect/resource reload cleanup reservation/action; không hồi sinh với fall immunity.
- Debug: velocity, airborne ticks, sweep/landing candidate, time-to-impact, window, cost, transition/hit ID, fall source/conversion.
- Risk `PR-2`: bounded sweep + animation/camera/hit burst. AoE target cap và no per-frame allocation bắt buộc.
- Current target vẫn offline/single-player nhưng chạy qua logical-server truth. Future multiplayer chỉ mở seam: cùng tick hai actor/placement/piston/hit revalidate theo ordered world revision và idempotent action/hit ID; không implement netcode gameplay trong cell này.
- Capability/mode/profile được version/migrate; runtime armed/action không save giữa session. Loader/platform adapters không được chứa weapon/AoE/fall semantics hoặc tạo Fabric-only save branch.
- Localization có action/cue/reject/subtitle keys cho `Armed`, `Không có điểm đáp`, `Thiếu Khí Lực`, `Bị cản`; không chèn tên phím vật lý vào câu và không dựa SFX không subtitle.

## 11. Acceptance hypotheses

- bấm quá sớm/quá muộn/không có ground cho reject/fall outcome nhất quán và đọc được;
- success chỉ suppress đúng fall component của một impact, không lava/void/DoT;
- packet/key repeat chỉ tạo một cost, impact và AoE;
- mọi weapon family + missing asset có fallback không đổi safety;
- low/high FPS, 20 TPS pressure và latency fixture giữ server outcome trong approved tolerance;
- người test hiểu cửa sổ và không thấy action auto-save hoặc cướp attack ngoài context;
- AoE có trọng lượng nhưng cap/occlusion/target/recovery giữ nó không thành farm, xuyên tường, đập block hoặc thay thế skill combat;
- held mining, normal aerial attack, climb Attack và unarmed/tool path luôn chọn đúng consumer, không gây slam bất ngờ.

## 12. Scenario matrix bắt buộc

| ID | Given/When | Oracle |
|---|---|---|
| `GRD-S-001` | rơi sớm/armed window/quá muộn + fresh Attack | chỉ armed fresh edge commit; one cost/action |
| `GRD-S-002` | held Attack/mining trước takeoff, đào block rồi rơi, key-repeat | không auto-slam/cướp transaction |
| `GRD-S-003` | normal aerial attack khi chưa armed rồi armed | combat owner trước; press cũ không sống lại |
| `GRD-S-004` | attached/mantle Attack rồi Drop/eject | deny trên tường; cần fresh airborne Attack |
| `GRD-S-005` | blade/heavy/polearm/ranged/catalyst/unarmed/tool/missing asset | safety parity; adapter shape/damage/recovery đúng cap |
| `GRD-S-006` | nhiều target, sau tường, khác cao độ, ally/tame/Shadow | target cap/occlusion/vertical/friendly rules đúng, one hit ID |
| `GRD-S-007` | extreme fall, Step/Dodge/Lightness/knockback lineage | bounded tier; no infinite damage/fall reset; owner đúng |
| `GRD-S-008` | slab/stair/thin edge/water/lava/slime/hay/powder snow/falling block | support adapter đúng; chỉ fall component được convert |
| `GRD-S-009` | candidate bị piston/place/break đổi trước impact | revalidate; commit hợp lệ hoặc tiếp tục fall, no phantom AoE |
| `GRD-S-010` | hit/grab/death/portal/reconnect/duplicate packet giữa phases | cleanup/idempotent; no ghost immunity/double damage |
| `GRD-S-011` | first/third, reduced motion, contextual/dedicated input | gameplay parity; armed/commit/denied cue đọc được |

## 13. Open decisions

`DB-051`: time-to-impact/armed cue/buffer, contextual-vs-dedicated input, Vigor/last-chance policy, orient/descent/recovery timing, horizontal correction, weapon family shape, bounded fall-energy tier, damage/posture/radius/occlusion/target cap, hit interruption và accessibility assist.
