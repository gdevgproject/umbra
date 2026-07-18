# PROD-SCOPE — Phạm vi, đóng gói và chiến lược phát triển luôn chơi được

> **DRI:** Producer + Game Director + Technical Director
> **Status:** `PROPOSED`

## 1. Hai khái niệm không được trộn

- **Playable Development Snapshot:** bản nội bộ cho chủ dự án chạy/chơi/test sau mỗi capability; có thể rất nhỏ nhưng không làm hỏng world/save đã hỗ trợ.
- **Public 1.0:** sản phẩm công khai chỉ khi full coherent promise đã chọn đạt quality bar. Không gọi một prototype là “release” chỉ vì chạy được.

UMBRA không cần Early Access để ép lịch. Tuy nhiên mainline phải có nhịp “luôn có bản chạy được”, tránh hàng tháng xây hạ tầng không có proof và tránh dồn integration tới cuối.

## 2. Scope ladder

| Cấp | Chứng minh | Playable contract |
|---|---|---|
| Technical Spike | một API/rủi ro, có thể bỏ | không nhập mainline nếu không có cleanup/decision |
| Interaction Prototype | một câu hỏi control/camera/feel | world test cô lập, không hứa save compatibility |
| Feature Prototype | một mechanic có contract | feature flag, debug harness, teardown rõ |
| Capability Snapshot | input→rule→feedback→save/test | mainline chạy được, regression set xanh |
| Core Loop Snapshot | survival/prepare→activity→reward→return | một save nội bộ có đường chơi coherent |
| Identity Snapshot | defeat→Arise→identity→fight/return | fantasy khác biệt của UMBRA được chứng minh |
| Alpha | mọi xương sống nối qua vertical slices | save migration bắt đầu được support nội bộ |
| Beta | feature scope khóa, content/polish/compatibility | không thêm system mới nếu không gate lại |
| Public 1.0 | full announced promise | release, support, migration, install và recovery đạt |

## 3. Always-Playable Mainline policy

Mỗi capability phải:

- bật/tắt bằng capability/config boundary khi hợp lý;
- không để UI/item/recipe/content nửa hoàn thành lộ vào normal play;
- có default/missing-content fallback;
- ghi schema version và migration ngay khi state bắt đầu được support;
- chạy integrated single-player và dedicated smoke test;
- có safe world backup/restore trước migration nguy hiểm;
- kết thúc bằng một named snapshot/tag candidate sau khi test;
- giữ `main` ở trạng thái compile, load world, save/reload và quit sạch.

“Chơi được từng phase” không có nghĩa mọi phase fun như game hoàn chỉnh. Foundation phase phải có proof scene/debug world; feature phase phải có player-visible micro-loop.

## 4. Product scope stack

### Foundation bắt buộc dù người chơi ít nhìn thấy

Logical server authority, stable IDs/content registry, save/migration/recovery, capability flags, input contexts, third-person camera seam, action/hit cadence, localization, observability, automated tests, performance budgets và compatibility adapters.

### Core identity của public product

- Minecraft survival/build/explore còn ý nghĩa.
- Third-person action embodiment chuyên nghiệp; first-person parity về luật.
- Combat công bằng chống click/packet spam.
- Gate persistent có objective/leave/death/reconnect đúng.
- Progression/build có lựa chọn và breakthrough nhìn thấy.
- Trỗi Dậy một đối thủ đáng nhớ thành Shadow identity lâu dài.
- Command/squad có chiều sâu và performance-safe.
- Một nơi trở về, xã hội và narrative phản chiếu hậu quả.
- Content/economy/endgame đủ breadth cho hành trình full promise được khóa sau vertical slices.

### Expansion seams được chuẩn bị, không implement sớm

Co-op/PvP/server society, mount nước/bay, vehicle, aquatic civilization, thêm dimension/Strata, add-on content packs, controller, replay/photo/streamer và social routes. Chuẩn bị bằng owner IDs, authority, content contracts và adapters—không bằng empty interfaces cho mọi ý tưởng tưởng tượng được.

## 5. 1.0 scope policy

Vision ceiling hiện gồm F→Vương Giả, campaign ba hồi, nhiều faction/boss, Gate/Red/Break, Tower/Strata, Shadow Legion, city/home/family và items/economy. Đây là đích game; số boss/faction/floor chính xác chỉ khóa sau khi camera–combat–Gate–Shadow vertical slices cung cấp production cost thật.

Nếu phải giảm breadth, giảm số instance trước khi cắt depth của identity/core loop. Một boss/Shadow/faction sâu tốt hơn nhiều reskin. “Full game” nghĩa lời hứa đã công bố hoàn chỉnh, không nghĩa mọi ý tưởng tương lai đã có mặt.

## 6. Add-on và all-in-one philosophy

UMBRA hướng tới đủ đầy để không **bắt buộc** cài mod khác. Điều đó không cấm compatibility/add-on:

- core gameplay không phụ thuộc add-on;
- data/content extension dùng contract/version/validation;
- integration với mod khác là adapter best-effort hoặc supported matrix có test;
- vehicle/mount/structure feature mới phải vào đúng domain, không chen patch trực tiếp vào combat/world state;
- không xây “universal API” trước khi có ít nhất hai consumer thật.

## 7. Ranh giới sản phẩm

- Không monetization gameplay, battle pass, daily login hoặc false scarcity.
- Không permadeath Shadow/family để ép cảm xúc.
- Không ép campaign tuyến tính phá sandbox.
- Không dùng “future-proof” để overengineer implementation hiện tại.
- Không công bố version/platform/mod support trước compatibility evidence.
- Không nhập ticket nếu không có playability/recovery/test contract tương ứng.
