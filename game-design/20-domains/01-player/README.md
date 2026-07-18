# DOM-PLAYER — Player Character và Progression Charter

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

Domain sở hữu player-owned capability, level/EXP, attributes, rank, specialization, talent, Potential, mastery và prestige. `SYS-PLAYER-TRAVERSAL` sở hữu luật Free Climb/Hạ Kình/Khinh Công; Presentation sở hữu camera/input/animation, Combat sở hữu hit/damage và World sở hữu geometry/content response.

## Fantasy

Người chơi là ngoại lệ duy nhất có thể tăng trưởng trong một xã hội mà sức mạnh NPC bị khóa. Tăng trưởng phải do họ nhìn thấy, phân bổ và chứng minh qua thử thách; không được biến save thành bẫy vì thiếu thông tin.

## Invariants đề xuất

- Hai trục: `Self` và `Active Retinue`, cộng hưởng nhưng không trùng vai trò; tối đa bốn reserve trong roster tám member không tính power trận hiện tại.
- Rank là danh tính/xã hội/quyền truy cập, không chỉ level gate.
- Free attribute có respec hợp lý; lựa chọn irreversible chỉ dành cho Potential đã preview.
- Mỗi giai đoạn mở một loại quyết định mới.
- Prestige cộng thêm, không reset/tước thành tựu.

## Feature map

```text
Awakening → early universal traversal training → XP/Level → Attributes
→ Reassessment/Rank → Job Change/Specialization → Potential/Mastery → Stratum/Prestige
```

## Tài liệu

- [Level, rank và progression](01-level-rank-and-progression.md)
- [Attributes, build và mastery](02-attributes-build-and-mastery.md)
- [Tuyến review thuộc tính và cân bằng](03-attribute-and-balance-review-guide.md)
- [Traversal: Free Climb, Hạ Kình và Khinh Công](traversal/README.md)
