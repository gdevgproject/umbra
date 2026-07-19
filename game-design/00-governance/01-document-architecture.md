# GOV-ARCH — Kiến trúc tài liệu thiết kế

> **Owner:** Design Operations
> **Reviewers:** Game Director, Lead Designer, Technical Director, QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## 1. Vấn đề kiến trúc cần giải

Một GDD nguyên khối thường trộn bốn thứ: ý tưởng, luật đã chốt, giải pháp kỹ thuật và kế hoạch làm. Khi một câu về dodge nằm giữa combat tổng quát, mọi thay đổi kéo theo formula, input, camera, animation, networking và ticket nhưng không có nơi nào buộc người sửa kiểm đủ các chiều đó.

UMBRA dùng **tài liệu dạng graph có phân cấp**, không dùng một chuỗi file tuyến tính làm nguồn chân lý.

## 2. Sáu cấp thiết kế

```text
Product → Domain → System → Feature Cell → Scenario/Rule → Implementation Ticket
```

| Cấp | Câu hỏi | Ví dụ | Có được chứa code solution? |
|---|---|---|---|
| Product | Game này tồn tại để tạo trải nghiệm gì? | UMBRA, pillars, anti-goals | Không |
| Domain | Ai sở hữu một vùng quyết định? | Combat, Progression, Shadows | Không |
| System | Những feature nào cùng quản lý một năng lực/state? | Action Resolution, Gate Lifecycle | Chỉ constraint |
| Feature Cell | Một ý định người chơi tạo ra kết quả quan sát được nào? | Dodge, light attack, Arise attempt | Chỉ contract kỹ thuật cần thiết |
| Scenario/Rule | Trong một điều kiện cụ thể, luật hoạt động ra sao? | dodge khi đứng yên, khi rơi, khi hết Focus | Không |
| Ticket | Thay đổi triển khai nhỏ, chứng minh được | input intent, state transition test | Có |

Ticket không phải “mini-mod”. **Feature Cell** là đơn vị thiết kế nhỏ nhất có ý nghĩa với người chơi; **Capability Slice** là lát cắt phát hành nhỏ nhất chơi được từ input tới feedback và test.

## 3. Bốn góc nhìn song song

Một cây thư mục không thể biểu diễn mọi quan hệ. Mỗi feature phải xuất hiện trong bốn bản đồ, bằng ID/link chứ không chép nội dung:

1. **Design hierarchy:** feature thuộc fantasy/domain/system nào.
2. **Dependency graph:** feature cần và ảnh hưởng contract nào.
3. **Experience flow:** trước–trong–sau hành động, failure/recovery.
4. **Delivery slice:** nhóm feature nào tạo thành một bản chơi độc lập có thể đánh giá.

Code module sau này là góc nhìn thứ năm. Không ép ranh giới tài liệu trùng package code; một Feature Cell có thể đi qua client, server, animation và data nhưng vẫn là một trải nghiệm duy nhất.

## 4. Quy tắc chia Domain và System

Domain là **biên quyền quyết định ổn định**, không phải tên folder, team chart, package code hoặc cách gom mọi feature có vẻ liên quan. System là một cụm state/capability bên trong đúng một domain; nó có thể có DRI chuyên môn riêng và phát Shared Contract cho domain khác mà không tự động trở thành domain mới.

Giữ hai system trong cùng domain khi chúng cùng phục vụ một mission, cùng approver cho invariant cốt lõi và phần lớn thay đổi player-visible cần được review như một quyết định thống nhất. Tách domain khi có ít nhất hai tín hiệu mạnh sau, và tạo ADR nếu việc tách đổi stable ID/ownership/dependency graph:

- hai vùng có authoritative state, invariant và lý do thay đổi độc lập;
- DRI/approver hoặc lifecycle gate khác nhau đến mức một phía thường phải chờ review không liên quan;
- một phía có thể phát hành, rollback, migrate và chịu performance/compatibility risk mà không thay phía kia;
- dependency chủ yếu đi qua một contract hữu hạn, thay vì hai phía phải đọc internals của nhau;
- backlog/consumer graph cho thấy một charter đang che hai critical path khác nhau;
- reviewer mới không thể mô tả boundary và public surface trong khoảng 15 phút nếu không bỏ qua nửa charter.

Không tách domain chỉ vì tham vọng lớn, file dài hoặc có nhiều role tham gia. Trước khi tách phải chứng minh biên mới làm giảm change coupling/blast radius; nếu mọi feature sau đó luôn sửa cả hai bên, biên mới là giả. Ngược lại, không giữ một “siêu domain” chỉ để giảm số folder khi hai owner đang điều hành state/lifecycle khác nhau.

Các plane `Content`, `Quality`, `Production`, `Research` và `Governance` không phải gameplay domain: chúng định nghĩa cách author, chứng minh, xếp thứ tự và quản trị các domain. Chúng không được âm thầm sở hữu player rule. Cây thư mục có thể co-locate hai domain cộng tác gần; Domain Charter và stable ID mới là ownership truth.

Boundary audit chạy khi Product expansion thêm capability lớn, trước mỗi Capability Slice implementation-ready và khi cùng một cross-domain edit lặp lại ba lần. Kết quả là `KEEP`, `SPLIT`, `MERGE` hoặc `ADD_SHARED_CONTRACT`, kèm producer→contract→consumer→quality→production impact map.

