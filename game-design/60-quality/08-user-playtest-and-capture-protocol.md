# QLT-USER-PLAYTEST — Người dùng test ít nhưng evidence cao

> **DRI:** UX Research Lead + QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Nguyên tắc phân công

Agent tự chạy static/unit/GameTest/integration/simulation/performance có thể tự động. Chỉ gửi user build khi automated pack liên quan xanh hoặc đã nói rõ blocker. User test bốn loại:

1. cảm giác/comfort/agency;
2. comprehension và emotional response;
3. hardware/driver/input/mod interaction Agent không có;
4. lỗi không tái hiện được trong harness.

## 2. Test Card Agent phải chuẩn bị

- `PLAY-ID`, câu hỏi duy nhất và vì sao cần con người;
- commit/build, install/update/backup instructions;
- save fixture hoặc seed, setup tự động tối đa;
- thời lượng mục tiêu 3–15 phút cho một card;
- chính xác input/action cần làm, không dẫn người chơi tới “đáp án cảm giác”;
- capture trigger: khi nào chụp ảnh, quay 10–30s hoặc bấm export diagnostics;
- 2–5 câu trả lời ngắn và stop condition;
- cách rollback/uninstall và nơi evidence được lưu.

## 3. Evidence Bundle tự động

Một nút/command debug nên xuất:

- build/commit, Minecraft/Fabric/Java/mod list/config hash;
- world/seed/dimension/position/game mode;
- recent action/network/state transition trace;
- camera mode/target/ray/obstruction state nếu liên quan;
- recent error log/performance sample;
- screenshot tự động và optional rolling video marker;
- anonymization trước khi chia sẻ.

User không phải tự tìm log hoặc mô tả mọi setting từ trí nhớ.

## 4. Cách user báo nhanh

Tối thiểu: `PLAY-ID`, kết quả `Đạt / Không đạt / Không chắc`, một câu “tôi mong đợi… nhưng thấy…”, và ảnh/video ở capture trigger nếu cần. Agent dùng bundle để điều tra; không bắt user lặp lại toàn flow nếu logs đã đủ.

## 5. Camera/combat feel card mẫu

- Chạy một hành lang, lùi sát tường, quay quanh target, mine/place hai block, đánh–dodge ba lần.
- Báo số lần cảm thấy đang “đánh nhau với camera”, lúc mất target/actor và mức say/khó chịu 0–4.
- Chụp/clip chỉ khi camera xuyên/rung, reticle chọn sai hoặc input khác mong đợi; diagnostic marker tự ghi state.

## 6. Safety

Không dùng save chính cho migration/destructive test nếu chưa có backup + restore proof. Không yêu cầu user cài tool/driver lạ, tắt bảo mật hoặc gửi dữ liệu riêng tư. Một failure nghiêm trọng dừng card và bảo toàn artifact.
