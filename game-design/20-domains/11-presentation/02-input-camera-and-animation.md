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

Animation biểu đạt phase/intent; gameplay marker được server xác nhận. Dodge cần clip/pose theo hướng hoặc blend grammar, nhưng hitbox/i-frame không suy ra từ frame hình. Root motion, cancel, foot sliding, weapon alignment, first/third-person parity và fallback khi asset thiếu đều cần contract.
