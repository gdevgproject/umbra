# RES-INPUT-LAYOUT — Default control layout research

> **Owner:** UX/Input Designer
> **Status:** `DISCOVERY`

## 1. Câu hỏi quyết định

1. Dodge cần thumb key, mouse key hay tap/hold trên sprint để vừa giữ mọi hướng?
2. Light/heavy/skill/lock-on/aim/command chia mouse–keyboard thế nào mà không cướp mining/building?
3. `1–9` tiếp tục là hotbar trong exploration/combat hay cần contextual loadout/wheel?
4. Camera-relative movement, facing, soft-target và precision aim làm thay đổi nhu cầu ngón tay nào?
5. Người chơi một tay, bàn phím không US và chuột hai nút có layout hoàn chỉnh nào?
6. Contextual Jump/Sneak cho Free Climb phân biệt jump-to-wall, build/pillar, auto-jump, dismount/swim và Drop ra sao mà mỗi press vẫn dự đoán được?
7. Neutral hold Jump cho Khinh Công phân biệt tap Jump/Climb Leap ra sao; ngưỡng nào còn responsive và khi nào phải dùng dedicated/toggle profile?
8. Fresh Attack cho Hạ Kình phân biệt held mining, normal aerial attack và armed window ra sao; dedicated alternative nằm ở đâu?
9. Future airborne Jump/Dodge giữ 360° direction trong khi Step↔Dodge chain mà không tạo double-consumer hoặc finger collision nào?

## 2. Ma trận công thái học bắt buộc

Mỗi candidate được chấm theo:

- có giữ được `W/A/S/D` và xoay camera cùng lúc;
- finger collision khi dodge tiến/lùi/trái/phải;
- tần suất, thời gian phản ứng, hold duration và accidental activation;
- tương tác với jump/sprint/sneak/attack/use/hotbar;
- one-edge-one-consumer, pre-held modifier, auto-jump và external-mode precedence;
- tap/hold threshold, armed cue, short buffer, key-repeat/deduplication và context switch giữa ground–wall–air;
- mỏi sau encounter dài và panic reach;
- bàn phím nhỏ/laptop/AZERTY/QWERTZ, left-handed và mouse 2-button;
- remap discoverability, conflict và accessibility alternative.

Ví dụ: gán Dodge vào `R` làm ngón trỏ khó giữ `D` đồng thời; vì vậy `R` có thể hợp reload/skill ít phụ thuộc hướng hơn nhưng không được mặc định là Dodge chỉ vì đang trống.

## 3. Reference method

Nghiên cứu ít nhất ba archetype: action RPG lock/soft-target, free-aim third-person và Minecraft-like sandbox. Ghi video/timecode/build/platform; trích nguyên lý về reach, chord, context và feedback—không chép nguyên layout vì hotbar/building của Minecraft tạo constraint khác.

GTA V là ví dụ hữu ích về context-sensitive controls và extensive remap, không phải đáp án trực tiếp. [Rockstar control guidance](https://www.rockstargames.com/newswire/article/51974aa3a724o2/rockstar-game-tips-tailoring-your-settings-and-controls-in)

## 4. Prototype sequence

1. Graybox movement + camera + mine/place, chưa combat.
2. Thêm light attack và bốn hướng Dodge; so sánh tối thiểu ba layout.
3. Thêm Free Climb + neutral tap/hold Lightness + Grounding armed Attack; so contextual/dedicated/toggle profiles trước khi khóa gesture.
4. Thêm hold/toggle variants, aim/lock candidate, future Step/Dodge chain và hotbar pressure.
5. Chạy scripted input trace để phát hiện lost/duplicate/stuck actions.
6. Human test blind: error rate, response time, finger discomfort, remap comprehension và preference.

Không khóa default trước bước 2. Không mở rộng skill roster trước khi layout có đường scale hoặc wheel/context solution được chứng minh.
