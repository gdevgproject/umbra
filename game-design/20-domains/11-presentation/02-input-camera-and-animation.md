# SYS-CONTROL-PRESENTATION — Input, camera và animation

> **DRI:** UX/Input + Camera + Animation Leads
> **Status:** `DISCOVERY`

## Input ownership

Thiết kế dùng `Action ID + Context + Trigger semantics`, không lấy một phím làm identity của mechanic. Canonical input package nằm tại [Input System](input/README.md); baseline vanilla 26.2 và nghiên cứu default layout nằm cùng package đó.

Mọi action phải có default candidate, full remap, conflict severity, press/hold/release semantics, repeat/buffer policy, accessibility alternative và tên Việt/Anh. Combat, vanilla, camera, UI, chat và command context có precedence quan sát được; client key mapping chỉ tạo intent, không tự commit gameplay state.

## Camera

Third-person overhaul là core capability. Canonical contract, decomposition và test nằm tại [Camera System](camera/README.md). File này chỉ sở hữu ranh giới camera–input–animation.

First-person và third-person dùng cùng action/target authority. Input layer gửi action/aim intent; camera client trình bày/predict nhưng không tự quyết hit/interaction. Lock-on, precision aim, obstruction và context transition là các Feature Cell riêng.

Sau khi `C2-PLAYER-EMBODIMENT` hoàn tất camera base, occlusion, aim ray và first-person parity, save mới mặc định mở ở third-person UMBRA. Trước gate đó không đổi default vanilla để tránh một trạng thái camera nửa hoàn thiện. Người chơi luôn có action chuyển góc nhìn; action cụ thể có thể đề xuất presentation mode nhưng không được âm thầm tước quyền đổi mode ngoài safety policy đã duyệt.

## Animation

Animation dùng ba lớp không được nhập làm một:

```text
authoritative action/locomotion/expression semantic
→ animation request + normalized phase/marker/facing contract
→ rig/body-topology asset graph + camera-specific presentation
```

- Gameplay owner phát semantic/action state; Animation chọn clip/blend/IK/fallback tương thích. Clip name, frame hoặc state máy animation không là gameplay truth.
- Marker gameplay mang action/transition ID và chỉ có hiệu lực khi owner contract xác nhận; animation/VFX/audio callback lặp, thiếu hoặc đến trễ không tự gây damage, cost, movement hay relationship mutation.
- Body topology profile khai humanoid/beast/flying/large-form capabilities, normalized semantic slots, missing-slot fallback và asset tier. Không ép mọi actor vào một skeleton hoặc copy graph thành nhánh `if actor_id`.
- Root motion là presentation/desired displacement input có policy; movement/collision/velocity cuối do server movement owner commit. Reconciliation không teleport xuyên block hoặc làm clip thay hitbox/i-frame.
- First-person arms/camera và third-person full body là projection của cùng action; khác clip được phép, khác timing/outcome không được phép nếu thiếu Feature/ADR riêng.
- Animation graph không đọc domain internals hoặc loader event trực tiếp; adapter chuyển resource reload/render hook, asset registry chuyển stable semantic→asset profile.
- Mỗi transition khai cancel/interruption/blend, weapon/hand anchor, foot contact, visibility/LOD, reduced-motion và fallback pose. Missing/reloaded asset không được kẹt action hoặc đổi luật.

Architecture proof trước production batch: một player action, một enemy telegraph và một non-humanoid/Shadow expression đi qua cùng semantic contract; marker duplicate/missing/late, resource reload, camera switch, LOD và dedicated-server-without-client-assets đều có oracle. Exact graph/runtime library chưa khóa; owner `DB-025/033`.

Traversal bổ sung grammar attach/climb four-direction/idle/leap/eject/mantle/slip, Grounding orient–descent–impact theo weapon adapter và Lightness launch–apex–descent–landing. IK tay/chân, cloth/trail và root motion chỉ trình bày; collision/velocity/Vigor/fall conversion thuộc [`CTR-TRAVERSAL`](../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md). Mỗi transition phải có fallback clip/pose để missing asset không đổi gameplay.
