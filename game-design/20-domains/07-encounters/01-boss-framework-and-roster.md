# SYS-BOSS-ENCOUNTER — Framework và roster

> **DRI:** Encounter Designer
> **Status:** `DISCOVERY`

## Phase contract

Phase đổi câu hỏi người chơi phải trả lời; không chỉ tăng stat ở mốc HP. Transition có cue, safe policy và persistence. Move selection tuân cooldown, spatial validity, anti-repeat và pressure budget.

## Quality bars

- Telegraph đa kênh đủ sớm cho mastery band mục tiêu.
- Camera góc một và ba đều thấy cue trọng yếu.
- Hitbox khớp presentation và debug được.
- Có punish window sau commitment; boss không chain vô hạn.
- Build khác nhau có đường giải, dù hiệu quả không bằng nhau.
- Capture/reward thay đổi lựa chọn sau encounter.
- Mỗi move có combat question, counter set, spatial validity, recovery và quan hệ với move khác; phase đổi grammar/câu hỏi, không chỉ nối thêm clip.
- Attempt sau phải có thể biểu hiện learning delta qua nhận diện cue, timing, vị trí, resource hoặc tool choice; death không chỉ báo “thiếu chỉ số”.
- Difficulty/assist thay đổi margin hoặc gánh nặng thực hiện minh bạch nhưng giữ lesson cốt lõi; không hidden rubber-band hoặc đọc input.
- Animation, VFX, SFX, music và arena tạo anticipation/impact/awe nhưng threat priority vẫn đọc được với player + 0/1/2/4 Shadow.

## Decomposition bắt buộc

“Một boss” là Content Instance lớn, không phải một Feature Cell hay một ticket. Trước production, Boss Teaching Card phải dẫn tới các cell/contract độc lập khi có lifecycle riêng: move/action kit, AI selection/pattern memory, phase/arena/objective, camera/target framing, animation–hit alignment, audio/VFX cue, reward/capture, difficulty/accessibility và retry/save/recovery. `DB-055` sở hữu Gate Boss Challenge Framework; từng boss (`DB-014` cho Iron Knight) chỉ điền instance sau khi framework và dependency liên quan đủ evidence.

## Roster planning

Roster matrix phải phủ lesson: spacing, dodge direction, parry timing, add control, posture, projectile/cover, command, resource, environmental read và multi-phase adaptation. Hai boss không được cùng lesson chỉ vì asset khác.
