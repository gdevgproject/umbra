# CTR-SHADOW-RETINUE — Sức chứa và tư cách thành viên Hắc Ảnh Cận Vệ

> **Owner:** Shadow Systems Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Balance, Combat, AI, Narrative, UX, Platform, Performance, QA
> **Status:** `PROPOSED`

## 1. Outcome và ranh giới

Người chơi xây một **đội Hắc Ảnh Cận Vệ nhỏ nhưng có chiều sâu**: từng thành viên có tên, vai trò, quan hệ và lý do được chọn. Contract này sở hữu sức chứa, tư cách thành viên và giới hạn triển khai dùng chung bởi Capture, Identity, Deployment, AI, UI, save và balance.

Contract không sở hữu xác suất Trỗi Dậy, moveset từng Shadow, công thức sức mạnh, animation biểu cảm hoặc milestone nội dung cụ thể dùng để mở slot.

## 2. Topology đã khóa ở cấp Product

```text
1 ≤ bonded_slot_capacity ≤ 8
0 ≤ bonded_roster_count ≤ bonded_slot_capacity
0 ≤ combat_deployed_count ≤ min(bonded_roster_count, 4)
0 ≤ unresolved_claim_count ≤ 1
```

- Khi hệ Trỗi Dậy được mở, người chơi có **một slot kết ước** để thu phục Shadow đầu tiên; không được tặng sẵn một Shadow chỉ vì có slot.
- Slot 2–4 mở dần bằng milestone chứng minh năng lực kết ước/chỉ huy; slot 5–8 mở chiều rộng roster, rotation và home/social presence. Exact milestone/cadence thuộc `DB-044`.
- Các slot sau phải có challenge/mastery rõ, deterministic và preview được. Không mở bằng RNG, thanh toán, lịch đăng nhập hoặc grind tiền thuần túy; không mặc định dồn cả bốn slot 5–8 vào một mốc.
- Tối đa bốn Shadow được materialize như đồng đội chiến đấu gần người chơi. Tối đa bốn thành viên còn lại là **dự bị chiến lược/home assignment** để đổi đội hình tại boundary hợp lệ, không phải nguồn DPS/HP miễn phí.
- Tại nhà/hub, cả tám có thể hiện diện xã hội theo budget/LOD/scene staging vì đây không phải combat deployment; “có thể hiện diện” không buộc tám full-AI actor cùng tick/diễn một lúc.

Exact cost, rank, bond threshold, quest/trial và điều kiện đổi dự bị chưa được duyệt. Parameter Registry không được suy ra chúng từ level/INT bằng công thức tự động.

## 3. Slot, membership và deployment là ba khái niệm khác nhau

### Slot capacity

Slot có trạng thái `LOCKED | VACANT | OCCUPIED`. Mở slot là progression account/world của player; nó không tự tạo Shadow hoặc tăng damage.

### Bonded membership

Một Shadow Identity đã kết ước luôn chiếm đúng một `OCCUPIED` slot dù đang dự bị, triển khai, Tán Vỡ, hồi sinh hay được phân công tại nhà. Không có “kho phụ”, token hoặc garrison làm identity ngừng tính vào roster.

### Combat deployment

Deployment chỉ đổi representation/assignment của thành viên đã kết ước. Nó không đổi ownership. Việc đổi dự bị giữa combat không được reset HP/cooldown, né consequence Tán Vỡ hoặc nhân bản reward; exact safe boundary thuộc `DB-044`.

## 4. Khi roster đầy

UMBRA phải bảo vệ cả cơ hội hiếm lẫn attachment hiện có:

1. Không bao giờ tự xóa, tự thay hoặc tự giải phóng một Shadow.
2. Không được tạo identity sở hữu thứ chín.
3. Một mục tiêu đủ điều kiện có thể trở thành tối đa **một Dư Âm đang chờ phán quyết** (`UNRESOLVED_CLAIM`). Đây chưa phải Shadow, không chiến đấu, không tăng trưởng, không có bond và không thể chuyển thành vật phẩm giao dịch.
4. Phán quyết diễn ra ở safe decision boundary với hồ sơ so sánh, hậu quả và xác nhận rõ: từ chối Dư Âm, hoặc chủ động chia tay một thành viên rồi mới hoàn tất Trỗi Dậy.
5. Không tích lũy nhiều claim thành một “quân đoàn ẩn”. Khi đã có một claim, attempt tạo claim khác bị chặn trước commit và giải thích cách xử lý claim hiện tại; không overwrite im lặng.
6. Không đặt đồng hồ ép người chơi ra quyết định mất mát khó đảo ngược. Gate cleanup phải chuyển claim hợp lệ tới safe resolution theo persistence contract thay vì xóa vì người chơi rời phòng.

Release/parting là quyết định hiếm, có preview về identity, gear, memory, relationship, content dependency và save consequence; không là thao tác dọn kho thường xuyên.

## 5. Invariants liên hệ thống

- **Authority:** logical server sở hữu slot, membership, claim và deployment; client chỉ gửi intent và trình bày kết quả.
- **Identity:** cùng một stable Shadow ID đi qua mọi state; không clone record khi summon/assign/home.
- **Balance:** reserve không đóng góp power budget trận hiện tại; chỉ active party mới được xét, có cap và role-fit do Balance sở hữu.
- **Encounter:** composition scale theo player + tối đa bốn active Shadow, objective/terrain/readability; không chỉ nhân HP hoặc số quái theo roster count.
- **Command/UI:** combat UI ưu tiên bốn active role/portrait/acknowledgement rõ; roster UI hỗ trợ so sánh/rotation tối đa tám member mà không thành spreadsheet/RTS control.
- **Persistence:** slot unlock, membership và claim là world-owned persistent state có migration; animation/temporary selection là derived/ephemeral.
- **Death:** death recall deployment theo Death Contract nhưng không làm mất slot, member hoặc claim.
- **Creative:** debug grant phải tôn trọng cap hoặc dùng fixture/provenance tách biệt; không âm thầm tạo save không thể load ở Survival.
- **Multiplayer future:** ownership là theo player/party policy được authority contract quyết sau; cap không được client tự khai.
- **Performance:** combat cardinality của Retinue có hard cap 4; social presence vẫn qua relevance/LOD, không suy ra có thể bỏ budget AI/animation.

## 6. Failure scenarios bắt buộc

- retry/reconnect không tạo hai member từ một claim;
- save giữa unlock/occupy không tạo slot âm, slot ma hoặc roster vượt cap;
- capture khi full không overwrite member/claim;
- summon đồng thời/reordered packet không vượt bốn combat-deployed;
- reserve swap không hồi miễn phí hoặc né cooldown;
- death/dimension unload/missing content không mất member;
- hạ version/migration không cắt member thứ năm tới thứ tám im lặng;
- Creative/command invalid không làm roster hợp lệ trở thành corrupt.

## 7. Bằng chứng để approve

- `DB-044`: prototype slot 1→8, full-roster claim/parting, reserve rotation và command/roster usability.
- Balance simulation ít nhất `player + 0/1/2/4 active Shadow` qua các mastery/build/enemy mix.
- Save/reload/death/reconnect/dimension/duplicate/reorder/migration tests cho mọi membership state.
- UI comprehension: người chơi phân biệt slot, bốn active, tối đa bốn reserve/home và pending claim mà không cần đọc tooltip dài.
- Attachment playtest: slot 5–8 được cảm nhận là lựa chọn chiến lược/quan hệ/collection có danh tính, không là hình phạt quản lý, filler bắt buộc hoặc power tax.
