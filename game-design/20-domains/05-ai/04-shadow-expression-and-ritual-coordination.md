# SYS-SHADOW-EXPRESSION — Biểu cảm, nghi lễ và hiện diện xã hội của Shadow

> **DRI:** AI Designer + Narrative Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Shadows, Animation, Audio, UX, Accessibility, Localization, Platform, Performance, QA
> **Status:** `DISCOVERY`

## 1. Player outcome

Người chơi cảm thấy từng Shadow **nhận biết mình, nhận biết đồng đội và hiểu ý nghĩa khoảnh khắc**. Cú quỳ, cú cúi đầu, khoảng lặng, ánh nhìn, tiếng đáp lệnh hay phản ứng sau chiến thắng phải làm tăng kính trọng/gắn kết—không biến đội hình thành robot đồng loạt phát emote.

Pillar chính: `PIL-ATTACHMENT`. Pillar phụ: `PIL-ASCENDANCE`, `PIL-BELONGING`. Failure mode cảm xúc: nghi lễ bị spam đến mức rẻ tiền, Shadow diễn sai lúc nguy hiểm hoặc mọi personality dùng cùng một animation.

## 2. Ba lớp tách biệt

```text
authoritative semantic event + relationship/personality facts
→ expression arbitration + group reservation
→ presentation profile: body/face/gaze/voice/VFX/subtitle
```

- **Gameplay/social truth:** logical server sở hữu event, bond/memory, command acknowledgement và điều kiện hợp lệ.
- **Arbitration:** chọn ai phản ứng, semantic nào, priority, thời lượng, cooldown và interruption; không tự đổi gameplay rule.
- **Presentation:** client chọn asset tương thích hình thể/camera/locale/accessibility. Thiếu face rig/voice/clip phải fallback an toàn chứ không mất acknowledgement.

Không lưu animation frame/timer như identity memory. Chỉ lưu milestone/relationship fact có hậu quả lâu dài.

## 3. Semantic vocabulary

| Semantic | Context hợp lệ | Biểu đạt cơ sở | Không được làm |
|---|---|---|---|
| `FIRST_BOND_OATH` | Trỗi Dậy hoàn tất lần đầu | nghi lễ kết ước riêng archetype | dùng lại như chào thường |
| `SOVEREIGN_ACKNOWLEDGE` | nhận direct command hợp lệ | nhìn về player + dấu hiệu xác nhận ngắn | khóa action trong combat |
| `MAJOR_FEALTY_RITE` | breakthrough/rank/ending quan trọng | quỳ/cúi sâu/stance tương đương | phát ở mọi level-up |
| `ASSEMBLE` | summon/formation tại safe window | vào vị trí, nhìn leader/anchor | cả đội chen cùng một điểm |
| `VICTORY_RELEASE` | encounter thật sự kết thúc | thở, hạ vũ khí, phản ứng tính cách | ăn mừng khi còn threat/objective |
| `PLAYER_DISTRESS` | player bị thương/nằm xuống | bảo vệ, gọi, lo lắng/giận dữ | bỏ command/objective nguy cấp |
| `ALLY_SHATTERED` | đồng đội Tán Vỡ | glance/bark/role response | grief animation dài giữa telegraph |
| `REUNION_RETURN` | revive/return/home | chào đón có quan hệ | phát đồng loạt mỗi summon |
| `IDLE_SOCIAL` | hub/home, threat thấp | gaze, spacing, banter, shared activity | loop liên tục cạnh player |
| `REFUSAL_OR_LIMIT` | lệnh bất khả thi/cooldown | phản hồi lý do đa kênh | im lặng hoặc giả đã làm |

Content có thể thêm semantic mới qua registry; không hard-code mỗi quest thành nhánh AI riêng.

## 4. Chính sách quỳ và kính trọng

- **Quỳ là dấu câu hiếm**, dành cho `FIRST_BOND_OATH`, `MAJOR_FEALTY_RITE` hoặc nghi lễ authored có ý nghĩa tương đương. Không quỳ mỗi khi summon, nhận lệnh, player đi ngang hoặc thắng mob thường.
- Semantic kính trọng không ép cùng một hình thể: hiệp sĩ có thể quỳ một gối; nhân vật kiêu hãnh đặt tay lên ngực/cúi đầu; thú hạ đầu/thân; thực thể bay hạ độ cao/xếp cánh. Ý nghĩa nhất quán, biểu đạt theo identity.
- Bond không đồng nghĩa xóa personality. Shadow trung thành vẫn có nhịp điệu, khoảng cách, giọng và mức trang trọng riêng; không dùng “bất tuân ngẫu nhiên” để chứng minh cá tính.
- Nghi lễ không tạo buff ẩn. Nếu một rite có gameplay reward, reward phải thuộc Feature/Resource contract và được communicate riêng.

