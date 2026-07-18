# SYS-INPUT — Action, context và remappable controls

> **DRI:** UX/Input Designer + Client Engineer
> **Reviewers:** Combat, Camera, Accessibility, Localization, Platform, QA
> **Status:** `DISCOVERY`

## 1. Player promise

Người chơi có thể hành động chính xác mà không phải đấu với bàn phím, context hoặc Minecraft. Default layout phải chơi tốt ngay, nhưng mọi action player-facing đều remap được và không giả định bàn phím US, chuột nhiều nút hay một kiểu cơ thể.

## 2. Ba artifact không được trộn

1. **Vanilla Key Baseline:** snapshot những gì Minecraft dùng ở một baseline cụ thể.
2. **UMBRA Action Catalog:** intent ổn định như `umbra.action.dodge`; không chứa key mặc định như identity.
3. **Default Layout Profile:** mapping candidate theo thiết bị/layout/context, có version và evidence.

Minecraft update có thể đổi artifact 1 mà không được âm thầm đổi 2. Artifact 3 phải được audit lại mỗi lần nâng baseline.

## 3. Action definition

Mỗi action khai:

- stable Action ID, label/help key Việt–Anh và category;
- gameplay intent, allowed/blocked contexts và precedence;
- `press / release / hold / repeat / chord / axis` semantics;
- buffer, debounce, consume/pass-through và server payload policy;
- default keyboard/mouse candidate, alternative và unbound policy;
- conflict class: `HARD`, `CONTEXTUAL`, `SOFT` hoặc `INFORMATIONAL`;
- accessibility: toggle/hold, timing, one-handed alternative và reset;
- test oracle, diagnostics event và migration khi default đổi.

Không dùng double-tap làm đường duy nhất cho action chiến đấu. Không context-overload một key nếu hai action có thể hợp lệ cùng lúc hoặc người chơi không dự đoán được action nào thắng.

## 4. Context stack

```text
modal confirmation/text entry
→ full-screen UI/chat/command
→ precision aim/targeting
→ combat
→ command/squad
→ exploration/build/mining
→ spectator/creative/debug
```

Đây là precedence candidate, không phải luật khóa. Mỗi context phải công bố action nào consume, suspend hoặc pass-through. Mở menu, mất focus, pause, death, portal và đổi camera phải release held state để không tạo “phím ma”.

## 5. Default-layout constitution

- Action tần suất cao và time-critical nằm ở mouse/thumb hoặc vùng gần WASD.
- Không gán một action cần bấm đồng thời với hướng cho chính ngón đang giữ hướng đó nếu có lựa chọn tốt hơn.
- Không chiếm phím vanilla chỉ vì action UMBRA “quan trọng hơn”; conflict phải được nhìn, giải thích và remap.
- Menu/journal/roster ít khẩn cấp có thể dùng vùng xa hơn; combat không được phụ thuộc tổ hợp khó với tới.
- Hold/toggle, sensitivity và camera/aim behavior là setting độc lập với binding.
- Default thay đổi qua version phải có migration prompt; không ghi đè custom binding.

## 6. Settings UX

Controls screen phải có search, filter theo context/device, conflict explanation, “đang dùng ở đâu”, reset theo action/category/all, secondary binding khi nền tảng cho phép, profile export/import và preview thao tác. Tên action dùng động từ + đối tượng/kết quả, không dùng jargon kỹ thuật hay tên phím trong label.

Các category dự kiến: `Core Movement & Combat`, `Skills & Loadout`, `Shadow Command`, `World Interaction`, `Interface`. Tên và mô tả đều là localization keys.

Action Catalog phải dành `umbra.action.quick_recovery` với semantics `PRESS`, remappable và context-aware. Đây không phải permission chọn phím mặc định trước audit 26.2/layout experiment; key repeat/packet retry chỉ tạo tối đa một recovery intent mỗi press.

## 7. Read next

- [Vanilla 26.2 key baseline](vanilla-26.2-key-baseline.md)
- [Default layout research](default-layout-research.md)
- [Camera System](../camera/README.md)
