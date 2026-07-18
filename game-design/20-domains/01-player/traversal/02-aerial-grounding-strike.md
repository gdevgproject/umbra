# FEAT-AERIAL-GROUNDING-STRIKE — Hạ Kình khi rơi

> **DRI:** Combat Traversal Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat, Animation, Camera, Input, VFX/Audio, World, Balance, Accessibility, QA
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi đã học kỹ thuật, đang rơi về một vùng đáp hợp lệ và bấm Primary Attack trong cửa sổ có thể đọc, game chấp nhận một Hạ Kình: hãm/quy hướng ngắn, lao xuống theo animation vũ khí, commit một impact nhẹ và chuyển fall damage của chính cú đáp thành landing an toàn.

## 2. Ý định được giữ và giới hạn

Giữ đúng fantasy người dùng:

- kỹ thuật phản xạ, không auto-save;
- có khoảnh khắc hãm/xoay/đập xuống đẹp;
- dùng vũ khí hiện tại hoặc fallback không vũ khí;
- impact nhẹ quanh điểm đáp;
- success cho landing an toàn.

Không biến thành:

- nút miễn mọi lava/void/grab/scripted lethal;
- AoE damage lớn hơn active combat skill;
- block-break/grief tool;
- infinite hover hoặc reset vertical height;
- client tự khai gần đất để xóa damage.

## 3. Unlock và role

- Universal passive technique, mở sớm sau Light Attack + fall teaching; không chiếm skill slot và không là Potential.
- Level chỉ là eligibility candidate; một training beat ngắn dạy cue/time-to-impact và thất bại an toàn ở độ cao thấp.
- Role chính: `landing conversion`; role phụ: `light space payoff`. Damage không phải lý do chính để spam nhảy.
- Implementation snapshot dùng capability grant; production quest delivery chỉ khi Quest Kernel sẵn sàng.

## 4. Eligibility

Server chỉ accept `GroundingIntent` khi:

- capability unlocked, actor alive/controlled và đang `AIRBORNE/FALLING`;
- downward velocity/airborne history đủ để hành động có nghĩa;
- bounded ground sweep dự đoán một landing candidate trong time-to-impact band;
- actor không ở Creative/Spectator flight, Elytra, swim, riding, climb attach, grab/knockdown hoặc hard-committed action;
- Vigor/transaction rule hợp lệ;
- Primary Attack context không bị UI/mining/use/another committed attack sở hữu.

Cửa sổ dựa **time-to-impact + velocity**, không chỉ “cách đất X block”, để ổn định hơn ở tốc độ rơi/TPS khác nhau. Exact band thuộc `DB-051`.

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
- Weapon adapter chỉ đổi pose/contact presentation và damage profile được duyệt; không đổi safety timing tùy cosmetic clip.
- Animation events: accept cue, orient marker, descent commit, impact marker, recovery end. Root motion không sở hữu world position.
- AoE là một radial/shape hit có stable action/hit ID, source/owner, friendly-fire/ruleset và target cap.
- Baseline damage nhẹ/posture nhỏ; không phá block/crop/redstone/container và không sinh fire/explosion.
- VFX dust/decal theo block surface profile; missing effect không mất impact cue. Audio/subtitle/haptic có intensity cap.

## 8. Interaction matrix direction

| Context | Direction |
|---|---|
| Free fall bình thường | eligible theo time-to-impact |
| Rơi do Free Climb slip | eligible nếu còn Vigor/policy; không xóa nguyên nhân slip khỏi trace |
| Lightness descent | Primary Attack có thể cancel thành Grounding Strike sau guard |
| Knockback/launch của enemy | eligibility theo control state; hard launch/grab có thể deny |
| Lava/fire/hazard landing | impact có thể tránh fall component, không tránh contact/environment damage |
| Water/slime/hay/powder snow | landing adapter tránh double mitigation/bounce |
| Void/no valid ground | deny; không tạo platform/teleport |
| Low ceiling/wall near landing | clearance sweep hoặc reject/fallback fall |
| Multiplayer future | server ground/velocity truth; forged near-ground payload reject |

## 9. Input, camera và accessibility

- Primary Attack context-transform chỉ active khi cue/eligibility rõ; normal aerial attack path sau này phải có precedence matrix.
- Alternative dedicated binding được phép cho one-handed/accessibility và người không muốn context transform.
- Input buffer có cap để nhận phản xạ hợp lệ dưới latency nhưng không “bấm từ rất cao rồi auto cứu”. Exact inclusive boundary server trace được.
- Third-person giữ điểm đáp/actor trong frame; camera không snap top-down hoặc tự lock enemy.
- First-person dùng reduced roll/sway và impact cue; setting có thể gợi ý third-person, không bắt buộc auto-switch.
- Accessibility có window assist/predictive cue, không auto-cast; future ranked ruleset có profile riêng nếu cần.

## 10. Authority, save và performance

- Runtime action ephemeral; capability/Vigor/cooldown authoritative và versioned.
- Death/portal/reconnect/resource reload cleanup reservation/action; không hồi sinh với fall immunity.
- Debug: velocity, airborne ticks, sweep/landing candidate, time-to-impact, window, cost, transition/hit ID, fall source/conversion.
- Risk `PR-2`: bounded sweep + animation/camera/hit burst. AoE target cap và no per-frame allocation bắt buộc.

## 11. Acceptance hypotheses

- bấm quá sớm/quá muộn/không có ground cho reject/fall outcome nhất quán và đọc được;
- success chỉ suppress đúng fall component của một impact, không lava/void/DoT;
- packet/key repeat chỉ tạo một cost, impact và AoE;
- mọi weapon family + missing asset có fallback không đổi safety;
- low/high FPS, 20 TPS pressure và latency fixture giữ server outcome trong approved tolerance;
- người test hiểu cửa sổ và không thấy action auto-save hoặc cướp attack ngoài context;
- damage nhẹ không trở thành cách farm/đập block/né encounter tối ưu.

## 12. Open decisions

`DB-051`: time-to-impact band/buffer, Vigor/last-chance policy, orient/descent/recovery timing, horizontal correction, weapon adapters, damage/posture profile, hit interruption và accessibility assist.

