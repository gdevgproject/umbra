# SYS-DEATH-RECOVERY — Death, consequence và trở lại cuộc chơi

> **DRI:** Systems Designer
> **Approver:** Game Director
> **Reviewers:** Combat, Shadows, Dungeon, Platform, UX, QA
> **Status:** `PROPOSED`

## 1. Player promise

Death phải làm người chơi muốn tránh lần chết tiếp theo, hiểu điều đã xảy ra và thay đổi cách chuẩn bị; nó không được xóa công sức dài hạn hoặc tạo vòng xoáy “càng chết càng không thể hồi phục”. Minecraft game mode và gamerule vẫn là owner của luật vanilla; UMBRA chỉ sở hữu state của UMBRA và cách các activity của UMBRA kết thúc/khôi phục.

## 2. Ba lớp hậu quả bắt buộc

1. **Information:** cho biết nguồn kết liễu, cue phòng thủ đã bỏ lỡ và trạng thái quan trọng; bản tóm tắt ngắn, mở rộng theo yêu cầu.
2. **Interruption:** action đang chạy dừng; target/command/threat tạm thời được cleanup; activity chuyển state bằng transition hợp lệ.
3. **Recovery:** một khoảng lùi ngắn, có giới hạn và có hơn một đường quay lại; không tước progression vĩnh viễn.

Không cộng dồn nhiều hình phạt nặng chỉ vì nhiều hệ cùng “muốn death có giá”. Death Resolver nhìn toàn outcome rồi áp một consequence profile thống nhất.

## 3. State Ownership Matrix

| State | Default sau death | Owner/ý nghĩa |
|---|---|---|
| Level, EXP, skill unlock/loadout, bounded capability mastery | giữ nguyên | thành quả dài hạn không bị tước |
| Shadow identity, level, bond, memory | giữ nguyên | attachment và công sức roster được bảo vệ |
| Shadow deployment/command/target/combat state | recall + reset an toàn | không xóa Shadow; không để stale entity/action |
| Current HP/Vigor và action/status tạm thời | thiết lập lại theo mode/activity profile | tạo nhịp hồi phục, không đổi max/permanent progression |
| Gate/quest participation | theo lifecycle contract của activity | checkpoint/retry/fail/re-entry phải khai riêng |
| UMBRA reward đang transaction | commit đúng một lần hoặc rollback | không duplicate hoặc mất im lặng |
| Vanilla inventory/XP/drop | theo Minecraft mode/gamerule | UMBRA không âm thầm override `keepInventory` |
| World construction, irreversible quest/world fact | giữ theo transaction đã commit | death không rollback lịch sử tùy tiện |

Một trạng thái “hậu chấn” ngắn vẫn là **candidate** nhưng không được là Fatigue/resource bar mới. Prototype phải loại death spiral: không giảm max HP/damage/Vigor theo cách khiến đường lấy lại tài nguyên khó hơn sau mỗi lần chết.

## 4. Game-mode composition

| Context | Chính sách UMBRA |
|---|---|
| Survival | áp Standard consequence; vanilla inventory/XP tuân gamerule; UMBRA permanent state giữ, deployment recall |
| Creative | creative/authoring intent thắng: death thông thường không tạo penalty; `/kill`, void hoặc admin reset chỉ cleanup an toàn |
| Adventure | giống Survival trừ khi authored activity khai profile riêng; không giả định quyền phá/đặt block |
| Spectator | không chạy action/progression/reward gameplay; state đang sở hữu phải cleanup/suspend rõ |
| Hardcore | Minecraft permadeath/spectator là authoritative; UMBRA không tạo đường respawn thay thế, nhưng vẫn flush ledger/recall/cleanup an toàn |

World có thể chọn `Gentle`, `Standard` hoặc `Custom` consequence profile khi policy UI được nghiên cứu. Profile là world-owned, versioned và preview được. Hardcore khóa các trường xung đột; thay policy bằng command/cheat phải có confirm và audit. Tên, exact penalty và quyền đổi giữa chừng còn thuộc `DB-040`.

## 5. Activity contract

Mỗi Gate, boss, quest instance hoặc PvP ruleset tương lai phải khai:

- vị trí/state trở lại; checkpoint nào còn;
- encounter reset toàn phần hay một phần;
- reward reservation/claim xử lý ra sao;
- party/Shadow owner khi player chết hoặc disconnect;
- chống exploit suicide/duplicate/re-entry;
- death review lấy dữ kiện nào;
- hậu quả activity có thay thế hay cộng với world profile.

Mặc định không cộng hai punishment cùng chức năng. Ví dụ activity đã mất attempt/reward thì world profile không thêm grind phục hồi tương đương.

## 6. Creative là first-class author/debug sandbox

Creative cho phép truy cập/spawn/grant/unlock content UMBRA để build và test. Nó không phải một bản game bị hỏng hoặc thiếu feature.

- State/reward tạo bằng Creative, command hoặc debug có provenance `CREATIVE`, `COMMAND` hoặc `DEBUG`.
- Chuyển lại Survival không xóa những gì user chủ động tạo. World solo vẫn chơi được.
- Eligibility cho challenge, achievement “earned in Survival” và future ranked record được tính theo từng event/reward từ provenance ledger; không dùng một cờ “tainted world” thô phá toàn save.
- Authoring tools nguy hiểm có confirm, undo/restore-as-copy khi khả thi và diagnostic rõ.
- Creative test path là bắt buộc trong lifecycle matrix: item, weapon, Shadow, Gate, quest state, reload và mode switch.

## 7. Scenario gates

- chết do enemy, fall, void, command và khi đổi dimension;
- chết đúng tick hit/reward/capture/save;
- quit/crash giữa death → respawn/cleanup;
- death trong Gate ở mỗi lifecycle state;
- Creative ↔ Survival, Creative `/kill`, Spectator, Hardcore;
- all Shadows deployed, Shadow đang shatter/revive/command;
- vanilla `keepInventory` bật/tắt;
- future co-op: owner chết, đồng đội còn sống, disconnect/reconnect.

## 8. Evidence cần trước Implementation Ready

Automated lifecycle/state-transition/duplicate tests phải xanh trước Test Card. Human playtest chỉ trả lời: consequence có đủ đáng sợ nhưng công bằng, recovery có kéo người chơi quay lại, death review có giúp học mà không phá immersion. Exact duration/cost chỉ được ghi Parameter Registry sau comparative playtest.