## 5. Khi nào chia nhỏ Feature Cell

Tách một Feature Cell nếu **bất kỳ** điều kiện sau đúng:

- Có hơn một ý định chính của người chơi.
- Có hai state machine hoặc hai runtime owner có thể thay đổi độc lập.
- Có thể demo/release/test một phần mà phần còn lại chưa tồn tại.
- Hai phần có lifecycle, rủi ro hoặc dependency khác nhau.
- Acceptance matrix vượt 20 scenario có ý nghĩa và hình thành các cụm độc lập.
- Một thay đổi thường xuyên buộc reviewer không liên quan phải đọc lại toàn bộ cell.

Không tách chỉ vì file dài. Một rule nhỏ ở lại trong cell khi nó không có giá trị độc lập. Ví dụ “dodge sang trái” là scenario của Dodge; “hệ lock-on” là Feature Cell riêng vì có input, camera, target lifecycle và UX độc lập.

## 6. Khi nào dừng chia

Một Feature Cell đủ nhỏ khi:

- Có đúng một câu `player intent → observable outcome`.
- Có một DRI chịu trách nhiệm kết luận.
- Có biên vào/ra rõ và danh sách dependency hữu hạn.
- Có thể bật/tắt hoặc cô lập trong test harness.
- Mọi rule cùng thay đổi vì một lý do trải nghiệm.
- Một reviewer mới hiểu contract trong khoảng 15 phút, không cần đọc cả game.

Mục tiêu không phải “code không cần suy nghĩ”. Code luôn cần phán đoán triển khai. Mục tiêu đúng là: **không để lập trình viên phải tự phát minh luật chơi, UX hoặc hậu quả sản phẩm trong lúc code**.

## 7. Loại tài liệu và quyền phát biểu

| Loại | Chứa | Không chứa |
|---|---|---|
| Charter | mục tiêu, ranh giới, anti-goals, ownership | thông số lẻ hoặc backlog |
| Feature Cell | contract chuẩn của một feature | lịch sử phiên bản, giải pháp chưa duyệt |
| Shared Contract | vocabulary/state/event dùng chung | thiết kế nội dung riêng |
| Decision Record | bối cảnh, lựa chọn, hệ quả, cách đảo ngược | toàn bộ spec lặp lại |
| Research Card | quan sát, bằng chứng, nguyên lý | quyết định UMBRA tự động |
| Content Instance | boss/quest/item/faction cụ thể | luật engine dùng chung |
| Quality Spec | oracle, matrix, budget, cách đo | scope sản phẩm |
| Production Item | priority, dependency, proof | nghiên cứu hoặc design mới |

## 8. ID ổn định

Đường dẫn có thể đổi; ID không đổi.

| Prefix | Loại | Ví dụ |
|---|---|---|
| `PIL-` | pillar | `PIL-MASTERY` |
| `DOM-` | domain | `DOM-COMBAT` |
| `SYS-` | system | `SYS-ACTION-RESOLUTION` |
| `FEAT-` | Feature Cell | `FEAT-COMBAT-DODGE` |
| `CTR-` | shared contract | `CTR-INPUT-ACTION` |
| `ADR-` | decision record | `ADR-0001-DODGE-RESOURCE` |
| `RES-` | research card | `RES-DODGE-GENSHIN` |
| `CNT-` | content instance | `CNT-BOSS-IRON-KNIGHT` |
| `QLT-` | quality spec | `QLT-COMBAT-FEEL` |
| `DB-` | design decision/research package | `DB-026` |
| `EPIC-` | candidate implementation epic, chưa cho phép code | `EPIC-C3-04` |
| `TKT-` | implementation ticket đã qua gate riêng | `TKT-C3-001` |
| `CR-` | ticket-local Change Request cho feedback/delta khi implementation; không sở hữu game rule | `CR-TKT-C3-001-01` |

Không nhúng số phiên bản vào ID hoặc tên file.

## 9. Source precedence

Không dùng một danh sách file ưu tiên toàn cục kiểu “formula luôn thắng design”. Quyền ưu tiên dựa trên **loại câu hỏi**:

- Ý nghĩa sản phẩm: Product Charter.
- Ranh giới/owner: Domain/System Charter.
- Luật feature: Feature Cell.
- Giao tiếp liên feature: Shared Contract.
- Lý do chọn: Decision Record.
- Con số đã duyệt: Parameter Registry/Balance Contract.
- Bằng chứng: Quality Spec và test record.
- Thứ tự làm: Production plan.

Nếu formula trái Feature Cell, đó là conflict phải xử lý; không tài liệu nào được âm thầm “thắng”.

## 10. Chính sách lịch sử

- Không tạo mục “Bổ sung v5.0”.
- Sửa canonical text tại chỗ.
- Lý do và phương án bị loại nằm trong ADR.
- Git giữ diff và lịch sử tác giả.
- Nội dung không còn hiệu lực bị thay trực tiếp trong canonical home; Git giữ provenance. Không duy trì một cây tài liệu cũ song song bắt người đọc phải né.
- Changelog chỉ tạo ở release, không dùng làm cấu trúc GDD.
