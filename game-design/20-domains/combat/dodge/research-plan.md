# FEAT-COMBAT-DODGE — Research và prototype plan

> **Status:** `PLANNED`
> **Decision owner:** Combat Designer

## 1. Câu hỏi nghiên cứu

1. Với Minecraft có cả góc 1 và góc 3, mô hình direction/neutral nào cho cảm giác chủ động nhất mà không gây chóng mặt?
2. Dodge nên thắng nhờ i-frame, displacement hay kết hợp theo threat category nào?
3. Cancel/commitment nào giữ combat responsive nhưng không biến đòn nặng thành vô rủi ro?
4. Resource nào tạo nhịp tốt mà không chặn sandbox hoặc khuyến khích spam?
5. Prediction/feedback nào khiến người chơi tin timing trong server tick/latency thực tế?

## 2. Nhóm tham chiếu cần so sánh

Không chọn game vì nổi tiếng; chọn vì đại diện một solution archetype.

| Nhóm | Nguồn candidate | Điều quan sát, không sao chép |
|---|---|---|
| action RPG camera thứ ba | Genshin Impact, NieR: Automata, Elden Ring | direction, neutral, lock-on, i-frame readability, stamina/cooldown |
| combat commitment nặng | Monster Hunter, Dark Souls/Elden Ring | startup/commit/recovery/cancel và roll catch công bằng |
| top-down/high readability | Hades, Diablo IV | threat density, dash charge, hazard category, cue |
| high mobility | Warframe, Guild Wars 2 | chaining, collision, resource abuse, camera |
| Minecraft combat mods | các mod hiện hành sau khi xác minh version | key conflict, first-person animation, tick/server, vanilla coexistence |
| base Minecraft | bản platform target đã xác minh | attack cooldown, sprint/shield/item, collision, swimming/crawl/vehicle |

Mỗi nguồn tạo Research Card riêng. Tối thiểu một nguồn phải cho thấy solution **không phù hợp**, để tránh confirmation bias.

## 3. Prototype ladder

### P0 — Greybox input/collision

- capsule/box đại diện, không art;
- ba direction option;
- test grid wall/corner/stair/edge/air/water;
- mục tiêu: loại solution gây mất control hoặc phá Minecraft collision.

### P1 — Paired attack/dodge timeline

- một light beat, một heavy commitment, một enemy telegraph;
- cancel matrix có debug overlay;
- mục tiêu: responsive vs weight, chống click/dodge spam.

### P2 — Defensive categories

- melee, projectile, AoE, lingering hazard, grab;
- displacement-only vs window-only vs hybrid;
- mục tiêu: người chơi dự đoán được rule sau tutorial ngắn.

### P3 — Resource/reward

- ít nhất hai option: Focus cost; cooldown/charge hoặc hybrid;
- perfect dodge variants: feedback-only, positional/combo reward, resource reward;
- mục tiêu: không có dominant spam loop, không gây wait-to-play.

### P4 — Camera/network/accessibility

- first/third person, latency 0–200ms, prediction on/off;
- reduced motion, shake off, cue audio/visual;
- mục tiêu: parity rule và trust.

## 4. Playtest questions

- Bạn định né hướng nào và nhân vật đã đi hướng nào?
- Vì sao đòn vừa rồi trúng/không trúng?
- Khi nào bạn cảm thấy cú đánh của mình đã “cam kết” và không nên né hủy?
- Bạn có chờ Focus hồi thay vì chơi không? Có spam vì không hiểu cost không?
- Góc nhìn nào làm bạn mất phương hướng?
- Khi tắt rung/chuyển động mạnh, bạn còn nhận ra timing không?

Đo hành vi và hỏi lại sau khi chơi; không giải thích rule trước rồi hỏi “có hiểu không”.

## 5. Decision outputs

Research/prototype phải tạo hoặc đóng:

- `ADR-DODGE-DIRECTION`;
- `ADR-DODGE-DEFENSE-CATEGORIES`;
- `ADR-ACTION-CANCEL-POLICY`;
- `ADR-DODGE-RESOURCE-REWARD`;
- `CTR-CAMERA-TARGET`, `CTR-ACTION-TIMELINE`, `CTR-COMBAT-HIT` phiên bản Proposed;
- scenario expected results và parameter ranges có evidence.

Không tạo final animation/VFX hoặc implementation ticket trước các output trên.

