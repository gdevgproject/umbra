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

Movement-like actions dùng representation axis/vector liên tục độc lập thiết bị: keyboard số hóa vector, analog giữ magnitude/góc sau dead-zone và device profile. Buffer chỉ giữ edge-triggered Action Intent có sequence/expiry/context; held axis là sampled state, không bị packet/key repeat biến thành nhiều press. Consumer feature sở hữu legal window/consume reason, còn Input sở hữu capture, dedupe, release và diagnostics.

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

Traversal dành semantic `umbra.action.climb` và `umbra.action.lightness`; semantic Action ID không đồng nghĩa cần một default key riêng. Khinh Công candidate dùng neutral hold Jump khi stable ground/`CLIMB_IDLE`, nhưng running/directional Jump phải commit ngay và neutral tap gate chỉ được giữ nếu latency/feel proof xanh; `DEDICATED_ACTION` cùng press-toggle/single-press assist là alternative bắt buộc. `Primary Attack` chỉ context-transform thành Hạ Kình từ fresh edge sau armed cue; held mining, edge đã consume trên wall và active mining transaction không được cướp, đồng thời có dedicated alternative. Exact mapping và precedence thuộc `DB-002/049–052`; không dùng double-tap làm đường duy nhất.

Free Climb default reuse hai muscle-memory Minecraft:

- `Jump/Traverse Up`: vanilla jump, low mantle, hop-attach, airborne grab/Step selector, targeted climb leap, Lightness neutral tap/hold selector hoặc post-mantle jump tùy authoritative context;
- `Sneak/Traverse Down`: vanilla sneak/dismount/swim-descend theo mode owner; chỉ fresh press sau climb latch mới deliberate Drop.

Đi/chạy/sprint chỉ va tường không attach; explicit player Jump arc trực diện vào valid face thì attach tự nhiên. Auto-jump, passive fall, held build/mine/use, pre-held Sneak và external force là inhibitor. Optional precision Climb/hold-to-cling/assisted-air-grab vẫn remap/configure được nhưng không buộc thêm phím mặc định. Mỗi physical edge có lineage ID và đúng một semantic consumer để Space không vừa jump vừa attach/leap, Shift không vừa dismount vừa Drop, key repeat không spam. Full buffer/vector/precedence dẫn tới [`FEAT-TRAVERSAL-FREE-CLIMB`](../../01-player/traversal/01-free-climbing.md), không định nghĩa lại ở layout.

## 7. Read next

- [Vanilla 26.2 key baseline](vanilla-26.2-key-baseline.md)
- [Default layout research](default-layout-research.md)
- [Camera System](../camera/README.md)
