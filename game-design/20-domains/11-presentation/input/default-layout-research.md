# RES-INPUT-LAYOUT — Default control layout research

> **Owner:** UX/Input Designer
> **Status:** `DISCOVERY`

## 1. Câu hỏi quyết định

1. Dodge cần thumb key, mouse key hay tap/hold trên sprint để vừa giữ mọi hướng?
2. Light/heavy/skill/lock-on/aim/command chia mouse–keyboard thế nào mà không cướp mining/building?
3. `1–9` tiếp tục là hotbar trong exploration/combat hay cần contextual loadout/wheel?
4. Camera-relative movement, facing, soft-target và precision aim làm thay đổi nhu cầu ngón tay nào?
5. Người chơi một tay, bàn phím không US và chuột hai nút có layout hoàn chỉnh nào?

## 2. Ma trận công thái học bắt buộc

Mỗi candidate được chấm theo:

- có giữ được `W/A/S/D` và xoay camera cùng lúc;
- finger collision khi dodge tiến/lùi/trái/phải;
- tần suất, thời gian phản ứng, hold duration và accidental activation;
- tương tác với jump/sprint/sneak/attack/use/hotbar;
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
3. Thêm hold/toggle variants, aim/lock candidate và hotbar pressure.
4. Chạy scripted input trace để phát hiện lost/duplicate/stuck actions.
5. Human test blind: error rate, response time, finger discomfort, remap comprehension và preference.

Không khóa default trước bước 2. Không mở rộng skill roster trước khi layout có đường scale hoặc wheel/context solution được chứng minh.