## 5. Group coordination thay vì emote spam

Một `Expression Coordinator` cấp Retinue thực hiện:

1. lọc semantic theo threat/action/camera/context;
2. chọn lead responder theo relationship, role, recency và visibility;
3. reserve attention/position/voice channel/interaction slot;
4. cho tối đa một phản ứng chính và số phản ứng phụ theo presentation budget;
5. stagger, cancel hoặc downgrade thành glance/short bark khi nhiều event tranh nhau;
6. log reason code cho selected/suppressed/interrupted behavior.

Không dùng random thuần để chọn mọi phản ứng. Cooldown áp theo semantic + actor + group; milestone authored có thể override nhưng vẫn phải qua safety/interrupt policy.

## 6. Priority và interruption

```text
safety/legal action
> dangerous telegraph/combat command acknowledgement
> objective/relationship critical beat
> milestone ritual
> reunion/victory
> idle social
```

- Casual/milestone expression không bắt đầu khi actor đang attack, dodge, path qua hazard, giữ target quan trọng hoặc threat chưa clear.
- Gameplay threat có quyền cắt presentation; interruption blend về locomotion/guard an toàn và không commit relationship event hai lần.
- Direct command cần acknowledgement trong latency/readability budget, nhưng có thể dùng gaze/icon/audio thay vì full-body clip.

## 7. Personality, relationship và face

Mỗi presentation profile khai body topology, formality band, energy, preferred distance, gaze ability, voice/subtitle set, facial capability và fallback. Relationship ảnh hưởng **semantic selection/intensity**, không nhân số state vô hạn.

Facial animation là enhancement theo asset tier:

1. silhouette/posture/orientation;
2. head/gaze/gesture;
3. voice/SFX/VFX + subtitle;
4. face/eye micro-expression nếu rig và camera distance cho phép.

Tier 1–3 phải đủ truyền ý nghĩa. Không giữ camera ép zoom vào mặt, không yêu cầu humanoid face cho mọi Shadow và không để thiếu facial asset block Feature Cell nền.

## 8. Hai camera, UX và accessibility

- Góc ba ưu tiên full-body readability và group spacing; camera không tự cướp quyền để đóng khung một emote thường.
- Góc một dùng hướng nhìn, âm thanh định vị, subtitle/speaker indicator và gesture nằm trong field-of-view hợp lý; không teleport Shadow vào khung hình.
- Player có control riêng cho social frequency/voice repetition/subtitle và reduced social motion; giảm presentation không làm mất command/error acknowledgement.
- Mọi bark/text có `vi_vn` và `en_us`; semantic ID không phụ thuộc câu chữ.
- Cue quan trọng có ít nhất hai kênh khi có thể; personality không được làm accessibility option thay đổi gameplay outcome.

## 9. Authority, save, performance và compatibility

- Client không được giả event kính trọng để tăng bond/reward; server xác nhận semantic và persistent consequence.
- Future co-op cần xác định addressee/ownership và relevance; không broadcast social event tới mọi client/world actor.
- Scheduler event-driven, có per-frame/tick work cap, animation/voice concurrency budget và spatial query hữu hạn; không scan toàn roster mỗi tick.
- Resource reload/missing animation/loader backend dùng semantic fallback; không crash hoặc kẹt AI state.
- AI trace ghi semantic, context facts, candidate, rejection, chosen asset profile, interruption và fallback reason.

## 10. Validation matrix

- First bond, summon, command success/failure, victory, player distress, ally Tán Vỡ, revive, home idle và major breakthrough.
- 1/2/4 active Shadow; năm member tại home; humanoid/beast/flying profile; first/third person.
- Hai event cùng tick, threat xuất hiện giữa rite, save/reload, death, dimension unload, resource reload và missing asset.
- `vi_vn`/`en_us`, subtitles off/on, reduced motion, no-audio, repeated-event soak và voice/animation cap.
- Human proof: người chơi nhận ra semantic và personality; quỳ vẫn “đắt” sau nhiều giờ; expression không gây cản control/camera.

## 11. Open decisions có owner

- `DB-045`: semantic set tối thiểu cho C5/C7, personality variants, cooldown bands, home interaction grammar và exemplar animation/audio package.
- Animation/Art: body topology/facial tiers và authoring cost sau asset exemplar.
- UX Research: tần suất nào tăng attachment mà không thành lặp; chỉ khóa bằng playtest, không bằng số bịa.

