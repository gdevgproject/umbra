# QLT-AUTOMATION-BOUNDARY — Máy chứng minh gì, khi nào cần người

> **DRI:** Test Architecture Lead + UX Research Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Evidence capability matrix

| Claim | Máy có thể chứng minh | Máy không tự kết luận |
|---|---|---|
| Input/action | key/action registry, context precedence, stuck/duplicate/lost intent, server result | bàn phím vật lý/layout/driver cụ thể có thoải mái không |
| Movement/combat | position/velocity/state/timing/damage/cooldown, bot script, hit cadence | weight, mastery, panic clarity, fun |
| Camera | transform/ray/target/occlusion trace, fixed-pose screenshots, collision incidents | say camera, predictability và “đánh nhau với camera” cảm nhận |
| UI/localization | tree/focus/navigation, key parity, placeholder, overflow heuristic, screenshots | hierarchy có trực giác, style có đẹp/đúng fantasy không |
| Animation/VFX | marker/state/clip existence, frame capture, clipping/overdraw metrics | anticipation/impact có thuyết phục, spectacle có mệt không |
| Audio | event/concurrency/file/loudness-range/priority checks | mix cảm xúc trên tai nghe/loa/phòng thật |
| Save/version | round-trip, migration, checksum, fault injection, restore fixture | user có hiểu cảnh báo/khôi phục dưới áp lực không |
| Quest/onboarding | state transition, objective/reward idempotency, scripted completion | meaning, pacing, surprise, attachment và nhớ lâu |
| Performance | frame/tick/GC/I/O/network/cardinality, regression attribution, soak trend | “mượt đủ” trên mọi máy chưa có profile; cảm giác chấp nhận trade-off presentation |

## 2. Screenshot/clip policy

Client GameTest có thể chụp screenshot cho camera/UI/render. Screenshot baseline phù hợp geometry, visibility, clipping, deterministic layout và regression lớn; không dùng pixel-perfect threshold mù với GPU/font/particle nondeterminism. Dùng vùng quan tâm, state trace và tolerance; backend/OS khác có baseline group riêng.

Video/frame sequence cần cho motion/transition nhưng vẫn không biến cảm giác thành automated fact. Auto capture luôn kèm build, seed, pose/camera state, GUI scale, locale, graphics backend và scenario ID.

## 3. Escalation algorithm

1. Xác định claim và oracle máy phù hợp.
2. Nếu thiếu observability lặp lại, ưu tiên thêm debug hook/harness thay vì nhờ user mãi.
3. Gán `PR-0–PR-3` theo `QLT-TEST`, rồi chạy static→unit/model→server/client→integration→perf/compat lanes liên quan.
4. Chỉ nhờ user khi claim vốn chủ quan, phụ thuộc hardware/physical input, hoặc instrumentation cost vượt giá trị cho một sự cố hiếm.
5. Gửi một Test Card có một câu hỏi; không gửi build “chơi thử xem có lỗi gì không”.
6. Từ evidence user, Agent cố tự reproduce và biến bug lặp lại thành regression tự động.

## 4. Stop conditions

Không gửi user test nếu build không load, automated oracle đỏ, save chính chưa backup, diagnostics không capture vùng nghi ngờ hoặc Agent chưa biết câu trả lời của user sẽ thay quyết định nào. Human playtest không phải bug crawler miễn phí.

Performance phụ thuộc phần cứng chỉ được nhờ user sau controlled runner/automated pack phù hợp. Test Card phải ghi graphics backend/settings, scene ID, capture command/overlay và một câu hỏi; không yêu cầu user tự chẩn đoán bottleneck.
